<template>
  <div id="app">
    <main>
      <PeskyBoxListing />
    </main>
  </div>
</template>

<script>
import PeskyBoxListing from './components/PeskyBoxListing.vue'

export default {
  name: 'App',
  components: {
    PeskyBoxListing
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Orbitron:wght@400;500;600;700&display=swap');

:root {
  color-scheme: dark;
  
  /* Primary color palette */
  --primary-deep-purple: #6A0DAD;
  --primary-purple: #8A2BE2;
  --primary-lavender: #BDB0D0;
  --primary-light-lavender: #E6E6FA;
  
  /* Secondary colors */
  --secondary-cyan: #ADD8E6;
  --secondary-magenta: #FF00FF;
  --secondary-pink: #E75480;
  
  /* Background and contrast colors */
  --bg-black: #0F0014;
  --bg-dark-gray: #1A1A1A;
  --bg-medium-gray: #333333;
}

* {
  box-sizing: border-box;
}

body {
  background-color: var(--bg-black);
  padding: 0;
  margin: 0;
  min-width: 100vw;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: "Inter", sans-serif;
  font-optical-sizing: auto;
  color: var(--primary-light-lavender);
  position: relative;
  overflow-x: hidden;
  background-image: url('./assets/inky.jpg');
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
}

body::after {
  content: "";
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: 
    radial-gradient(circle at 20% 30%, rgba(173, 216, 230, 0.2) 0%, rgba(0, 0, 0, 0) 50%),
    radial-gradient(circle at 80% 70%, rgba(106, 13, 173, 0.2) 0%, rgba(0, 0, 0, 0) 50%);
  z-index: -2;
  pointer-events: none;
}

#app {
  width: 100%;
  display: flex;
  justify-content: center;
  position: relative;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Orbitron', sans-serif;
  letter-spacing: 0.05em;
  text-shadow: 0 0 10px rgba(173, 216, 230, 0.5);
}

a {
  color: var(--secondary-magenta);
  text-decoration: none;
  transition: all 0.3s ease;
  position: relative;
}

a:hover {
  color: var(--secondary-cyan);
  text-shadow: 0 0 8px rgba(173, 216, 230, 0.6);
}

a::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 1px;
  background: linear-gradient(90deg, var(--secondary-magenta), var(--secondary-cyan));
  transition: width 0.3s ease;
}

a:hover::after {
  width: 100%;
}

.hidden {
  display: none !important;
}

.row {
  display: flex;
  flex-direction: row;
}

.col {
  display: flex;
  flex-direction: column;
}

.align-items-center {
  align-items: center;
}

.justify-content-between {
  justify-content: space-between;
}

.justify-content-end {
  justify-content: flex-end;
}

.m-0 { margin: 0; }
.m-1 { margin: 0.25rem; }
.m-2 { margin: 0.5rem; }
.m-3 { margin: 0.75rem; }
.m-4 { margin: 1rem; }
.m-5 { margin: 2rem; }

.mt-1 { margin-top: 0.25rem; }
.mt-2 { margin-top: 0.5rem; }
.mt-3 { margin-top: 0.75rem; }
.mt-4 { margin-top: 1rem; }
.mt-5 { margin-top: 2rem; }

.mb-1 { margin-bottom: 0.25rem; }
.mb-2 { margin-bottom: 0.5rem; }
.mb-3 { margin-bottom: 0.75rem; }
.mb-4 { margin-bottom: 1rem; }
.mb-5 { margin-bottom: 2rem; }

.ms-1 { margin-left: 0.25rem; }
.ms-2 { margin-left: 0.5rem; }
.ms-3 { margin-left: 0.75rem; }
.ms-4 { margin-left: 1rem; }
.ms-5 { margin-left: 2rem; }

.me-1 { margin-right: 0.25rem; }
.me-2 { margin-right: 0.5rem; }
.me-3 { margin-right: 0.75rem; }
.me-4 { margin-right: 1rem; }
.me-5 { margin-right: 2rem; }

.p-1 { padding: 0.25rem; }
.p-2 { padding: 0.5rem; }
.p-3 { padding: 0.75rem; }
.p-4 { padding: 1rem; }
.p-5 { padding: 2rem; }

.ps-1 { padding-left: 0.25rem; }
.ps-2 { padding-left: 0.5rem; }
.ps-3 { padding-left: 0.75rem; }
.ps-4 { padding-left: 1rem; }
.ps-5 { padding-left: 2rem; }

.pe-1 { padding-right: 0.25rem; }
.pe-2 { padding-right: 0.5rem; }
.pe-3 { padding-right: 0.75rem; }
.pe-4 { padding-right: 1rem; }
.pe-5 { padding-right: 2rem; }

.w-100 { width: 100%; }
.flex-1 { flex: 1; }
</style>
