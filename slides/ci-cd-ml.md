---
marp: true
theme: default
paginate: true
html: true
style: |
  @import url('https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600&display=swap');

  :root {
    --navy:    #1A1A33;
    --orange:  #FF6745;
    --lime:    #DDFF45;
    --cyan:    #00E5EE;
    --purple:  #C445FF;
    --violet:  #7657FF;
    --offwhite:#E8E7E1;
    --card:    #252540;
    --border:  #2E2E50;
    --body:    #B0AFCC;
    --muted:   #6B6A8A;
    --light:   #FFFFFF;
    --green:   #22c55e;
    --red:     #ef4444;
  }

  section {
    background: var(--navy);
    color: var(--light);
    font-family: 'Inter', sans-serif;
    font-weight: 400;
    padding: 80px 68px 48px;
    line-height: 1.6;
  }

  h1 {
    font-family: 'Work Sans', sans-serif;
    font-weight: 800;
    font-size: 2.4em;
    color: var(--light);
    line-height: 1.15;
    margin-bottom: 0.15em;
  }

  h2 {
    font-family: 'Inter', sans-serif;
    font-weight: 300;
    font-size: 1.1em;
    color: var(--body);
    margin-bottom: 0.4em;
  }

  h3 {
    font-family: 'Work Sans', sans-serif;
    font-weight: 600;
    font-size: 0.58em;
    color: var(--muted);
    text-transform: uppercase;
    letter-spacing: 0.18em;
    margin-bottom: 0.5em;
  }

  strong { color: var(--orange); font-weight: 600; }
  em { color: var(--lime); font-style: normal; font-weight: 500; }
  a { color: var(--cyan); text-decoration: none; }

  section.lead {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    background: radial-gradient(ellipse at 30% 70%, #2A1F40 0%, var(--navy) 65%);
    padding-top: 48px;
  }
  section.lead h1 { font-size: 3em; }
  section.lead h2 { color: var(--body); font-size: 1.05em; max-width: 620px; }

  section.transition {
    display: flex;
    flex-direction: column;
    justify-content: center;
    background: var(--orange);
    color: var(--light);
    padding-top: 48px;
  }
  section.transition h1 { color: var(--light); font-size: 2.8em; }
  section.transition h2 { color: rgba(255,255,255,0.78); font-weight: 400; }
  section.transition h3 { color: rgba(255,255,255,0.6); }

  section.transition-lime {
    display: flex;
    flex-direction: column;
    justify-content: center;
    background: linear-gradient(135deg, #252520 0%, #1A1A15 100%);
    border-left: 6px solid var(--lime);
    color: var(--light);
    padding-top: 48px;
  }
  section.transition-lime h1 { color: var(--lime); font-size: 2.8em; }
  section.transition-lime h2 { color: rgba(255,255,255,0.78); font-weight: 400; }
  section.transition-lime h3 { color: rgba(221,255,69,0.5); }

  section.break {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    background: linear-gradient(135deg, #1A1A33 0%, #0A0A1A 100%);
    border: 2px solid var(--border);
    padding-top: 48px;
  }
  section.break h1 { color: var(--cyan); font-size: 3em; }
  section.break h2 { color: var(--body); font-weight: 400; }

  section.session2 {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    text-align: center;
    background: radial-gradient(ellipse at 70% 30%, #1A2A40 0%, var(--navy) 65%);
    padding-top: 80px;
  }
  section.session2 h1 { font-size: 2.4em; color: var(--cyan); line-height: 1.15; margin: 0.1em 0; }
  section.session2 h2 { color: var(--body); font-size: 1.05em; max-width: 620px; }

  section.governance-compact h1 { font-size: 2.15em; line-height: 1.08; margin-bottom: 0.08em; }
  section.governance-compact svg { margin-top: 6px; margin-bottom: 4px; height: 38px; }

  footer { font-size: 0.44em; color: var(--muted); }
  section::after { color: var(--muted); font-size: 0.5em; }

  ul, ol { padding-left: 1.4em; color: var(--body); }
  li { margin-bottom: 0.32em; }
  li::marker { color: var(--orange); }

  table { width: 100%; border-collapse: collapse; font-size: 0.7em; }
  th { font-family: 'Work Sans', sans-serif; font-weight: 600; font-size: 0.58em;
       text-transform: uppercase; letter-spacing: 0.12em; color: var(--muted);
       border-bottom: 1px solid var(--border); padding: 8px 12px; text-align: left; }
  td { padding: 8px 12px; border-bottom: 1px solid var(--border); color: var(--body); }
  tr:hover td { background: var(--card); }

  blockquote {
    border-left: 3px solid var(--orange);
    padding: 12px 18px;
    margin: 0;
    background: var(--card);
    border-radius: 0 8px 8px 0;
    font-family: 'Work Sans', sans-serif;
    font-weight: 500;
    font-style: normal;
    color: var(--offwhite);
    font-size: 0.95em;
  }

  code { background: var(--card); color: var(--lime); padding: 2px 6px; border-radius: 4px; font-size: 0.83em; }
  pre { background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 12px 16px; }
  pre code { background: none; color: var(--offwhite); font-size: 0.72em; }

  .tag {
    font-family: 'Work Sans', sans-serif;
    font-weight: 700;
    font-size: 0.5em;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    padding: 3px 10px;
    border-radius: 4px;
  }
  .tag-orange { background: rgba(255,103,69,0.2); color: var(--orange); border: 1px solid var(--orange); }
  .tag-lime   { background: rgba(221,255,69,0.15); color: var(--lime);   border: 1px solid var(--lime); }
  .tag-cyan   { background: rgba(0,229,238,0.15);  color: var(--cyan);   border: 1px solid var(--cyan); }
  .tag-violet { background: rgba(118,87,255,0.2);  color: var(--violet); border: 1px solid var(--violet); }

  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(14px); }
    to   { opacity: 1; transform: translateY(0); }
  }
  .fade-up   { animation: fadeUp 0.5s ease both; }
  .fade-up-2 { animation: fadeUp 0.5s 0.15s ease both; }
  .fade-up-3 { animation: fadeUp 0.5s 0.30s ease both; }

  header { text-align: right; font-size: 0.5em; color: var(--muted); }
  header img { height: 36px; margin: 0; vertical-align: middle; }

header: '![h:36](./assets/logos/Liora_Logo_White.svg)'
footer: 'CI/CD appliqué au Machine Learning · 2 × 4h'
---

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

<div style="display:flex;flex-direction:column;align-items:center;justify-content:center;gap:14px;transform:translateY(10px);">
  <img src="./assets/logos/Liora_Logo_White.svg" style="height:38px;opacity:0.92;">

  <div style="font-family:'Work Sans',sans-serif;font-weight:600;font-size:0.56em;letter-spacing:0.18em;text-transform:uppercase;color:var(--muted);">MLOps · Formation 2 × 4h</div>

  <div style="font-family:'Work Sans',sans-serif;font-weight:800;font-size:2.18em;line-height:1.04;color:var(--light);">CI/CD appliqué au<br>Machine Learning</div>

  <div style="font-size:0.9em;color:var(--body);max-width:760px;line-height:1.45;">Pipelines, automatisation, monitoring et gouvernance sur Azure</div>

  <div>
    <span class="tag tag-orange">Azure ML</span>&nbsp;
    <span class="tag tag-lime">GitHub Actions</span>&nbsp;
    <span class="tag tag-cyan">Azure Pipelines</span>
  </div>

  <div style="margin-top:10px;display:flex;gap:6px;justify-content:center;">
  <div style="width:40px;height:3px;border-radius:2px;background:var(--orange);"></div>
  <div style="width:40px;height:3px;border-radius:2px;background:var(--lime);"></div>
  <div style="width:40px;height:3px;border-radius:2px;background:var(--cyan);"></div>
  </div>
</div>

---

### Objectifs pédagogiques

# Ce que vous allez approfondir

<div style="background:#252540;border:1px solid #2E2E50;border-radius:12px;padding:20px 24px;margin-top:12px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.55em;text-transform:uppercase;letter-spacing:0.18em;color:#DDFF45;margin-bottom:12px;">Objectifs d'apprentissage</div>
  <ul style="margin:0;padding-left:1.2em;color:#B0AFCC;font-size:0.76em;line-height:1.9;">
    <li>Expliquer les <strong>spécificités d'un pipeline CI/CD ML</strong> par rapport au logiciel classique</li>
    <li>Lire et écrire des <strong>pipelines YAML</strong> pour GitHub Actions et Azure Pipelines</li>
    <li>Mettre en place un <strong>quality gate</strong> automatisé sur les métriques du modèle</li>
    <li>Choisir entre <strong>AKS</strong> et <strong>AML Managed Endpoint</strong> selon le contexte</li>
    <li>Configurer le <strong>monitoring applicatif et ML</strong> avec App Insights et KQL</li>
    <li>Simuler et analyser un <strong>drift de données</strong> en production</li>
    <li>Appliquer les bonnes pratiques de <strong>gouvernance</strong> : RBAC, Key Vault, OIDC</li>
  </ul>
</div>

---

### Plan de la formation

# 5 parties · 8h au total

<div style="display:flex;gap:12px;margin-top:4px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--orange);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.52em;color:var(--orange);text-transform:uppercase;letter-spacing:0.12em;font-family:'Work Sans';font-weight:700;margin-bottom:6px;">Matin · 4h</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.8em;color:var(--light);margin-bottom:6px;">Fondations CI/CD ML</div>
    <div style="font-size:0.62em;color:var(--body);line-height:1.6;">Partie 1 · Fondations ML<br>Partie 2 · Infra & Environnements<br>Partie 3 · CI/CD & Outils<br>— Démo guidée 1 —</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--cyan);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.52em;color:var(--cyan);text-transform:uppercase;letter-spacing:0.12em;font-family:'Work Sans';font-weight:700;margin-bottom:6px;">Après-midi · 4h</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.8em;color:var(--light);margin-bottom:6px;">Serving, Monitoring & Gouvernance</div>
    <div style="font-size:0.62em;color:var(--body);line-height:1.6;">Partie 3 · Serving (AKS vs AML)<br>Partie 4 · Tracking, Registry & Drift<br>— Démo guidée 2 —<br>Partie 5 · Gouvernance</div>
  </div>
</div>

<div style="margin-top:14px;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.25);border-radius:10px;padding:10px 16px;font-size:0.68em;color:var(--body);">
  La journée suit le même rythme : <strong>théorie + quiz interactifs</strong> → <strong>démo guidée</strong> → <strong>récap collectif</strong>
</div>

<div style="margin-top:10px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:10px;padding:10px 16px;font-size:0.64em;color:var(--body);">
  Pour cette formation en <strong>une journée</strong>, l'environnement <code>dev</code> de démonstration est supposé <strong>préparé en amont</strong> — cela condense les étapes de setup et d'infrastructure détaillées dans le lab complet.
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->

### Partie 1 — Fondations

# Pourquoi le CI/CD
# change avec le ML ?

## Du notebook au système industrialisé

---

### Le problème de départ

# Un notebook qui marche… et après ?

<div style="display:flex;gap:14px;margin-top:10px;">
  <div style="flex:1;background:rgba(239,68,68,0.1);border:1px solid rgba(239,68,68,0.3);border-radius:10px;padding:10px 14px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.64em;color:#ef4444;margin-bottom:6px;">Situation typique</div>
    <ul style="margin:0;padding-left:1.2em;font-size:0.64em;color:var(--body);line-height:1.6;">
      <li>Notebook qui tourne sur <em>ma machine</em></li>
      <li>Données en local ou dans un Drive</li>
      <li>Évaluation faite <em>une fois</em> à la main</li>
      <li>Déploiement : "j'ai envoyé le pkl par email"</li>
      <li>Monitoring : "on verra si ça plante"</li>
    </ul>
  </div>
  <div style="flex:1;background:rgba(34,197,94,0.08);border:1px solid rgba(34,197,94,0.25);border-radius:10px;padding:10px 14px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.64em;color:#22c55e;margin-bottom:6px;">Ce qu'on vise</div>
    <ul style="margin:0;padding-left:1.2em;font-size:0.64em;color:var(--body);line-height:1.6;">
      <li>Scripts <strong>relancables</strong> sur n'importe quel compute</li>
      <li>Entraînement <strong>tracé et versionné</strong></li>
      <li>Quality gate <strong>automatique</strong></li>
      <li>Déploiement <strong>reproductible</strong> via pipeline</li>
      <li>Monitoring <strong>continu</strong> après mise en production</li>
    </ul>
  </div>
</div>

<div style="margin-top:10px;border-left:3px solid var(--orange);background:var(--card);border-radius:0 8px 8px 0;padding:10px 14px;font-size:0.66em;color:var(--offwhite);font-family:'Work Sans';font-weight:500;">
  Le MLOps commence quand on accepte que ces cinq points ont <strong>autant d'importance que le score du modèle</strong>.
</div>

---

### Les 4 questions MLOps

# Un projet ML exploitable répond à 4 questions

<div style="display:flex;gap:10px;margin-top:16px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--orange);border-radius:10px;padding:14px 16px;text-align:center;">
    <div style="font-family:'Work Sans';font-weight:800;font-size:2em;color:var(--orange);line-height:1;">1</div>
    <div style="font-size:0.65em;color:var(--light);font-family:'Work Sans';font-weight:600;margin-top:6px;">Comment entraîner et évaluer proprement ?</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--lime);border-radius:10px;padding:14px 16px;text-align:center;">
    <div style="font-family:'Work Sans';font-weight:800;font-size:2em;color:var(--lime);line-height:1;">2</div>
    <div style="font-size:0.65em;color:var(--light);font-family:'Work Sans';font-weight:600;margin-top:6px;">Comment mettre en service sans bricolage manuel ?</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--cyan);border-radius:10px;padding:14px 16px;text-align:center;">
    <div style="font-family:'Work Sans';font-weight:800;font-size:2em;color:var(--cyan);line-height:1;">3</div>
    <div style="font-size:0.65em;color:var(--light);font-family:'Work Sans';font-weight:600;margin-top:6px;">Comment observer ce qui se passe après le déploiement ?</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--violet);border-radius:10px;padding:14px 16px;text-align:center;">
    <div style="font-family:'Work Sans';font-weight:800;font-size:2em;color:var(--violet);line-height:1;">4</div>
    <div style="font-size:0.65em;color:var(--light);font-family:'Work Sans';font-weight:600;margin-top:6px;">Comment contrôler qui a le droit de faire quoi ?</div>
  </div>
</div>

<div style="margin-top:14px;font-size:0.7em;color:var(--body);text-align:center;">
  Le CI/CD ML est la réponse concrète aux questions <strong>1</strong> et <strong>2</strong>. Le monitoring répond à la <strong>3</strong>. La gouvernance à la <strong>4</strong>.
</div>

---

### Quiz · Vérification rapide

# CI ou CD ?

<div style="background:var(--card);border:1px solid var(--border);border-radius:12px;padding:20px 24px;margin-top:12px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.6em;text-transform:uppercase;letter-spacing:0.15em;color:var(--purple);margin-bottom:14px;">Question 1 / 4</div>
  <div style="font-family:'Work Sans';font-weight:600;font-size:0.9em;color:var(--light);margin-bottom:16px;">Un pipeline exécute automatiquement <code>black</code>, <code>flake8</code> et <code>pytest</code> à chaque push. C'est de la…</div>
  <div style="display:flex;gap:10px;">
    <div style="flex:1;background:rgba(255,103,69,0.1);border:1px solid rgba(255,103,69,0.3);border-radius:8px;padding:12px 14px;font-size:0.72em;color:var(--light);cursor:pointer;">A · Intégration Continue (CI)</div>
    <div style="flex:1;background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:12px 14px;font-size:0.72em;color:var(--body);">B · Déploiement Continu (CD)</div>
    <div style="flex:1;background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:12px 14px;font-size:0.72em;color:var(--body);">C · Les deux</div>
  </div>
</div>

<div style="margin-top:12px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  <strong style="color:var(--lime);">Réponse : A</strong> — La CI vérifie que le changement est acceptable. La CD livre l'artefact dans un environnement.
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->

### Partie 1 · suite

# Spécificités des
# pipelines ML

## Ce qui change par rapport au logiciel classique

---

### ML vs logiciel classique

<div style="font-size:1em;font-weight:700;color:var(--light);margin-bottom:10px;">Ce qui change avec le ML</div>

<table style="font-size:0.62em;line-height:1.4;width:100%;border-collapse:collapse;">
  <thead>
    <tr>
      <th style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;text-align:left;">Aspect</th>
      <th style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;text-align:left;">Logiciel classique</th>
      <th style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;text-align:left;">MLOps (bonne pratique)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>CI vérifie</strong></td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;">Code + tests unitaires</td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Code + tests unitaires + smoke tests</strong> (pas d'entraînement complet)</td>
    </tr>
    <tr>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Pipeline ML</strong></td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;">N/A</td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Entraînement + évaluation + quality gate</strong> (séparé, schedule/event)</td>
    </tr>
    <tr>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Quality gate</strong></td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;">Tests passent/fail</td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Métriques modèle (accuracy ≥ seuil)</strong> dans pipeline ML</td>
    </tr>
    <tr>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Artefacts CI</strong></td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;">Binaire / image Docker</td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Image Docker (code only) + modèle (registry séparé)</strong></td>
    </tr>
    <tr>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Durée CI</strong></td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;">&lt; 10 min</td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>5-10 min</strong></td>
    </tr>
    <tr>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>Durée Pipeline ML</strong></td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;">N/A</td>
      <td style="border:1px solid rgba(255,255,255,0.2);padding:4px 8px;"><strong>30 min - 2h</strong> (compute dédié)</td>
    </tr>
  </tbody>
</table>

<div style="margin-top:8px;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.25);border-radius:8px;padding:8px 12px;font-size:0.64em;color:var(--body);">
  <strong>Note :</strong> Dans ce repo, <code>ci-train.yml</code> mélange CI et entraînement → anti-pattern expliqué slide suivante.
</div>

---

<!-- _class: transition-red -->

### Anti-pattern dans le repo

<div style="font-size:0.95em;font-weight:700;color:var(--light);margin-bottom:8px;">Ce qu'on voit dans <code>ci-train.yml</code> … et pourquoi c'est problématique</div>

<div style="display:flex;gap:10px;margin-top:10px;">
  <div style="flex:1;background:rgba(239,68,68,0.08);border:1px solid rgba(239,68,68,0.25);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:#ef4444;margin-bottom:6px;">❌ Ce que fait le workflow actuel</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.60em;color:var(--body);line-height:1.5;">
      <li><strong>Mélange CI + entraînement</strong> : lint, tests, <em>et</em> pipeline AML</li>
      <li><strong>Attente bloquante</strong> : runner GitHub attend 20+ min (boucle sleep)</li>
      <li><strong>Double entraînement</strong> : AML entraîne → puis <code>cd-deploy-dev.yml</code> ré-entraîne localement (lines 42-43)</li>
      <li><strong>Quality gate indirect</strong> : CI échoue si job AML retourne erreur</li>
    </ul>
  </div>
  
  <div style="flex:1;background:rgba(34,197,94,0.06);border:1px solid rgba(34,197,94,0.2);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:#22c55e;margin-bottom:6px;">✅ Bonne pratique</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.60em;color:var(--body);line-height:1.5;">
      <li><strong>CI séparée</strong> : lint + tests + build (5-10 min, <em>sans</em> entraînement)</li>
      <li><strong>Pipeline ML indépendant</strong> : schedule/event, compute AML dédié</li>
      <li><strong>Modèle versionné</strong> : Azure ML Model Registry, <em>pas</em> ré-entraîné dans build CD</li>
      <li><strong>Quality gate clair</strong> : <code>evaluate_model</code> bloque/valide avant enregistrement</li>
    </ul>
  </div>
</div>

<div style="margin-top:8px;background:rgba(255,103,69,0.06);border:1px solid rgba(255,103,69,0.2);border-radius:8px;padding:8px 10px;font-size:0.59em;color:var(--body);">
  <strong>Pourquoi :</strong> CI rapide pour développeurs. Pipeline ML long mais indépendant — peut échouer sans impacter vélocité du code.
</div>

<div style="margin-top:6px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:6px 10px;font-size:0.58em;color:var(--body);">
  <strong>Flexibilité GitHub Actions :</strong> Ce repo montre qu'on peut tout mettre dans un seul workflow, mais ce n'est pas une bonne pratique MLOps. Workflows séparés + triggers différents (push vs schedule) = meilleure séparation.
</div>

---

### Anatomie d'un pipeline AML

# 3 étapes · 1 quality gate

<svg width="100%" height="72" viewBox="0 0 680 72" style="margin-top:14px;margin-bottom:10px;">
  <!-- prep_data -->
  <rect x="0" y="10" width="130" height="52" rx="8" fill="#252540" stroke="#2E2E50" stroke-width="1"/>
  <text x="65" y="32" text-anchor="middle" font-family="Work Sans" font-size="11" font-weight="700" fill="#FF6745">prep_data</text>
  <text x="65" y="48" text-anchor="middle" font-family="Inter" font-size="9" fill="#B0AFCC">charge · split</text>
  <!-- arrow -->
  <path d="M130 36 L158 36" stroke="#6B6A8A" stroke-width="1.5" marker-end="url(#arr)"/>
  <!-- train_model -->
  <rect x="158" y="10" width="140" height="52" rx="8" fill="#252540" stroke="#2E2E50" stroke-width="1"/>
  <text x="228" y="32" text-anchor="middle" font-family="Work Sans" font-size="11" font-weight="700" fill="#DDFF45">train_model</text>
  <text x="228" y="48" text-anchor="middle" font-family="Inter" font-size="9" fill="#B0AFCC">entraîne · MLflow</text>
  <!-- arrow -->
  <path d="M298 36 L326 36" stroke="#6B6A8A" stroke-width="1.5" marker-end="url(#arr)"/>
  <!-- evaluate_model -->
  <rect x="326" y="10" width="150" height="52" rx="8" fill="#252540" stroke="#2E2E50" stroke-width="1"/>
  <text x="401" y="32" text-anchor="middle" font-family="Work Sans" font-size="11" font-weight="700" fill="#00E5EE">evaluate_model</text>
  <text x="401" y="48" text-anchor="middle" font-family="Inter" font-size="9" fill="#B0AFCC">quality gate ≥ 0.90</text>
  <!-- arrow -->
  <path d="M476 36 L504 36" stroke="#6B6A8A" stroke-width="1.5" marker-end="url(#arr)"/>
  <!-- CD -->
  <rect x="504" y="4" width="176" height="64" rx="8" fill="rgba(221,255,69,0.08)" stroke="#DDFF45" stroke-width="1.5"/>
  <text x="592" y="30" text-anchor="middle" font-family="Work Sans" font-size="11" font-weight="700" fill="#DDFF45">🚀 CD déclenché</text>
  <text x="592" y="48" text-anchor="middle" font-family="Inter" font-size="9" fill="#B0AFCC">si PASS → déploiement</text>
  <!-- arrowhead marker -->
  <defs><marker id="arr" markerWidth="6" markerHeight="6" refX="3" refY="3" orient="auto"><path d="M0,0 L0,6 L6,3 z" fill="#6B6A8A"/></marker></defs>
</svg>

```yaml
# mlops/pipelines/pipeline.yml (extrait)
jobs:
  prep_data:
    component: azureml:prep_data@latest
  train_model:
    component: azureml:train_model@latest
    inputs: { training_data: ${{parent.jobs.prep_data.outputs.training_data}} }
  evaluate_model:
    component: azureml:evaluate_model@latest
    inputs: { model: ${{parent.jobs.train_model.outputs.model}} }
```

---

### Validation des données

# Ce que `prep.py` vérifie avant d'entraîner

<div style="display:flex;gap:14px;margin-top:10px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--orange);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.64em;color:var(--orange);margin-bottom:6px;">Structure attendue</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.6;">
      <li>4 features numériques (cm)</li>
      <li>1 colonne <code>target</code> (0, 1, 2)</li>
      <li>Aucune valeur nulle</li>
      <li>150 lignes minimum</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--lime);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.64em;color:var(--lime);margin-bottom:6px;">Ce que fait <code>prep.py</code> dans ce repo</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.6;">
      <li>Charge Iris depuis sklearn</li>
      <li>Renomme les colonnes</li>
      <li>Split 80/20 stratifié</li>
      <li>Sauvegarde <code>train.csv</code> + <code>test.csv</code></li>
    </ul>
  </div>
  <div style="flex:1;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.3);border-top:3px solid var(--red);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.64em;color:var(--red);margin-bottom:6px;">En production : vérifier aussi</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.6;">
      <li>Plage de valeurs (ex: sepal ∈ [4,8])</li>
      <li>Distribution des classes (déséquilibre ?)</li>
      <li>Schéma : types de colonnes corrects</li>
      <li><em>Bloquer le pipeline si KO</em></li>
    </ul>
  </div>
</div>

<div style="margin-top:12px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  Dans ce lab, les données viennent de sklearn → toujours propres. En vrai projet, <strong>la validation des données est le premier quality gate</strong>, avant même l'entraînement.
</div>

---

### Quality gate

# Le pipeline peut — et doit — échouer

<div style="display:flex;gap:16px;margin-top:14px;align-items:flex-start;">
  <pre style="flex:1;margin:0;background:#1e1e2e;border:1px solid rgba(255,255,255,0.1);border-radius:8px;padding:12px 14px;font-size:0.58em;line-height:1.6;color:#cdd6f4;overflow:hidden;"><code><span style="color:#6c7086"># evaluate_model/evaluate.py (extrait)</span>
accuracy = accuracy_score(y_test, y_pred)
mlflow.log_metric(<span style="color:#a6e3a1">"accuracy"</span>, accuracy)

THRESHOLD = <span style="color:#89b4fa">float</span>(os.environ.get(
    <span style="color:#a6e3a1">"ACCURACY_THRESHOLD"</span>, <span style="color:#a6e3a1">"0.90"</span>
))

<span style="color:#cba6f7">if</span> accuracy &lt; THRESHOLD:
    <span style="color:#89b4fa">print</span>(<span style="color:#a6e3a1">f"FAIL: {accuracy:.3f} &lt; {THRESHOLD}"</span>)
    sys.exit(<span style="color:#fab387">1</span>)          <span style="color:#6c7086"># fait échouer le job AML</span>
<span style="color:#cba6f7">else</span>:
    <span style="color:#89b4fa">print</span>(<span style="color:#a6e3a1">f"PASS: {accuracy:.3f} >= {THRESHOLD}"</span>)</code></pre>
  <div style="flex:1;display:flex;flex-direction:column;gap:10px;">
    <div style="background:rgba(34,197,94,0.08);border:1px solid rgba(34,197,94,0.3);border-radius:10px;padding:14px 16px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.65em;color:#22c55e;margin-bottom:4px;">Si accuracy ≥ 0.90</div>
      <div style="font-size:0.65em;color:var(--body);">Job AML → succès<br>CI GitHub → verte<br>CD dev peut être déclenché</div>
    </div>
    <div style="background:rgba(239,68,68,0.08);border:1px solid rgba(239,68,68,0.3);border-radius:10px;padding:14px 16px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.65em;color:#ef4444;margin-bottom:4px;">Si accuracy &lt; 0.90</div>
      <div style="font-size:0.65em;color:var(--body);"><code>sys.exit(1)</code> → job AML rouge<br>CI GitHub bloquée<br>CD <strong>non déclenché</strong></div>
    </div>
  </div>
</div>

---

### Exercice · Lecture de YAML

# À vous de jouer

<div style="background:var(--card);border:1px solid var(--border);border-radius:12px;padding:18px 22px;margin-top:12px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.55em;text-transform:uppercase;letter-spacing:0.18em;color:var(--orange);margin-bottom:12px;">Exercice · 8 min · En binôme</div>
  <div style="font-size:0.74em;color:var(--body);line-height:1.7;">
    Ouvrez <code>.github/workflows/ci-train.yml</code> dans le repo.<br><br>
    <strong>Répondez aux 3 questions :</strong>
    <ol style="margin-top:8px;padding-left:1.3em;">
      <li>Sur quel événement Git ce workflow se déclenche-t-il ?</li>
      <li>Quelle étape soumet le pipeline à Azure ML ? Quel script est appelé ?</li>
      <li>Que se passerait-il si on changeait le seuil <code>ACCURACY_THRESHOLD</code> à <code>0.99</code> ?</li>
    </ol>
  </div>
</div>

<div style="margin-top:12px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:10px 14px;font-size:0.63em;color:var(--body);">
  Repère clé : la commande <code>az ml job create</code> + le flag <code>--stream</code> qui bloque GitHub Actions jusqu'à la fin du job AML.
</div>

---

<!-- _class: transition-lime -->
<!-- _paginate: false -->

### Partie 2 — Infrastructure

# IaC & Environnements

## Terraform crée la plateforme, le CI/CD l'exploite

---

### Ce que Terraform provisionne

# Un environnement complet en une commande

<div style="display:flex;gap:12px;margin-top:12px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--orange);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--orange);margin-bottom:8px;">Compute & Serving</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.7;">
      <li><code>azurerm_machine_learning_workspace</code></li>
      <li><code>azurerm_kubernetes_cluster</code> (AKS)</li>
      <li><code>azurerm_container_registry</code> (ACR)</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--lime);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--lime);margin-bottom:8px;">Observabilité & Secrets</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.7;">
      <li><code>azurerm_application_insights</code></li>
      <li><code>azurerm_log_analytics_workspace</code></li>
      <li><code>azurerm_key_vault</code></li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--cyan);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--cyan);margin-bottom:8px;">Automatisations RBAC</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.7;">
      <li><code>AcrPull</code> pour AKS → ACR</li>
      <li><code>AcrPull</code> pour AML → ACR</li>
      <li>Séparation <code>dev</code> / <code>prod</code> par variable</li>
    </ul>
  </div>
</div>

<div style="margin-top:12px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  Un même <code>main.tf</code> déploie <code>dev</code> et <code>prod</code> — seul le fichier <code>.tfvars</code> change. Le backend remote stocke l'état dans un Storage Account Azure.
</div>

---

### Pourquoi c'est important pour le CI/CD

# L'infra conditionne tout le reste

<div style="display:flex;gap:14px;margin-top:14px;">
  <div style="flex:1;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.2);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--orange);margin-bottom:8px;">Sans IaC</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.7;">
      <li>Ressources créées manuellement au portail</li>
      <li>Différences non tracées entre dev et prod</li>
      <li>Pas de revue de code sur l'infra</li>
      <li>Impossible de recréer l'environnement</li>
    </ul>
  </div>
  <div style="flex:1;background:rgba(34,197,94,0.06);border:1px solid rgba(34,197,94,0.2);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--green);margin-bottom:8px;">Avec IaC (Terraform)</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.7;">
      <li><code>terraform plan</code> montre les changements avant</li>
      <li>Même code → même infra dev & prod</li>
      <li>PR review sur chaque changement d'infra</li>
      <li>Rollback possible via l'historique Git</li>
    </ul>
  </div>
</div>

<div style="margin-top:12px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  Pour cette formation, l'environnement <code>dev</code> est <strong>déjà provisionné</strong>. Le code Terraform est dans <code>infrastructure/terraform/</code> — consultable à tout moment.
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->

### Partie 3 — CI/CD

# Outils CI/CD :
# GitHub Actions & Azure Pipelines

## Deux syntaxes, un même modèle d'exploitation

---

### Structure GitHub Actions

<div style="font-size:1.6em;font-weight:800;color:var(--light);margin:4px 0 10px;">Anatomie d'un workflow</div>

<div style="display:flex;gap:12px;margin-top:4px;align-items:flex-start;">
  <pre style="flex:1;margin:0;background:#1e1e2e;border:1px solid rgba(255,255,255,0.1);border-radius:8px;padding:10px 12px;font-size:0.55em;line-height:1.55;color:#cdd6f4;overflow:hidden;"><code><span style="color:#6c7086"># .github/workflows/ci-train.yml</span>
<span style="color:#89b4fa">name</span>: CI — Train & Evaluate

<span style="color:#89b4fa">on</span>:
  <span style="color:#89b4fa">push</span>:
    <span style="color:#89b4fa">branches</span>: [dev]   <span style="color:#6c7086"># push → dev</span>
  <span style="color:#89b4fa">pull_request</span>:
    <span style="color:#89b4fa">branches</span>: [main]  <span style="color:#6c7086"># PR → main</span>

<span style="color:#89b4fa">permissions</span>:
  <span style="color:#89b4fa">id-token</span>: write   <span style="color:#6c7086"># OIDC</span>
  <span style="color:#89b4fa">contents</span>: read</code></pre>

  <pre style="flex:1.4;margin:0;background:#1e1e2e;border:1px solid rgba(255,255,255,0.1);border-radius:8px;padding:10px 12px;font-size:0.55em;line-height:1.55;color:#cdd6f4;overflow:hidden;"><code><span style="color:#89b4fa">jobs</span>:
  <span style="color:#cba6f7">lint-and-test</span>:
    <span style="color:#89b4fa">runs-on</span>: ubuntu-latest
    <span style="color:#89b4fa">steps</span>:
      - <span style="color:#89b4fa">uses</span>: actions/checkout@v4
      - <span style="color:#89b4fa">name</span>: Lint
        <span style="color:#89b4fa">run</span>: black --check . && flake8 .
      - <span style="color:#89b4fa">name</span>: Tests
        <span style="color:#89b4fa">run</span>: pytest tests/ -v

  <span style="color:#cba6f7">train</span>:
    <span style="color:#89b4fa">needs</span>: lint-and-test  <span style="color:#6c7086"># dépendance explicite</span>
    <span style="color:#89b4fa">steps</span>:
      - <span style="color:#89b4fa">uses</span>: azure/login@v2  <span style="color:#6c7086"># OIDC</span>
        <span style="color:#89b4fa">with</span>:
          <span style="color:#89b4fa">client-id</span>: ${{ secrets.AZURE_CLIENT_ID }}
          <span style="color:#89b4fa">tenant-id</span>: ${{ secrets.AZURE_TENANT_ID }}
          <span style="color:#89b4fa">subscription-id</span>: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
      - <span style="color:#89b4fa">name</span>: Submit AML pipeline
        <span style="color:#89b4fa">run</span>: az ml job create -f mlops/pipelines/pipeline.yml --stream</code></pre>
</div>

---

### Équivalence Azure DevOps

# Même logique, autre vocabulaire

<div style="display:flex;gap:14px;margin-top:12px;">
  <div style="flex:1;display:flex;flex-direction:column;gap:8px;">
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);"><code>workflow</code></span>
      <span style="font-size:0.62em;color:var(--offwhite);"><code>pipeline</code></span>
      <span style="font-size:0.58em;color:var(--muted);">unité d'automatisation</span>
    </div>
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);"><code>on: push</code></span>
      <span style="font-size:0.62em;color:var(--offwhite);"><code>trigger</code></span>
      <span style="font-size:0.58em;color:var(--muted);">déclencheur</span>
    </div>
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);"><code>jobs</code></span>
      <span style="font-size:0.62em;color:var(--offwhite);"><code>stages / jobs</code></span>
      <span style="font-size:0.58em;color:var(--muted);">unités d'exécution</span>
    </div>
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);"><code>steps</code></span>
      <span style="font-size:0.62em;color:var(--offwhite);"><code>steps</code></span>
      <span style="font-size:0.58em;color:var(--muted);">actions individuelles</span>
    </div>
  </div>
  <div style="flex:1;display:flex;flex-direction:column;gap:8px;">
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);"><code>uses: azure/login</code></span>
      <span style="font-size:0.62em;color:var(--offwhite);"><code>AzureCLI@2</code></span>
      <span style="font-size:0.58em;color:var(--muted);">auth Azure</span>
    </div>
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);"><code>secrets.AZURE_*</code></span>
      <span style="font-size:0.62em;color:var(--offwhite);"><code>Variable Groups</code></span>
      <span style="font-size:0.58em;color:var(--muted);">secrets</span>
    </div>
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);">GitHub Environments</span>
      <span style="font-size:0.62em;color:var(--offwhite);">Approvals &amp; Gates</span>
      <span style="font-size:0.58em;color:var(--muted);">promotion</span>
    </div>
    <div style="display:flex;justify-content:space-between;gap:10px;background:var(--card);border:1px solid var(--border);border-radius:8px;padding:10px 12px;">
      <span style="font-size:0.62em;color:var(--offwhite);"><code>needs</code></span>
      <span style="font-size:0.62em;color:var(--offwhite);"><code>dependsOn</code></span>
      <span style="font-size:0.58em;color:var(--muted);">dépendances</span>
    </div>
  </div>
</div>

<div style="margin-top:10px;background:rgba(118,87,255,0.08);border:1px solid rgba(118,87,255,0.25);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  Le modèle d'exploitation est identique : événement Git → jobs ordonnés → artefacts → promotion contrôlée vers prod.
</div>

---

### OIDC — Le point de sécurité clé

# Pourquoi OIDC plutôt qu'un secret statique ?

<svg width="100%" height="52" viewBox="0 0 640 60" style="margin-top:4px;margin-bottom:2px;">
  <!-- GitHub -->
  <rect x="0" y="10" width="100" height="40" rx="6" fill="#252540" stroke="#2E2E50" stroke-width="1"/>
  <text x="50" y="34" text-anchor="middle" font-family="Work Sans" font-size="10" font-weight="700" fill="#E8E7E1">GitHub</text>
  <!-- arrow 1 -->
  <path d="M100 30 L178 30" stroke="#FF6745" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="139" y="24" text-anchor="middle" font-family="Inter" font-size="8" fill="#FF6745">demande token</text>
  <!-- Entra ID -->
  <rect x="180" y="10" width="120" height="40" rx="6" fill="#252540" stroke="#7657FF" stroke-width="1.5"/>
  <text x="240" y="28" text-anchor="middle" font-family="Work Sans" font-size="10" font-weight="700" fill="#7657FF">Azure</text>
  <text x="240" y="42" text-anchor="middle" font-family="Work Sans" font-size="10" font-weight="700" fill="#7657FF">Entra ID</text>
  <!-- arrow 2 -->
  <path d="M300 30 L378 30" stroke="#DDFF45" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="339" y="24" text-anchor="middle" font-family="Inter" font-size="8" fill="#DDFF45">token ~1h</text>
  <!-- GitHub runner -->
  <rect x="380" y="10" width="120" height="40" rx="6" fill="#252540" stroke="#DDFF45" stroke-width="1"/>
  <text x="440" y="28" text-anchor="middle" font-family="Work Sans" font-size="10" font-weight="700" fill="#DDFF45">Runner</text>
  <text x="440" y="42" text-anchor="middle" font-family="Inter" font-size="8" fill="#B0AFCC">GitHub Actions</text>
  <!-- arrow 3 -->
  <path d="M500 30 L578 30" stroke="#00E5EE" stroke-width="1.5" marker-end="url(#arr2)"/>
  <text x="539" y="24" text-anchor="middle" font-family="Inter" font-size="8" fill="#00E5EE">az login</text>
  <!-- Azure -->
  <rect x="580" y="10" width="60" height="40" rx="6" fill="#252540" stroke="#00E5EE" stroke-width="1"/>
  <text x="610" y="34" text-anchor="middle" font-family="Work Sans" font-size="10" font-weight="700" fill="#00E5EE">Azure</text>
  <defs><marker id="arr2" markerWidth="6" markerHeight="6" refX="3" refY="3" orient="auto"><path d="M0,0 L0,6 L6,3 z" fill="#6B6A8A"/></marker></defs>
</svg>

<div style="display:flex;gap:10px;margin-top:8px;align-items:stretch;">
  <div style="flex:1;background:rgba(239,68,68,0.08);border:1px solid rgba(239,68,68,0.25);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:#ef4444;margin-bottom:6px;">Ancienne pratique</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.55;">
      <li>Service Principal avec mot de passe</li>
      <li>Secret stocké dans GitHub Secrets</li>
      <li>Valide <strong>indéfiniment</strong> (jusqu'à rotation manuelle)</li>
      <li>Si leaké → accès Azure complet</li>
    </ul>
  </div>
  <div style="flex:1;background:rgba(34,197,94,0.06);border:1px solid rgba(34,197,94,0.2);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:#22c55e;margin-bottom:6px;">Avec OIDC (federated credentials)</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.55;">
      <li>GitHub demande un token temporaire à Entra ID</li>
      <li>Token valide <strong>~1h</strong> · non réutilisable</li>
      <li><strong>Aucun secret longue durée</strong> dans GitHub</li>
      <li>Contexte borné : branche ou environment</li>
    </ul>
  </div>
  <pre style="flex:1;margin:0;background:#1e1e2e;border:1px solid rgba(255,255,255,0.1);border-radius:8px;padding:10px 12px;font-size:0.52em;line-height:1.55;color:#cdd6f4;overflow:hidden;"><code><span style="color:#6c7086"># Dans le workflow</span>
<span style="color:#6c7086"># pas de mot de passe</span>
- <span style="color:#89b4fa">uses</span>: azure/login@v2
  <span style="color:#89b4fa">with</span>:
    <span style="color:#89b4fa">client-id</span>:
      ${{ secrets.AZURE_CLIENT_ID }}
    <span style="color:#89b4fa">tenant-id</span>:
      ${{ secrets.AZURE_TENANT_ID }}
    <span style="color:#89b4fa">subscription-id</span>:
      ${{ secrets.AZURE_SUBSCRIPTION_ID }}</code></pre>
</div>

---

### Quiz · OIDC

# Qu'est-ce qu'on stocke dans GitHub Secrets avec OIDC ?

<div style="background:var(--card);border:1px solid var(--border);border-radius:12px;padding:14px 18px;margin-top:8px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.58em;text-transform:uppercase;letter-spacing:0.15em;color:var(--purple);margin-bottom:10px;">Question 2 / 4</div>
  <div style="font-family:'Work Sans';font-weight:600;font-size:0.78em;color:var(--light);margin-bottom:12px;">Avec OIDC configuré, quels éléments se trouvent dans les GitHub Secrets ?</div>
  <div style="display:flex;flex-direction:column;gap:6px;">
    <div style="background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:8px 12px;font-size:0.66em;color:var(--body);">A · Le mot de passe du Service Principal</div>
    <div style="background:rgba(221,255,69,0.1);border:1px solid var(--lime);border-radius:8px;padding:8px 12px;font-size:0.66em;color:var(--light);">B · Le Client ID, Tenant ID et Subscription ID (pas de mot de passe)</div>
    <div style="background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:8px 12px;font-size:0.66em;color:var(--body);">C · Rien du tout, les secrets sont dans Key Vault</div>
  </div>
</div>

<div style="margin-top:8px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:8px 12px;font-size:0.61em;color:var(--body);">
  <strong style="color:var(--lime);">Réponse : B</strong> — Les IDs sont des identifiants, pas des secrets. C'est Azure Entra qui émet le token temporaire à la demande.
</div>

---

### Architecture du lab

# Ce que vous allez manipuler

<div style="display:flex;gap:12px;margin-top:14px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:0.55em;color:var(--orange);font-family:'Work Sans';font-weight:700;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:6px;">Workflows GitHub</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.65em;color:var(--body);line-height:1.7;">
      <li><code>ci-train.yml</code> — lint + test + AML</li>
      <li><code>cd-deploy-dev.yml</code> — image + AKS dev</li>
      <li><code>cd-deploy-aml-endpoint.yml</code> — Managed Endpoint</li>
      <li><code>cd-deploy-prod.yml</code> — promotion prod</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:0.55em;color:var(--lime);font-family:'Work Sans';font-weight:700;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:6px;">Azure Resources</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.65em;color:var(--body);line-height:1.7;">
      <li>Azure ML Workspace → jobs, registry</li>
      <li>Azure Container Registry → images</li>
      <li>AKS dev/prod → serving</li>
      <li>App Insights → telemetry HTTP</li>
      <li>Key Vault → secrets</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:0.55em;color:var(--cyan);font-family:'Work Sans';font-weight:700;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:6px;">Stratégie de branches</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.65em;color:var(--body);line-height:1.7;">
      <li><code>dev</code> → push déclenche CI auto</li>
      <li><code>main</code> → PR et promotion prod</li>
      <li>CD dev → auto après CI verte, <strong>rejouable manuellement</strong></li>
      <li>CD prod → approbation requise</li>
    </ul>
  </div>
</div>

---

### Takeaway · Sécurité CI/CD

# À retenir avant la démo

<div style="background:linear-gradient(135deg,rgba(255,103,69,0.1),rgba(118,87,255,0.07));border:1px solid var(--orange);border-radius:14px;padding:14px 18px;margin-top:10px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.55em;text-transform:uppercase;letter-spacing:0.18em;color:var(--orange);margin-bottom:10px;">Points clés · Parties 1-3</div>
  <ul style="margin:0;padding-left:1.2em;color:var(--offwhite);font-size:0.66em;line-height:1.65;">
    <li>⚠️ <strong>Anti-pattern dans ce repo :</strong> <code>ci-train.yml</code> mélange CI et entraînement AML → bloque les merges 1-2h par commit</li>
    <li>✅ <strong>Bonne pratique :</strong> CI rapide (5-10 min) séparée du Pipeline ML (30min-2h, déclenché par schedule/event)</li>
    <li>Le quality gate dans <code>evaluate_model</code> bloque l'enregistrement du modèle, pas directement la CI</li>
    <li>OIDC = <strong>aucun secret longue durée</strong> dans GitHub</li>
    <li><strong>L'identité du pipeline</strong> compte autant que le code du pipeline</li>
    <li>Dans ce repo, le CD dev peut partir <strong>automatiquement</strong> après la CI, mais il est aussi <strong>rejouable manuellement</strong> pour la démonstration</li>
  </ul>
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->

### Démo guidée · Parties 1-3

# On passe à la démo

## Exécution du pipeline CI/CD complet — en direct

---

### Démo 1 · Vue d'ensemble

# Ce qu'on va observer ensemble

<div style="display:flex;gap:0;margin-top:18px;align-items:stretch;">
  <div style="flex:1;background:rgba(255,103,69,0.1);border:1px solid rgba(255,103,69,0.3);border-radius:10px 0 0 10px;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">1️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--orange);margin-bottom:4px;">Push → CI</div>
    <div style="font-size:0.6em;color:var(--body);">lint · tests unitaires · soumission pipeline AML</div>
  </div>
  <div style="flex:1;background:rgba(221,255,69,0.08);border:1px solid rgba(221,255,69,0.2);border-left:0;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">2️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--lime);margin-bottom:4px;">Pipeline AML</div>
    <div style="font-size:0.6em;color:var(--body);">prep → train → evaluate → quality gate</div>
  </div>
  <div style="flex:1;background:rgba(0,229,238,0.06);border:1px solid rgba(0,229,238,0.2);border-left:0;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">3️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--cyan);margin-bottom:4px;">CD → AKS</div>
    <div style="font-size:0.6em;color:var(--body);">image ACR · déploiement pod · endpoint HTTP</div>
  </div>
  <div style="flex:1;background:rgba(118,87,255,0.08);border:1px solid rgba(118,87,255,0.2);border-left:0;border-radius:0 10px 10px 0;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">4️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--violet);margin-bottom:4px;">Test live</div>
    <div style="font-size:0.6em;color:var(--body);">curl /predict → JSON · logs dans App Insights</div>
  </div>
</div>

<div style="margin-top:16px;background:rgba(255,103,69,0.06);border:1px solid rgba(255,103,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  📍 Repo : <code>.github/workflows/ci-train.yml</code> + <code>cd-deploy-dev.yml</code> + <code>mlops/pipelines/pipeline.yml</code>
</div>

---

### Démo 1 · Déroulé pédagogique

# Ce qu'on observe à chaque étape

<div style="display:flex;flex-direction:column;gap:4px;margin-top:6px;">
  <div style="display:flex;gap:8px;align-items:stretch;">
    <div style="min-width:30px;height:30px;border-radius:50%;background:var(--orange);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.68em;color:white;flex-shrink:0;align-self:center;">1</div>
    <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--orange);border-radius:8px;padding:6px 10px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.58em;color:var(--offwhite);">Prérequis RBAC</div>
      <div style="font-size:0.54em;color:var(--body);line-height:1.35;">OIDC doit avoir les droits sur <code>rg-mlopslab-dev</code>. <strong>Sans rôle, pas de pipeline</strong>.</div>
    </div>
  </div>
  <div style="display:flex;gap:8px;align-items:stretch;">
    <div style="min-width:30px;height:30px;border-radius:50%;background:var(--orange);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.68em;color:white;flex-shrink:0;align-self:center;">2</div>
    <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--orange);border-radius:8px;padding:6px 10px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.58em;color:var(--offwhite);">Lire le workflow avant de pousser</div>
      <div style="font-size:0.54em;color:var(--body);line-height:1.35;">Repérer <code>on:</code>, <code>needs:</code>, <code>--stream</code>. <strong>Comprendre avant d'exécuter</strong>.</div>
    </div>
  </div>
  <div style="display:flex;gap:8px;align-items:stretch;">
    <div style="min-width:30px;height:30px;border-radius:50%;background:var(--lime);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--navy);flex-shrink:0;align-self:center;">3</div>
    <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--lime);border-radius:8px;padding:6px 10px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.58em;color:var(--offwhite);">Push → CI déclenchée</div>
      <div style="font-size:0.54em;color:var(--body);line-height:1.35;">Git déclenche un job AML : <code>prep_data</code> → <code>train_model</code> → <code>evaluate_model</code>.</div>
    </div>
  </div>
  <div style="display:flex;gap:8px;align-items:stretch;">
    <div style="min-width:30px;height:30px;border-radius:50%;background:var(--lime);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--navy);flex-shrink:0;align-self:center;">4</div>
    <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--lime);border-radius:8px;padding:6px 10px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.58em;color:var(--offwhite);">Quality gate en action</div>
      <div style="font-size:0.54em;color:var(--body);line-height:1.35;">MLflow log <code>accuracy</code>. Si ≥ 0.90, le pipeline continue ; sinon <code>sys.exit(1)</code>.</div>
    </div>
  </div>
  <div style="display:flex;gap:8px;align-items:stretch;">
    <div style="min-width:30px;height:30px;border-radius:50%;background:var(--cyan);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--navy);flex-shrink:0;align-self:center;">5</div>
    <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--cyan);border-radius:8px;padding:6px 10px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.58em;color:var(--offwhite);">CD dev : image → ACR → AKS</div>
      <div style="font-size:0.54em;color:var(--body);line-height:1.35;">La chaîne build → push ACR → déploiement pod est rejouée à la demande.</div>
    </div>
  </div>
  <div style="display:flex;gap:8px;align-items:stretch;">
    <div style="min-width:30px;height:30px;border-radius:50%;background:var(--violet);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.68em;color:white;flex-shrink:0;align-self:center;">6</div>
    <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--violet);border-radius:8px;padding:6px 10px;">
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.58em;color:var(--offwhite);">Tester le service en live</div>
      <div style="font-size:0.54em;color:var(--body);line-height:1.35;"><code>curl /predict</code> → JSON : la boucle commit → modèle → API est fermée.</div>
    </div>
  </div>
</div>

<div style="margin-top:4px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:4px 8px;font-size:0.52em;color:var(--body);line-height:1.25;">
  📘 <strong>Commandes détaillées :</strong> <code>lab/partie2.md</code> et <code>lab/partie3.md</code> — les slides donnent le <em>pourquoi</em>, le lab donne le <em>comment</em>.
</div>

---

### Récap Démo 1

# Ce qu'on vient de voir

<div style="display:flex;gap:10px;margin-top:14px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.58em;color:var(--orange);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:8px;">CI</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.65em;color:var(--body);line-height:1.8;">
      <li>Workflow CI déclenché sur push ✓</li>
      <li>Job AML exécuté (3 étapes) ✓</li>
      <li>Accuracy loggée dans MLflow ✓</li>
      <li>Quality gate passé (≥ 0.90) ✓</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.58em;color:var(--lime);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:8px;">CD dev</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.65em;color:var(--body);line-height:1.8;">
      <li>CD déclenché manuellement ✓</li>
      <li>Image dans ACR ✓</li>
      <li>Pod AKS en état Running ✓</li>
      <li>curl /predict → réponse JSON ✓</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.58em;color:var(--cyan);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:8px;">Concepts</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.65em;color:var(--body);line-height:1.8;">
      <li>CI vs CD : différence claire ✓</li>
      <li>Quality gate : rôle compris ✓</li>
      <li>OIDC : pas de secret SP ✓</li>
      <li>CI locale ≠ CI cloud ✓</li>
    </ul>
  </div>
</div>

---

<!-- _class: break -->
<!-- _paginate: false -->

# ☕ Pause

## Reprise dans 1h

### Parties 3-5 : Serving · Monitoring · Gouvernance

---

<!-- _class: session2 -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

<img src="./assets/logos/Liora_Logo_White.svg" style="height:36px;margin-top:40px;margin-bottom:12px;opacity:0.85;">

### Parties 3-5 · Après-midi

# Serving, Monitoring
# & Gouvernance

## Du déploiement à l'exploitation en production


<span class="tag tag-cyan">Partie 3 · Serving</span>&nbsp;
<span class="tag tag-lime">Partie 4 · Tracking</span>&nbsp;
<span class="tag tag-violet">Partie 5 · Gouvernance</span>

<div style="margin-top:24px;display:flex;gap:6px;justify-content:center;">
  <div style="width:40px;height:3px;border-radius:2px;background:var(--cyan);"></div>
  <div style="width:40px;height:3px;border-radius:2px;background:var(--lime);"></div>
  <div style="width:40px;height:3px;border-radius:2px;background:var(--violet);"></div>
</div>

---

### Récap · Parties 1-3

# Ce qu'on a vu ce matin

<div style="display:flex;gap:10px;margin-top:14px;">
  <div style="flex:1;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.2);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.65em;font-family:'Work Sans';font-weight:700;color:var(--orange);margin-bottom:6px;">Partie 1 · Fondations</div>
    <div style="font-size:0.63em;color:var(--body);line-height:1.6;">La CI ML valide code + pipeline AML. La CD livre un comportement de prédiction, pas juste du code.</div>
  </div>
  <div style="flex:1;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.65em;font-family:'Work Sans';font-weight:700;color:var(--lime);margin-bottom:6px;">Partie 2 · Infra</div>
    <div style="font-size:0.63em;color:var(--body);line-height:1.6;">Terraform provisionne l'environnement complet. Un même <code>main.tf</code> pour dev et prod.</div>
  </div>
  <div style="flex:1;background:rgba(118,87,255,0.08);border:1px solid rgba(118,87,255,0.2);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.65em;font-family:'Work Sans';font-weight:700;color:var(--violet);margin-bottom:6px;">Partie 3 · CI/CD</div>
    <div style="font-size:0.63em;color:var(--body);line-height:1.6;">OIDC, quality gate, GH Actions + Démo : CI → CD dev → AKS → curl /predict ✓</div>
  </div>
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->

### Partie 3 · Serving

# Deux modes de serving

## AKS ou AML Managed Endpoint : comment choisir ?

---

### AKS : ce que vous contrôlez

# Serving sur AKS — Contrôle applicatif

<div style="display:flex;gap:16px;margin-top:12px;align-items:stretch;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--orange);margin-bottom:8px;">Ce que l'équipe gère explicitement</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.64em;color:var(--body);line-height:1.8;">
      <li><strong>Image Docker</strong> avec runtime de serving dédié</li>
      <li><strong>Dépendances serving séparées</strong> du training</li>
      <li><strong>Manifest Kubernetes</strong> : Deployment + Service</li>
      <li><strong>IP externe</strong> exposée par le LoadBalancer</li>
      <li><strong>Instrumentation Flask</strong> vers App Insights</li>
    </ul>
  </div>
  <div style="width:280px;background:var(--card);border:1px solid var(--border);border-radius:10px;overflow:hidden;">
    <img src="./assets/images/servers.jpg" style="width:100%;height:180px;object-fit:cover;display:block;">
    <div style="padding:10px 12px;font-size:0.58em;color:var(--muted);">AKS = plus de contrôle sur le runtime, le réseau et le cycle de vie du conteneur.</div>
  </div>
</div>

<div style="margin-top:10px;background:rgba(255,103,69,0.06);border:1px solid rgba(255,103,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  <strong>Bonne pratique :</strong> séparer les dépendances training et serving. L'image AKS est plus légère et plus stable.
</div>

---

### AML Managed Endpoint : ce qu'Azure gère

# Serving géré — La logique plateforme

<div style="display:flex;gap:16px;margin-top:12px;align-items:stretch;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--cyan);margin-bottom:8px;">Ce qu'Azure ML prend en charge</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.64em;color:var(--body);line-height:1.8;">
      <li><strong>Cycle endpoint / deployment</strong></li>
      <li><strong>Intégration native</strong> avec le registre AML</li>
      <li><strong>Scaling</strong> et runtime partiellement gérés</li>
      <li>Mais il faut toujours fournir <code>score.py</code></li>
      <li>Et un <strong>environnement d'inférence correct</strong></li>
    </ul>
  </div>
  <div style="width:280px;background:var(--card);border:1px solid var(--border);border-radius:10px;overflow:hidden;">
    <img src="./assets/images/cloud_network.jpg" style="width:100%;height:180px;object-fit:cover;display:block;">
    <div style="padding:10px 12px;font-size:0.58em;color:var(--muted);">Managed Endpoint = plus rapide à industrialiser quand on veut rester proche des primitives AML.</div>
  </div>
</div>

<div style="margin-top:10px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  Managed Endpoint ≠ "aucune question technique". Il faut encore un environnement d'inférence et un <code>score.py</code> compatible.
</div>

---

### Choisir le mode de serving

# Cadre de décision

| Question | AKS | AML Managed Endpoint |
|---|---|---|
| Mon équipe a une culture Kubernetes | ✅ Oui | Pas nécessaire |
| Je veux contrôler finement le runtime | ✅ Oui | Moins |
| Je veux aller plus vite au départ | Moins | ✅ Oui |
| Je veux un registre de modèles intégré | ❌ Non automatique | ✅ Oui |
| Je veux des logs HTTP dans App Insights | ✅ Oui (Flask) | Possible |
| Je veux mutualiser avec d'autres workloads | ✅ Oui | Non |

<div style="margin-top:10px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  Dans la séquence <strong>versioning + monitoring</strong> de l'après-midi, le modèle visible dans AML dépend du workflow <strong>Managed Endpoint</strong>, pas du déploiement AKS.
</div>

---

### Quiz · Serving

# Quel workflow enregistre le modèle dans AML ?

<div style="background:var(--card);border:1px solid var(--border);border-radius:12px;padding:20px 24px;margin-top:12px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.6em;text-transform:uppercase;letter-spacing:0.15em;color:var(--purple);margin-bottom:14px;">Question 3 / 4</div>
  <div style="font-family:'Work Sans';font-weight:600;font-size:0.85em;color:var(--light);margin-bottom:16px;">Je veux que le modèle <code>iris-classifier</code> apparaisse dans le registre du workspace AML. Quel workflow déclencher ?</div>
  <div style="display:flex;flex-direction:column;gap:8px;">
    <div style="background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:10px 14px;font-size:0.7em;color:var(--body);">A · <code>ci-train.yml</code></div>
    <div style="background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:10px 14px;font-size:0.7em;color:var(--body);">B · <code>cd-deploy-dev.yml</code> (déploiement AKS)</div>
    <div style="background:rgba(221,255,69,0.1);border:1px solid var(--lime);border-radius:8px;padding:10px 14px;font-size:0.7em;color:var(--light);">C · <code>cd-deploy-aml-endpoint.yml</code></div>
  </div>
</div>

<div style="margin-top:10px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.63em;color:var(--body);">
  <strong style="color:var(--lime);">Réponse : C</strong> — Le déploiement AKS n'enregistre pas le modèle dans AML. Seul le workflow Managed Endpoint le fait.
</div>

---

<!-- _class: transition-lime -->
<!-- _paginate: false -->

### Partie 4 — Tracking & Monitoring

# Monitoring multi-niveaux

## Observer un modèle en production ne se résume pas à regarder la latence

---

### Les 4 niveaux d'observabilité

# Ce qu'on regarde à chaque niveau

| Niveau | Ce qu'on regarde | Outil dans ce repo |
|---|---|---|
| **Applicatif** | Requêtes HTTP · erreurs · latence | Application Insights |
| **ML** | Runs · métriques · versions modèle | Azure ML Studio |
| **Plateforme** | Pods · rollout · service exposé | AKS / `kubectl` |
| **Gouvernance** | Qui a le droit d'agir | RBAC · Entra ID · Key Vault |

<div style="margin-top:12px;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.25);border-radius:10px;padding:14px 16px;font-size:0.68em;color:var(--body);">
  <strong>Erreurs classiques :</strong><br>
  · Une requête <code>200</code> ne dit rien sur la qualité du modèle<br>
  · Un bon score offline ne dit rien sur la santé du service<br>
  · Une alerte infra ne dit rien sur un drift métier
</div>

---

### Application Insights & KQL

# Observer le trafic HTTP du service AKS

```kusto
// Requêtes récentes
requests
| where timestamp > ago(30m)
| order by timestamp desc
| take 20

// Succès / codes HTTP
requests
| where timestamp > ago(30m)
| summarize count() by success, resultCode

// Volume dans le temps (buckets 5 min)
requests
| where timestamp > ago(30m)
| summarize count() by bin(timestamp, 5m), success
| order by timestamp desc

// Traces applicatives
traces
| where timestamp > ago(30m)
| order by timestamp desc
| take 20
```

---

### Exercice · KQL

# À vous d'écrire une requête

<div style="background:var(--card);border:1px solid var(--border);border-radius:12px;padding:18px 22px;margin-top:12px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.55em;text-transform:uppercase;letter-spacing:0.18em;color:var(--orange);margin-bottom:12px;">Exercice · 6 min</div>
  <div style="font-size:0.74em;color:var(--body);line-height:1.7;">
    Dans Azure Portal → votre ressource App Insights → <strong>Logs</strong> (Query Hub).<br><br>
    <strong>Écrivez une requête KQL qui :</strong>
    <ol style="margin-top:8px;padding-left:1.3em;">
      <li>Prend les requêtes des <strong>dernières 1h</strong></li>
      <li>Filtre uniquement les requêtes en <strong>échec</strong> (<code>success == false</code>)</li>
      <li>Affiche le <code>resultCode</code>, le <code>url</code> et le <code>timestamp</code></li>
    </ol>
  </div>
</div>

<div style="margin-top:10px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:10px 14px;font-size:0.63em;color:var(--body);">
  Si aucune requête en échec : simuler une erreur avec <code>curl -X POST .../predict -d 'invalid'</code> puis relancer.
</div>

---

<!-- _class: transition-lime -->
<!-- _paginate: false -->

### Partie 4 · Versioning

# Registre de modèles
# & versioning

## Du run MLflow au modèle en production

---

### MLflow dans AML

# Tracking manuel avec mlflow.start_run()

<div style="display:flex;gap:10px;margin-top:14px;align-items:stretch;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--orange);text-transform:uppercase;margin-bottom:6px;">1. Le run devient observable</div>
    <div style="font-size:0.6em;color:var(--body);line-height:1.55;">`mlflow.start_run()` crée une frontière claire : ce qui se passe pendant l'entraînement est enregistré comme un <strong>run</strong>.</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--lime);text-transform:uppercase;margin-bottom:6px;">2. Le run laisse des preuves</div>
    <div style="font-size:0.6em;color:var(--body);line-height:1.55;">On logge les <strong>paramètres</strong>, les <strong>métriques</strong> et plus tard les <strong>artefacts</strong> pour comparer les essais entre eux.</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--cyan);text-transform:uppercase;margin-bottom:6px;">3. AML Studio sert à comparer</div>
    <div style="font-size:0.6em;color:var(--body);line-height:1.55;">Le lab montre ensuite comment retrouver ces runs dans AML Studio pour choisir le bon modèle avant l'enregistrement.</div>
  </div>
</div>

<div style="margin-top:10px;border-left:3px solid var(--orange);background:var(--card);border-radius:0 8px 8px 0;padding:10px 14px;font-size:0.62em;color:var(--offwhite);line-height:1.45;">
  <strong>Message clé :</strong> le tracking ne sert pas à “faire tourner” le modèle, mais à rendre l'entraînement <strong>reproductible</strong>, <strong>comparable</strong> et <strong>auditable</strong>.
</div>

<div style="margin-top:8px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:7px 10px;font-size:0.54em;color:var(--body);line-height:1.35;">
  📘 <strong>Dans le lab :</strong> on ouvre AML Studio pour voir les runs, leurs métriques et les comparer. La slide explique <em>pourquoi</em> c'est important.
</div>

---

### Cycle de vie du modèle

# Du run au modèle enregistré

<div style="display:flex;align-items:stretch;gap:10px;margin-top:14px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:1.4em;margin-bottom:4px;">🧪</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.65em;color:var(--orange);text-transform:uppercase;margin-bottom:5px;">Run</div>
    <div style="font-size:0.58em;color:var(--body);line-height:1.45;">On observe un essai d'entraînement et ses métriques dans AML Studio.</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:1.4em;margin-bottom:4px;">📦</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.65em;color:var(--lime);text-transform:uppercase;margin-bottom:5px;">Registry</div>
    <div style="font-size:0.58em;color:var(--body);line-height:1.45;">Le modèle retenu devient un <strong>actif versionné</strong> et identifiable.</div>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:1.4em;margin-bottom:4px;">🚀</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.65em;color:var(--cyan);text-transform:uppercase;margin-bottom:5px;">Deploy / Rollback</div>
    <div style="font-size:0.58em;color:var(--body);line-height:1.45;">Le déploiement pointe une version précise, et l'ancien modèle reste disponible en retour arrière.</div>
  </div>
</div>

<div style="margin-top:10px;border-left:3px solid var(--lime);background:var(--card);border-radius:0 8px 8px 0;padding:10px 14px;font-size:0.62em;color:var(--offwhite);line-height:1.45;">
  <strong>Message clé :</strong> un bon modèle n'est pas seulement un fichier ; c'est une <strong>version de référence</strong> qu'on peut retrouver, déployer et remplacer.
</div>

<div style="margin-top:8px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:7px 10px;font-size:0.54em;color:var(--body);line-height:1.35;">
  📘 <strong>Dans le lab :</strong> la commande <code>az ml model list</code> sert à vérifier que la version existe. La slide explique surtout <em>à quoi sert</em> cette étape dans le cycle de vie.
</div>

---

### Quiz · Versioning

# Que retourne az ml model list ?

<div style="background:var(--card);border:1px solid var(--border);border-radius:12px;padding:20px 24px;margin-top:12px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:700;font-size:0.6em;text-transform:uppercase;letter-spacing:0.15em;color:var(--purple);margin-bottom:14px;">Question 4 / 4</div>
  <div style="font-family:'Work Sans';font-weight:600;font-size:0.85em;color:var(--light);margin-bottom:16px;">Vous lancez <code>az ml model list --name iris-classifier</code> et n'obtenez aucun résultat. Pourquoi ?</div>
  <div style="display:flex;flex-direction:column;gap:8px;">
    <div style="background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:10px 14px;font-size:0.7em;color:var(--body);">A · Le modèle n'a jamais été entraîné</div>
    <div style="background:rgba(221,255,69,0.1);border:1px solid var(--lime);border-radius:8px;padding:10px 14px;font-size:0.7em;color:var(--light);">B · Le workflow <code>cd-deploy-aml-endpoint.yml</code> n'a pas encore été exécuté</div>
    <div style="background:var(--navy);border:1px solid var(--border);border-radius:8px;padding:10px 14px;font-size:0.7em;color:var(--body);">C · Le déploiement AKS n'a pas réussi</div>
  </div>
</div>

<div style="margin-top:10px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.63em;color:var(--body);">
  <strong style="color:var(--lime);">Réponse : B</strong> — Le déploiement AKS ne crée pas d'entrée dans le registre AML. Seul le workflow Managed Endpoint enregistre <code>iris-classifier</code>.
</div>

---

<!-- _class: transition-lime -->
<!-- _paginate: false -->

### Partie 4 · Drift

# Drift de données
# & alerting

## Détecter la dégradation silencieuse d'un modèle

---

### Data drift vs Concept drift

# Deux types de dégradation à distinguer

<svg width="100%" height="52" viewBox="0 0 640 52" style="margin-top:10px;margin-bottom:6px;">
  <!-- Data drift: two distribution curves -->
  <text x="130" y="12" text-anchor="middle" font-family="Work Sans" font-size="9" font-weight="700" fill="#C445FF">DATA DRIFT — distribution des entrées</text>
  <!-- curve train -->
  <path d="M20 44 C40 44 50 8 80 8 C110 8 120 44 140 44" stroke="#7657FF" stroke-width="2" fill="rgba(118,87,255,0.15)" stroke-linecap="round"/>
  <text x="80" y="30" text-anchor="middle" font-family="Inter" font-size="8" fill="#7657FF">train</text>
  <!-- curve prod -->
  <path d="M100 44 C120 44 145 12 175 12 C205 12 215 44 235 44" stroke="#C445FF" stroke-width="2" fill="rgba(196,69,255,0.12)" stroke-linecap="round"/>
  <text x="175" y="28" text-anchor="middle" font-family="Inter" font-size="8" fill="#C445FF">prod</text>
  <!-- separator -->
  <line x1="320" y1="4" x2="320" y2="48" stroke="#2E2E50" stroke-width="1" stroke-dasharray="4"/>
  <!-- Concept drift: same input, diff output -->
  <text x="480" y="12" text-anchor="middle" font-family="Work Sans" font-size="9" font-weight="700" fill="#7657FF">CONCEPT DRIFT — relation feature→label</text>
  <!-- box train -->
  <rect x="340" y="18" width="70" height="24" rx="4" fill="#252540" stroke="#7657FF" stroke-width="1"/>
  <text x="375" y="34" text-anchor="middle" font-family="Inter" font-size="8" fill="#7657FF">X → y₁ (avant)</text>
  <!-- box prod -->
  <rect x="450" y="18" width="80" height="24" rx="4" fill="#252540" stroke="#C445FF" stroke-width="1"/>
  <text x="490" y="34" text-anchor="middle" font-family="Inter" font-size="8" fill="#C445FF">X → y₂ (après)</text>
  <!-- arrow between -->
  <path d="M410 30 L448 30" stroke="#FF6745" stroke-width="1.5" stroke-dasharray="3" marker-end="url(#arr3)"/>
  <text x="430" y="25" text-anchor="middle" font-family="Inter" font-size="7" fill="#FF6745">dérive</text>
  <!-- model OK both -->
  <rect x="560" y="18" width="70" height="24" rx="4" fill="rgba(34,197,94,0.1)" stroke="#22c55e" stroke-width="1"/>
  <text x="595" y="27" text-anchor="middle" font-family="Inter" font-size="8" fill="#22c55e">HTTP 200</text>
  <text x="595" y="38" text-anchor="middle" font-family="Inter" font-size="7" fill="#6B6A8A">mais préd. fausse</text>
  <path d="M530 30 L558 30" stroke="#6B6A8A" stroke-width="1" marker-end="url(#arr3)"/>
  <defs><marker id="arr3" markerWidth="5" markerHeight="5" refX="3" refY="2.5" orient="auto"><path d="M0,0 L0,5 L5,2.5 z" fill="#6B6A8A"/></marker></defs>
</svg>

<div style="display:flex;gap:16px;margin-top:6px;">
  <div style="flex:1;background:rgba(196,69,255,0.08);border:1px solid rgba(196,69,255,0.25);border-radius:10px;padding:16px 18px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.72em;color:var(--purple);margin-bottom:8px;">Data Drift</div>
    <div style="font-size:0.68em;color:var(--body);line-height:1.6;">
      La <strong>distribution des entrées change</strong><br><br>
      Exemple : le capteur mesure maintenant en cm au lieu de mm → les features ont une nouvelle échelle<br><br>
      Le modèle reçoit des valeurs hors de sa zone d'entraînement
    </div>
  </div>
  <div style="flex:1;background:rgba(118,87,255,0.08);border:1px solid rgba(118,87,255,0.25);border-radius:10px;padding:16px 18px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.72em;color:var(--violet);margin-bottom:8px;">Concept Drift</div>
    <div style="font-size:0.68em;color:var(--body);line-height:1.6;">
      La <strong>relation entre features et label change</strong><br><br>
      Exemple : les habitudes d'achat changent après une crise → le modèle de recommandation prédit avec des patterns obsolètes<br><br>
      Le modèle répond, mais de moins en moins bien
    </div>
  </div>
</div>

---

### Le piège du 200 OK

# Drift ≠ erreur HTTP

<div style="display:flex;gap:14px;margin-top:14px;align-items:stretch;">
  <div style="flex:1.2;background:var(--card);border:1px solid var(--border);border-radius:12px;padding:16px 18px;">
    <div style="display:flex;align-items:center;gap:10px;margin-bottom:10px;">
      <div style="font-size:1.6em;">⚠️</div>
      <div style="font-family:'Work Sans';font-weight:700;font-size:0.72em;color:var(--orange);">Point de confusion fréquent</div>
    </div>
    <div style="font-size:0.66em;color:var(--body);line-height:1.75;">
      Le script de drift envoie des données <em>hors distribution</em>.
      L'API AKS peut continuer à répondre en <strong style="color:#22c55e;">200 OK</strong>.
      <br><br>
      <strong style="color:var(--light);">Donc :</strong> HTTP OK ≠ modèle fiable.
    </div>
  </div>
  <div style="flex:1;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:12px;padding:16px 18px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--lime);margin-bottom:8px;">Ce qu'il faut vraiment suivre</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.8;">
      <li>Distribution des <strong>features en entrée</strong></li>
      <li>Distribution des <strong>prédictions en sortie</strong></li>
      <li><strong>Accuracy réelle</strong> si les labels sont disponibles</li>
    </ul>
  </div>
</div>

---

### Azure Monitor — Alerting

# Alerte HTTP sur les requêtes en échec

<div style="display:flex;gap:14px;margin-top:12px;align-items:stretch;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.64em;color:var(--orange);margin-bottom:8px;">1. Récupérer l'ID App Insights</div>
    <pre style="margin:0;padding:10px 12px;font-size:0.6em;"><code>AI_ID=$(az monitor app-insights component show \
  --app appi-mlopslab-dev \
  --resource-group rg-mlopslab-dev \
  --query id -o tsv)</code></pre>
  </div>
  <div style="flex:1.25;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.64em;color:var(--cyan);margin-bottom:8px;">2. Créer l'alerte métrique</div>
    <pre style="margin:0;padding:10px 12px;font-size:0.58em;"><code>az monitor metrics alert create \
  --name alert-failed-requests-dev \
  --resource-group rg-mlopslab-dev \
  --scopes "$AI_ID" \
  --condition "count requests/failed > 5" \
  --window-size 5m \
  --evaluation-frequency 1m</code></pre>
  </div>
</div>

<div style="margin-top:10px;background:rgba(255,103,69,0.06);border:1px solid rgba(255,103,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.64em;color:var(--body);">
  Un drift métier <strong>n'est pas détectable par cette alerte</strong>. Elle détecte les erreurs techniques, pas la dégradation des prédictions.
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->

### Démo guidée · Parties 3-5

# On passe à la démo

## Managed Endpoint · Versioning · Drift · RBAC

---

### Démo 2 · Vue d'ensemble

# Ce qu'on va observer ensemble

<div style="display:flex;gap:0;margin-top:18px;align-items:stretch;">
  <div style="flex:1;background:rgba(0,229,238,0.1);border:1px solid rgba(0,229,238,0.3);border-radius:10px 0 0 10px;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">1️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--cyan);margin-bottom:4px;">Managed Endpoint</div>
    <div style="font-size:0.6em;color:var(--body);">déploiement AML · enregistrement modèle</div>
  </div>
  <div style="flex:1;background:rgba(221,255,69,0.08);border:1px solid rgba(221,255,69,0.2);border-left:0;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">2️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--lime);margin-bottom:4px;">Model Registry</div>
    <div style="font-size:0.6em;color:var(--body);">versioning · lien run MLflow · rollback</div>
  </div>
  <div style="flex:1;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.2);border-left:0;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">3️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--orange);margin-bottom:4px;">Alerting + Drift</div>
    <div style="font-size:0.6em;color:var(--body);">alerte Azure Monitor · simulation drift</div>
  </div>
  <div style="flex:1;background:rgba(118,87,255,0.08);border:1px solid rgba(118,87,255,0.2);border-left:0;border-radius:0 10px 10px 0;padding:16px;text-align:center;">
    <div style="font-size:1.6em;margin-bottom:6px;">4️⃣</div>
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--violet);margin-bottom:4px;">RBAC + KV</div>
    <div style="font-size:0.6em;color:var(--body);">moindre privilège · secrets sécurisés</div>
  </div>
</div>

<div style="margin-top:16px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  📍 Repo : <code>cd-deploy-aml-endpoint.yml</code> · <code>scripts/generate-drift.py</code> · <code>scripts/setup-rbac.sh</code>
</div>

---

### Démo 2 · Déroulé pédagogique

# Ce qu'on observe à chaque étape

<div style="display:flex;gap:10px;margin-top:6px;align-items:flex-start;">
  <div style="flex:1;display:flex;flex-direction:column;gap:6px;">
    <div style="display:flex;gap:8px;align-items:stretch;">
      <div style="min-width:26px;height:26px;border-radius:50%;background:var(--cyan);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--navy);flex-shrink:0;align-self:center;">1</div>
      <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--cyan);border-radius:8px;padding:5px 10px;">
        <div style="font-family:'Work Sans';font-weight:700;font-size:0.56em;color:var(--offwhite);">Managed Endpoint AML</div>
        <div style="font-size:0.5em;color:var(--body);line-height:1.25;">Azure gère la scale/scoring. Deux runtimes de serving, même modèle.</div>
      </div>
    </div>
    <div style="display:flex;gap:8px;align-items:stretch;">
      <div style="min-width:26px;height:26px;border-radius:50%;background:var(--cyan);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--navy);flex-shrink:0;align-self:center;">2</div>
      <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--cyan);border-radius:8px;padding:5px 10px;">
        <div style="font-family:'Work Sans';font-weight:700;font-size:0.56em;color:var(--offwhite);">Model Registry = source de vérité</div>
        <div style="font-size:0.5em;color:var(--body);line-height:1.25;">Versions, tags, lineage : on sait quel commit a produit quel modèle.</div>
      </div>
    </div>
    <div style="display:flex;gap:8px;align-items:stretch;">
      <div style="min-width:26px;height:26px;border-radius:50%;background:var(--lime);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--navy);flex-shrink:0;align-self:center;">3</div>
      <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--lime);border-radius:8px;padding:5px 10px;">
        <div style="font-family:'Work Sans';font-weight:700;font-size:0.56em;color:var(--offwhite);">Alerte Azure Monitor</div>
        <div style="font-size:0.5em;color:var(--body);line-height:1.25;">Elle voit les erreurs techniques, pas un drift métier silencieux.</div>
      </div>
    </div>
    <div style="display:flex;gap:8px;align-items:stretch;">
      <div style="min-width:26px;height:26px;border-radius:50%;background:var(--lime);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--navy);flex-shrink:0;align-self:center;">4</div>
      <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--lime);border-radius:8px;padding:5px 10px;">
        <div style="font-family:'Work Sans';font-weight:700;font-size:0.56em;color:var(--offwhite);">Trafic normal → baseline</div>
        <div style="font-size:0.5em;color:var(--body);line-height:1.25;">On établit la référence latence + succès dans App Insights.</div>
      </div>
    </div>
  </div>
  <div style="flex:1;display:flex;flex-direction:column;gap:6px;">
    <div style="display:flex;gap:8px;align-items:stretch;">
      <div style="min-width:26px;height:26px;border-radius:50%;background:var(--orange);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.62em;color:white;flex-shrink:0;align-self:center;">5</div>
      <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--orange);border-radius:8px;padding:5px 10px;">
        <div style="font-family:'Work Sans';font-weight:700;font-size:0.56em;color:var(--offwhite);">Drift simulé</div>
        <div style="font-size:0.5em;color:var(--body);line-height:1.25;"><code>generate-drift.py</code> envoie des valeurs hors plage ; l'API répond encore 200 OK.</div>
      </div>
    </div>
    <div style="display:flex;gap:8px;align-items:stretch;">
      <div style="min-width:26px;height:26px;border-radius:50%;background:var(--orange);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.62em;color:white;flex-shrink:0;align-self:center;">6</div>
      <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--orange);border-radius:8px;padding:5px 10px;">
        <div style="font-family:'Work Sans';font-weight:700;font-size:0.56em;color:var(--offwhite);">App Insights</div>
        <div style="font-size:0.5em;color:var(--body);line-height:1.25;">Les requêtes montent, mais le drift ne se voit pas sans logger les features.</div>
      </div>
    </div>
    <div style="display:flex;gap:8px;align-items:stretch;">
      <div style="min-width:26px;height:26px;border-radius:50%;background:var(--violet);display:flex;align-items:center;justify-content:center;font-family:'Work Sans';font-weight:700;font-size:0.62em;color:white;flex-shrink:0;align-self:center;">7</div>
      <div style="flex:1;background:var(--card);border:1px solid var(--border);border-left:3px solid var(--violet);border-radius:8px;padding:5px 10px;">
        <div style="font-family:'Work Sans';font-weight:700;font-size:0.56em;color:var(--offwhite);">RBAC & Key Vault</div>
        <div style="font-size:0.5em;color:var(--body);line-height:1.25;">OIDC pour la CI, Key Vault pour les secrets, MSI pour les services.</div>
      </div>
    </div>
  </div>
</div>

<div style="margin-top:4px;background:rgba(0,229,238,0.05);border:1px solid rgba(0,229,238,0.2);border-radius:8px;padding:4px 8px;font-size:0.5em;color:var(--body);line-height:1.2;">
  📘 <strong>Dans le lab :</strong> chaque étape est détaillée avec les commandes. Ici, on retient le <em>rôle</em> de chaque étape dans le cycle de vie.
</div>

---

### Récap Démo 2

# Ce qu'on vient de voir

<div style="display:flex;gap:10px;margin-top:14px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:0.55em;color:var(--cyan);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:6px;">Serving</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.8;">
      <li>Managed Endpoint AML déployé ✓</li>
      <li>Modèle enregistré dans le registry ✓</li>
      <li>Lineage job → modèle → endpoint ✓</li>
      <li>curl /score → prédiction JSON ✓</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:0.55em;color:var(--lime);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:6px;">Monitoring</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.8;">
      <li>Alerte Azure Monitor créée ✓</li>
      <li>Trafic normal dans App Insights ✓</li>
      <li>Drift simulé → HTTP 200 ✓</li>
      <li>KQL : traces vs requests ✓</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:12px 14px;">
    <div style="font-size:0.55em;color:var(--violet);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:6px;">Gouvernance</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.8;">
      <li>RBAC minimal configuré ✓</li>
      <li>Secret lu depuis Key Vault ✓</li>
      <li>0 secret en clair dans le code ✓</li>
    </ul>
  </div>
</div>

---

### Limites de la démo

# Ce que cette simulation ne couvre pas

<div style="display:flex;gap:14px;margin-top:14px;">
  <div style="flex:1;background:rgba(196,69,255,0.08);border:1px solid rgba(196,69,255,0.25);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--purple);margin-bottom:8px;">Ce qu'on simule ici</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.8;">
      <li>✅ <strong>Data drift</strong> : features hors distribution</li>
      <li>✅ Invisible pour une alerte HTTP</li>
      <li>✅ Détectable via KQL sur les traces</li>
    </ul>
  </div>
  <div style="flex:1;background:rgba(239,68,68,0.06);border:1px solid rgba(239,68,68,0.25);border-radius:10px;padding:14px 16px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--red);margin-bottom:8px;">Ce qu'on ne simule pas</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.63em;color:var(--body);line-height:1.8;">
      <li>❌ <strong>Concept drift</strong> : la relation feature→label change</li>
      <li>❌ Comparaison prédictions vs ground truth</li>
      <li>❌ Seuil statistique sur distribution (ex: PSI, KL divergence)</li>
      <li>❌ Retraining automatique déclenché par dérive</li>
    </ul>
  </div>
</div>

<div style="margin-top:12px;background:rgba(221,255,69,0.06);border:1px solid rgba(221,255,69,0.2);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  Pour aller plus loin : <strong>Azure ML Data Monitor</strong> calcule des métriques de drift automatiquement sur les datasets. Ce n'est pas configuré dans ce lab — c'est une étape suivante naturelle.
</div>

---

<!-- _class: transition-lime -->
<!-- _paginate: false -->

### Partie 5 — Gouvernance

# Gouvernance

## RBAC, Key Vault et séparation dev/prod

---

<!-- _class: governance-compact -->
### Gouvernance — les 3 piliers

# Ce qui rend une plateforme ML crédible en entreprise

<svg width="100%" height="38" viewBox="0 0 680 46" style="margin-top:6px;margin-bottom:4px;">
  <!-- dev env -->
  <rect x="0" y="4" width="140" height="38" rx="6" fill="#252540" stroke="#2E2E50" stroke-width="1"/>
  <text x="70" y="20" text-anchor="middle" font-family="Work Sans" font-size="9" font-weight="700" fill="#B0AFCC">rg-mlopslab-dev</text>
  <text x="70" y="34" text-anchor="middle" font-family="Inter" font-size="8" fill="#6B6A8A">AML · AKS · ACR</text>
  <!-- arrow -->
  <path d="M140 23 L178 23" stroke="#6B6A8A" stroke-width="1.5" stroke-dasharray="4" marker-end="url(#arr4)"/>
  <text x="159" y="18" text-anchor="middle" font-family="Inter" font-size="7" fill="#FF6745">promotion</text>
  <!-- prod env -->
  <rect x="180" y="4" width="140" height="38" rx="6" fill="#252540" stroke="#DDFF45" stroke-width="1.5"/>
  <text x="250" y="20" text-anchor="middle" font-family="Work Sans" font-size="9" font-weight="700" fill="#DDFF45">rg-mlopslab-prod</text>
  <text x="250" y="34" text-anchor="middle" font-family="Inter" font-size="8" fill="#6B6A8A">approbation manuelle</text>
  <!-- separator -->
  <line x1="360" y1="0" x2="360" y2="46" stroke="#2E2E50" stroke-width="1" stroke-dasharray="3"/>
  <!-- RBAC -->
  <rect x="375" y="4" width="90" height="38" rx="6" fill="rgba(255,103,69,0.1)" stroke="#FF6745" stroke-width="1"/>
  <text x="420" y="20" text-anchor="middle" font-family="Work Sans" font-size="9" font-weight="700" fill="#FF6745">RBAC</text>
  <text x="420" y="33" text-anchor="middle" font-family="Inter" font-size="8" fill="#B0AFCC">moindre privilège</text>
  <!-- arrow -->
  <path d="M465 23 L483 23" stroke="#6B6A8A" stroke-width="1" marker-end="url(#arr4)"/>
  <!-- Key Vault -->
  <rect x="485" y="4" width="90" height="38" rx="6" fill="rgba(221,255,69,0.08)" stroke="#DDFF45" stroke-width="1"/>
  <text x="530" y="20" text-anchor="middle" font-family="Work Sans" font-size="9" font-weight="700" fill="#DDFF45">Key Vault</text>
  <text x="530" y="33" text-anchor="middle" font-family="Inter" font-size="8" fill="#B0AFCC">0 secret en clair</text>
  <!-- arrow -->
  <path d="M575 23 L593 23" stroke="#6B6A8A" stroke-width="1" marker-end="url(#arr4)"/>
  <!-- OIDC -->
  <rect x="595" y="4" width="85" height="38" rx="6" fill="rgba(118,87,255,0.1)" stroke="#7657FF" stroke-width="1"/>
  <text x="637" y="20" text-anchor="middle" font-family="Work Sans" font-size="9" font-weight="700" fill="#7657FF">OIDC</text>
  <text x="637" y="33" text-anchor="middle" font-family="Inter" font-size="8" fill="#B0AFCC">id. fédérée CI</text>
  <defs><marker id="arr4" markerWidth="5" markerHeight="5" refX="3" refY="2.5" orient="auto"><path d="M0,0 L0,5 L5,2.5 z" fill="#6B6A8A"/></marker></defs>
</svg>

<div style="display:flex;gap:10px;margin-top:2px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--orange);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--orange);margin-bottom:6px;">RBAC — Moindre privilège</div>
    <ul style="margin:0;padding-left:1.05em;font-size:0.58em;color:var(--body);line-height:1.45;">
      <li><code>AzureML Data Scientist</code> → scope RG</li>
      <li><code>AKS Cluster User Role</code> → scope AKS seulement</li>
      <li><code>Key Vault Secrets User</code> → scope KV seulement</li>
      <li>Pipeline CI/CD : <code>Contributor</code> scope RG, <strong>pas subscription</strong></li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--lime);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--lime);margin-bottom:6px;">Key Vault — Centralisation des secrets</div>
    <ul style="margin:0;padding-left:1.05em;font-size:0.58em;color:var(--body);line-height:1.45;">
      <li>Secrets API, connexions DB, clés</li>
      <li>Rotation possible sans changer le code</li>
      <li>Audit trail intégré</li>
      <li>Jamais de secret en clair dans le code</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-top:3px solid var(--cyan);border-radius:10px;padding:10px 12px;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.62em;color:var(--cyan);margin-bottom:6px;">Séparation dev / prod</div>
    <ul style="margin:0;padding-left:1.05em;font-size:0.58em;color:var(--body);line-height:1.45;">
      <li>Resource groups séparés</li>
      <li>GitHub Environment <code>production</code></li>
      <li>Approbation manuelle obligatoire</li>
      <li>Promotion d'artefact (pas rebuild)</li>
    </ul>
  </div>
</div>

---

### Anti-patterns à connaître

# Ce qu'il ne faut pas faire

<div style="display:flex;gap:16px;margin-top:14px;">
  <div style="flex:1;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--orange);margin-bottom:10px;">Anti-patterns CI/CD ML</div>
    <ul style="font-size:0.67em;color:var(--body);line-height:1.8;padding-left:1.2em;">
      <li>Reconstruire différemment en prod</li>
      <li>Promouvoir sans validation ni observation des métriques</li>
      <li>Valider seulement la CI locale</li>
      <li>Ignorer le quality gate ("on verra en prod")</li>
    </ul>
  </div>
  <div style="flex:1;">
    <div style="font-family:'Work Sans';font-weight:700;font-size:0.68em;color:var(--orange);margin-bottom:10px;">Anti-patterns monitoring</div>
    <ul style="font-size:0.67em;color:var(--body);line-height:1.8;padding-left:1.2em;">
      <li>Confondre "monitoring HTTP" et "monitoring ML"</li>
      <li>Croire qu'un endpoint 200 suffit</li>
      <li>Parler de gouvernance seulement à la fin</li>
      <li>Monitorer la latence mais pas les prédictions</li>
    </ul>
  </div>
</div>

<div style="margin-top:12px;background:rgba(255,103,69,0.08);border:1px solid rgba(255,103,69,0.25);border-radius:8px;padding:10px 14px;font-size:0.65em;color:var(--body);">
  La séparation <em>identité technique du pipeline</em> vs <em>droits donnés à une équipe humaine</em> est essentielle pour l'auditabilité.
</div>

---

### Pour aller plus loin

# Ce que ce repo ne montre pas encore

<div style="display:flex;gap:12px;margin-top:14px;">
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.6em;color:var(--purple);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:6px;">Monitoring ML avancé</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.7;">
      <li>Suivi statistique de la distribution des features</li>
      <li>Comparaison prédictions vs ground truth</li>
      <li>Détection automatique de concept drift</li>
      <li>Retraining déclenché par seuil</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.6em;color:var(--cyan);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:6px;">CI/CD avancé</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.7;">
      <li>Blue/green deployment sur AKS</li>
      <li>Canary releases sur Managed Endpoint</li>
      <li>Tests d'intégration post-déploiement</li>
      <li>Rollback automatique sur dégradation</li>
    </ul>
  </div>
  <div style="flex:1;background:var(--card);border:1px solid var(--border);border-radius:10px;padding:14px 16px;">
    <div style="font-size:0.6em;color:var(--violet);font-family:'Work Sans';font-weight:700;text-transform:uppercase;margin-bottom:6px;">Gouvernance avancée</div>
    <ul style="margin:0;padding-left:1.1em;font-size:0.62em;color:var(--body);line-height:1.7;">
      <li>Azure Policy pour conformité</li>
      <li>Workload Identity pour les pods AKS</li>
      <li>Gestion des coûts et budgets</li>
      <li>Diagnostic settings centralisés</li>
    </ul>
  </div>
</div>

---

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

<img src="./assets/logos/Liora_Logo_White.svg" style="height:42px;margin-bottom:14px;opacity:0.9;">

### Récap final

# 6 idées à emporter

<div style="display:flex;flex-direction:column;gap:8px;margin-top:14px;max-width:700px;text-align:left;">
  <div style="background:rgba(255,103,69,0.12);border-left:3px solid var(--orange);border-radius:0 8px 8px 0;padding:8px 16px;font-size:0.72em;color:var(--offwhite);">
    <strong>1.</strong> La CI ML valide le code <em>et</em> l'exécution dans Azure ML — pas seulement le lint et les tests locaux
  </div>
  <div style="background:rgba(221,255,69,0.08);border-left:3px solid var(--lime);border-radius:0 8px 8px 0;padding:8px 16px;font-size:0.72em;color:var(--offwhite);">
    <strong>2.</strong> Le quality gate sur les métriques bloque automatiquement le déploiement si le modèle est insuffisant
  </div>
  <div style="background:rgba(0,229,238,0.08);border-left:3px solid var(--cyan);border-radius:0 8px 8px 0;padding:8px 16px;font-size:0.72em;color:var(--offwhite);">
    <strong>3.</strong> OIDC = aucun secret longue durée dans GitHub — l'identité du pipeline compte autant que son code
  </div>
  <div style="background:rgba(118,87,255,0.1);border-left:3px solid var(--violet);border-radius:0 8px 8px 0;padding:8px 16px;font-size:0.72em;color:var(--offwhite);">
    <strong>4.</strong> AKS et AML Managed Endpoint ne jouent pas le même rôle — le choix dépend de l'organisation, pas de la "pureté technique"
  </div>
  <div style="background:rgba(196,69,255,0.08);border-left:3px solid var(--purple);border-radius:0 8px 8px 0;padding:8px 16px;font-size:0.72em;color:var(--offwhite);">
    <strong>5.</strong> HTTP 200 ≠ modèle correct — le drift métier est invisible pour une alerte sur les failed requests
  </div>
  <div style="background:rgba(255,103,69,0.08);border-left:3px solid var(--muted);border-radius:0 8px 8px 0;padding:8px 16px;font-size:0.72em;color:var(--offwhite);">
    <strong>6.</strong> La gouvernance (RBAC, KV, séparation dev/prod) n'est pas un "détail enterprise" — c'est ce qui rend une démo reproductible en production
  </div>
</div>
