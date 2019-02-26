function bring() {
    srcdir=$(dirname $1)
    destdir=".$srcdir"
    srcfile=$1
    mkdir -p $destdir
    cp $srcfile $destdir -r && echo "Copiado $srcfile para $destdir"
}

bring /media/dados/Lucas/BACKUP/borg_backup.sh
bring /media/dados/Lucas/BACKUP/phone_backup.sh
bring /media/dados/Lucas/BACKUP/update_script.sh
bring ~/.bashrc
bring ~/.config/nvim/init.vim
bring ~/.tmux.conf
bring ~/.zshrc
bring ~/environment

pacman -Qe > pacman-explicit.txt
