nn ;nv :source $HOME/.nvim/init.vim<CR>
nn ;ua :!$HOME/.zsh/upalias<CR>

au BufEnter * sil! !rm -f $__VIM_ARG__ &
	\ rm -f $__VIM_PROG__ &
au BufEnter * sil! lcd %:p:h

" open cwd in new terminal
nn <space>s :!exec $TERMINAL &<CR><CR>

" jump between paragraphs
map J }
map K {
map <C-j> <C-d>
map <C-k> <C-u>

" copy paste
vn <C-d> "+y:delete<CR>
vn <C-c> "*y :let @+=@*<CR>
nn cc <S-v> "*y :let @+=@*<CR>
no <C-p> "+P
no <C-s> :w<CR>h

" turn off vim macros
map q <Nop>

" quote $variable
nn qs lF$dEi""<Esc>hpl
nn Qs F"xf"xh
nn QS Qs

" quote word
nn qq lbdEi""<Esc>hpl
nn QQ F"xf"xh
nn Qq QQ

nn q' lbdEi''<Esc>hpl
nn Q' F'xf'xh

nn q9 lbdEi()<Esc>hpl
nn Q9 F(xf)xh

nn q, lbdEi<><Esc>hpl
nn Q, F<xf>xh
nn q. q,
nn Q. Q,

nn q- lbdEi__<Esc>hpl
nn Q- F_xf_xh
nn q_ q-
nn Q_ Q-

colo murphy
if has('nvim')
	se termguicolors
en
hi NormalFloat ctermbg=none guibg=none
hi VertSplit ctermbg=none guibg=none
hi FoldColumn ctermbg=none guibg=none
hi SignColumn ctermbg=none guibg=none
hi LineNr ctermbg=none guibg=none
hi CursorLineNr ctermbg=none guibg=none
hi Normal ctermbg=none guibg=none

filet plugin indent on
se wildmode=longest,full,full
se maxmempattern=2000000 " use more ram
se cinoptions+=:0 " disable switch indent
se number relativenumber
se linebreak
se nohlsearch
se incsearch
se mouse=a
se encoding=utf-8
se nobackup
se nowritebackup
se updatetime=300
se signcolumn=yes
se modifiable
se nocompatible
if has('nvim')
	se inccommand=nosplit " incremental search
en

" save as sudo
cnorea w!! execute 'sil! write !sudo tee % >/dev/null' <bar> edit!
" disable swap startup warning
au SwapExists * let v:swapchoice = "e" | echom "swap exists"

" C highlighting
au BufRead,BufNewFile *.c,*.h,*.hpp,*.cpp sil! hi PreProc ctermfg=35 guifg=#8ed5e5
sil! au BufRead,BufNewFile *.c,*.h,*.hpp,*.cpp sil! mat Operator /[\<\>\?\{\}\:\+\=\|\.\-\&\*,;!]/
sil! au BufRead,BufNewFile *.c,*.h,*.hpp,*.cpp sil! 2mat Special /[(){}]/
" disable autocomment
au FileType * setl formatoptions-=c formatoptions-=r formatoptions-=o
au BufNewFile,BufRead *.h se filetype=c
" 4-space tabs
au BufNewFile,BufRead *.dart se autoindent expandtab tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.json se autoindent expandtab tabstop=4 shiftwidth=4
" format current file
au FileType c,cpp nm ;cfm :silent exec "!cfm %:p"<CR>
au FileType sh,bash,zsh nm ;cfm :silent exec "!shfmt -w -fn %:p"<CR>

au BufNewFile *.c,*.cpp 0r ~/.nvim/templates/skeleton.c | $delete _
au BufNewFile *.pl,*.pm 0r ~/.nvim/templates/skeleton.pl
au BufNewFile *.awk 0r ~/.nvim/templates/skeleton.awk

au BufWritePost *sxhkdrc !killall sxhkd; nohup sxhkd & rm nohup.out;

" visible cursor and parens
hi MatchParen guifg=white guibg=none
hi CursorLine ctermbg=none guibg=#3c3836
hi CursorColumn ctermbg=none guibg=#3c3836
" completion menu
hi Pmenu ctermbg=none ctermfg=15 guibg=none guifg=#ffffff
hi PmenuSel ctermfg=Black ctermbg=none gui=reverse

" undodir
let myVimDir = '$HOME/.vim'
" add if !myVimDir
if stridx(&runtimepath, expand(myVimDir)) == -1
	let &runtimepath.=','.myVimDir
en
if has('persistent_undo')
	let myUndoDir = expand(myVimDir . '/undodir')
	" Create dirs
	cal system('mkdir ' . myVimDir)
	cal system('mkdir ' . myUndoDir)
	let &undodir = myUndoDir
	se undofile
en
