#!/bin/bash

set -Eeuo pipefail

# Dossier contenant ce script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# URL du dépôt passée en argument
REPO_URL="${1:-}"

# Dossier de travail et fichier journal
WORK_DIR="$HOME/ci-workspace/Tp-bash"
LOG_FILE="$SCRIPT_DIR/ci.log"

# Fonction de journalisation
log() {
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
}

# Fonction de gestion des erreurs
fail() {
    log "ECHEC : $*"
    exit 1
}

# Vérifier que l'URL a été fournie
if [ -z "$REPO_URL" ]; then
    fail "Veuillez fournir l'URL du dépôt Git."
fi

log "===== Début du pipeline CI ====="

# Étape 1 : récupérer ou mettre à jour le dépôt
mkdir -p "$(dirname "$WORK_DIR")"

if [ -d "$WORK_DIR/.git" ]; then
    log "Mise à jour du dépôt avec git pull..."
    git -C "$WORK_DIR" pull 2>&1 | tee -a "$LOG_FILE" || fail "Impossible de mettre à jour le dépôt."
elif [ -e "$WORK_DIR" ]; then
    fail "Le dossier existe mais ne contient pas un dépôt Git valide."
else
    log "Clonage du dépôt avec git clone..."
    git clone "$REPO_URL" "$WORK_DIR" 2>&1 | tee -a "$LOG_FILE" || fail "Impossible de cloner le dépôt."
fi

# Fonction de tests
run_tests() {
    log "Début des tests..."

    for fichier in check_disk.sh backup.sh; do
        if [ ! -f "$WORK_DIR/$fichier" ]; then
            fail "Fichier manquant : $fichier"
        fi

        log "Vérification syntaxique de $fichier..."
        bash -n "$WORK_DIR/$fichier" || fail "Erreur de syntaxe dans $fichier."

        log "Test réussi : $fichier"
    done

    log "Tous les tests sont réussis."
}

# Étape 2 : exécuter les tests
run_tests

log "===== PIPELINE CI RÉUSSI ====="
exit 0
