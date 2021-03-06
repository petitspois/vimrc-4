" https://github.com/gaopenghigh/vimrc

" ==========
" 常用快捷键
" ==========

" === 编辑 ===
" A                     在行末追加
" I                     在行首插入
" J                     把两行连起来
" :r FILENAME           向当前文件中插入另外的文件的内容
" :23r FILENAME         把FILENAME的内容插入到第23行
" :1,10 w FILENAME      把0到10行间的内容保存为FILENAME
" :1,10 w >> FILE       把1到10行间的内容追加到FILENAME
" :g/string/d           删除所有包含string的行
" <Ctrl>+a/<Ctrl>+x     增加/减少当前光标下的数字
" u/U                   在选中之后，”U”和”u”分别把选中的部分大写或小写
" !sort                 对文本进行简单排序：用shift v选中多行文本，输入 !sort
" r/<Ctrl>+r            撤销/重复
" </>                   缩进控制
" set paste             粘贴

" === 移动 ===
" <Shift> + v           行选择
" <Ctrl> + v            操作(块选择后按$到行末)
" g_                    本行最后一个不是blank字符的位置
" gd                    到变量声明的地方
" f                     字符查找命令，”fx” 命令向后查找本行中的字符 x
" F                     似于f, 但是向左查找
" H,M,L                 别代表移到当前视野的Home, Middle, Last处
" 20|                   光标移动到第20列
" <Ctrl> + ]            到定义的地方，需要ctags事先生成tag文件
" <Ctrl> + o            回之前的位置

" === 操作 ===
" :ls                   列出buffer
" 5 + <Ctrl> + ^        跳到第5号buffer
" <Ctrl> + g            显示当前编辑文件中当前光标所在行位置以及文件状态信息
" g + <Ctrl> + g        显示统计信息
" :qall                 全部退出
" :wqall                全部保存退出
" :vs/:split            垂直/水平分割窗口
" :tabedit              新开一个tab编辑
" gt/gT, <C-PgUp/PgDn>  在tab间切换
" :so/:source FILE      Source vim脚本文件, :so % source正在编辑的文件

" === 在tabs和windows之间移动 ===

" map leader键设置
let mapleader = ","
let g:mapleader = ","

" 按<F2>在新tab中编辑文件, 注意下一行末尾是有个空格的:)
nnoremap <F2> :tabedit

" 按 ,1 ,2 ,3等跳到相应的tab
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt

" ====
" 替换
" ====

" s/old/new/g    当前行中所有old替换成new
" :%s/old/new/   表示将全文中old替换成new，但每行只替换第一个单词
" :%s/old/new/g  表示将全文中所有出现过的old替换成new (所有都替换)
" :g/string/d    删除所有包含string的行
" :v/string/d    删除所有不包含string的行

" ==
" 宏
" ==

" qa    开始录制, 过程记录在寄存器a
" @a    replay寄存器a中的宏
" @@    replay最新录制的宏
" 20@a  replay 20遍a中的宏

" ========
" 全局设置
" ========

" === 备份和保存 ===
set nobackup        " 关闭备份
set nowb            " 当覆盖一个文件时没有备份
set noswapfile      " 没有swap文件
set hid             " 切换buffer时不自动保存
set autowrite       " 做buffer切换等操作时，自动把内容写回文件

" 重新打开一个文件时跳到上一次编辑的地方
if has("autocmd")
   autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" what is autocmd:
" 在文件读写，缓冲区或窗口进出，甚至 Vim退出等时刻，可以指定要自动执行的命令

" === 显示 ===
set showmatch       " 显示括号配对
set linebreak       " 整词换行
set incsearch       " 输入字符串就显示匹配点
set hlsearch        " 高亮搜索结果
set number          " 显示行号
set title           " 在title bar上显示信息

" === 状态行 ===
set laststatus=2    " 显示状态行，0不显示, 1当窗口数大于1是显示, 2总是显示
set ruler           " 显示标尺

" === 外观 ===
syntax on
"set background=dark

" === 格式 ===
set tabstop=4       " 1 tab = 4 spaces
set shiftwidth=4    " 缩进规格为4个空格
set expandtab       " 使用空格代替tab, 输入:re可以把tab替换为空格
set autoindent      " 自动缩进
set smartindent     " Smart缩进

" 列数为80,120的地方高亮显示, 只支持vim7.3
if exists('+colorcolumn')
    let &colorcolumn="80,".join(range(120,999),",")
endif

" ==================
" 使用Vundle管理插件
" ==================

" 使用Vundle来管理插件 https://github.com/gmarik/Vundle.vim
" 首先运行：
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 然后把下面几行写入.vimrc:
set nocompatible
filetype off " required!
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" 然后在.vimrc里面设置需要安装的插件
" 输入:PluginInstall安装插件

Plugin 'gmarik/vundle'      " 使用vundle管理vundle

Plugin 'Tagbar'      "{
    " Tagbar显示右侧边栏
    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
    nmap <F9> :TagbarToggle<CR>

    " Golang {
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
        \ }
    "}

Plugin 'Syntastic' "{
    " Syntastic是强大的语法检查插件
    " 通过其他专业的检查工具，实现在vim内部检查各种语言的语法
    " 各种语言的语法检查工具: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
    let g:syntastic_python_checkers = ['pyflakes', 'pep8', 'pylint']
"}

Plugin 'vim-powerline' "{
    " vim-powerline让状态栏更酷
    " 使用vundle安装出错, 手工安装:
    " cd ~/.vim/bundle && git clone https://github.com/Lokaltog/vim-powerline
"}

Plugin 'vim-golang' "{
    " golang官方插件
    " 使用vundle找不到这个插件，所以手工安装
    " 方法一: cd ~/.vim/bundle && git clone https://github.com/jnwhiteh/vim-golang.git
    " 方法二: cp -r $GOROOT/misc/vim ~/.vim/bundle
    autocmd BufWritePre *.go Fmt
"}

Plugin 'vim-compiler-go' "{
"}

Plugin 'vim-godef' "{
 let g:godef_split = 2 " open the definition in a new tab
 let g:godef_same_file_in_same_window=1
"}

Plugin 'nerdtree' "{
    " 文件浏览
    " 手工安装: cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdtree.git
    " 默认显示bookmarks
    let NERDTreeShowBookmarks = 1
    " 按F3打开文件导航窗口, 在导航窗口按q退出
    map <silent> <F3> :NERDTreeToggle<cr>
"}

Plugin 'molokai' "{
    " 最好的颜色主题molokai, https://github.com/tomasr/molokai
    " 注意，有好几个名为molokai的主题，上面tomasr这个最美
    " 最后一定要设置t_Co=256
    colorscheme molokai
    let g:rehash256 = 1
    set t_Co=256                " number of colors
"}

Plugin 'command-t' "{
" 超级好用的文件查找插件
" 需要手工安装：
"     cd ~/.vim/bundle && git clone git@github.com:wincent/command-t.git
"     cd ~/.vim/bundle/command-t/ruby/command-t/ && ruby extconf.rb && make
" 查找文件:  <leader>-t , 查找buffer: <leader>-b
" C-h, C-j 在文件列表中移动
" C-s 在水平窗口打开, C-v 在垂直分割窗口打开, C-t 在新Tab打开
" }

Plugin 'nerdcommenter' "{
" 批量加减注释
" 手工安装
"     cd ~/.vim/bundle && git clone git@github.com:scrooloose/nerdcommenter.git
" <leader>-cc 加注释， <leader>-cu 减注释
"}

Plugin 'vim-surround' "{
" 手工安装: cd ~/.vim/bundle && git clone git://github.com/tpope/vim-surround.git
" 快捷键: cs, ds, yss
" }

Plugin 'Vim-Jinja2-Syntax'


" vundle设置完之后需要写入下面这行
filetype plugin indent on

" ==========
" 自定义函数
" ==========

" 删除末尾的空格
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.t2t,*.sh,*.md,*.markdown,*.go :call DeleteTrailingWS()

" 自动添加一些有用的信息
autocmd BufNewFile *.sh,*.py exec ":call SetTitle()"
func SetTitle()
    if &filetype == 'sh'
        call setline(1, "\#!/bin/sh")
        call append(line(".")+1, "")
        :8
    elseif &filetype == 'python'
        call append(line("."), "\# -*- coding: utf-8 -*-")
        call append(line(".")+2, "")
        :8
    endif
endfunc

" 运行这个文件(python, bash, lua, perl, go)
" 写python或shell时经常需要运行正在编辑的文件做测试
" 按下<F10>就用相应的解释器运行这个文件
map <F10> :call AutoRun(input('argv : '))<cr>
func AutoRun(par)
    let par = a:par
    exec "w"
    if &filetype == 'sh'
        let cmd = "!bash % ".par
    elseif &filetype == 'python'
        let cmd = "!python % ".par
    elseif &filetype == 'perl'
        let cmd = "!perl % ".par
    elseif &filetype == 'lua'
        let cmd = "!lua % ".par
    elseif &filetype == 'go'
        let cmd = "!go run % ".par
    elseif &filetype == 'php'
        let cmd = "!php % ".par
    else
        let cmd = "!echo nothing todo"
    endif
    exec cmd
endfunc

