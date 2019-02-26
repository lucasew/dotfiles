case $1 in
getpkg)
    echo "Obtendo pacotes instalados..."
    pacman -Qn > /media/dados/Lucas/BACKUP/pacman.txt
    pacman -Qm >> /media/dados/Lucas/BACKUP/pacman.txt
;;
snapshot)
    sh $0 getpkg
    sudo borg create \
    	--verbose \
    	--progress \
    	--list \
    	--exclude '/home/*/.cache/*' \
    	--exclude '/var/cache/' \
    	--exclude '/var/tmp' \
    	--exclude '/var/log' \
    	--exclude '/var/lib/docker' \
    	--exclude '/var/lib/dnf' \
    	--exclude '/home/*/.mozilla' \
        --exclude '/home/lucas59356/Downloads/' \
        --exclude '/home/lucas59356/.var' \
        --exclude '*cache*' \
        --exclude '/media/dados/Lucas/BACKUP/borg' \
        --exclude '/home/*/TESTES' \
    	borg::'{hostname}-{now}' \
    	/etc \
    	/home \
    	/media/dados/Lucas/BACKUP/
    ;;
upload)
    rclone sync borg driveutf:/backup/BORG --stats 1s -vvvv --transfers 1  || (sleep 5; ./borg_backup.sh upload)
;;
all)
    sh $0 snapshot
    sh $0 upload
    ;;
*)
    echo "Não reconheço esse comando :("
    ;;
esac

#       /var \
#    	/opt \
#    	/boot \
#    	/root \
