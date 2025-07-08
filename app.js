window.addEventListener('load', () => {
  setTimeout(() => {
    document.getElementById('splash').classList.add('hidden');
    document.getElementById('main').classList.remove('hidden');
  }, 1500);
});
document.getElementById('launch-btn').addEventListener('click', async () => {
  const url = document.getElementById('url-input').value.trim();
  if (!url) return alert('Veuillez entrer une URL.');
  const out = document.getElementById('output');
  out.textContent = 'Analyse en cours…';
  try {
    const resp = await fetch('http://127.0.0.1:8000/api/analyse-url', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ url })
    });
    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
    const data = await resp.json();
    out.textContent = JSON.stringify(data, null, 2);
  } catch (err) {
    out.textContent = `Erreur : ${err.message}`;
  }
});