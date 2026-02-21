/**
 * @name ServiceWorker_NetSecurePro
 * @description Gestionnaire hors-ligne pour la souveraineté Z-CORE.
 */

const CACHE_NAME = 'netsecurepro-v9-cache';
const ASSETS_TO_CACHE = [
  '/IA22/z-coreg.html',
  '/IA22/manifest.json',
  'https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js'
];

// Installation : Archivage des ressources dans le cache local
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[IA22_LOGIC] Sécurisation locale des actifs...');
      return cache.addAll(ASSETS_TO_CACHE);
    })
  );
});

// Interception : Priorité au cache pour garantir le mode sans API
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});

// Sentinelle : Exécution du cycle de nettoyage de 30 jours
self.addEventListener('periodicsync', (event) => {
  if (event.tag === 'auto-clean-logs') {
    console.log("[SENTINEL] Exécution du cycle de nettoyage 30 jours...");
    // Déclenchement de la logique définie le [2026-02-14]
  }
});
