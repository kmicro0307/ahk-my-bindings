nmap j gj
nmap k gk
" I like using H and L for beginning/end of line
nmap H 0
nmap L $
nmap K 15k
nmap J 15j
vmap H 0
vmap L $
vmap K 15k
" 本来のJを使いたいのでコメントアウト
"
vmap J 15j
" Quickly remove search highlights
nmap <F9> :nohl
nmap <C-z> u
nmap <Esc> :nohl
" nmap <C-c> <C-c>:nohl
map <C-`> <C-[>
nmap <C-[> :nohl
imap jk <C-[>
" imap <C-@> <C-[>

nmap <C-a> y
" nmap O o<Esc>D 
nmap <C-0> o<Esc>D 
vmap <C-a> y
" Yank to system clipboard
set clipboard=unnamed
nmap <Space> /
nmap <S-Space> ?
""nmap <C-v> p
"" "" nmap s <C-s>
nmap <C-Left> b
nmap <C-Right> w
nmap ^ T-
" nmap <Home> 00
" nmap <End> $j
"行の削除
