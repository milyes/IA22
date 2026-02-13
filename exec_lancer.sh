#!/bin/bash
# AUTO-LANCEUR MILYES_IA v9
# NETSECUREPRO SOUVERAINETÉ NUMÉRIQUE

PORT=8080
FILE="index.html"

echo -e "\033[0;32m[SYSTEM] Initialisation de l'environnement MILYES_IA v9...\033[0m"

if [[ ! -f "$FILE" ]]; then
    echo -e "\033[0;31m[ERROR] $FILE manquant. Veuillez créer le fichier HTML.\033[0m"
    exit 1
fi

echo "[SYSTEM] Démarrage du serveur souverain sur http://localhost:$PORT"
# Lancement silencieux du serveur Python3
python3 -m http.server $PORT > /dev/null 2>&1 &
PID=$!

# Ouverture automatique selon le système
sleep 1
if [[ "$OSTYPE" == "linux-gnu"* ]]; then xdg-open "http://localhost:$PORT";
elif [[ "$OSTYPE" == "darwin"* ]]; then open "http://localhost:$PORT";
else start "http://localhost:$PORT"; fi

echo -e "\033[1;34m[STATUS] INTERFACE DÉPLOYÉE (PID: $PID)\033[0m"
echo "Appuyez sur [CTRL+C] pour stopper le terminal et fermer le port."

trap "kill $PID; echo -e '\n[SYSTEM] NOYAU DÉSACTIVÉ.'; exit" SIGINT
wait $PID
