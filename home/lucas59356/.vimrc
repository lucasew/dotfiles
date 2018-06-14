set nu               " Numera as linhas
set showmatch        " Mostra os parenteses e chaves que fecham o bloco
set autoindent       " Continua o nivel de indentação da linha anterior
syntax on
filetype plugin on
tab ball

echom "Carregando plugins..."

" ---------------< Carregar plugins >---------------
call plug#begin('~/.vim/plugged')
" Complete plugins
" -- Python3
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" -- Golang
Plug 'zchee/deoplete-go', { 'do': 'make'}
" -- Elixir (syntax highlight
Plug 'elixir-editors/vim-elixir', {'for': 'elixir'}
" -> Outros utilitários
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
" Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Folder tree
Plug 'scrooloose/nerdtree'
call plug#end()

" -------------< Configuração de ambiente >----------
echom "Configurando ambiente..."

" Menos BO com o caps ligado
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq

" Habilitar mouse
set mouse=a

" Backup
set backup

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='minimalist'

"NERDTree - Abrir com o editor, precisar chama com :NERDTreeToggle
"autocmd vimenter * NERDTree

let mapleader = ','  " Leader é a vírgula agora

" Ponto e vírgula dá : para entrar no modo de comando
nnoremap ; : 				 

" Melhor movimentação entre abas e janelas segundo o site que eu copiei
map <C-K> :tabnext<CR>
map <C-J> :tabprev<CR>
map <C-Right> :tabnext<CR>
map <C-Left>  :tabprev<CR>
" Wildmenu - Autocomplete para o modo de comando, bem legau :P
set wildmenu
set wildmode=full

" Makefile
autocmd FileType make setlocal noexpandtab
" Python
autocmd FileType python 
	\ set tabstop=4 |
	\ set omnifunc=jedi#completions |
" Golang
autocmd FileType go 
  \ set tabstop=4 |
" VIM
autocmd Filetype vim set tabstop=2

echom "Feito!"
