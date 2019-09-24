function bring() {
    srcdir=$(dirname $1)
    destdir=".$srcdir"
    srcfile=$1
    mkdir -p $destdir
    cp $srcfile $destdir -r && echo "Copiado $srcfile para $destdir"
}

bring /etc/systemd/system/screenlock.service
bring /media/dados/Lucas/BACKUP/borg_backup.sh
bring /media/dados/Lucas/BACKUP/phone_backup.sh
bring /media/dados/Lucas/BACKUP/update_script.sh
bring /usr/bin/projetor
bring /usr/bin/xlock
bring ~/.bashrc
bring ~/.config/betterlockscreenrc
bring ~/.config/compton.conf
bring ~/.config/i3/config
bring ~/.config/i3/wall.png
bring ~/.config/nvim/init.vim
bring ~/.config/polybar/config
bring ~/.config/rofi/config
bring ~/.tmux.conf
bring ~/.zshrc
bring ~/environment

pacman -Qe > pacman-explicit.txt
