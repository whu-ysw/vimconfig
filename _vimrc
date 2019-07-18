"取消兼容模式
set nocompatible
"显示行号
set number 
"取消备份
set nobackup 

set tabstop=4
" 自动缩进
"set autoindent
"set smartindent
set cindent


" 语法高亮
syntax on
" 文件类型
filetype on

" 颜色配置
colorscheme solarized

"中文乱码
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
"vim菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"提示信息乱码
language messages zh_CN.utf-8

"插件管理
set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
call vundle#begin('$HOME/vimfiles/bundle')
"let Vundle manage Vundle,  required
Plugin 'VundleVim/Vundle.vim' "my bundle plugin
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kannokanno/previm'
Plugin 'tyru/open-browser.vim'
Plugin 'eshion/vim-sync'
call vundle#end()
filetype plugin indent on

"插件配置
"NerdTree
map <F2> : NERDTreeToggle<CR>
let NERDTreeWinSize = 25
"previm
map <F3> : PrevimOpen<CR>
map <F4> : e $HOME/_vimrc <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "##########################################################################")
        call append(line("."), "# File Name: ".expand("%"))
        call append(line(".")+1, "# Author: ysw")
        call append(line(".")+3, "# Created Time: ".strftime("%c"))
        call append(line(".")+4, "#########################################################################")
        call append(line(".")+5, "#!/bin/sh")
        call append(line(".")+7, "export PATH")
        call append(line(".")+8, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: Shengwang Ye")
        call append(line(".")+2, "    > Mail: whu_ysw@163.com ")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
	if &filetype == 'h' "vim会将c header file识别成cpp文件类型
		let sourcefilename=expand("%:t")
		let definename=substitute(sourcefilename,' ','','g')
		let definename=substitute(definename,'\.','_','g')
		let definename = toupper(definename)
		call append(line(".")+6, "#ifndef __".definename."_H")	
		call append(line(".")+7, "#define __".definename."_H")	
		call append(line(".")+8, "#endif");
	else 
		if &filetype == 'cpp'
			call append(line(".")+6, "#include<iostream>")
			call append(line(".")+7, "using namespace std;")
			call append(line(".")+8, "")
		endif
	endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc
