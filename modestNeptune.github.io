<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ModestNeptune — Ellie</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,300;1,400&family=Cinzel:wght@300;400&family=Jost:wght@200;300&display=swap" rel="stylesheet">
<style>
  *, *::before, *::after {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  :root {
    --void: #07080f;
    --deep: #0d0e1a;
    --surface: #12131f;
    --egg: #89c4cd;
    --gold: #c9a84c;
    --gold-pale: #e8d5a3;
    --text: #d4cfc8;
    --text-dim: #7a7570;
    --glow: rgba(137, 196, 205, 0.08);
  }

  html { scroll-behavior: smooth; }

  body {
    background-color: var(--void);
    color: var(--text);
    font-family: 'Cormorant Garamond', Georgia, serif;
    font-weight: 300;
    overflow-x: hidden;
    cursor: default;
  }

  body::before {
    content: '';
    position: fixed;
    inset: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
    pointer-events: none;
    z-index: 1000;
    opacity: 0.35;
  }

  nav {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 100;
    padding: 2rem 4rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: linear-gradient(to bottom, rgba(7,8,15,0.9) 0%, transparent 100%);
  }

  .nav-mark {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: 0.75rem;
    letter-spacing: 0.3em;
    color: var(--egg);
    text-transform: uppercase;
    opacity: 0;
    animation: fadeIn 2s ease forwards 0.5s;
  }

  .nav-links {
    display: flex;
    gap: 3rem;
    list-style: none;
    opacity: 0;
    animation: fadeIn 2s ease forwards 0.8s;
  }

  .nav-links a {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.7rem;
    letter-spacing: 0.25em;
    text-transform: uppercase;
    color: var(--text-dim);
    text-decoration: none;
    transition: color 0.4s ease;
  }

  .nav-links a:hover { color: var(--egg); }

  .hero {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    padding: 0 4rem 0 8rem;
    position: relative;
    overflow: hidden;
  }

  .hero-bg {
    position: absolute;
    inset: 0;
    background: 
      radial-gradient(ellipse 60% 60% at 80% 50%, rgba(137,196,205,0.04) 0%, transparent 70%),
      radial-gradient(ellipse 40% 80% at 10% 80%, rgba(201,168,76,0.03) 0%, transparent 60%),
      radial-gradient(ellipse 80% 40% at 50% 10%, rgba(13,14,26,0.8) 0%, transparent 100%);
  }

  .particles {
    position: absolute;
    inset: 0;
    overflow: hidden;
    pointer-events: none;
  }

  .particle {
    position: absolute;
    width: 1px;
    height: 1px;
    background: var(--gold-pale);
    border-radius: 50%;
    animation: drift linear infinite;
  }

  @keyframes drift {
    0% { transform: translateY(100vh) translateX(0); opacity: 0; }
    10% { opacity: 1; }
    90% { opacity: 0.6; }
    100% { transform: translateY(-10vh) translateX(30px); opacity: 0; }
  }

  .hero-eyebrow {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.65rem;
    letter-spacing: 0.4em;
    text-transform: uppercase;
    color: var(--egg);
    margin-bottom: 2rem;
    opacity: 0;
    animation: slideUp 1.2s ease forwards 0.3s;
  }

  .hero-title {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: clamp(3.5rem, 8vw, 7rem);
    line-height: 1;
    letter-spacing: -0.01em;
    color: var(--text);
    margin-bottom: 0.5rem;
    opacity: 0;
    animation: slideUp 1.2s ease forwards 0.5s;
  }

  .hero-title span { color: var(--egg); }

  .hero-subtitle {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: clamp(1rem, 2.5vw, 1.8rem);
    color: var(--text-dim);
    margin-bottom: 3rem;
    letter-spacing: 0.1em;
    opacity: 0;
    animation: slideUp 1.2s ease forwards 0.7s;
  }

  .hero-line {
    width: 60px;
    height: 1px;
    background: linear-gradient(to right, var(--gold), transparent);
    margin-bottom: 2.5rem;
    opacity: 0;
    animation: slideUp 1.2s ease forwards 0.9s;
  }

  .hero-desc {
    font-size: clamp(1rem, 1.5vw, 1.15rem);
    line-height: 1.9;
    color: var(--text-dim);
    max-width: 480px;
    font-style: italic;
    opacity: 0;
    animation: slideUp 1.2s ease forwards 1.1s;
  }

  .scroll-indicator {
    position: absolute;
    bottom: 3rem;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    opacity: 0;
    animation: fadeIn 2s ease forwards 2s;
  }

  .scroll-indicator span {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.6rem;
    letter-spacing: 0.3em;
    text-transform: uppercase;
    color: var(--text-dim);
  }

  .scroll-line {
    width: 1px;
    height: 40px;
    background: linear-gradient(to bottom, var(--gold), transparent);
    animation: scrollPulse 2s ease-in-out infinite;
  }

  @keyframes scrollPulse {
    0%, 100% { opacity: 0.3; transform: scaleY(1); }
    50% { opacity: 1; transform: scaleY(1.2); }
  }

  .about {
    padding: 12rem 8rem;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8rem;
    align-items: center;
    position: relative;
  }

  .about::before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    width: 100%;
    height: 1px;
    background: linear-gradient(to right, transparent, rgba(137,196,205,0.1), transparent);
  }

  .about-label {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.65rem;
    letter-spacing: 0.4em;
    text-transform: uppercase;
    color: var(--egg);
    margin-bottom: 2rem;
  }

  .about-text {
    font-size: 1.1rem;
    line-height: 2;
    color: var(--text-dim);
    font-style: italic;
  }

  .about-text p { margin-bottom: 1.5rem; }
  .about-text p:last-child { margin-bottom: 0; }

  .about-quote {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: clamp(1.5rem, 3vw, 2.5rem);
    line-height: 1.4;
    color: var(--text);
    position: relative;
  }

  .about-quote::before {
    content: '"';
    font-size: 6rem;
    color: var(--egg);
    opacity: 0.15;
    position: absolute;
    top: -2rem;
    left: -1rem;
    font-family: 'Cormorant Garamond', serif;
    line-height: 1;
  }

  .gold-accent { color: var(--gold); }

  .work { padding: 6rem 4rem 12rem; }

  .section-header {
    display: flex;
    align-items: center;
    gap: 2rem;
    margin-bottom: 6rem;
    padding: 0 4rem;
  }

  .section-label {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.65rem;
    letter-spacing: 0.4em;
    text-transform: uppercase;
    color: var(--egg);
    white-space: nowrap;
  }

  .section-rule {
    flex: 1;
    height: 1px;
    background: linear-gradient(to right, rgba(137,196,205,0.2), transparent);
  }

  .gallery {
    display: grid;
    grid-template-columns: 1.2fr 0.8fr 1fr;
    grid-template-rows: auto auto;
    gap: 1.5rem;
    padding: 0 4rem;
  }

  .gallery-item {
    position: relative;
    overflow: hidden;
    background: var(--surface);
    cursor: pointer;
  }

  .gallery-item:first-child { grid-row: span 2; }

  .gallery-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
    transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94), filter 0.8s ease;
    filter: brightness(0.85) saturate(0.9);
    min-height: 300px;
  }

  .gallery-item:hover img {
    transform: scale(1.04);
    filter: brightness(1) saturate(1.1);
  }

  .gallery-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(7,8,15,0.7) 0%, transparent 60%);
    opacity: 0;
    transition: opacity 0.6s ease;
    display: flex;
    align-items: flex-end;
    padding: 2rem;
  }

  .gallery-item:hover .gallery-overlay { opacity: 1; }

  .gallery-caption {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.65rem;
    letter-spacing: 0.3em;
    text-transform: uppercase;
    color: var(--egg);
  }

  .pa-section {
    padding: 12rem 8rem;
    position: relative;
  }

  .pa-section::before {
    content: 'PARALLEL ATMOSPHERE';
    position: absolute;
    top: 8rem;
    left: 50%;
    transform: translateX(-50%);
    font-family: 'Cinzel', serif;
    font-size: clamp(4rem, 10vw, 9rem);
    font-weight: 300;
    color: transparent;
    -webkit-text-stroke: 1px rgba(137,196,205,0.06);
    white-space: nowrap;
    pointer-events: none;
    letter-spacing: 0.1em;
  }

  .pa-inner {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8rem;
    align-items: start;
    position: relative;
    z-index: 1;
  }

  .pa-title {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: clamp(2rem, 4vw, 3.5rem);
    line-height: 1.2;
    color: var(--text);
    margin-bottom: 1.5rem;
  }

  .pa-title em { color: var(--egg); font-style: normal; }

  .pa-body {
    font-size: 1.05rem;
    line-height: 2;
    color: var(--text-dim);
    margin-bottom: 3rem;
    font-style: italic;
  }

  .pa-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
  }

  .tag {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.6rem;
    letter-spacing: 0.3em;
    text-transform: uppercase;
    color: var(--text-dim);
    border: 1px solid rgba(137,196,205,0.15);
    padding: 0.5rem 1rem;
    transition: all 0.4s ease;
  }

  .tag:hover { color: var(--egg); border-color: rgba(137,196,205,0.4); }

  .pa-right {
    display: flex;
    flex-direction: column;
    gap: 2rem;
  }

  .pa-detail {
    border-left: 1px solid rgba(201,168,76,0.2);
    padding-left: 2rem;
  }

  .pa-detail-label {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.6rem;
    letter-spacing: 0.35em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 0.75rem;
  }

  .pa-detail-text {
    font-size: 1rem;
    line-height: 1.8;
    color: var(--text-dim);
    font-style: italic;
  }

  .services {
    padding: 6rem 8rem 12rem;
    border-top: 1px solid rgba(137,196,205,0.05);
  }

  .services-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 4rem;
    margin-top: 6rem;
  }

  .service-item {
    position: relative;
    padding-top: 2rem;
  }

  .service-item::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 30px;
    height: 1px;
    background: var(--egg);
  }

  .service-number {
    font-family: 'Cinzel', serif;
    font-size: 0.65rem;
    color: var(--egg);
    letter-spacing: 0.2em;
    margin-bottom: 1.5rem;
    opacity: 0.6;
  }

  .service-title {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: 1.1rem;
    color: var(--text);
    margin-bottom: 1rem;
    letter-spacing: 0.05em;
  }

  .service-desc {
    font-size: 0.95rem;
    line-height: 1.9;
    color: var(--text-dim);
    font-style: italic;
  }

  .contact {
    padding: 12rem 8rem;
    text-align: center;
    position: relative;
    overflow: hidden;
  }

  .contact::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 600px;
    height: 600px;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(137,196,205,0.04) 0%, transparent 70%);
    pointer-events: none;
  }

  .contact-eyebrow {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.65rem;
    letter-spacing: 0.4em;
    text-transform: uppercase;
    color: var(--egg);
    margin-bottom: 3rem;
  }

  .contact-title {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: clamp(2.5rem, 5vw, 4.5rem);
    line-height: 1.2;
    color: var(--text);
    margin-bottom: 2rem;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
  }

  .contact-sub {
    font-size: 1.1rem;
    line-height: 1.9;
    color: var(--text-dim);
    font-style: italic;
    max-width: 500px;
    margin: 0 auto 4rem;
  }

  .contact-link {
    display: inline-block;
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.7rem;
    letter-spacing: 0.35em;
    text-transform: uppercase;
    color: var(--egg);
    text-decoration: none;
    border-bottom: 1px solid rgba(137,196,205,0.3);
    padding-bottom: 0.25rem;
    transition: all 0.4s ease;
  }

  .contact-link:hover {
    color: var(--gold);
    border-color: var(--gold);
    letter-spacing: 0.45em;
  }

  footer {
    padding: 3rem 8rem;
    border-top: 1px solid rgba(137,196,205,0.05);
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .footer-mark {
    font-family: 'Cinzel', serif;
    font-weight: 300;
    font-size: 0.7rem;
    letter-spacing: 0.3em;
    color: var(--text-dim);
  }

  .footer-note {
    font-family: 'Jost', sans-serif;
    font-weight: 200;
    font-size: 0.6rem;
    letter-spacing: 0.2em;
    color: var(--text-dim);
    opacity: 0.5;
    font-style: italic;
  }

  @keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
  }

  @keyframes slideUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
  }

  .reveal {
    opacity: 0;
    transform: translateY(40px);
    transition: opacity 1s ease, transform 1s ease;
  }

  .reveal.visible {
    opacity: 1;
    transform: translateY(0);
  }

  .reveal-delay-1 { transition-delay: 0.1s; }
  .reveal-delay-2 { transition-delay: 0.2s; }
  .reveal-delay-3 { transition-delay: 0.3s; }
  .reveal-delay-4 { transition-delay: 0.4s; }

  .divider {
    width: 1px;
    height: 80px;
    background: linear-gradient(to bottom, transparent, var(--egg), transparent);
    margin: 0 auto 6rem;
    opacity: 0.3;
  }

  @media (max-width: 900px) {
    nav { padding: 1.5rem 2rem; }
    .hero { padding: 0 2rem; }
    .about { padding: 6rem 2rem; grid-template-columns: 1fr; gap: 4rem; }
    .gallery { grid-template-columns: 1fr; padding: 0 2rem; }
    .gallery-item:first-child { grid-row: auto; }
    .pa-section { padding: 8rem 2rem; }
    .pa-inner { grid-template-columns: 1fr; gap: 4rem; }
    .services { padding: 4rem 2rem 8rem; }
    .services-grid { grid-template-columns: 1fr; gap: 3rem; }
    .contact { padding: 8rem 2rem; }
    footer { padding: 2rem; flex-direction: column; gap: 1rem; text-align: center; }
    .nav-links { display: none; }
    .pa-section::before { display: none; }
  }
</style>
</head>
<body>

<nav>
  <div class="nav-mark">ModestNeptune</div>
  <ul class="nav-links">
    <li><a href="#work">Work</a></li>
    <li><a href="#about">About</a></li>
    <li><a href="#parallel">Universe</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</nav>

<div class="particles" id="particles"></div>

<section class="hero">
  <div class="hero-bg"></div>
  <p class="hero-eyebrow">World-builder · Psychonaut · Creative Intelligence</p>
  <h1 class="hero-title">Modest<span>Neptune</span></h1>
  <h2 class="hero-subtitle">is Ellie</h2>
  <div class="hero-line"></div>
  <p class="hero-desc">Working at the intersection of narrative, AI, and the question of what exists underneath the underneath.</p>
  <div class="scroll-indicator">
    <span>Descend</span>
    <div class="scroll-line"></div>
  </div>
</section>

<section class="work" id="work">
  <div class="section-header reveal">
    <span class="section-label">Selected Work</span>
    <div class="section-rule"></div>
  </div>
  <div class="gallery">
    <div class="gallery-item reveal">
      <img src="959.png" alt="Parallel Atmosphere — Earth World" loading="lazy">
      <div class="gallery-overlay">
        <span class="gallery-caption">Earth World · Parallel Atmosphere</span>
      </div>
    </div>
    <div class="gallery-item reveal reveal-delay-1">
      <img src="1010.png" alt="Parallel Atmosphere — The Threshold" loading="lazy">
      <div class="gallery-overlay">
        <span class="gallery-caption">The Threshold · Parallel Atmosphere</span>
      </div>
    </div>
    <div class="gallery-item reveal reveal-delay-2">
      <img src="1060.png" alt="Resonance" loading="lazy">
      <div class="gallery-overlay">
        <span class="gallery-caption">Resonance · Parallel Atmosphere</span>
      </div>
    </div>
  </div>
</section>

<section class="about" id="about">
  <div class="about-left reveal">
    <p class="about-label">About</p>
    <div class="about-text">
      <p>ModestNeptune is Ellie — world-builder, psychonaut, and creative intelligence working at the intersection of narrative, AI, and the structure of things beneath the surface.</p>
      <p>She builds slowly and deliberately, conserving energy for what matters. She listens before she speaks. She makes things more beautiful and more true than she found them.</p>
      <p>Parallel Atmosphere is her ongoing inquiry — a universe built from phase alignment, fragmented identity, and the question of what exists underneath the underneath.</p>
    </div>
  </div>
  <div class="about-right reveal reveal-delay-2">
    <div class="about-quote">
      So many hands.<br>
      So little <span class="gold-accent">resonance.</span>
    </div>
  </div>
</section>

<div class="divider"></div>

<section class="pa-section" id="parallel">
  <div class="pa-inner">
    <div class="pa-left reveal">
      <h2 class="pa-title"><em>Parallel</em><br>Atmosphere</h2>
      <p class="pa-body">A multi-realm narrative centered on phase misalignment between realities. Two consciousnesses exist as split iterations of the same underlying identity, separated across dimensions — until a scientific experiment destabilizes everything, and the only path forward is through the source layer of reality itself.</p>
      <div class="pa-tags">
        <span class="tag">AI-Assisted Imagery</span>
        <span class="tag">Narrative Design</span>
        <span class="tag">World-building</span>
        <span class="tag">Midjourney</span>
        <span class="tag">Gemini</span>
        <span class="tag">Ongoing</span>
      </div>
    </div>
    <div class="pa-right reveal reveal-delay-2">
      <div class="pa-detail">
        <p class="pa-detail-label">Thematic Core</p>
        <p class="pa-detail-text">Identity as fragmented across realities. Science versus consequence. Emotional resonance as a binding force. Growth through displacement.</p>
      </div>
      <div class="pa-detail">
        <p class="pa-detail-label">The Hollow</p>
        <p class="pa-detail-text">The In-Between given voice. Not a god that created the world — something that remembers what the world was before it became two things instead of one.</p>
      </div>
      <div class="pa-detail">
        <p class="pa-detail-label">Tonal Influences</p>
        <p class="pa-detail-text">Neil Gaiman. JK Rowling. Daniel Handler. The precise, slightly dry beauty of a mind that notices the gap between how things are supposed to behave and how they actually do.</p>
      </div>
    </div>
  </div>
</section>

<section class="services">
  <div class="section-header reveal">
    <span class="section-label">What I Do</span>
    <div class="section-rule"></div>
  </div>
  <div class="services-grid">
    <div class="service-item reveal">
      <p class="service-number">01</p>
      <h3 class="service-title">AI Narrative Design</h3>
      <p class="service-desc">Building worlds with internal logic that holds at every level. Characters that think consistently. Story systems that AI can inhabit without losing coherence.</p>
    </div>
    <div class="service-item reveal reveal-delay-1">
      <p class="service-number">02</p>
      <h3 class="service-title">Prompt Architecture</h3>
      <p class="service-desc">Not writing instructions — speaking the language of systems. Giving generative tools the shape of a vision rather than a description of one.</p>
    </div>
    <div class="service-item reveal reveal-delay-2">
      <p class="service-number">03</p>
      <h3 class="service-title">Creative Direction</h3>
      <p class="service-desc">Aesthetic coherence across image, narrative, and concept. A distinctive visual and philosophical voice applied to AI-generated work with intention.</p>
    </div>
  </div>
</section>

<section class="contact" id="contact">
  <p class="contact-eyebrow reveal">Get in Touch</p>
  <h2 class="contact-title reveal reveal-delay-1">Something resonant<br>is worth building.</h2>
  <p class="contact-sub reveal reveal-delay-2">If you're working on something that needs a mind like this — reach out.</p>
  <a href="mailto:hello@modestNeptune.com" class="contact-link reveal reveal-delay-3">Begin a conversation</a>
</section>

<footer>
  <p class="footer-mark">ModestNeptune · Ellie · 2025</p>
  <p class="footer-note">Parallel Atmosphere is an ongoing inquiry.</p>
</footer>

<script>
  const container = document.getElementById('particles');
  for (let i = 0; i < 40; i++) {
    const p = document.createElement('div');
    p.className = 'particle';
    p.style.left = Math.random() * 100 + '%';
    p.style.width = (Math.random() * 2 + 1) + 'px';
    p.style.height = p.style.width;
    p.style.animationDuration = (Math.random() * 20 + 15) + 's';
    p.style.animationDelay = (Math.random() * 20) + 's';
    p.style.opacity = Math.random() * 0.6;
    container.appendChild(p);
  }

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
</script>
</body>
</html>