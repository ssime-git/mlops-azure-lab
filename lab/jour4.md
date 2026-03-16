# Jour 4 — Tracking, Registry & Monitoring

## Objectifs
- Comparer des runs MLflow dans AML Studio
- Gerer les versions de modeles dans le registre de modeles du workspace AML
- Configurer une alerte Azure Monitor
- Simuler du data drift

## Dependances depuis J3

Le Jour 4 suppose que:
- le pipeline AML du Jour 3 a deja tourne avec succes
- le workflow `CD — Deploy AML Managed Endpoint` a ete lance au moins une fois si tu veux manipuler un modele enregistre dans AML
- le workflow CD dev vers AKS a deja termine si tu veux simuler du drift sur `iris-classifier-svc`

En pratique:
- sans modele enregistre, la partie "versioning" ne montrera rien
- sans endpoint AKS accessible, la simulation de drift ne peut pas fonctionner

## Atelier

### 1. Explorer les runs MLflow (10 min)
Azure ML Studio > Jobs > selectionner 2 runs > Compare.
Observer : Metrics, Parameters, Artifacts, Tags.

### 2. Versioning de modeles dans le workspace AML (10 min)
Precondition:
- avoir lance au moins une fois le workflow `CD — Deploy AML Managed Endpoint` du Jour 3
- ce workflow enregistre le modele `iris-classifier` dans le workspace AML dev

```bash
az ml model list --name iris-classifier
az ml model show --name iris-classifier --version 1
```
Azure ML Studio > Models > iris-classifier -> historique des versions dans le workspace.

Important:
- ici on parle du registre de modeles du **workspace AML**
- ce lab n'utilise pas un AML Registry partage entre plusieurs workspaces

### 3. Alerte Azure Monitor (15 min)
Portal > App Insights (`appi-mlopslab-dev`) > Alerts > New Alert Rule.
- Signal : `requests/failed`
- Threshold : > 5 en 5 min
- Action group : email

### 4. Simulation drift (25 min)
Precondition:
- le workflow `CD — Deploy to Dev` du Jour 3 doit avoir deploye l'application sur AKS
- `kubectl get svc iris-classifier-svc` doit retourner une `EXTERNAL-IP`

```bash
ENDPOINT=$(kubectl get svc iris-classifier-svc -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Trafic normal
uv run python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 50 --n_drifted 0

# Observer App Insights > Live Metrics pendant l'envoi

# Trafic drifte
uv run python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 10 --n_drifted 40

# Observer les reponses anormales dans App Insights > Requests
```

Si `EXTERNAL-IP` est vide:
- attendre encore un peu que le Load Balancer Azure soit provisionne
- ou revenir au Jour 3 pour verifier le workflow CD dev

## Checkpoint J4
- [ ] 2 runs compares dans AML Studio
- [ ] Versions modele visibles dans le workspace AML
- [ ] Alerte Monitor configuree
- [ ] Drift simule et logs observes dans App Insights
