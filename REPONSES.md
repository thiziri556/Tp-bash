
# Réponses aux questions de réflexion

## Exercice 2.1 — Navigation, recherche et permissions

La commande `chmod 644` donne au propriétaire les droits de lecture et d'écriture, tandis que le groupe et les autres utilisateurs disposent uniquement du droit de lecture. Le propriétaire ne peut donc pas exécuter le fichier.

## Exercice 2.2 — Surveillance de l'espace disque

Les guillemets autour de `"$UTILISATION"` permettent de traiter la variable comme un seul argument et d'éviter certains problèmes liés aux espaces ou aux caractères spéciaux. C'est une bonne pratique en Bash.

## Exercice 2.3 — Sauvegarde et gestion des erreurs

L'instruction `set -Eeuo pipefail` permet de renforcer la gestion des erreurs :
- `-e` : arrêter le script lorsqu'une commande échoue dans les situations concernées.
- `-E` : propager les pièges ERR dans les fonctions et certains sous-shells.
- `-u` : signaler l'utilisation d'une variable non définie.
- `-o pipefail` : détecter l'échec d'une commande dans un pipeline.

Sans cette instruction, le script pourrait continuer après une erreur et afficher un message de réussite alors que la sauvegarde a échoué.

## Exercice 2.4 — Planification avec Cron

Cron nécessite des chemins absolus car il exécute les tâches dans un environnement différent du terminal interactif. Le répertoire courant et les variables d'environnement peuvent être différents. Les chemins absolus permettent de localiser correctement les scripts et les fichiers journaux.

## Exercice 2.5 — Mini-projet d'intégration (CI/CD)

### 1. Quelles étapes ajouter pour transformer ce script en un vrai pipeline CI ?

Pour obtenir un véritable pipeline d'intégration continue, on pourrait ajouter les étapes suivantes :

- Installation des dépendances du projet.
- Compilation ou construction de l'application.
- Exécution de tests unitaires et fonctionnels.
- Analyse de la qualité du code avec SonarQube.
- Vérification de la sécurité et recherche des vulnérabilités.
- Génération d'un rapport de tests.
- Création d'un artefact prêt à être déployé.
- Déploiement automatique après validation, dans une étape de CD.

On pourrait utiliser des outils comme GitHub Actions, GitLab CI ou Jenkins pour automatiser ces étapes à chaque modification du code.

### 2. Quels sont les points de défaillance à gérer avec des codes de retour ?

Plusieurs erreurs peuvent survenir pendant un pipeline :

- Échec du clonage du dépôt à cause d'un problème réseau ou d'authentification.
- Échec de la mise à jour avec `git pull`.
- Fichier source manquant.
- Erreur de syntaxe dans un script.
- Échec de l'installation des dépendances.
- Échec des tests unitaires ou fonctionnels.
- Échec de la compilation.
- Échec du déploiement.

Chaque étape doit retourner un code adapté : `0` en cas de réussite et un code non nul en cas d'échec. Cela permet d'arrêter le pipeline au bon moment et d'identifier l'origine du problème.


