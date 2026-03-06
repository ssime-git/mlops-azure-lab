# Jour 4 — Tracking, Registry & Monitoring

## Objectifs
- Comparer des runs MLflow dans AML Studio
- Gerer les versions de modeles dans AML Registry
- Configurer une alerte Azure Monitor
- Simuler du data drift

## Atelier

### 1. Explorer les runs MLflow (10 min)
Azure ML Studio > Jobs > selectionner 2 runs > Compare.
Observer : Metrics, Parameters, Artifacts, Tags.

### 2. Versioning de modeles (10 min)
```bash
az ml model list --name iris-classifier
az ml model show --name iris-classifier --version 1
```
Azure ML Studio > Models > iris-classifier -> historique des versions.

### 3. Alerte Azure Monitor (15 min)
Portal > App Insights (`appi-mlopslab-dev`) > Alerts > New Alert Rule.
- Signal : `requests/failed`
- Threshold : > 5 en 5 min
- Action group : email

### 4. Simulation drift (25 min)
```bash
ENDPOINT=$(kubectl get svc iris-classifier-svc -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Trafic normal
python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 50 --n_drifted 0

# Observer App Insights > Live Metrics pendant l'envoi

# Trafic drifte
python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 10 --n_drifted 40

# Observer les reponses anormales dans App Insights > Requests
```

## Checkpoint J4
- [ ] 2 runs compares dans AML Studio
- [ ] Versions modele visibles dans AML Registry
- [ ] Alerte Monitor configuree
- [ ] Drift simule et logs observes dans App Insights
