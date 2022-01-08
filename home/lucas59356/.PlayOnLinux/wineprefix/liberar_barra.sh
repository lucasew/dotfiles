DESTINATION=/media/dados/Jogos/WINE

mv -v $1 $DESTINATION
ln -s $DESTINATION/$1 $1
