
#!/bin/bash

set -Eeuo pipefail

# Dossier à sauvegarder
DOSSIER="${1:-data}"

# Vérifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier $DOSSIER n'existe pas." >&2
    exit 1
fi

# Créer le dossier des sauvegardes
mkdir -p backups

# Récupérer la date et l'heure
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Construire le nom de l'archive
ARCHIVE="backups/backup_${DATE}.tar.gz"

# Créer l'archive
tar -czf "$ARCHIVE" "$DOSSIER"

echo "Sauvegarde créée : $ARCHIVE"

# Supprimer les sauvegardes de plus de 7 jours
for fichier in backups/*.tar.gz; do

    [ -f "$fichier" ] || continue

    ANCIEN=$(find "$fichier" -maxdepth 0 -type f -mtime +7 -print)

    if [ -n "$ANCIEN" ]; then
        echo "Suppression de l'ancienne sauvegarde : $fichier"
        rm -- "$fichier"
    fi

done

echo "Opération terminée."
exit 0
