nn sv :source ~/.nvim/init.vim<CR>

nn <C-f> :!echo %:p:h >$__lf_cd__;
	\ echo 'fzfvim' >$__vim_prog__;
	\ echo %:p >$__vim_arg__<CR> ZZ
nn <C-o> :!echo %:p:h >$__lf_cd__;
	\ echo 'lfcd' >$__vim_prog__;
	\ echo %:p >$__vim_arg__<CR> ZZ
nn <C-h> :!echo ~ >$__lf_cd__;
	\ echo 'fzfvim' >$__vim_prog__;
	\ echo ~ >$__vim_arg__<CR> ZZ

" motions

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

" surround word with symbol

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

au SwapExists * let v:swapchoice = "e" | echom "swap exists"

" C highlighting
au BufRead,BufNewFile *.c,*.h,*.hpp,*.cpp sil! hi PreProc ctermfg=35 guifg=#8ed5e5
sil! au BufRead,BufNewFile *.c,*.h,*.hpp,*.cpp sil! mat Operator /[\<\>\?\{\}\:\+\=\|\.\-\&\*,;!]/
sil! au BufRead,BufNewFile *.c,*.h,*.hpp,*.cpp sil! 2mat Special /[(){}]/
au FileType * setl formatoptions-=c formatoptions-=r formatoptions-=o
au BufWritePost *sxhkdrc !killall sxhkd; nohup sxhkd & rm nohup.out;
au BufNewFile,BufRead *.dart se autoindent expandtab tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.json se autoindent expandtab tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.h se filetype=c
au BufNewFile *.c,*.cpp 0r ~/.nvim/templates/skeleton.c | $delete _
au BufNewFile *.pl,*.pm 0r ~/.nvim/templates/skeleton.pl
au BufNewFile *.awk 0r ~/.nvim/templates/skeleton.awk
au FileType c,cpp nm cfm :silent exec "!cfm %:p"<CR>
au FileType sh,bash nm cfm :silent exec "!shfmt -w %:p"<CR>
au BufEnter * sil! lcd %:p:h
au BufEnter * sil! !echo :%p:h >$__vim_arg__

" visible cursor and parens
hi MatchParen guifg=white guibg=none
hi CursorLine ctermbg=none guibg=#3c3836
hi CursorColumn ctermbg=none guibg=#3c3836
" completion menu
hi Pmenu ctermbg=none ctermfg=15 guibg=none guifg=#ffffff
" hi PmenuSel ctermfg=Black ctermbg=none gui=reverse

" undodir
let __vimDir__ = '$HOME/.vim'
" add if !__vimDir__
if stridx(&runtimepath, expand(__vimDir__)) == -1
	let &runtimepath.=','.__vimDir__
en
if has('persistent_undo')
	let myUndoDir = expand(__vimDir__ . '/undodir')
	" Create dirs
	cal system('mkdir ' . __vimDir__)
	cal system('mkdir ' . myUndoDir)
	let &undodir = myUndoDir
	se undofile
en
