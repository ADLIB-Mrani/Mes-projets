# Charte graphique proposée

Intention : un portfolio sobre et lisible, où les preuves de projets et les visualisations occupent la place principale. La maquette est un support statique de conception, pas une application.

## Couleurs

| Rôle | Valeur | Usage |
| --- | --- | --- |
| Texte principal | `#162A34` | Titres et contenu sur fond clair |
| Texte secondaire | `#48606C` | Métadonnées et descriptions |
| Accent principal | `#166653` | Liens, boutons, sélection et repères C1–C4 |
| Accent doux | `#D7EA98` | Badges avec texte foncé |
| Fond | `#F6F5F0` | Arrière-plan général |
| Surface | `#FFFFFF` | Cartes et blocs de contenu |
| Bordure | `#D5DED9` | Séparateurs, sans servir seule à transmettre un état |

Utiliser du texte blanc sur les boutons verts, du texte foncé sur les badges clairs. Vérifier le contraste des états interactifs lors de l’implémentation.

## Typographie et mise en page

- Police système sans-serif : `system-ui, -apple-system, "Segoe UI", sans-serif` ; aucun téléchargement externe indispensable.
- Corps 16 px minimum ; interligne 1,6 ; paragraphes d’environ 65 caractères par ligne.
- Titres : 48–56 px sur ordinateur, 32–36 px sur téléphone.
- Conteneur centré, largeur maximale 1 120 px ; marges 24 px sur ordinateur, 16 px sur téléphone.
- Espacements fondés sur 8 px ; cartes avec coins de 16 px.
- Sous 768 px : navigation compacte, une colonne ; entre 768 et 1 023 px : deux colonnes selon l’espace ; au-delà : trois cartes de projets maximum par ligne.

## Composants

- Navigation : Accueil, Projets, Compétences, Alternance ; lien de contact uniquement après ajout d’une adresse réelle.
- Carte projet : année, titre, résumé, outils utilisés et lien « Voir le projet ».
- Indicateur : valeur, unité, périmètre, source et date de mise à jour.
- Filtre : libellé visible, valeur choisie, bouton de réinitialisation et nombre de résultats.
- Compétence : code C1–C4, intitulé complet et liens vers les projets/preuves.
- Graphique : légende, unité et tableau de données accessible ; pas d’information transmise uniquement par couleur.

## Accessibilité et mobile

Éléments HTML sémantiques, un titre principal par page, lien d’évitement, focus clavier visible, boutons utilisables au toucher. Prévoir les états sans données, aucun résultat et erreur de chargement. Les graphiques auront une alternative textuelle ; désactiver les animations non essentielles si l’utilisateur préfère réduire les mouvements.

Le SVG et son PNG montrent l’accueil sur ordinateur et mobile. Les autres écrans sont décrits dans `CONTENU.md` et devront être maquettés avant leur développement.
