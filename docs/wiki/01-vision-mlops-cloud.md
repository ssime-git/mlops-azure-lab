# Vision MLOps Cloud sur Azure

[Home](./Home.md) | [Workflow global d'un projet MLOps sur Azure](./00-workflow-global-azure-mlops.md) | [Architecture du repo](./02-architecture-du-repo.md)

## Ce que veut dire "faire du MLOps dans le cloud"

Le MLOps consiste a industrialiser un cycle de vie ML qui ne s'arrete pas a l'entrainement :

- preparer les donnees
- entrainer et evaluer
- versionner les artefacts utiles
- deployer un service de prediction
- observer ce service en production
- faire evoluer le modele et l'infrastructure sans casser l'existant

Dans le cloud, on cherche en plus a separer clairement :

- le code applicatif
- l'infrastructure
- les identites et permissions
- les environnements
- les pipelines d'automatisation

## Pourquoi le mot "industrialiser" est important

Dans beaucoup de projets ML debutants, le modele existe, mais le systeme autour du modele n'existe pas encore vraiment.

On voit souvent:

- un notebook qui marche sur une machine
- des fichiers de donnees en local
- une evaluation manuelle
- un deploiement fait une fois "pour montrer"

Le passage au MLOps commence quand on cherche a rendre tout cela:

- relancable
- tracable
- partageable
- automatisable
- observable

Le cloud n'est pas la finalite.
Le cloud est le moyen d'executer cela dans un cadre plus stable et plus standardise.

## Message cle

Le sujet principal n'est pas "comment lancer un modele sur Azure".
Le sujet principal est "comment rendre un systeme ML reproductible, deployable, observable et gouvernable".

## Si tu viens de la data science

Le changement de perspective le plus important est souvent celui-ci :

- en data science, on optimise surtout l'experimentation
- en MLOps, on optimise aussi la reproductibilite, la mise en service et la maintenance

Autrement dit :
- un notebook utile n'est pas encore un produit exploitable
- un bon score offline n'est pas encore une mise en production reussie

## Les 4 questions de fond d'un projet MLOps

Un projet ML exploitable doit repondre a quatre questions en meme temps:

1. Comment entrainer et evaluer proprement ?
2. Comment mettre en service sans bricolage manuel ?
3. Comment observer ce qui se passe apres le deploiement ?
4. Comment controler qui a le droit de faire quoi ?

Le MLOps commence quand on accepte que ces quatre questions ont autant d'importance que le score du modele.

## Comment ce repo materialise cette vision

Le depot suit une logique en couches :

- `mlops/data-science/` contient le code ML, le serveur de scoring et l'environnement d'execution
- `mlops/pipelines/` contient les definitions AML et le manifest de deploiement AKS
- `.github/workflows/` contient l'orchestration CI/CD
- `infrastructure/bicep/` et `infrastructure/terraform/` provisionnent Azure
- `scripts/` fournit des operations transverses comme le bootstrap AML, le RBAC ou la simulation de drift

## Chaine de valeur MLOps du repo

```mermaid
flowchart TD
    A[Notebook ou code local] --> B[Scripts versionnes]
    B --> C[Tests et lint]
    C --> D[Pipeline AML]
    D --> E[Evaluation]
    E --> F[Enregistrement ou packaging]
    F --> G[Deploiement AKS ou AML]
    G --> H[Monitoring et drift]
    H --> I[Amelioration continue]
```

## Pourquoi Azure est pertinent ici

Azure apporte plusieurs briques qui couvrent les besoins MLOps sans tout reconstruire soi-meme :

- Azure Machine Learning pour les jobs, les endpoints et le registre de modeles du workspace
- Azure Kubernetes Service pour le serving conteneurise et la maitrise de l'execution
- Azure Container Registry pour stocker les images de serving
- Key Vault pour les secrets et la centralisation des references sensibles
- Application Insights et Azure Monitor pour la telemetrie et les alertes
- Microsoft Entra ID pour l'identite federee et le RBAC

## A quoi sert chaque brique, en langage simple

| Brique Azure | A quoi elle sert dans le repo | Question a laquelle elle repond |
|---|---|---|
| Azure ML | executer des jobs ML et gerer les assets ML | "Ou tourne l'entrainement ?" |
| ACR | stocker des images Docker | "Ou vit l'image de serving ?" |
| AKS | executer une application de prediction conteneurisee | "Ou tourne le service HTTP ?" |
| Application Insights | observer les requetes et la telemetrie applicative | "Que se passe-t-il apres le deploiement ?" |
| Key Vault | stocker des secrets | "Ou mettre les informations sensibles ?" |
| Entra ID | gerer identites et permissions | "Qui a le droit d'agir ?" |

## Pourquoi on ne met pas tout dans Azure ML

Question frequente d'un debutant:
"Si Azure ML existe, pourquoi garder aussi ACR, AKS, Key Vault, App Insights ?"

La reponse est simple:

- Azure ML couvre tres bien les workflows et assets ML
- mais un systeme exploitable a aussi besoin d'un runtime applicatif, d'une observabilite, d'une gestion d'identites et d'une gestion de secrets

Il faut donc raisonner en systeme:

- AML pour la couche ML
- AKS ou Managed Endpoint pour la couche serving
- App Insights / Monitor pour l'observabilite
- Entra / RBAC / Key Vault pour la gouvernance

## Lecture entreprise

Pour une organisation, Azure n'apporte pas seulement des services techniques.
Azure apporte surtout un cadre coherent pour :

- maitriser les identites
- separer les environnements
- tracer les changements
- standardiser les deploiements
- brancher le ML sur les pratiques DevOps existantes

## Ce qu'il faut retenir au debut

Si tu debutes en MLOps, il n'est pas necessaire de tout maitriser d'un coup.
Dans ce repo, il suffit d'abord de comprendre ces 5 idees :

1. le code ML doit devenir un script reproductible
2. ce script doit etre teste automatiquement
3. l'infrastructure cloud doit etre decrite comme du code
4. le deploiement doit etre automatisable
5. le modele doit etre observable apres mise en service

## Du prototype au produit

| Quand on debute en DS | Ce qu'il faut ajouter en MLOps |
|---|---|
| Notebook local | Scripts relancables |
| Bon score offline | Quality gate automatise |
| Fichiers locaux | Artefacts traces et versionnes |
| Manipulations manuelles | Pipelines CI/CD |
| Test ponctuel | Observabilite continue |

## Bonnes pratiques a retenir tres tot

- separer le code exploratoire du code relancable
- versionner l'infrastructure comme le code applicatif
- eviter les operations cloud irreproductibles a la main
- donner des permissions minimales plutot qu'un acces large
- distinguer ce qui releve du "modele" et ce qui releve du "service"
- prevoir l'observation avant d'avoir un incident

## Le principe cle : tout traiter comme un systeme

Dans un projet ML immature, l'equipe pense souvent en une seule question :
"le modele est-il bon ?"

Dans un projet MLOps, il faut aussi repondre a ces questions :

- qui peut deployer ?
- sur quelle infra ?
- comment reproduire l'entrainement ?
- ou sont les logs ?
- comment on promeut `dev` vers `prod` ?
- que se passe-t-il si le endpoint tombe ou si les donnees changent ?

Ce repo est utile parce qu'il montre que le MLOps n'est pas un outil unique.
C'est l'assemblage coherent de pratiques DevOps, Data et plateforme cloud.

## Schema de lecture debutant

```mermaid
flowchart TD
    A[Code et notebook] --> B[Scripts relancables]
    B --> C[Tests et quality gate]
    C --> D[Infra et identite]
    D --> E[Entrainement et deploiement]
    E --> F[Monitoring]
    F --> G[Correction et iteration]
```

Si tu ne dois retenir qu'une idee:

- un projet ML mature n'est pas seulement un bon modele
- c'est un bon modele place dans un systeme fiable

## Point d'attention

Une erreur frequente en formation consiste a reduire le MLOps a AML ou a Kubernetes.
Ici, il faut insister sur le fait que la valeur vient de l'ensemble :
code, pipeline, infra, identite, deploiement, monitoring et gouvernance.

## Navigation

- Precedent: [Workflow global d'un projet MLOps sur Azure](./00-workflow-global-azure-mlops.md)
- Suite: [Architecture du repo](./02-architecture-du-repo.md)
