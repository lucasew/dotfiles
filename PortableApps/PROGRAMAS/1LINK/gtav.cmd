@echo off

shift
set PARAMS=%*
pushd %PREFIX%DADOS\Jogos\Grand Theft Auto V
__wrapper__ DADOS\Jogos\Grand Theft Auto V\PlayGTAV.exe
popd