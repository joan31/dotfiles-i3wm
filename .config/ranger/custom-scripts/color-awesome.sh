#!/bin/sh

###################################################
##                 COLOR AWESOME                 ##
##                                               ##
##  ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗ ##
##  ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝ ##
##  ███████╗██║     ██████╔╝██║██████╔╝   ██║    ##
##  ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║    ##
##  ███████║╚██████╗██║  ██║██║██║        ██║    ##
##  ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝    ##
##                                               ##
##  .../ranger/custom-scripts/color-awesome.sh   ##
###################################################

# Script pour automatiser dans ranger la mise en place d'un fond d'écran,
# génerer la palette de couleurs et un thème d'icônes par rapport au wallpaper.
# Dans le rc.conf mapper une touche, par exemple pour la touche b suivi de w:
# map bw shell ~/.config/ranger/custom-scripts/color-awesome.sh %f
# Les dépendances nécessaires sont: feh, python-pywal, oomox (AUR), pygtk.

# Déclaration des variables
# Récuperation du premier paramètre correspondant au chemin du fichier (%f)
file=$1

# Valeur en pourcentage de la transparence du terminal (0-100)
alpha=90

# Chemin du template gtk
gtk_template=~/.cache/wal/colors-oomox

# Nom donné au thème gtk
gtk_name=wal

# Nom donné au thème des icônes
icons_name=wal

# Fonction pour la mise en place du fond d'écran
wallpaper() {
	echo 'Mise en place du wallpaper...'
	feh --bg-scale $file
	echo 'Wallpaper affiché'
}

# Fonction pour la génération de la palette de couleurs
color_scheme() {
	echo 'Génération de la palette de couleurs...'
	wal -c &&
	wal -a $alpha -i $file -n &&
	echo 'Palette de couleurs généré'
}

# Fonction pour la génération du thème gtk
gtk_theme() {
	echo 'Génération du thème gtk...'
	oomox-cli -o $gtk_name $gtk_template &&
	echo 'Thème gtk généré'
}

# Fonction pour la génération du thème des icônes
icons_theme() {
	# Variable contenant la couleur 4 (en hexadécimal sans #) du xresources généré par pywal
	color=$(xrdb -query | grep '*color4' | awk '{gsub (/\#/,"");print $NF}')
	echo "Génération du thème des icônes au couleur $color..."
	oomox-archdroid-icons-cli -o $icons_name -c $color &&
	echo 'Thème des icônes généré'
}

# Fonction pour recharger à la volée le thème gtk
reload_gtk() {
	echo 'Patience encore 5 secondes...'
	sleep 5
	echo 'Actualisation à la volée du thème gtk'
	python2 - <<END
import gtk
events = gtk.gdk.Event(gtk.gdk.CLIENT_EVENT)
data = gtk.gdk.atom_intern("_GTK_READ_RCFILES", False)
events.data_format = 8
events.send_event = True
events.message_type = data
events.send_clientmessage_toall()
END
	echo 'Thème gtk actualisé'
}

# Fonction globale
start_colorawesome() {
	echo 'BIENVENUE DANS COLOR AWESOME'
	echo 'GENERATION EN COURS...'
	wallpaper
	color_scheme
	gtk_theme
	icons_theme
	reload_gtk
	echo 'FIN DE LA GENERATION'
	echo 'ENJOY'
}

# Execution de la fonction principale
start_colorawesome
