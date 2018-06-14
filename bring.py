import os
from pathlib import Path
def bring(path):
    origin = path
    destination = os.getcwd()
    copyto = Path(destination + origin).parent.absolute()
    #print(origin)
    #print(destination)
    #print(copyto)
    os.system('mkdir -p "%s"' %copyto)
    os.system('cp "%s"  "%s" -r' %(origin, copyto))
bring('/home/lucas59356/.zshrc')
bring('/home/lucas59356/.vimrc')
