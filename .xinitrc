#!/bin/sh

######################################################
##                        X                         ##
##                                                  ##
##   ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗  ##
##  ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝  ##
##  ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗ ##
##  ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║ ##
##  ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝ ##
##   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝  ##
##                                                  ##
##                                     ~/.xinitrc   ##
######################################################

# Déclaration des variables
user_feh=$HOME/.fehbg
user_polybar=$HOME/.config/polybar/config
user_pywal=$HOME/.cache/wal/sequences
user_resources=$HOME/.Xresources

# Fonction initialisation pour lancer le contenu du répertoire /etc/X11/xinit/xinitrc.d
start_init () {
	# Contrôle présence répertoire /etc/X11/xinit/xinitrc.d et execute son contenu
	if [ -d /etc/X11/xinit/xinitrc.d ] ; then
		for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
			[ -x "$f" ] && . "$f"
		done
		unset f
	fi
}

# Fonction pour utiliser le .Xresources de l'utilisateur
start_xresources () {
	# Contrôle présence fichier Xresources
	if [ -f $user_resources ]; then
		xrdb -merge $user_resources
	fi
}

# Fonction pour afficher le fond d'écran
start_feh () {
	# Contrôle présence fichier fehbg
	if [ -f $user_feh ]; then
		~/.fehbg &
	fi
}

# Fonction pour restaurer la palette de couleurs
start_pywal () {
	# Contrôle présence fichier sequence
	if [ -f $user_pywal ]; then
		wal -a 90 -n -R &
	fi
}

# Démarrer la barre des tâches polybar
start_polybar () {
	# Contrôle présence fichier polybar config
	if [ -f $user_polybar ]; then
		polybar -r top &
	fi
}

# Fonction pour démarrer les programmes communs
start_cmprgs () {
	# Vérouiller le pavé numérique
	numlockx &

	# Démarrer la composition graphique
	compton &

	# Executer le daemon du gestionnaire de fichier pour l'auto montage
	pcmanfm -d &

	# Executer la fonction pour le fond d'écran
	start_feh

	# Executer la fonction pour la palette de couleurs
	start_pywal

	# Executer la fonction pour démarrer la barre des tâches
	start_polybar
}

# Fonction pour démarrer le gestionnaire de fenêtres i3 avec Xresources utilisateur et programmes communs
start_i3 () {
	# Executer la fonction du Xresources
	start_xresources

	# Executer la fonction des programmes communs
	start_cmprgs

	# Executer le gestionnaire de fenêtres i3
	exec i3
}

# Executer la fonction d'initialisation du contenu /etc/X11/xinit/xinitrc.d
start_init

# Executer la fonction de démarrage du gestionnaire de fenêtres i3 avec les configurations et programmes communs
start_i3
