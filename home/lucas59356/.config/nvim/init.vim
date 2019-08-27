let hostname = substitute(system('hostname'), '\n', '', '')
let isNote = hostname == "acer-arch" " Estou rodando o script no meu note?

" Inicializar map dos langservers
let g:LanguageClient_serverCommands = {}

" Baixar vimplug automagicamente
function! PreparaPlug(path)
    if empty(glob(a:path))
        execute '!wget -O ' . a:path . '  https://raw.github.com/junegunn/vim-plug/master/plug.vim'
        echom "Abra novamente e chame :PlugInstall"
    endif
endfunction

" Plug: Instalação
if has("nvim")
    call PreparaPlug("~/.config/nvim/autoload/plug.vim")
else
    call PreparaPlug("~/.vim/autoload/plug.vim")
endif

function! IsAC() " Checa se o note tá na tomada
    return readfile('/sys/class/power_supply/ACAD/online')
endfunction

com! Dosify set ff=dos

" Clipboard:
map gy "+y
map gp "+p
map gd "+d

" Mover pelas tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Tirar highlight da última pesquisa
noremap <C-n> :nohl<CR>

" Recarregar: vimrc ao salvar 
if has('nvim')
    autocmd! bufwritepost init.vim source %
else
    autocmd! bufwritepost .vimrc source %
endif

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
set completeopt=menuone,noinsert,noselect " Customizações no menu de autocomplete, :help completeopt para mais info
" janela de preview que mostra algumas coisas dos comandos
" set completeopt+=preview " Ativa
set previewheight=3 " Altura máxima do preview
set winfixheight " Mantém

" Wildmenu: autocomplete para modo de comando
set wildmenu
set wildmode=list:longest,full

" Wildmenu: ignorar quem?
set wildignore+=*.pyc " Python
set wildignore+=*.o " C
set wildignore+=*.class " Java

" Menos dor de cabeça, recomendo.
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq
nnoremap ; :

syntax on " Ativa syntax highlight
filetype plugin on " Plugins necessitam disso
tab ball " Deixa menos bagunçado colocando um arquivo por aba

call plug#begin()
Plug 'jiangmiao/auto-pairs' " Fecha os blocos que abre, fica parecido com o esquema do vs code
Plug 'tpope/vim-surround' " Mexe com coisas em volta, tipo parenteses
Plug 'tomtom/tcomment_vim' " Preguiça de comentar as coisas na mão: gc {des,}comenta o selecionado, gcc {des,}comenta a linha
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

if has('nvim')
    Plug 'ncm2/ncm2' " Autocomplete
    Plug 'ncm2/ncm2-path' " Completa pastas e arquivos
    Plug 'roxma/nvim-yarp' " Dependencia do plugin anterior
    Plug 'ncm2/ncm2-syntax' " Completa pela definição de sintaxe
    Plug 'shougo/neco-syntax' " Dependencia
endif

if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }
endif

" Vue:
Plug 'posva/vim-vue' " Syntax highlight para vue já puxando tudo certin

" Toml:
Plug 'cespare/vim-toml' " Syntax highlight toml

" Typescript:
Plug 'HerringtonDarkholme/yats.vim' " Syntax typescript
" Plug 'ncm2/nvim-typescript', {'do': './install.sh'}
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" Denite:
if isNote
    Plug 'Shougo/denite.nvim'
    autocmd FileType denite call s:denite_conf()
    function! s:denite_conf() abort
        nnoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> d
                    \ denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> p
                    \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> q
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> i
                    \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
                    \ denite#do_map('toggle_select').'j'
    endfunction
endif

" VimScript:
Plug 'ncm2/ncm2-vim'
Plug 'Shougo/neco-vim'

" Markdown:
if executable('npm')
    " MarkdownPreview chama o preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
endif

" Latex:
if executable('pdflatex')
    " LLPStartPreview mostra o preview
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'lervag/vimtex'
    " https://github.com/lervag/vimtex/issues/1160
    au User Ncm2Plugin call ncm2#register_source({
                \ 'name' : 'vimtex',
                \ 'priority': 9,
                \ 'subscope_enable': 1,
                \ 'complete_length': 1,
                \ 'scope': ['tex'],
                \ 'mark': 'tex',
                \ 'word_pattern': '\w+',
                \ 'complete_pattern': g:vimtex#re#ncm,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
endif

" if executable('typescript-language-server')
"     let g:LanguageClient_serverCommands.typescript = [exepath('typescript-language-server'), '--stdio']
" endif
"
if executable('ccls')
    let g:LanguageClient_serverCommands.c = [exepath('ccls')]
    let g:LanguageClient_serverCommands.cpp = [exepath('ccls')]
endif

if executable('gopls')
    let g:LanguageClient_serverCommands.go = [exepath('gopls')]
endif

" if executable('jdtls')
"     let g:LanguageClient_serverCommands.java = [exepath('jdtls'), '-data', getcwd()]
" endif

if executable('lua-lsp')
    let g:LanguageClient_serverCommands.lua = [exepath('lua-lsp')]
endif

if executable('rls')
    let g:LanguageClient_serverCommands.rust = [exepath('rls')]
endif

" if executable('javascript-typescript-stdio')
"     let g:LanguageClient_serverCommands.javascript = [exepath('javascript-typescript-stdio')]
" endif

if has('nvim')
    Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}
endif

" Dart:
if executable('dart_language_server')
    Plug 'dart-lang/dart-vim-plugin' " Syntax Highlight dart
    let g:LanguageClient_serverCommands.dart = [exepath('dart_language_server')]
    let dart_html_in_string=v:true
    let dart_style_guide = 2
    let dart_format_on_save = 1
endif

" Java:
if has('nvim')
    Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp']}
    Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}
endif


" Arduino:
if has('arduino')
    Plug 'stevearc/vim-arduino'
    let g:arduino_dir = '/usr/share/arduino'
endif

if executable("gofmt")
    " autocmd BufWrite *.go :%!gofmt " Passa gofmt automagicamente
endif

if executable('pdftotext')
    " Ler pdf no vim
    :command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
endif

if has('nvim')
    " NCM2:
    autocmd BufEnter * call ncm2#enable_for_buffer() " Ativa pra galera
    nnoremap <F5> :call LanguageClient_contextMenu()<CR>
endif

" Temas e customizações
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#virtualenv=1
let g:airline_powerline_fonts = 1 " Aqui desbugou um símbolo
let g:airline_theme='minimalist'
let g:airline_statusline_ontop=1 " É estranho mas é legal :v

" Colorscheme:
Plug 'joshdick/onedark.vim' " Onedark <3
autocmd VimEnter * colorscheme onedark

" Trocar variante do tema
com! Transparent hi Normal ctermbg=none
com! White hi Normal ctermbg=white
com! Black hi Normal ctermbg=black

" Leader == vírgula
let mapleader = ','

" Emmet: macro para html
Plug 'mattn/emmet-vim'
autocmd VimEnter * EmmetInstall
let g:user_emmet_mode='a'

" Neomake:
Plug 'neomake/neomake'
autocmd VimEnter * call neomake#configure#automake('w')

" Syntastic:
if has('nvim')
    Plug 'vim-syntastic/syntastic'
endif

" Echodoc: 
if has('nvim')
    Plug 'Shougo/echodoc.vim'
    let g:echodoc#enable_at_startup=1
    " set cmdheight=2
    set noshowmode
    " let g:echodoc#type = "virtual"
endif

call plug#end()
