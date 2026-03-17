# CI/CD GitHub Actions + Azure

[Home](./Home.md) | [Architecture du repo](./02-architecture-du-repo.md) | [Serving, observabilite et gouvernance](./04-serving-observabilite-gouvernance.md)

## Le principe

Le repo utilise GitHub Actions comme moteur d'automatisation.
Azure sert de plateforme d'execution et de deploiement.
L'ensemble est relie proprement par OIDC, donc sans secret statique Azure dans GitHub.

## Message cle

Ici, la CI/CD n'est pas une couche annexe.
Elle est le mecanisme qui relie le code, l'infrastructure, l'identite cloud et les environnements de deploiement.

## Si tu n'as jamais vraiment utilise la CI/CD

Tu peux lire cette page avec une idee simple :

- la CI verifie automatiquement qu'un changement ne casse pas le projet
- la CD automatise le deploiement quand les conditions sont reunies

Dans ce repo, cela veut dire concretement :

- verifier le code Python
- lancer les tests
- soumettre un pipeline AML
- construire une image de serving
- deployer sur Azure

## Pourquoi on fait cette automatisation

| Sans CI/CD | Avec CI/CD |
|---|---|
| On rerun a la main quand on pense a le faire | Chaque changement important repasse par des verifications |
| On oublie facilement une etape | Les etapes sont encodees dans le workflow |
| Les resultats dependent de la machine de chacun | L'execution est plus standardisee |
| Le deploiement repose sur la memoire de l'equipe | Le processus devient lisible et repetable |

## Vue d'ensemble du flux CI/CD

```mermaid
sequenceDiagram
    participant Dev as Developpeur
    participant GH as GitHub Actions
    participant Entra as Microsoft Entra ID
    participant AML as Azure ML
    participant ACR as Azure Container Registry
    participant AKS as AKS

    Dev->>GH: push / pull request / workflow_dispatch
    GH->>GH: lint + tests
    GH->>Entra: token OIDC
    Entra-->>GH: token Azure temporaire
    GH->>AML: submit training pipeline
    GH->>GH: CD dev manuel
    GH->>ACR: build et push image
    GH->>AKS: deploy manifest
```

## CI : verifier puis entrainer

Le workflow [`.github/workflows/ci-train.yml`](../../.github/workflows/ci-train.yml) fait trois choses :

1. verifier le style et le formatage
2. executer les tests
3. soumettre un pipeline AML

Le pipeline AML lui-meme est dans [`mlops/pipelines/pipeline.yml`](../../mlops/pipelines/pipeline.yml).
Il orchestre trois jobs :

- preparation des donnees
- entrainement
- evaluation

Point important :
- la CI ne s'arrete pas au code Python local
- elle valide aussi la capacite a faire tourner le workflow ML dans Azure ML

Lecture entreprise :
- cela montre qu'un pipeline ML doit etre teste aussi dans son contexte d'execution cible
- un script qui marche localement n'est pas encore un actif exploitable

Si tu viens du notebook :
- pense a la CI comme a un collegue automatique qui rerun les verifications a chaque changement
- pense a AML comme a l'endroit ou l'entrainement est execute de facon standardisee

Point de branche:
- dans ce repo, les declenchements automatiques `push` sont volontairement attaches a `dev`
- `main` reste une branche de reference synchronisee et de validation via `pull_request`
- cela evite de dupliquer les runs CI/CD sur deux branches qui portent le meme contenu

## CD dev : construire puis deployer

Le workflow [`.github/workflows/cd-deploy-dev.yml`](../../.github/workflows/cd-deploy-dev.yml) illustre une logique classique :

1. attendre une CI reussie
2. reconstruire un artefact modele local
3. construire l'image de serving avec le `Dockerfile`
4. pousser l'image dans Azure Container Registry
5. injecter les valeurs dynamiques dans le manifest Kubernetes
6. deployer sur AKS

Dans le lab actuel, le `CD dev` est lance **manuellement** apres verification du resultat de la CI.
Ce choix est volontaire:

- le pipeline AML prend deja plusieurs minutes
- on ne veut pas rebuild et redeployer AKS a chaque push de test
- cela rend la demonstration plus lisible et plus proche d'un gate de promotion vers `dev`

Point important :
- l'image de serving embarque un modele construit pendant le workflow
- cela montre une logique simple de bout en bout
- dans le repo, l'image AKS utilise maintenant un runtime de serving dedie, separe des dependances de training/MLflow
- cette separation evite des conflits de dependances dans l'image de serving et reflète mieux une architecture reelle

Ce que tu dois comprendre ici :
- deploiement ne veut pas dire seulement "copier du code"
- il faut aussi preparer le runtime qui va exposer la prediction

## AKS et Managed Endpoint AML ne jouent pas le meme role

Le repo montre deux cibles de deploiement differentes :

| Cible | Workflow | Ce que cela produit | Utilite principale |
|---|---|---|---|
| `AKS` | [`.github/workflows/cd-deploy-dev.yml`](../../.github/workflows/cd-deploy-dev.yml) | une application de scoring conteneurisee sur Kubernetes | serving applicatif + App Insights |
| `Managed Endpoint AML` | [`.github/workflows/cd-deploy-aml-endpoint.yml`](../../.github/workflows/cd-deploy-aml-endpoint.yml) | un modele enregistre dans AML + un endpoint gere | registre de modeles + serving ML gere |

Point cle:
- le deploiement `AKS` n'enregistre pas automatiquement le modele dans le registre AML
- le workflow `Managed Endpoint AML` enregistre `iris-classifier` dans le workspace AML
- c'est pour cela que le versioning de modele du Jour 4 depend du workflow Managed Endpoint, pas du deploiement AKS

## Separation recommandee des environnements

```mermaid
flowchart LR
    A[Commit ou PR] --> B[CI]
    B --> C[Environnement dev]
    C --> D[Verification]
    D --> E[Approbation]
    E --> F[Environnement prod]
```

## CD prod : promotion controlee

Le workflow [`.github/workflows/cd-deploy-prod.yml`](../../.github/workflows/cd-deploy-prod.yml) ajoute deux controles utiles :

- une confirmation explicite via `CONFIRM`
- une protection GitHub Environment `production`

Il ne rebuild pas depuis zero.
Il recupere l'image la plus recente depuis l'ACR dev, l'importe dans l'ACR prod, puis deploie sur AKS prod.

Lecture MLOps :
- on cherche a promouvoir un artefact deja produit, pas a recompiler différemment en prod
- c'est plus proche d'une vraie logique de release

Lecture entreprise :
- la prod doit etre une promotion controlee, pas un environnement "special" reconstruit differemment
- cette logique simplifie l'auditabilite et reduit les ecarts entre environnements

Version simple :
- `dev` sert a tester rapidement
- `prod` demande plus de controle
- on essaie de promouvoir quelque chose qui existe deja, pas de refaire autrement

## OIDC : le point de securite le plus important

Le repo s'appuie sur `azure/login@v2` avec :

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

Le secret important ici n'est pas un mot de passe Azure.
L'authentification s'appuie sur une App Registration et des Federated Credentials.

Cela signifie :

- pas de secret longue duree a stocker dans GitHub
- tokens temporaires
- contexte d'usage borne par branche ou environment

En pratique, c'est un excellent exemple moderne a montrer dans un wiki MLOps cloud.

## Point d'attention

Le point le plus important a faire passer en formation est souvent celui-ci :
l'identite du pipeline compte autant que le code du pipeline.
Sans modele propre d'authentification et de permissions, la CI/CD devient fragile ou dangereuse.

Si les notions d'OIDC, App Registration ou Federated Credentials sont nouvelles :
- retiens surtout que le pipeline s'authentifie a Azure sans stocker de mot de passe longue duree
- c'est une bonne pratique moderne a connaitre tres tot

## Pourquoi cette approche parle aussi aux equipes Azure DevOps

La logique est exactement celle d'un pipeline d'entreprise classique :

- un evenement Git declenche une automation
- l'automation execute des jobs ordonnes
- certains jobs produisent des artefacts
- des garde-fous controlent la promotion vers la prod
- l'authentification cloud est geree par une identite de pipeline

La difference visible est surtout dans l'outil, pas dans le modele d'exploitation.

## Bootstrap AML

Le workflow [`.github/workflows/ops-bootstrap-aml.yml`](../../.github/workflows/ops-bootstrap-aml.yml)
et le script [`scripts/bootstrap-aml.sh`](../../scripts/bootstrap-aml.sh) servent a initialiser ou reparer
les assets AML utiles au lab.

Lecture MLOps :
- tout ce qui est repetitif ou fragile doit devenir scriptable
- un bon systeme cloud evite les operations manuelles irreproductibles

## Navigation

- Precedent: [Architecture du repo](./02-architecture-du-repo.md)
- Suite: [Serving, observabilite et gouvernance](./04-serving-observabilite-gouvernance.md)
