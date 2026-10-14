# Tâches prêtes à transformer en issues

Les identifiants T01–T08 sont internes à ce document, pas des numéros d’issues GitHub. Les tâches ne sont pas encore créées sur GitHub. À leur création, remplacer les dépendances par des liens réels.

| ID | Titre | Dépendance | Priorité | Critères d’acceptation |
| --- | --- | --- | --- | --- |
| T01 | Confirmer le cadrage, les dates et les données sources | Aucune | P1 | Contraintes du cours identifiées ; calendrier confirmé ; liste des données manquantes |
| T02 | Valider la maquette et les parcours de navigation | T01 | P1 | Accueil desktop/mobile ; vues projets, détail, compétences et alternance ; navigation explicitée |
| T03 | Créer et vérifier la base PostgreSQL | T01, T02 | P1 | Scripts exécutés ; clés/relations vérifiées ; rejets des valeurs invalides et des doublons contrôlés |
| T04 | Développer les routes et la lecture des données | T03 | P1 | Un projet réel affiché depuis la base ; erreurs gérées ; requêtes paramétrées |
| T05 | Développer les pages et filtres des projets | T02, T04 | P1 | Filtres combinables ; détail accessible ; aucun résultat expliqué ; retour aux filtres possible |
| T06 | Afficher compétences, alternance et statistiques | T04, T05 | P1 | C1–C4 présents ; preuves distinctes de la mobilisation ; sommes cohérentes avec SQL et sources visibles |
| T07 | Vérifier mobile, clavier et cas sans données | T05, T06 | P1 | Vérification sur petit écran et clavier ; tableau accessible pour graphiques ; erreurs corrigées |
| T08 | Finaliser documentation, bilan et oral | T07 | P1 | Lancement testé depuis les instructions ; limites et difficultés décrites ; démonstration préparée |

Découper une tâche en sous-tâches si elle dépasse une séance. Déplacer en « Terminé » seulement après vérification des critères, et consigner le résultat dans `AVANCEMENT.md`.
