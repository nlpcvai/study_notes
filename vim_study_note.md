​	

# vim study note

## Buffer (digits): 1-9, " (quoation mark)



### Navigation 

``` shell
ctrl+E		# drag down window
ctrl+Y		# drag up window
<C-w> k <C-w> x     # swap panes position
^w+v, ^w+s   # split 
Ctrl+W +/-: increase/decrease height (ex. 20<C-w>+)
Ctrl+W >/<: increase/decrease width (ex. 30<C-w><)
Ctrl+W _: set height (ex. 50<C-w>_)
Ctrl+W |: set width (ex. 50<C-w>|)
Ctrl+W =: equalize width and height of all windows
z0<CR> to minimize height of current window
z99<CR> to maxmize height of current window
z= to make them all equal

buffer-variable    b:     Local to the current buffer.                          
window-variable    w:     Local to the current window.                          
tabpage-variable   t:     Local to the current tab page.                        
global-variable    g:     Global.                                               
local-variable     l:     Local to a function.                                  
script-variable    s:     Local to a :source'ed Vim script.                     
function-argument  a:     Function argument (only inside a function).           
vim-variable       v:     Global, predefined by Vim.
```

Format
n			# find up
N			# find down
```

### Format

​``` shell
=%			# Format current file
```



### visual mode

viw, vaw, vip, vap, vi), va), vi{, vi[, vi", vib, viB, 

**Keyword completion**

ctrl+n, ctrl+p

### Uppercase

gUis, 

### Autocmd



saveas

### Abbrevation

整页翻页 ctrl-f ctrl-b
f就是forword b就是backward

翻半页
ctrl-d ctlr-u
d=down u=up

滚一行
ctrl-e ctrl-y

zz 让光标所在的行居屏幕中央
zt 让光标所在的行居屏幕最上一行 t=top
zb 让光标所在的行居屏幕最下一行 b=bottom						

## vim registers

You could add the selected text to the register `r` by doing `"ry`. By doing `y` you are copying (yanking) the selected text, and then adding it to the register `"r`. To paste the content of this register, the logic is the same: `"rp`. You are `p`asting the data that is in this register.

You can also access the registers in insert/command mode with `Ctrl-r` + register name, like in `Ctrl-r r`. It will just paste the text in your current buffer.
You can use the `:reg` command to see all the registers and their content, or filter just the ones that you are interested with `:reg a b c`.

### The unnamed register

`vim` has a unnamed (or default) register that can be accessed with `""`. Any text that you delete (with `d`, `c`, `s` or `x`) or yank (with `y`) will be placed there, and that’s what `vim` uses to `p`aste, when no explicit register is given. A simple `p` is the same thing as doing `""p`.

Well, as I said, `vim` will always replace the unnamed register, but of course we didn’t lose the yanked text, `vim` would not have survived that long if it was that dumb, right?

`vim` automatically populates what is called the **numbered registers** for us. As expected, these are registers from `"0` to `"9`.
`"0` will always have the content of the latest yank, and the others will have last 9 deleted text, being `"1` the newest, and `"9` the oldest. So if you yanked some text, you can always refer to it using `"0p`.

### The read only registers

There are 4 read only registers: `".`, `"%`, `":` and `"#`
The last inserted text is stored on `".`, and it’s quite handy if you need to write the same text twice, in different places, not needing to yank and paste.

`"%` has the current file path, starting from the directory where `vim` was first opened. What I usually use it for is to copy the current file to the clipboard, so I can use it externally (running a script in another terminal, for instance). You could execute `:let @+=@%` to do that. `let` is used to write to a register, and `"+` is the clipboard register, so we are copying the current file path to the clipboard.

`":` is the most recently executed command. If you save the current buffer with `:w`, “w” will be in this register. A good way to use it is with `@:`, to execute this command again. For example, if you execute a substitute command in one line, like in `:s/foo/bar`, you can just to go another line and execute `@:` to run this substitution again.

`"#` is the name of the alternate file, that you can think of it as the last edited file (it’s a bit more complex than that, go to `:h alternate-file` if you want to understand it better). It’s what `vim` uses to switch between files when you use `Ctrl-^`, and you could do the same thing with `:e Ctrl-r #`. I rarely use this, but hopefully you are more creative than I am.

### The expression and the search registers

The expression register (`"=`) is used to deal with results of expressions. This is easier to understand with an example. If, in insert mode, you type `Ctrl-r =`, you will see a “=” sign in the command line. Then if you type `2+2 `, `4` will be printed. This can be used to execute all sort of expressions, even calling external commands. To give another example, if you type `Ctrl-r =` and then, in the command line, `system('ls') `, the output of the `ls` command will be pasted in your buffer.

The search register, as you may have imagined, is where the latest text that you searched with `/`, `?`, `*` or `#` is. If, for example, you just searched for `/Nietzsche`, and now you want to replace it with something else, there is no way you are going to type “Nietzsche” again, just do `:%s//mustache/g` and you are good to go.

## Macros
<<<<<<< HEAD

You may already be familiar with `vim`’s macros. It’s a way to record a set of actions that can be executed multiple times (`:h recording` if you need more information). What you probably didn’t know is that `vim` uses a register to store these actions, so if you use `qw` to record a macro, the register `"w` will have all the things that you did, it’s all just plain text.

The cool thing about this is that, as it is just a normal register, you can manipulate it as you want. How many times have you forgotten that step in the middle of a macro recording and had to do it all over again? Well, fixing that is as simple as editing a register.
For example, if you forgot to add a semicolon in the end of that `w` macro, just do something like `:let @W='i;'`. Noticed the upcased `W`? That’s just how we append a value to a register, using its upcased name, so here we are just appending the command `i;` to the register, to enter insert mode (`i`) and add a semicolon.
If you need to edit something in the middle of the register, just do `:let @w='`, change what you want, and close the quotes in the end. Done, no more recording a macro 10 times before you get it right.

Another cool thing about this is that, as it’s just plain text in a register, you can easily move macros around, applying it in other vim instance, or sharing it with someone else. Think about it, if you have that register in your clipboard, you can just execute it with (is the clipboard register). Try it, just write “ivim is awesome” anywhere, then copy it to your clipboard, and execute in a vim buffer. How cool is that?

You may already be familiar with `vim`’s macros. It’s a way to record a set of actions that can be executed multiple times (`:h recording` if you need more information). What you probably didn’t know is that `vim` uses a register to store these actions, so if you use `qw` to record a macro, the register `"w` will have all the things that you did, it’s all just plain text.

The cool thing about this is that, as it is just a normal register, you can manipulate it as you want. How many times have you forgotten that step in the middle of a macro recording and had to do it all over again? Well, fixing that is as simple as editing a register.
For example, if you forgot to add a semicolon in the end of that `w` macro, just do something like `:let @W='i;'`. Noticed the upcased `W`? That’s just how we append a value to a register, using its upcased name, so here we are just appending the command `i;` to the register, to enter insert mode (`i`) and add a semicolon.
If you need to edit something in the middle of the register, just do `:let @w='`, change what you want, and close the quotes in the end. Done, no more recording a macro 10 times before you get it right.

Another cool thing about this is that, as it’s just plain text in a register, you can easily move macros around, applying it in other `vim` instance, or sharing it with someone else. Think about it, if you have that register in your clipboard, you can just execute it with `@+` (`"+` is the clipboard register). Try it, just write “ivim is awesome” anywhere, then copy it to your clipboard, and execute `@+` in a `vim` buffer. How cool is that?

``` shell
set nocompatible              " be iMproved, required
filetype off                  " required
 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
 
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
 
 
" let g:airline_powerline_fonts = 1
 
" if !exists('g:airline_symbols')
" let g:airline_symbols={}
" endif
 
syntax enable
set number relativenumber
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wildmenu
 
set nobackup
set nowritebackup
set noswapfile
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
"set langmenu=zh_CN.UTF-8
set helplang=en
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
 
 
" 在被分割的窗口间显示空白，便于阅读
""set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 为C程序提供自动缩进
set smartindent
" 高亮显示普通txt文件（需要txt.vim脚本）
"" au BufRead,BufNewFile *  setfiletype txt
"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on
"打开文件类型检测, 加了这句才可以用智能补全
""set completeopt=longest,menu
"---------------Mappings----------------"
 
let mapleader = ','
imap jk <ESC>
nnoremap ,ev :tabedit ~/.vimrc<cr>
 
 
set backspace=indent,eol,start
 
 

"---------------Auto-Commands----------------"
autocmd BufWritePost .vimrc source %
 
inoremap <C-u> <esc>gUiwea

map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()                  # The ! is needed to unset the function declared before

    exec "w" 

    if &filetype == 'c' 

        exec "!g++ % -o %<"

        exec "! ./%<"

    elseif &filetype == 'cpp'

        exec "!g++ % -o %<"

        exec "! ./%<"

    elseif &filetype == 'java'

        exec "!javac %"

        exec "!java %<"

    elseif &filetype == 'sh'

        :!sh %

    elseif &filetype == 'python'

        :!python3 %

    elseif &filetype == 'go'

        :!go run %

    endif

endfunc

 

augroup ShellCmds

    autocmd!                   # Delete all previours autocmd

    autocmd Filetype sh call setline(1,"\#!/usr/bin/bash") 

augroup END
```

### vim-plug

``` shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

