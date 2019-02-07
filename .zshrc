######################################################
##                       ZSH                        ##
##                                                  ##
##   ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗  ##
##  ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝  ##
##  ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗ ##
##  ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║ ##
##  ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝ ##
##   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝  ##
##                                                  ##
##                                       ~/.zshrc   ##
######################################################
 
# Chemin du répertoire oh-my-zsh
export ZSH="/home/joan/.oh-my-zsh"

# Affiche un thème spécifique suivant si console graphique ou tty
# Affiche neofetch si en console graphique
if [ "$TERM" != 'linux' ]; then
	ZSH_THEME="agnoster"
	neofetch
else
	ZSH_THEME="daveverwer"
fi

# Plugins actif
plugins=(
	git
)

# Source de oh-my-zsh
source $ZSH/oh-my-zsh.sh
