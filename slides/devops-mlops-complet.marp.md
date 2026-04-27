---
marp: true
theme: default
paginate: true
html: true
style: |
  @import url('https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700;800;900&family=Inter:wght@300;400;500;600&display=swap');

  :root {
    --navy:    #1A1A33;
    --navy2:   #252540;
    --orange:  #FF6745;
    --lime:    #DDFF45;
    --cyan:    #00E5EE;
    --violet:  #7657FF;
    --purple:  #C445FF;
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
    padding: 44px 64px;
    line-height: 1.55;
    box-sizing: border-box;
    overflow: hidden;
  }

  h1 {
    font-family: 'Work Sans', sans-serif;
    font-weight: 800;
    font-size: 2.2em;
    color: #FFF;
    line-height: 1.12;
    margin: 0 0 .18em;
  }

  h2 {
    font-family: 'Inter', sans-serif;
    font-weight: 300;
    font-size: 1.05em;
    color: var(--body);
    margin: 0 0 .3em;
  }

  h3 {
    font-family: 'Work Sans', sans-serif;
    font-weight: 600;
    font-size: .54em;
    color: var(--muted);
    text-transform: uppercase;
    letter-spacing: .18em;
    margin: 0 0 .55em;
  }

  strong { color: var(--orange); font-weight: 600; }
  em     { color: var(--lime); font-style: normal; font-weight: 500; }
  a      { color: var(--cyan); text-decoration: none; }

  ul, ol { padding-left: 1.3em; color: var(--body); font-size: .78em; margin: 0; }
  li     { margin-bottom: .25em; }
  li::marker { color: var(--orange); }

  table { width: 100%; border-collapse: collapse; font-size: .72em; }
  th {
    font-family: 'Work Sans', sans-serif;
    font-weight: 600;
    font-size: .6em;
    text-transform: uppercase;
    letter-spacing: .12em;
    color: var(--muted);
    border-bottom: 1px solid var(--border);
    padding: 7px 10px;
    text-align: left;
  }
  td { padding: 8px 10px; border-bottom: 1px solid var(--border); color: var(--body); vertical-align: top; }
  tr:hover td { background: rgba(37,37,64,.5); }

  blockquote {
    border-left: 3px solid var(--orange);
    padding: 10px 18px;
    margin: 0;
    background: var(--card);
    border-radius: 0 8px 8px 0;
    font-family: 'Work Sans', sans-serif;
    font-weight: 500;
    font-style: normal;
    color: var(--offwhite);
    font-size: .9em;
  }

  code {
    background: var(--card);
    color: var(--lime);
    padding: 2px 6px;
    border-radius: 4px;
    font-size: .82em;
  }

  header { text-align: right; }
  footer { font-size: .42em; color: var(--muted); }
  section::after { color: var(--muted); font-size: .46em; }

  /* ── LEAD (cover) ── */
  section.lead {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    background: radial-gradient(ellipse at 80% 20%, #2A1040 0%, var(--navy) 60%);
    padding: 60px 72px;
  }
  section.lead h1 {
    font-size: 3em;
    color: #FFF;
    margin-bottom: .12em;
  }
  section.lead h2 { font-size: 1.15em; color: var(--body); }
  section.lead h3 { color: var(--orange); font-size: .6em; }

  /* ── CLOSING ── */
  section.closing {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    background: radial-gradient(ellipse at 30% 70%, #2A1F40 0%, var(--navy) 65%);
  }
  section.closing h1 { font-size: 2.8em; }
  section.closing h2 { color: var(--body); font-size: 1.1em; }

  /* ── TRANSITION ── */
  section.transition {
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    padding-bottom: 72px;
    background: var(--orange);
    position: relative;
    overflow: hidden;
  }
  section.transition::before {
    content: '';
    position: absolute;
    top: -80px;
    right: -80px;
    width: 320px;
    height: 320px;
    border-radius: 50%;
    background: rgba(255,255,255,.07);
  }
  section.transition h1 { color: #FFF; font-size: 3em; margin-bottom: .1em; }
  section.transition h2 { color: rgba(255,255,255,.8); font-weight: 300; }
  section.transition h3 { color: rgba(255,255,255,.6); }

  /* ── TAGS ── */
  .tag {
    font-family: 'Work Sans', sans-serif;
    font-weight: 700;
    font-size: .5em;
    letter-spacing: .12em;
    text-transform: uppercase;
    padding: 3px 10px;
    border-radius: 4px;
    display: inline-block;
  }
  .tag-orange { background: rgba(255,103,69,.2);  color: var(--orange); border: 1px solid var(--orange); }
  .tag-lime   { background: rgba(221,255,69,.15); color: var(--lime);   border: 1px solid var(--lime); }
  .tag-cyan   { background: rgba(0,229,238,.15);  color: var(--cyan);   border: 1px solid var(--cyan); }
  .tag-violet { background: rgba(118,87,255,.2);  color: var(--violet); border: 1px solid var(--violet); }

  /* ── CARDS ── */
  .note-card, .exercise, .takeaway, .objectives {
    border-radius: 10px;
    padding: 14px 18px;
    margin-top: 12px;
  }
  .note-card, .objectives {
    background: var(--card);
    border: 1px solid var(--border);
  }
  .exercise {
    background: rgba(221,255,69,.07);
    border: 1px solid var(--lime);
  }
  .takeaway {
    background: linear-gradient(135deg, rgba(255,103,69,.12), rgba(118,87,255,.08));
    border: 1px solid var(--orange);
  }

  .eyebrow {
    font-family: 'Work Sans', sans-serif;
    font-weight: 700;
    font-size: .5em;
    text-transform: uppercase;
    letter-spacing: .18em;
    margin-bottom: 8px;
  }
  .small  { font-size: .66em; color: var(--body); line-height: 1.55; }
  .muted  { color: var(--muted); }
  .center { text-align: center; }

  /* ── LAYOUT ── */
  .row {
    display: flex;
    gap: 14px;
    margin-top: 12px;
  }
  .col { flex: 1; }

  .mini-card {
    background: var(--card);
    border: 1px solid var(--border);
    border-top: 3px solid var(--orange);
    border-radius: 10px;
    padding: 12px 14px;
    height: 100%;
    box-sizing: border-box;
  }
  .mini-card.alt-lime   { border-top-color: var(--lime); }
  .mini-card.alt-cyan   { border-top-color: var(--cyan); }
  .mini-card.alt-violet { border-top-color: var(--violet); }

  .diagram-box {
    background: #20203d;
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 14px 16px;
    margin-top: 12px;
  }

  /* ── PROGRESS ── */
  .module-progress {
    display: flex;
    gap: 6px;
    margin-bottom: 18px;
  }
  .module-progress span {
    flex: 1;
    height: 4px;
    border-radius: 2px;
    background: var(--border);
  }
  .module-progress span.active { background: var(--orange); }

  /* ── STEP ── */
  .step {
    display: flex;
    align-items: flex-start;
    gap: 14px;
    margin-bottom: 8px;
  }
  .step-num {
    min-width: 28px;
    height: 28px;
    border-radius: 50%;
    background: var(--orange);
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Work Sans', sans-serif;
    font-weight: 700;
    font-size: .7em;
    color: white;
    flex-shrink: 0;
  }
  .step-num.s2 { background: var(--lime);   color: var(--navy); }
  .step-num.s3 { background: var(--cyan);   color: var(--navy); }
  .step-num.s4 { background: var(--violet); color: white; }
  .step-num.s5 { background: var(--orange); }
  .step-num.s6 { background: var(--lime);   color: var(--navy); }
  .step-num.s7 { background: var(--cyan);   color: var(--navy); }
  .step-body .title { font-family: 'Work Sans', sans-serif; font-weight: 600; font-size: .72em; color: var(--offwhite); }
  .step-body .desc  { font-size: .62em; color: var(--body); margin-top: 2px; }

header: '![w:72](./assets/logos/Liora_Logo_White.svg)'
footer: 'DevOps / MLOps · Formation CGI'
---

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

<div style="display:flex;align-items:center;gap:20px;margin-bottom:32px;">
  <img src="./assets/logos/Liora_Logo_White.svg" style="height:52px;" />
</div>

### Parcours de formation · CGI

# DevOps, MLOps
# et industrialisation

## De la preuve de concept au système en production : comprendre, structurer et piloter

<br>

<div style="display:flex;gap:8px;margin-top:8px;">
  <span class="tag tag-lime">Partie 1 · Fondamentaux</span>
  <span class="tag tag-orange">Partie 2 · Pipeline CI/CD</span>
  <span class="tag tag-cyan">Partie 3 · GitOps</span>
  <span class="tag tag-violet">Partie 4 · Sécurité</span>
</div>

<div style="position:absolute;right:0;top:0;bottom:0;width:38%;background:url('./assets/images/code_screen.jpg') center/cover;opacity:.18;border-radius:0;"></div>

---

<!-- _class: transition -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

### Partie 1 sur 4

# Fondamentaux

## Pourquoi un modèle doit être pensé comme un système complet

---

<!-- _paginate: true -->

### Vue d'ensemble · Partie 1

# Ce que couvre cette première partie

<div class="module-progress">
  <span class="active"></span><span></span><span></span><span></span>
</div>

<div class="objectives">
  <div class="eyebrow" style="color:var(--lime);">Objectifs d'apprentissage</div>
  <ul>
    <li>Comprendre pourquoi les approches <strong>DevOps</strong> et <strong>MLOps</strong> sont devenues nécessaires</li>
    <li>Identifier les limites d'un fonctionnement <strong>manuel</strong></li>
    <li>Lire le <strong>cycle de vie complet</strong> d'un système de machine learning</li>
    <li>Poser les bases de la <strong>reproductibilité</strong> et du <strong>versioning</strong></li>
  </ul>
</div>

---

### Cas fil rouge

# Le système que nous allons suivre

<div class="note-card">
  <div class="eyebrow" style="color:var(--orange);">Cas de référence</div>
  <div class="small">Une équipe doit industrialiser une API FastAPI qui classe automatiquement les tickets SAV en catégories de priorité pour aider le support client à traiter plus vite les demandes.</div>
</div>

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">Entrée</div>
      <div class="small">texte du ticket, métadonnées, historique</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">Sortie</div>
      <div class="small">catégorie et priorité proposées</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-cyan">
      <div class="eyebrow muted">Risque</div>
      <div class="small">baisse de qualité, déploiement fragile, surcharge</div>
    </div>
  </div>
</div>

---

### Point de départ

# Pourquoi industrialiser ?

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">Sans industrialisation</div>
      <div class="small">Le système dépend souvent d'une machine, d'une personne et d'une suite d'étapes manuelles difficiles à rejouer.</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">Avec industrialisation</div>
      <div class="small">Le code, les dépendances, les versions et les déploiements deviennent compréhensibles, répétables et pilotables.</div>
    </div>
  </div>
</div>

<div class="takeaway" style="margin-top:16px;">
  <div class="eyebrow" style="color:var(--orange);">Message clé</div>
  <div style="font-family:'Work Sans',sans-serif;font-weight:500;font-size:.82em;color:var(--offwhite);">Un modèle en prod doit pouvoir se reconstruire à l'identique la semaine prochaine. Sinon, c'est un prototype, pas un système.</div>
</div>

---

### Définitions

# DevOps et MLOps

<div class="row">
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--orange);">DevOps</div>
      <div class="small">Industrialise la livraison logicielle : build, tests, déploiement, monitoring et cadence de mise à jour.</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--lime);">MLOps</div>
      <div class="small">Étend la même logique au cycle de vie des données, des entraînements, des modèles et de leur surveillance en production.</div>
    </div>
  </div>
</div>

<table style="margin-top:16px;">
  <thead>
    <tr><th>Dimension</th><th>DevOps</th><th>MLOps</th></tr>
  </thead>
  <tbody>
    <tr><td>Entrée principale</td><td>code applicatif</td><td>code + données + modèle</td></tr>
    <tr><td>Objet déployé</td><td>application</td><td>service prédictif</td></tr>
    <tr><td>Risque spécifique</td><td>bug logiciel</td><td>dérive et perte de qualité</td></tr>
  </tbody>
</table>

---

### Vision système

# Le cycle de vie d'un système ML

<div class="diagram-box">
  <div style="display:flex;gap:8px;justify-content:center;margin-bottom:8px;">
    <div class="mini-card" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">1</div><div class="small" style="font-size:.6em;">Collecte des données</div></div>
    <div class="mini-card alt-lime" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">2</div><div class="small" style="font-size:.6em;">Préparation &amp; features</div></div>
    <div class="mini-card alt-cyan" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">3</div><div class="small" style="font-size:.6em;">Entraînement</div></div>
    <div class="mini-card alt-violet" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">4</div><div class="small" style="font-size:.6em;">Évaluation qualité</div></div>
  </div>
  <div style="text-align:center;color:var(--muted);font-size:1em;margin:4px 0;">↓</div>
  <div style="display:flex;gap:8px;justify-content:center;">
    <div class="mini-card" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">5</div><div class="small" style="font-size:.6em;">Packaging (conteneur)</div></div>
    <div class="mini-card alt-lime" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">6</div><div class="small" style="font-size:.6em;">Déploiement en prod</div></div>
    <div class="mini-card alt-cyan" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">7</div><div class="small" style="font-size:.6em;">Monitoring continu</div></div>
    <div class="mini-card alt-violet" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">8</div><div class="small" style="font-size:.6em;">Réentraînement</div></div>
  </div>
</div>

---

### Monitoring

# Quand faut-il réentraîner ?

<div class="row">
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">Santé du service</div>
      <ul>
        <li>disponibilité, latence</li>
        <li>consommation CPU / mémoire</li>
      </ul>
    </div>
  </div>
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">Santé du modèle</div>
      <ul>
        <li>qualité des prédictions</li>
        <li>dérive des données entrantes</li>
        <li>décision de réentraînement</li>
      </ul>
    </div>
  </div>
</div>

<div class="row">
  <div class="col"><div class="mini-card"><div class="eyebrow muted">Alerte</div><div class="small">un seuil déclenche l'investigation</div></div></div>
  <div class="col"><div class="mini-card alt-lime"><div class="eyebrow muted">Owner</div><div class="small">quelqu'un lit le signal</div></div></div>
  <div class="col"><div class="mini-card alt-cyan"><div class="eyebrow muted">Décision</div><div class="small">on réentraîne sur critère, pas sur intuition</div></div></div>
</div>

<div class="takeaway" style="margin-top:10px;">
  <div class="eyebrow" style="color:var(--orange);">Boucle MLOps</div>
  <div style="font-family:'Work Sans',sans-serif;font-weight:500;font-size:.78em;color:var(--offwhite);">Votre API répond. L'infra dit "OK". Mais les agents classent mal les tickets depuis deux semaines. Monitoring métier = détecter ça.</div>
</div>

---

### Risque opérationnel

# Ce qu'il faut versionner

<div class="row">
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">À ne pas oublier</div>
      <ul>
        <li>le <strong>code</strong> d'entraînement et de service</li>
        <li>les <strong>données</strong> et leurs transformations</li>
        <li>les <strong>dépendances</strong> de l'environnement</li>
        <li>le <strong>modèle entraîné</strong></li>
      </ul>
    </div>
  </div>
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--cyan);">Pourquoi ?</div>
      <div class="small">Si un modèle se dégrade, il faut relier la version du code, la version des données et la version du modèle pour comprendre ce qui a changé.</div>
    </div>
    <div class="takeaway" style="margin-top:10px;">
      <div class="eyebrow" style="color:var(--orange);">À retenir</div>
      <div style="font-family:'Work Sans',sans-serif;font-weight:500;font-size:.76em;color:var(--offwhite);">Reproductibilité = rejouer. Portabilité = déplacer. Les deux ensemble.</div>
    </div>
  </div>
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

### Partie 2 sur 4

# Pipeline et
# industrialisation

## Transformer un changement de code en livraison fiable et traçable

---

### Vue d'ensemble · Partie 2

# Les briques du deuxième bloc

<div class="module-progress">
  <span class="active"></span><span class="active"></span><span></span><span></span>
</div>

<div class="objectives">
  <div class="eyebrow" style="color:var(--lime);">Objectifs d'apprentissage</div>
  <ul>
    <li>Relier <strong>versioning</strong>, <strong>conteneurs</strong> et <strong>pipeline</strong></li>
    <li>Lire un flux standard de <strong>CI/CD</strong></li>
    <li>Comprendre le rôle d'un <strong>registry</strong> et d'un artefact</li>
    <li>Comprendre pourquoi les environnements structurent la promotion</li>
  </ul>
</div>

---

### Cas fil rouge · Partie 2

# Ce que l'équipe veut désormais automatiser

<div class="note-card">
  <div class="eyebrow" style="color:var(--orange);">Fil rouge</div>
  <div class="small">À chaque changement sur l'API de tickets SAV, l'équipe veut reconstruire la même image, la valider, puis la promouvoir entre les environnements sans perdre la trace de la version du modèle servie.</div>
</div>

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">Code</div>
      <div class="small">Dépôt structuré, conventions de branches, scripts compréhensibles.</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">Dépendances</div>
      <div class="small">Versions figées, environnement reconstruisible, base d'exécution explicite.</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-cyan">
      <div class="eyebrow muted">Artefacts</div>
      <div class="small">Image, modèle ou paquet publiable dans un registre identifiable.</div>
    </div>
  </div>
</div>

---

### Conteneurisation

# Pourquoi empaqueter le service

<div class="diagram-box">
  <div style="display:flex;align-items:center;justify-content:space-between;gap:12px;">
    <div class="mini-card" style="flex:1;border-top-color:var(--orange);padding:12px 14px;">
      <div class="eyebrow muted">Entrées</div>
      <div class="small">Code d'API, modèle, runtime, dépendances.</div>
    </div>
    <div style="font-size:1.2em;color:var(--muted);">→</div>
    <div class="mini-card alt-lime" style="flex:1;padding:12px 14px;">
      <div class="eyebrow muted">Image OCI</div>
      <div class="small">Paquet portable, versionné, exécutable par tout moteur compatible (Docker, containerd, Podman…).</div>
    </div>
    <div style="font-size:1.2em;color:var(--muted);">→</div>
    <div class="mini-card alt-cyan" style="flex:1;padding:12px 14px;">
      <div class="eyebrow muted">Exécution</div>
      <div class="small">Serveur, VM, cluster, plateforme managée.</div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">Oui</div>
      <div class="small">portabilité, packaging stable, standardisation d'exécution</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">Non — pas seul</div>
      <div class="small">versioning données, gestion des secrets, monitoring, stratégie de déploiement</div>
    </div>
  </div>
</div>

---

### CI/CD standard

# Le flux d'automatisation

<table>
  <thead>
    <tr><th>Étape</th><th>Rôle</th><th>Sortie attendue</th></tr>
  </thead>
  <tbody>
    <tr><td>Push sur le dépôt</td><td>déclencher un changement versionné</td><td>événement</td></tr>
    <tr><td>Webhook</td><td>prévenir l'outil CI</td><td>déclenchement</td></tr>
    <tr><td>Checkout</td><td>récupérer la bonne version</td><td>copie de travail</td></tr>
    <tr><td>Build + tests</td><td>valider et construire</td><td>artefact exploitable</td></tr>
    <tr><td>Publication</td><td>stocker l'artefact</td><td>image dans un registry</td></tr>
    <tr><td>Déploiement</td><td>mettre à jour un environnement</td><td>service publié</td></tr>
  </tbody>
</table>

<div class="row" style="margin-top:12px;">
  <div class="col">
    <div class="note-card" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--orange);">CI</div>
      <div class="small">Vérifie le code, lance les tests, scanne l'image et produit un artefact immuable.</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--lime);">CD</div>
      <div class="small">Orchestre la promotion de cet artefact vers les bons environnements, avec garde-fous et approbation.</div>
    </div>
  </div>
</div>

---

### Lecture du pipeline

# De la modification au livrable

<div style="display:flex;flex-direction:column;gap:6px;margin-top:12px;">
  <div style="display:flex;gap:0;align-items:center;">
    <div style="flex:1;background:rgba(255,103,69,.15);border:1px solid var(--orange);border-radius:8px;padding:9px 12px;text-align:center;">
      <div style="font-size:.46em;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;font-family:'Work Sans',sans-serif;font-weight:600;">Développeur</div>
      <div style="font-size:.64em;color:var(--orange);font-family:'Work Sans',sans-serif;font-weight:700;margin-top:2px;">Push</div>
    </div>
    <div style="color:var(--muted);padding:0 5px;font-size:1em;">→</div>
    <div style="flex:1;background:rgba(0,229,238,.1);border:1px solid var(--cyan);border-radius:8px;padding:9px 12px;text-align:center;">
      <div style="font-size:.46em;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;font-family:'Work Sans',sans-serif;font-weight:600;">SCM Git</div>
      <div style="font-size:.64em;color:var(--cyan);font-family:'Work Sans',sans-serif;font-weight:700;margin-top:2px;">Webhook</div>
    </div>
    <div style="color:var(--muted);padding:0 5px;font-size:1em;">→</div>
    <div style="flex:1;background:rgba(221,255,69,.1);border:1px solid var(--lime);border-radius:8px;padding:9px 12px;text-align:center;">
      <div style="font-size:.46em;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;font-family:'Work Sans',sans-serif;font-weight:600;">CI</div>
      <div style="font-size:.64em;color:var(--lime);font-family:'Work Sans',sans-serif;font-weight:700;margin-top:2px;">Checkout</div>
    </div>
    <div style="color:var(--muted);padding:0 5px;font-size:1em;">→</div>
    <div style="flex:1;background:rgba(255,103,69,.15);border:1px solid var(--orange);border-radius:8px;padding:9px 12px;text-align:center;">
      <div style="font-size:.46em;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;font-family:'Work Sans',sans-serif;font-weight:600;">Runner</div>
      <div style="font-size:.64em;color:var(--orange);font-family:'Work Sans',sans-serif;font-weight:700;margin-top:2px;">Build + Tests</div>
    </div>
  </div>
  <div style="text-align:right;padding-right:0;color:var(--muted);">↓</div>
  <div style="display:flex;gap:0;align-items:center;">
    <div style="flex:1;background:rgba(221,255,69,.1);border:1px solid var(--lime);border-radius:8px;padding:9px 12px;text-align:center;">
      <div style="font-size:.46em;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;font-family:'Work Sans',sans-serif;font-weight:600;">Runner</div>
      <div style="font-size:.64em;color:var(--lime);font-family:'Work Sans',sans-serif;font-weight:700;margin-top:2px;">Scan sécurité</div>
    </div>
    <div style="color:var(--muted);padding:0 5px;font-size:1em;">→</div>
    <div style="flex:1;background:rgba(0,229,238,.1);border:1px solid var(--cyan);border-radius:8px;padding:9px 12px;text-align:center;">
      <div style="font-size:.46em;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;font-family:'Work Sans',sans-serif;font-weight:600;">Runner → Registry</div>
      <div style="font-size:.64em;color:var(--cyan);font-family:'Work Sans',sans-serif;font-weight:700;margin-top:2px;">Publish</div>
    </div>
    <div style="color:var(--muted);padding:0 5px;font-size:1em;">→</div>
    <div style="flex:1;background:rgba(118,87,255,.15);border:1px solid var(--violet);border-radius:8px;padding:9px 12px;text-align:center;">
      <div style="font-size:.46em;color:var(--muted);text-transform:uppercase;letter-spacing:.1em;font-family:'Work Sans',sans-serif;font-weight:600;">CD</div>
      <div style="font-size:.64em;color:var(--violet);font-family:'Work Sans',sans-serif;font-weight:700;margin-top:2px;">Deploy</div>
    </div>
  </div>
</div>

<div class="takeaway" style="margin-top:10px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:500;font-size:.76em;color:var(--offwhite);">Un push déclenche tout. Même résultat à 3h du matin qu'à 14h. Traçable, rejouable, sans intervention humaine.</div>
</div>

---

### Environnements

# Pourquoi on ne déploie pas partout d'un coup

<table>
  <thead>
    <tr><th>Environnement</th><th>Usage pratique</th><th>Critère de promotion</th></tr>
  </thead>
  <tbody>
    <tr><td>Dev</td><td>vérifier vite que l'API démarre</td><td>service fonctionnel</td></tr>
    <tr><td>Test</td><td>valider le pipeline et l'intégration</td><td>tests et scans OK</td></tr>
    <tr><td>Staging</td><td>se rapprocher de la prod</td><td>comportement final validé</td></tr>
    <tr><td>Prod</td><td>servir le trafic réel</td><td>feux au vert + décision de mise en ligne</td></tr>
  </tbody>
</table>

<div class="row">
  <div class="col">
    <div class="note-card" style="margin-top:12px;">
      <div class="eyebrow" style="color:var(--orange);">Continuous delivery</div>
      <div class="small">La dernière promotion vers la production reste validée manuellement.</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card" style="margin-top:12px;">
      <div class="eyebrow" style="color:var(--lime);">Continuous deployment</div>
      <div class="small">Le système met en ligne automatiquement si toutes les règles sont respectées.</div>
    </div>
  </div>
</div>

<div class="exercise" style="margin-top:10px;">
  <div class="eyebrow" style="color:var(--lime);">Règle simple</div>
  <div class="small">On promeut le <strong>même artefact</strong> entre les environnements. On ne reconstruit pas une image différente entre staging et prod.</div>
</div>

---

### Stratégie de déploiement

# Blue-green et canary

<div class="row">
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--orange);">Blue-green</div>
      <div class="small">Deux environnements de prod en parallèle. On bascule tout le trafic en un coup. <strong>Rollback</strong> instantané : l'ancien environnement reste actif.</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--lime);">Canary</div>
      <div class="small">On expose d'abord 5 % du trafic à la nouvelle version. On observe latence, erreurs et qualité du modèle avant de généraliser.</div>
    </div>
  </div>
</div>

<div class="diagram-box">
  <div style="display:flex;align-items:center;justify-content:center;gap:12px;flex-wrap:wrap;">
    <div class="mini-card" style="width:130px;border-top-color:var(--orange);padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">Version stable</div><div class="small center" style="font-size:.62em;">95 % du trafic</div></div>
    <div style="font-size:1.1em;color:var(--muted);">+</div>
    <div class="mini-card alt-lime" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">Nouvelle version</div><div class="small center" style="font-size:.62em;">5 % du trafic</div></div>
    <div style="font-size:1.1em;color:var(--muted);">→</div>
    <div class="mini-card alt-cyan" style="width:130px;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.46em;">Si indicateurs OK</div><div class="small center" style="font-size:.62em;">100 % basculé</div></div>
  </div>
</div>

---

### Registry

# Pourquoi publier un artefact intermédiaire

<div class="row">
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">Fonctions d'un registry</div>
      <ul>
        <li>centraliser les images ou paquets validés</li>
        <li>référencer les versions déployables</li>
        <li>éviter de reconstruire depuis zéro à chaque fois</li>
      </ul>
    </div>
  </div>
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--cyan);">Lecture MLOps</div>
      <div class="small">Le modèle servi en production peut être empaqueté dans une image contenant aussi le runtime et les dépendances nécessaires à son exécution.</div>
    </div>
  </div>
</div>

<div class="exercise" style="margin-top:12px;">
  <div class="eyebrow" style="color:var(--lime);">Mini-lab · Lire une promotion</div>
  <div class="small">Prenez une image <code>tickets-api:1.4.2</code>. Décidez ce qui doit rester identique entre staging et prod, ce qui peut changer via la configuration, et à quel moment un rollback doit être préparé.</div>
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

### Partie 3 sur 4

# GitOps, déploiement
# et scalabilité

## Séparer l'état désiré, sécuriser la mise à jour et tenir la charge

---

### Vue d'ensemble · Partie 3

# Les briques du troisième bloc

<div class="module-progress">
  <span class="active"></span><span class="active"></span><span class="active"></span><span></span>
</div>

<div class="objectives">
  <div class="eyebrow" style="color:var(--lime);">Objectifs d'apprentissage</div>
  <ul>
    <li>Comparer déploiement <strong>push</strong> et <strong>pull</strong></li>
    <li>Comprendre l'intérêt d'un <strong>dépôt manifeste</strong></li>
    <li>Lire une architecture <strong>GitOps</strong> simple</li>
    <li>Différencier scalabilité <strong>verticale</strong> et <strong>horizontale</strong></li>
  </ul>
</div>

---

### Sécurité Kubernetes

# Les trois couches d'accès au cluster

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">Authentication</div>
      <div class="small">Qui êtes-vous ? Via un <strong>kubeconfig</strong> ou un token de <strong>ServiceAccount</strong>.</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">Authorization — RBAC</div>
      <div class="small"><em>Role-Based Access Control</em> — que pouvez-vous faire dans quel <strong>namespace</strong> ?</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-cyan">
      <div class="eyebrow muted">Admission</div>
      <div class="small">Validation finale : la demande respecte-t-elle les règles de sécurité du cluster ?</div>
    </div>
  </div>
</div>

<div class="note-card">
  <div class="eyebrow" style="color:var(--orange);">Conséquence directe sur le déploiement</div>
  <div class="small">En mode push, le runner CI doit détenir un kubeconfig avec des droits suffisants. Si ce runner est compromis, l'attaquant hérite de ces droits. C'est précisément ce que le mode pull (GitOps) cherche à éliminer.</div>
</div>

---

### Push vs Pull

# Les deux modes de déploiement

<div class="row">
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--orange);">Mode push</div>
      <div class="small">Le pipeline construit l'artefact et applique directement la mise à jour. Simple et rapide, mais le pipeline porte des permissions élevées sur la plateforme.</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--lime);">Mode pull — GitOps</div>
      <div class="small">Le pipeline met à jour un <strong>dépôt manifeste</strong>. Un outil interne lit ce dépôt et synchronise le cluster. Personne n'appuie sur "déployer".</div>
    </div>
  </div>
</div>

<table style="margin-top:14px;">
  <thead>
    <tr><th>Critère</th><th>Mode push</th><th>Mode pull / GitOps</th></tr>
  </thead>
  <tbody>
    <tr><td>Accès au cluster</td><td>porté par le pipeline</td><td>porté par l'outil GitOps interne</td></tr>
    <tr><td>État désiré</td><td>moins explicite</td><td>déclaré dans Git</td></tr>
    <tr><td>Auditabilité</td><td>dépend de la CI</td><td>visible dans les commits de manifeste</td></tr>
    <tr><td>Cas d'usage</td><td>simple et direct</td><td>plus robuste en contexte gouverné</td></tr>
  </tbody>
</table>

---

### GitOps

# Architecture pull — flux complet

<div class="diagram-box">
  <div style="display:flex;align-items:center;justify-content:space-between;gap:8px;">
    <div class="mini-card" style="flex:1;padding:10px 12px;"><div class="small" style="font-size:.6em;">Pipeline CI</div></div>
    <div style="font-size:.85em;color:var(--muted);">met à jour</div>
    <div class="mini-card alt-lime" style="flex:1;padding:10px 12px;"><div class="small" style="font-size:.6em;">Dépôt manifeste <span style="color:var(--muted);">(état désiré)</span></div></div>
    <div style="font-size:.85em;color:var(--muted);">lu par</div>
    <div class="mini-card alt-cyan" style="flex:1;padding:10px 12px;"><div class="small" style="font-size:.6em;">Outil GitOps <span style="color:var(--muted);">(ex. Argo CD)</span></div></div>
    <div style="font-size:.85em;color:var(--muted);">→</div>
    <div class="mini-card alt-violet" style="flex:1;padding:10px 12px;"><div class="small" style="font-size:.6em;">Cluster cible</div></div>
  </div>
</div>

<div class="exercise" style="margin-top:12px;">
  <div class="eyebrow" style="color:var(--lime);">Mini-lab · Sécuriser le mode pull</div>
  <div class="small">En mode pull, le pipeline ne touche plus le cluster. Listez les trois actifs qui deviennent des cibles à leur tour, et indiquez une mesure de durcissement minimale pour chacun.</div>
</div>

<div class="row" style="margin-top:10px;">
  <div class="col"><div class="mini-card" style="padding:10px 12px;"><div class="eyebrow muted" style="font-size:.44em;">Dépôt manifeste</div><div class="small" style="font-size:.6em;">accès en écriture restreint, revue PR obligatoire</div></div></div>
  <div class="col"><div class="mini-card alt-lime" style="padding:10px 12px;"><div class="eyebrow muted" style="font-size:.44em;">Registry</div><div class="small" style="font-size:.6em;">images signées, lecture seule pour l'outil GitOps</div></div></div>
  <div class="col"><div class="mini-card alt-cyan" style="padding:10px 12px;"><div class="eyebrow muted" style="font-size:.44em;">Outil GitOps</div><div class="small" style="font-size:.6em;">RBAC interne, audit des synchronisations</div></div></div>
</div>

---

### Montée en charge

# Verticale ou horizontale ?

<div class="row">
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--orange);">Verticale</div>
      <div class="small">On augmente la taille de la machine existante. Utile pour test ou démonstration, mais le point unique de défaillance reste entier.</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card">
      <div class="eyebrow" style="color:var(--lime);">Horizontale</div>
      <div class="small">On répartit la charge sur plusieurs instances derrière un équilibreur, avec possibilité d'autoscaling.</div>
    </div>
  </div>
</div>

<div class="diagram-box">
  <div style="display:flex;align-items:center;justify-content:center;gap:16px;">
    <div class="mini-card" style="width:160px;border-top-color:var(--orange);padding:10px 12px;">
      <div class="eyebrow muted" style="font-size:.46em;">Entrée</div>
      <div class="small center" style="font-size:.6em;">Load balancer</div>
    </div>
    <div style="font-size:1.3em;color:var(--muted);">→</div>
    <div style="display:flex;gap:10px;">
      <div class="mini-card alt-lime" style="width:110px;padding:10px 12px;"><div class="small center" style="font-size:.6em;">Instance 1</div></div>
      <div class="mini-card alt-cyan" style="width:110px;padding:10px 12px;"><div class="small center" style="font-size:.6em;">Instance 2</div></div>
      <div class="mini-card alt-violet" style="width:110px;padding:10px 12px;"><div class="small center" style="font-size:.6em;">Instance 3</div></div>
    </div>
  </div>
</div>

---

### Autoscaling

# Calibrer min, max et signal

<div class="row">
  <div class="col"><div class="mini-card"><div class="eyebrow muted">Min</div><div class="small">nombre minimal de réplicas</div></div></div>
  <div class="col"><div class="mini-card alt-lime"><div class="eyebrow muted">Max</div><div class="small">limite de croissance autorisée</div></div></div>
  <div class="col"><div class="mini-card alt-cyan"><div class="eyebrow muted">Signal</div><div class="small">CPU, mémoire, requêtes ou métrique dédiée</div></div></div>
</div>

<div class="diagram-box">
  <div style="display:flex;gap:8px;align-items:stretch;">
    <div class="mini-card" style="flex:1;border-top-color:var(--orange);padding:10px 12px;"><div class="eyebrow muted" style="font-size:.44em;">1 — Test de charge</div><div class="small" style="font-size:.6em;">Gatling / k6 — montée progressive en charge</div></div>
    <div style="color:var(--muted);flex-shrink:0;">→</div>
    <div class="mini-card alt-lime" style="flex:1;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.44em;">2 — Seuil</div><div class="small" style="font-size:.6em;">Latence P95 qui commence à dégrader</div></div>
    <div style="color:var(--muted);flex-shrink:0;">→</div>
    <div class="mini-card alt-cyan" style="flex:1;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.44em;">3 — Calculer</div><div class="small" style="font-size:.6em;">max = trafic_max ÷ débit_saturant</div></div>
    <div style="color:var(--muted);flex-shrink:0;">→</div>
    <div class="mini-card alt-violet" style="flex:1;padding:10px 12px;"><div class="eyebrow muted" style="font-size:.44em;">4 — Régler</div><div class="small" style="font-size:.6em;">target CPU ≈ 70 % pour garder de la marge</div></div>
  </div>
</div>

<div class="takeaway" style="margin-top:10px;">
  <div style="font-family:'Work Sans',sans-serif;font-weight:500;font-size:.76em;color:var(--offwhite);">min et max se calculent avec un test de charge réel, pas au doigt mouillé. Sans ça, l'autoscaling oscille à vide ou sature sans prévenir.</div>
</div>

---

### À retenir · Partie 3

# Leçons de ce troisième bloc

<div class="row">
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">Mini-lab</div>
      <div class="small">Le trafic de tickets double pendant deux heures. Expliquez ce qui se passe si l'équipe reste en vertical, puis ce qui change si elle passe en horizontal avec autoscaling et load balancer.</div>
    </div>
  </div>
  <div class="col">
    <div class="takeaway" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--orange);">Ce qu'il faut retenir</div>
      <ul style="font-size:.72em;color:var(--offwhite);">
        <li>GitOps rend le déploiement <strong>déclaratif</strong> et <strong>auditable</strong>.</li>
        <li>La production ne doit pas dépendre d'une seule machine.</li>
        <li>La scalabilité horizontale répond à la fois à la <strong>charge</strong> et à la <strong>résilience</strong>.</li>
      </ul>
    </div>
  </div>
</div>

---

<!-- _class: transition -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

### Partie 4 sur 4

# Sécurité,
# souveraineté et synthèse

## Réduire la surface d'exposition et préparer la suite

---

### Vue d'ensemble · Partie 4

# Les briques du dernier bloc

<div class="module-progress">
  <span class="active"></span><span class="active"></span><span class="active"></span><span class="active"></span>
</div>

<div class="objectives">
  <div class="eyebrow" style="color:var(--lime);">Objectifs d'apprentissage</div>
  <ul>
    <li>Comprendre le principe du <strong>moindre privilège</strong></li>
    <li>Différencier <strong>PAT</strong>, <strong>SSH</strong> et gestion des secrets</li>
    <li>Relier scans, <strong>CVE</strong> et <strong>SBOM</strong> à la promotion</li>
    <li>Clore avec backup, restauration et feuille de route pratique</li>
  </ul>
</div>

---

### Cas fil rouge · Partie 4

# Dernière question sur l'API de tickets SAV

<div class="note-card">
  <div class="eyebrow" style="color:var(--orange);">Problème</div>
  <div class="small">Même avec une image propre et un déploiement piloté, il faut encore décider qui a accès à quoi, comment scanner le livrable, comment auditer les changements et comment garder la maîtrise dans une architecture souveraine.</div>
</div>

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">Principe fondateur</div>
      <div class="small">N'accorder à un compte, un token ou un runner que les droits strictement nécessaires à sa mission.</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">Effet recherché</div>
      <div class="small">Réduire l'impact d'un accès compromis et éviter les permissions excessives dans les pipelines.</div>
    </div>
  </div>
</div>

---

### Accès dépôt

# PAT versus SSH

<div style="display:flex;gap:16px;margin-bottom:12px;margin-top:6px;">
  <div style="font-size:.62em;color:var(--body);flex:1;"><strong style="color:var(--orange);">SSH</strong> — Secure Shell : protocole de connexion sécurisée, aussi utilisé pour authentifier l'accès aux dépôts Git.</div>
  <div style="font-size:.62em;color:var(--body);flex:1;"><strong style="color:var(--lime);">PAT</strong> — Personal Access Token : jeton personnel à durée limitée, avec des droits précisément définis.</div>
</div>

<table>
  <thead>
    <tr><th>Sujet</th><th>SSH</th><th>PAT</th></tr>
  </thead>
  <tbody>
    <tr><td>Granularité</td><td>plus générique</td><td>souvent plus fine</td></tr>
    <tr><td>Périmètre</td><td>moins ciblé</td><td>plus facile à borner</td></tr>
    <tr><td>Lecture sécurité</td><td>accès sécurisé</td><td>meilleur support du moindre privilège</td></tr>
  </tbody>
</table>

<div class="exercise" style="margin-top:12px;">
  <div class="eyebrow" style="color:var(--lime);">Réflexe</div>
  <div class="small">Toujours se demander : si ce jeton ou cette clé fuit, quel périmètre réel serait compromis ?</div>
</div>

<div class="takeaway" style="margin-top:10px;">
  <div class="eyebrow" style="color:var(--orange);">Message clé</div>
  <div style="font-family:'Work Sans',sans-serif;font-weight:500;font-size:.76em;color:var(--offwhite);">Un token permanent dans la CI, c'est une clé sous le paillasson. Un coffre-fort de secrets (ex. Vault) délivre un accès le temps d'une tâche, puis il expire.</div>
</div>

---

### Supply chain

# CVE, SBOM et décision avant promotion

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">CVE</div>
      <div class="small"><em>Common Vulnerabilities and Exposures</em> — identifiant standard d'une faille connue dans un composant logiciel</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">SBOM</div>
      <div class="small"><em>Software Bill of Materials</em> — liste exhaustive de tous les composants embarqués dans l'image déployée</div>
    </div>
  </div>
</div>

<div class="row" style="margin-top:10px;">
  <div class="col">
    <div class="exercise" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--lime);">Outil courant</div>
      <div class="small"><strong>Trivy</strong> (Aqua Security) — scan en quelques secondes : CVE détectés, sévérité, SBOM généré. S'intègre dans une étape CI avant publication.</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--orange);">Décision de promotion</div>
      <div class="small">Un scan sans règle, c'est une alarme qui sonne dans une pièce vide. Définir avant : sévérité <strong>critique</strong> = blocage. <strong>Élevée</strong> = alerte. <strong>Moyenne</strong> = décision manuelle.</div>
    </div>
  </div>
</div>

---

### Architecture souveraine

# GitLab comme stack DevOps complet

<table>
  <thead>
    <tr><th>Composant</th><th>Ce que GitLab fournit nativement</th></tr>
  </thead>
  <tbody>
    <tr><td>SCM</td><td>Dépôts Git, branches, merge requests, revues de code</td></tr>
    <tr><td>CI/CD</td><td>Runners, pipelines YAML, artefacts, cache</td></tr>
    <tr><td>Registry</td><td>Container Registry intégré (images OCI)</td></tr>
    <tr><td>ML</td><td>Model Registry, Package Registry</td></tr>
    <tr><td>Déploiement</td><td>Agent Kubernetes, Environments, Feature Flags</td></tr>
    <tr><td>IaC</td><td>Backend Terraform State — infrastructure déclarée dans des fichiers versionnés</td></tr>
  </tbody>
</table>

<div class="exercise" style="margin-top:10px;">
  <div class="eyebrow" style="color:var(--lime);">Intérêt on-prem</div>
  <div class="small">Un GitLab self-hosted remplace en une seule instance : GitHub + DockerHub + Jenkins + ArgoCD. Moins de surface d'attaque, moins d'intégrations à maintenir.</div>
</div>

---

### Résilience opérationnelle

# Backup et restauration

<div class="row">
  <div class="col">
    <div class="mini-card">
      <div class="eyebrow muted">À sauvegarder</div>
      <div class="small">dépôts, artefacts, manifestes et configurations critiques</div>
    </div>
  </div>
  <div class="col">
    <div class="mini-card alt-lime">
      <div class="eyebrow muted">Rollback vs Restore</div>
      <div class="small"><strong>Rollback</strong> = revenir à une version précédente. <strong>Restore</strong> = reconstruire un état après perte ou corruption.</div>
    </div>
  </div>
</div>

<div class="row" style="margin-top:10px;">
  <div class="col">
    <div class="note-card" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--cyan);">RPO</div>
      <div class="small"><em>Recovery Point Objective</em> — quelle perte maximale de données est acceptable ? (ex : 1 heure de travail)</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--cyan);">RTO</div>
      <div class="small"><em>Recovery Time Objective</em> — combien de temps peut-on rester indisponible avant impact métier ?</div>
    </div>
  </div>
  <div class="col">
    <div class="note-card" style="margin-top:0;">
      <div class="eyebrow" style="color:var(--cyan);">Restore drill</div>
      <div class="small">Exercice de restauration à blanc — tester la procédure en conditions réelles avant d'en avoir besoin</div>
    </div>
  </div>
</div>

---

### Gouvernance

# Ce qu'une architecture mature doit prouver

<div class="row">
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">Auditabilité</div>
      <div class="small">Qui a changé quoi, quand, pourquoi et vers quelle version déployée ?</div>
    </div>
  </div>
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">Traçabilité</div>
      <div class="small">Quelle relation entre code, données, modèle, image et état déployé ?</div>
    </div>
  </div>
  <div class="col">
    <div class="exercise">
      <div class="eyebrow" style="color:var(--lime);">Contrôle</div>
      <div class="small">Quels garde-fous avant la production et quelles règles de réversibilité ?</div>
    </div>
  </div>
</div>

<div class="exercise" style="margin-top:12px;">
  <div class="eyebrow" style="color:var(--lime);">Mini-lab · Cartographier les risques</div>
  <div class="small">Pour l'API tickets SAV, dessinez la chaîne complète (push de code → cluster en prod). Identifiez les trois points où une permission excessive crée un risque réel. Pour chacun, proposez la mesure la plus simple.</div>
</div>

---

### Feuille de route

# Ordre de mise en pratique recommandé

<div style="display:flex;flex-direction:column;gap:8px;margin-top:10px;">
  <div class="step"><div class="step-num">1</div><div class="step-body"><div class="title">Structurer le dépôt et figer les dépendances</div></div></div>
  <div class="step"><div class="step-num s2">2</div><div class="step-body"><div class="title">Conteneuriser le service ou le modèle servi</div></div></div>
  <div class="step"><div class="step-num s3">3</div><div class="step-body"><div class="title">Mettre en place une CI simple et fiable</div></div></div>
  <div class="step"><div class="step-num s4">4</div><div class="step-body"><div class="title">Publier les artefacts dans un registry</div></div></div>
  <div class="step"><div class="step-num s5">5</div><div class="step-body"><div class="title">Formaliser les environnements et le déploiement</div></div></div>
  <div class="step"><div class="step-num s6">6</div><div class="step-body"><div class="title">Introduire GitOps, monitoring et scans de sécurité</div></div></div>
  <div class="step"><div class="step-num s7">7</div><div class="step-body"><div class="title">Prévoir backup, restauration et réentraînement piloté</div></div></div>
</div>

---

### Synthèse finale

# Ce qu'il faut retenir de la série

<div class="takeaway" style="margin-top:16px;">
  <div class="eyebrow" style="color:var(--orange);">Quatre questions concrètes</div>
  <div style="display:flex;flex-direction:column;gap:8px;margin-top:4px;">
    <div style="display:flex;align-items:center;gap:12px;font-size:.74em;color:var(--offwhite);">
      <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M3 8l3.5 3.5L13 4.5" stroke="#DDFF45" stroke-width="2" stroke-linecap="round"/></svg>
      Est-ce qu'on peut <strong>rejouer</strong> ce résultat ?
    </div>
    <div style="display:flex;align-items:center;gap:12px;font-size:.74em;color:var(--offwhite);">
      <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M3 8l3.5 3.5L13 4.5" stroke="#DDFF45" stroke-width="2" stroke-linecap="round"/></svg>
      Est-ce qu'on peut le <strong>déployer ailleurs</strong> ?
    </div>
    <div style="display:flex;align-items:center;gap:12px;font-size:.74em;color:var(--offwhite);">
      <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M3 8l3.5 3.5L13 4.5" stroke="#DDFF45" stroke-width="2" stroke-linecap="round"/></svg>
      Est-ce qu'on <strong>sait ce qui se passe en prod</strong> ?
    </div>
    <div style="display:flex;align-items:center;gap:12px;font-size:.74em;color:var(--offwhite);">
      <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M3 8l3.5 3.5L13 4.5" stroke="#DDFF45" stroke-width="2" stroke-linecap="round"/></svg>
      Est-ce qu'on <strong>sait qui a changé quoi</strong> ?
    </div>
  </div>
  <div style="font-family:'Work Sans',sans-serif;font-weight:600;font-size:.8em;color:var(--lime);margin-top:14px;">Si oui aux quatre : le système est en ordre.</div>
</div>

---

<!-- _class: closing -->
<!-- _paginate: false -->
<!-- _header: '' -->
<!-- _footer: '' -->

<img src="./assets/logos/Liora_Logo_White.svg" style="height:48px;margin-bottom:28px;" />

### Fin de parcours

# Base prête pour
# la suite

## La structure est maintenant suffisamment stable pour accueillir l'IaC, le cloud ML et la gouvernance avancée.

<br>

<div style="display:flex;gap:8px;justify-content:center;margin-top:16px;">
  <div style="width:44px;height:5px;border-radius:3px;background:var(--orange);"></div>
  <div style="width:44px;height:5px;border-radius:3px;background:var(--orange);"></div>
  <div style="width:44px;height:5px;border-radius:3px;background:var(--orange);"></div>
  <div style="width:44px;height:5px;border-radius:3px;background:var(--orange);"></div>
</div>
