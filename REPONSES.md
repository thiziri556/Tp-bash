TP N° 2 : Linux & Scripting Bash — Réponses

2.1 — Que donne chmod 644 ? Le fichier est-il exécutable par son propriétaire ?
 La command chmod 644 donne rw-r--r-- : lecture et écriture pour le propriétaire, lecture seule pour le groupe et les autres. Non, le fichier n'est exécutable par personne, pas même par son propriétaire.

2.2 — Pourquoi des guillemets autour de "$UTILISATION" dans le if ? 
 Si la variable est vide ou contient des espaces, sans guillemets le test devient invalide et provoque une erreur. Les guillemets garantissent que la variable est toujours traitée comme un seul argument.

2.3 — Sans set -Eeuo pipefail, que se passe-t-il si tar échoue ?
  Il affiche un succès et peut même supprimer les anciennes sauvegardes alors que la nouvelle n'a pas été créée. Avec set -e, le script s'arrête dès la première erreur. -u bloque les variables non définies, et pipefail détecte une erreur au milieu d'un pipeline.

2.4 — Pourquoi cron nécessite-t-il des chemins absolus ? 
 Cron ne lance pas le script depuis le dossier courant (il démarre souvent dans le dossier personnel) et utilise un environnement minimal, avec un PATH réduit. Les chemins relatifs et certaines commandes ne sont donc pas trouvés. Les chemins absolus fonctionnent quel que soit le contexte.

2.5 — Comment en faire un vrai pipeline CI ? Quels points de défaillance gérer ?
  Étapes à ajouter : installation des dépendances, compilation (build), vrais tests automatisés, création d'un artefact, déploiement, notification du résultat. Il faudrait aussi le déclencher automatiquement à chaque push (ex. GitHub Actions).

  Points de défaillance à gérer avec les codes de retour : échec du git clone/git pull (réseau, URL invalide), dépendances introuvables, échec de compilation, tests en échec, échec du déploiement. Chaque étape doit vérifier le code de retour et arrêter le pipeline avec exit 1 en cas d'erreur.
