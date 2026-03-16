# Wiki du repo MLOps Azure Lab

Cette page est l'index documentaire dans le repo.
Si tu veux publier ce contenu comme un vrai GitHub Wiki, utilise plutot [Home](./Home.md)
comme page d'accueil et [_Sidebar](./_Sidebar.md) comme navigation simple.

Ce wiki explique comment lire ce depot comme une plateforme MLOps cloud orientee Azure.
L'idee n'est pas seulement de decrire les fichiers, mais de montrer comment les briques
Azure, GitHub et MLOps s'assemblent dans une chaine coherente.

## A qui s'adresse ce wiki

- A une equipe data qui veut comprendre comment passer du notebook au deploiement.
- A une equipe plateforme qui veut voir une implementation simple mais realiste sur Azure.
- A des personnes venant d'Azure DevOps et qui veulent faire le parallelle avec GitHub Actions.

## Parcours recommande

1. [Workflow global d'un projet MLOps sur Azure](./00-workflow-global-azure-mlops.md)
2. [Vision MLOps Cloud sur Azure](./01-vision-mlops-cloud.md)
3. [Architecture du repo](./02-architecture-du-repo.md)
4. [CI/CD GitHub Actions + Azure](./03-ci-cd-github-actions-azure.md)
5. [Serving, observabilite et gouvernance](./04-serving-observabilite-gouvernance.md)
6. [GitHub Actions vs Azure DevOps](./05-github-actions-vs-azure-devops.md)
7. [Glossaire MLOps Azure](./06-glossaire-mlops-azure.md)

## Fichiers de navigation wiki

- [Home](./Home.md)
- [_Sidebar](./_Sidebar.md)

## Idee generale du repo

Ce depot montre un flux MLOps complet autour d'un cas simple de classification Iris :

- code data science versionne dans Git
- tests et qualite automatises
- entrainement orchestre dans Azure Machine Learning
- infrastructure deployee par IaC
- image de serving construite et poussee dans Azure Container Registry
- deploiement sur AKS ou via Managed Online Endpoint AML
- telemetrie, monitoring et securite geres avec les services Azure

## Ce que le repo illustre bien

- la separation entre code ML, code infra et code pipeline
- l'authentification cloud sans secret via OIDC
- la distinction entre environnement `dev` et `prod`
- la difference entre "deployer un conteneur sur AKS" et "servir un modele avec AML"
- la transposition relativement directe entre GitHub Actions et Azure DevOps

## A garder en tete

Le lab fait des raccourcis pedagogiques utiles :

- l'exemple est volontairement compact
- certains flux sont plus rapides que dans une vraie organisation
- la production reelle aurait souvent plus de validations, de separation des roles et de controles de conformite

Le depot reste neanmoins tres utile pour expliquer la logique de fond du MLOps cloud moderne.
