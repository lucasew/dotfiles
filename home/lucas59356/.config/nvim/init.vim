echom "Verificando dependências básicas..."

" Baixar vimplug automagicamente
function! CheckPlug(path)
    if empty(glob(a:path))
        execute '!curl -fLo ' . a:path . ' --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    endif
endfunction
call CheckPlug("~/.config/nvim/autoload/plug.vim")

com! Dosify set ff=dos

echom "Iniciando..."

" Área de transferência
map gy "+y
map gp "+p
map gd "+d

" Mover pelas tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Tirar highlight da última pesquisa
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Recarregar vimrc ao salvar 
autocmd! bufwritepost init.vim source %
autocmd! bufwritepost .vimrc source %

set encoding=utf-8 " Sempre usar utf-8 ao salvar os arquivos
set nu " Linhas numeradas
set showmatch " Highlight de parenteses e chaves
set path+=** " Busca recursiva

" Indentação
set autoindent " Mantem os niveis de indentação
set tabstop=4 " Tab de 4 espaços
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab " Tabs viram espaços
set list " Ilustra a identação

set nobackup " Desativar backup

set nocompatible " Desativando retrocompatibilidade com o vi
set mouse=a " Ativar mouse
set completeopt=menuone,noinsert,noselect,longest " Customizações no menu de autocomplete, :help completeopt para mais info
" janela de preview que mostra algumas coisas dos comandos
set completeopt+=preview " Ativa
set previewheight=3 " Altura máxima do preview
set winfixheight " Mantém

" Wildmenu: autocomplete para modo de comando
set wildmenu
set wildmode=list:longest,full

" Wildignores
set wildignore+=*.pyc " Python
set wildignore+=*.o " C
set wildignore+=*.class " Java

" Menos dor de cabeça, recomendo.
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq
nnoremap ; :

syntax on " Ativa syntax highlight
filetype plugin on " Plugins necessitam disso
tab ball " Deixa menos bagunçado colocando um arquivo por aba

" Navegação entre os arquivos
nmap gt :bnext<CR>
nmap gT :bprev<CR>
nmap g$ :blast<CR>
nmap g^ :bfirst<CR>
nmap gc :bdelete<CR>

echom "Carregando plugins..."
call plug#begin()
" Plugins aqui
Plug 'Townk/vim-autoclose' " Fecha os blocos que abre
Plug 'tomtom/tcomment_vim' " Preguiça de comentar as coisas na mão: gc {des,}comenta o selecionado, gcc {des,}comenta a linha
Plug 'joshdick/onedark.vim' " Onedark <3
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mattn/emmet-vim'
Plug 'ncm2/ncm2' " Autocomplete
Plug 'ncm2/ncm2-path' " Completa pastas e arquivos
Plug 'ncm2/ncm2-syntax' " Completa pela definição de sintaxe
Plug 'roxma/nvim-yarp' " Dependencia do plugin anterior
Plug 'shougo/neco-syntax' " Dependencia
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'dart-lang/dart-vim-plugin' " Syntax Highlight dart
Plug 'ternjs/tern_for_vim' " Javascript
" Arduino
Plug 'stevearc/vim-arduino'
call plug#end()

let g:LanguageClient_serverCommands = {
            \'rust': ['/usr/bin/rls'],
            \'dart': ['/home/lucas59356/.pub-cache/bin/dart_language_server'],
            \'cpp': ['/usr/bin/ccls'],
            \'c': ['/usr/bin/ccls'],
            \'go': ['/home/lucas59356/go/bin/go-langserver', '-gocodecompletion'],
            \'java': ['/usr/bin/jdtls', '-data', getcwd()],
            \'lua': ['/bin/lua-lsp'],
            \}


echom "Configurando ambiente..."

" Ler pdf no vim
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -

" NCM
autocmd BufEnter * call ncm2#enable_for_buffer() " Ativa pra galera

" Temas e customizações
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#virtualenv=1
let g:airline_powerline_fonts = 1 " Aqui desbugou um símbolo
let g:airline_theme='deus'
" let g:airline_statusline_ontop=1 " É estranho mas é legal :v

colorscheme onedark
" colorscheme afterglow

" Leader == vírgula
let mapleader = ','

" Emmet: macro para html
let g:user_emmet_mode='a'
autocmd FileType html,css EmmetInstall

" Dart
let dart_html_in_string=v:true
let dart_style_guide = 2
let dart_format_on_save = 1

" Arduino
let g:arduino_dir = '/usr/share/arduino'
