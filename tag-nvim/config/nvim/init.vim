set nocompatible			"不与vi兼容
set termguicolors
colorscheme industry        "配色方案
" colorscheme darkblue           "配色方案
" colorscheme koehler           "配色方案
" colorscheme evening           "配色方案
"透明背景
set background=dark
highlight Normal guibg=NONE ctermbg=None
highlight DiffAdd guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE

filetype on					"启动文件类型检查
syntax on					"代码高亮
set number					"显示行号
set relativenumber			"相对行号
set textwidth=120			"一行最多输入120字符，否则自动换行(会添加换行符，慎用), 可用gq强制换行
set formatoptions+=w		"gq自动换行时避免多行合一
set mouse=c			        "屏蔽鼠标
set wrap					"自动换行
set wrapmargin=5			"折行与右边缘相差字符数
set linebreak				"只在特殊符号处换行，单词不折
set scrolloff=3				"滚动时光标距离底/顶部有多少行
set sidescrolloff=10		"滚动时光标距离左/右有多少字符
set showmatch				"括号匹配
set hlsearch				"搜索高亮
set ignorecase				"查找时忽略大小写
set smartcase				"查找时如果有大写，强制区分大小写
set splitbelow				"默认分屏在下方, sp
set splitright				"默认分屏在右方, vsp
set wildmenu				"tab命令补全时显示候选列表
set confirm					"在处理未保存或只读文件的时候，弹出确认
set incsearch				"递进式搜索(一边输入一边高亮, 但是会时刻跳转光标)
set showcmd					"显示命令
set autochdir				"自动切换工作目录
set nobackup				"写入文件时，不做备份
set nowritebackup			"写入文件时，不做备份
set noswapfile				"不用交换文件
set cursorline				"高亮当前行
set ambiwidth=double        "使用双字宽显示
set autoread			    "当文件被改动时自动载入
set helplang=cn				"使用中文帮助文档
set spell					"启动内置英文检查
set spelllang=en,cjk		"设置检查语言为英语，中文，日语
highlight clear SpellRare 
highlight clear SpellBad 
highlight clear SpellCap 
highlight clear SpellLocal

"设置在不同模式下的光标样式 start
" For VTE compatible terminals (urxvt, st, xterm, gnome-terminal 3.x,  
" Konsole KDE5 and others) and wsltty
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
"设置在不同模式下的光标样式 end

" 缩进相关 start
filetype indent on		"自动匹配缩进方式
set autoindent			"自动缩进, 可用缩写为"ai"
set smartindent			"智能缩进，类似与cindent
set shiftwidth=4		"自动缩进的长度
set tabstop=4			"设置tab大小为4空格
set softtabstop=4		"保证tab和空格共用时缩进格式相同
set expandtab			"设置tab为空格
" 缩进相关 end

" 折叠 start
" za切换折叠模式，zR取消全部折叠，zM折叠全部
" manual: 手工定义折叠 
" indent: 按照缩进折叠
" syntax: 基于语法折叠
" marker: 按照文中标志折叠
" expr  : 用表达式来定义折叠
" diff  : 对没有改变的内容折叠
set foldmethod=syntax       "设置默认折叠方式
" set foldmethod=manual	    "折叠方式manual可追加，实现自定义折叠
set foldcolumn=0            "左侧折叠标志栏的宽度
set nofoldenable            "打开文件时不自动折叠
set foldtext=MyFoldText()   "定义折叠后的显示内容
function MyFoldText()
    let start=getline(v:foldstart)
    let temp=substitute(start, "(.*)", "(...)", "g")
    let end=getline(v:foldend)
    let show=printf("%s\t\t%s", temp, end)
    return v:folddashes . show
endfunction
" 折叠 end

" 状态栏设置 start
" %.50F		最长显示50字符的文件路径
" %t		显示文件名
" %m		如果缓冲区已修改则表示为[+]
" %r		如果缓冲区为只读则表示为[RO]
" %h		如果为帮助缓冲区显示为[Help]
" %w		如果为预览窗口则显示为[Preview]
" %=		后面的类容右侧对齐
" %{&ff}	文件系统类型
" %{&fenc}	文件编码格式
" %y		文件类型, 使用[]包裹
" %Y		文件类型, 不使用[]包裹
" %l		光标所在行
" %c		光标所在列
" %p		当前行占总行数百分比
" %{strftime(\"%y/%m/%d-%H:%M:%S\")}	显示时间
set laststatus=1	"是否显示状态栏, 0：不，1：多窗口显示，2，显示
set statusline=%.40F%m%r%h%w%=%y%{&fenc}\ %l,%c\ %03p%%\ 
set ruler			"标尺栏, 存在状态栏时不显示
set rulerformat=%40(%2*%<%=%t%m%r%w\ %l,%c\ %p%%%) 
" 状态栏设置 end

" 文件编码 start
" 
" ucs-bom最不容易误判，utf-8其次
" gb18030涵盖范围广，同时兼容较低涵盖的GBK, GB2312, ASCII
" 繁体的big5支持范围不大，且与gb18030相互会错误识别, 但是big5使用场景较少
" latin1是ISO-8859-1，支持范围着实太小，但基本可以表示一切，放最后
" utf-16,utf-32实测不包含在fileencodings中也可以被正确识别, 且使用场景较少
"
set fileencodings=ucs-bom,utf-8,gb18030,euc-jp,euc-kr,latin1
" set encoding=utf-8
" set fileencoding=utf-8
" 文件编码 end

" key map start
" inoremap , , 
nnoremap <ESC> :noh<CR>
" 使当前找到的字符所在行居中
nnoremap n nzzzv
nnoremap N Nzzzv
" key map end

" makefile use tab
autocmd FileType make set noexpandtab
" 设置Makefile不用空格替换Tab

" 对于长度高于80字符的部分添加下划线
autocmd FileType c match Underlined /\%>119v.*/
" match Underlined /\%>79v.*/
" set colorcolumn=120	"设置80列报警线

autocmd TermOpen term://* set nornu | set nonu
autocmd TermOpen term://* startinsert

"自动按照文件类型执行脚本函数
autocmd BufNewFile *.sh,*.c,*.h,*.hpp,*.cpp,*.py exec ":call SetTitle()" 

"定义函数SetTitle，自动插入文件头 
func SetTitle()
    if &filetype == 'sh'
        call setline(1,"#!/bin/sh")
        " call append(line("."), "# The exit status of the previous command is obtained as the final exit state")
        " call append(line(".")+1, "# and echo first parm")
        " call append(line(".")+2, "function _exit()")
        " call append(line(".")+3, "{")
        " call append(line(".")+4, "    ret=$?")
        " call append(line(".")+5, "    if [ \"$0\" != \"${BASH_SOURCE[0]}\" ]; then")
        " call append(line(".")+6, "        echo \"return script $1\"")
        " call append(line(".")+7, "        return $ret")
        " call append(line(".")+8, "    else")
        " call append(line(".")+9, "        echo \"exit script $1\"")
        " call append(line(".")+10, "        exit $ret")
        " call append(line(".")+11, "    fi")
        " call append(line(".")+12, "}")
        " call append(line(".")+13, "")
    elseif (expand("%:e") == 'h') || (expand("%:e") == 'hpp')
        call setline(1,"#ifndef _".toupper(expand("%:t:r"))."_H__")
        call append(line("."), "#define _".toupper(expand("%:t:r"))."_H__")
        call append(line(".")+1, "")
        call append(line(".")+2, "")
        call append(line(".")+3, "#endif")
    elseif &filetype == 'c'
        call setline(1,"#include <stdio.h>")
        call append(line("."), "#include <stdint.h>")
        call append(line(".")+1, "")
        call append(line(".")+2, "int main(int argc, char *argv[])")
        call append(line(".")+3, "{")
        call append(line(".")+4, "\treturn 0;")
        call append(line(".")+5, "}")
        call append(line(".")+6, "")
    elseif &filetype == 'cpp'
        call setline(1,"#include <iostream>")
        call append(line("."), "")
        call append(line(".")+1, "int main()")
        call append(line(".")+2, "{")
        call append(line(".")+3, "\treturn 0;")
        call append(line(".")+4, "}")
        call append(line(".")+5, "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."), "# -*- coding: UTF-8 -*-")
    endif
endfunc

" some others

