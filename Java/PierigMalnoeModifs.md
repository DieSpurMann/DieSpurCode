# Modifications apportées au Jeu de la Vie.
# Par Pierig Malnoë TP1 Groupe A

## 1. Nouvel Observateur
<p>Ajout d'un observateur qui notifie dans la console le numéro de génération et le nombre de cellule en vie actuellement</p>

## 2. Drag 'n' Zoom
<p>Ajout de la détéction du scroll pour zoomer-dezoomer et le maintien du clic pour pouvoir se déplacer sur la carte</p>

## 3. Pause via Spacebar
<p>Ajout d'une pause via la space bar, pour relancer on peut réappuyer sur la space bar</p>

## 4. Ajout d'un header de settings
### 4.1. Bouton Pause
<p>Réutilise la fonctionalité de la space bar mais en bouton où il faut cliquer dessus</p>

### 4.2. Bouton suivant
<p>Génère la génération suivante lorsqu'on clique dessus</p>

### 4.3. Slider de la vitesse:
<p>Slider pour changer la vitesse de génération de la plus grande vitesse (à gauche) vers la plus petite (à droite)</p>

### 4.4. Gestion de thème:
<p>Par défault, le thème classique. On peut utiliser une liste déroulante pour changer le thème (Thèmes à ton humoristique)</p>

### 4.5. Bouton pour réinitialiser la grille
<p>On clique dessus et ça réinitialise la grille de façon aléatoire.</p>

### 4.6. Bouton de gestion des règles
<p>On réutilise la même logique que pour les thèmes, mais avec les règles. On a le setVisitor qui remplace les anciennes règles par celle choisie.</p>

## 5. Mode HighLife
<p>Ajout d'une variante célèbre du jeu classique via le pattern Visiteur. Les règles de survie restent les mêmes (2 ou 3 voisines), mais une cellule morte ressuscite désormais si elle possède exactement 3 OU 6 voisines.</p>

## 6. Mode Day & Night
<p>Ajout d'une variante symétrique où les blocs de cellules mortes se comportent comme les blocs de cellules vivantes. Une cellule survit avec 3, 4, 6, 7 ou 8 voisines, et une cellule morte ressuscite avec 3, 6, 7 ou 8 voisines.</p>
