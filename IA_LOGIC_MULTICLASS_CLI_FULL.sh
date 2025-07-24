#!/bin/bash
# Menu CLI pour IA_LOGIC_MULTICLASS_CLI

clear
echo "==============================="
echo "🔷 IA_LOGIC_MULTICLASS_CLI 🔷"
echo "==============================="
echo "1. Afficher le logo"
echo "2. Lancer IA (placeholder)"
echo "3. Description du projet"
echo "4. Quitter"
echo "==============================="
read -p "Choix : " choix

case $choix in
    1)
        if command -v termimage &> /dev/null; then
            termimage IA_LOGIC_ICON.png
        elif command -v fim &> /dev/null; then
            fim -a IA_LOGIC_ICON.png
        else
            echo "Image prête mais outil manquant (termimage ou fim non installé)"
        fi
        ;;
    2)
        echo "🚀 Lancement du module IA..."
        # Ajouter ici ton appel à ton IA réelle
        ;;
    3)
        echo "Ce projet CLI permet d'intégrer l'IA LOGIC MULTICLASS à votre terminal via Termux ou Linux."
        echo "Logo IA, menu interactif, et intégration possible WebView/API à venir."
        ;;
    4)
        echo "👋 Au revoir."
        exit 0
        ;;
    *)
        echo "⛔ Choix invalide."
        ;;
esac
PKy��Z��4!IA_LOGIC_MULTICLASS_CLI/README.md# IA_LOGIC_MULTICLASS_CLI

Ce projet intègre un menu CLI intelligent pour afficher un logo IA, interagir avec des scripts logiques,
et préparer l'intégration future avec WebView ou APK mobile.

## Fichiers inclus
- `IA_LOGIC_ICON.png` : logo IA officiel
- `launch.sh` : menu CLI intelligent
- `auto_copy_ia.sh` : script pour détection automatique du logo
- `README.md` : documentation de ce module

## Auteur
**Zoubirou Mohammed Ilyes**
[ORCID](https://orcid.org/0009-0007-7571-3178)
Projet NetSecurePro IA
PKy��Z)IA_LOGIC_MULTICLASS_CLI/IA_LOGIC_ICON.pngPKy��Z3����'IA_LOGIC_MULTICLASS_CLI/auto_copy_ia.sh#!/bin/bash
# Script intelligent : auto_copy_ia.sh
FICHIER="IA_LOGIC_ICON.png"
DEST="$HOME/IA_LOGIC_MULTICLASS_CLI"

echo "🔍 Recherche du fichier $FICHIER ..."
CHEMIN=$(find ~ -type f -name "$FICHIER" 2>/dev/null | head -n 1)

if [ -z "$CHEMIN" ]; then
    echo "❌ Fichier $FICHIER non trouvé."
    exit 1
fi

echo "✅ Trouvé à : $CHEMIN"
mkdir -p "$DEST"
cp "$CHEMIN" "$DEST/"
if [ -f "$DEST/$FICHIER" ]; then
    echo "✅ Copie réussie vers $DEST/"
else
    echo "❌ Erreur lors de la copie."
fi



