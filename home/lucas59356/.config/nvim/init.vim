set encoding=utf-8 " Sempre usar utf-8 ao salvar os arquivos
set nu " Linhas numeradas
set showmatch " Highlight de parenteses e chaves
set autoindent " Mantem os niveis de indentação
set tabstop=4 " Tab de 4 espaços
set shiftwidth=4 "Evitando que o vim de identação de 8 espaços
set path+=** " Busca recursiva
set expandtab " Tabs viram espaços
set list " Ilustra a identação
set nocompatible " Desativando retrocompatibilidade com o vi
set nobackup " Desativar backup
set mouse=a " Ativar mouse


syntax on
filetype plugin on
tab ball

echom "Carregando plugins..."
call plug#begin()
" Plugins aqui
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi' " Python
Plug 'zchee/deoplete-go' " Go
Plug 'fatih/vim-go' " Go
Plug 'Shougo/neco-vim' " Viml
Plug 'elixir-editors/vim-elixir', {'for': 'elixir'} " Elixir
Plug 'artur-shaik/vim-javacomplete2' " Java
Plug 'Shougo/neosnippet.vim' " Engine de snippets
Plug 'Shougo/neosnippet-snippets' " Alguns snippets para o cara ali de cima
Plug 'Townk/vim-autoclose'
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'danilo-augusto/vim-afterglow' " Esquema de cores, gostei desse pra usar pelo putty
Plug 'mattn/emmet-vim'

call plug#end()
let g:deoplete#enable_at_startup = 1

" Menos dor de cabeça 
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq
nnoremap ; :



" Temas e customizações
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='minimalist'
colorscheme afterglow

" Leader == vírgula
let mapleader = ','

" Movimentar pelas abas
map <C-K> :tabnext<CR>
map <C-J> :tabprev<CR>
map <C-R> :tabnext<CR>
map <C-L> :tabprev<CR>

" Wildmenu: autocomplete para modo de comando
set wildmenu
set wildmode=full

" Emmet: macro para html
let g:user_emmet_mode='a'
autocmd FileType html,css EmmetInstall
