# LANG
export LANG=ja_JP.UTF-8

# KEYBIND
bindkey -v
bindkey "" history-incremental-search-backward

# PROMPT
PROMPT='%{%(?..$fg[red])%}%%%{$reset_color%} '
PROMPT2="> "
SPROMPT="%r is correct? [n,y,a,e]: "
RPROMPT='[%{$fg[magenta]%}$(ruby -e "print RUBY_VERSION, %(p), RUBY_PATCHLEVEL") `rprompt-git-current-branch`%F{cyan}%~%f]'
RPROMPT2="%K{green}%_%k"
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
## 入力が右端まで来たらRPROMPTを消す
setopt transient_rprompt

# ${fg[...]} や $reset_color をロード
autoload -U colors; colors

function rprompt-git-current-branch {
    local name st color

    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi
    name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
    if [[ -z $name ]]; then
        return
    fi
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=${fg[green]}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=${fg[yellow]}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=${fg_bold[red]}
    else
        color=${fg[red]}
    fi

    # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
    # これをしないと右プロンプトの位置がずれる
    echo "%{$color%}$name%{$reset_color%} "
}


# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## ヒストリファイルに追記する。
setopt append_history
## すぐにヒストリファイルに追記する。
#setopt inc_append_history
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ヒストリを共有
setopt share_history
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space

# 補完
autoload -Uz compinit
compinit
## The following lines were added by compinstall
zstyle :compinstall filename '/home/myokoym/.zshrc'
## 補完候補を一覧表示
setopt auto_list
## TAB で順に補完候補を切り替える
setopt auto_menu
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補を詰めて表示
setopt list_packed
## スペルチェック
setopt correct
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

# 未分類
## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## ビープを鳴らさない
setopt nobeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ディレクトリ名だけで cd
setopt auto_cd
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
#setopt NO_flow_control
## コマンドラインでも # 以降をコメントと見なす
#setopt interactive_comments

# PAGER
if type lv > /dev/null 2>&1; then
    ## lvを優先する。
    export PAGER="lv"
else
    ## lvがなかったらlessを使う。
    export PAGER="less"
fi

if [ "$PAGER" = "lv" ]; then
    ## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
    ## -l: 1行が長くと折り返されていても1行として扱う。
    ##     （コピーしたときに余計な改行を入れない。）
    export LV="-c -l"
else
    ## lvがなくてもlvでページャーを起動する。
    alias lv="$PAGER"
fi

# global aliases
alias -g T="| tee"
alias -g G="| grep"
alias -g L="|& $PAGER"
alias -g WC="| wc"
alias -g LC="| wc -l"
alias -g Z="| tail"


# 以下は.bashrcと共用

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# alias
## some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

## my aliases
alias lt='ls -AltrF'
alias hi='history'
alias hii='history 1'
alias ra=rails
alias g=git
alias rre='rbenv rehash'
alias be='bundle exec'
alias v='vim'
#alias e='emacs'
#alias enw='emacs -nw'
alias gren='gren --color'
alias miru='mireru'
alias mm='middleman'
alias bemm='bundle exec middleman'
alias ej='termit en ja'
alias je='termit ja en'
alias aps='aptitude search'
alias par='padrino rake'

## jokey git alias
alias gtat='git status'
alias gta='git status'
alias giff='git diff'
alias gog='git log'
alias ghow='git show'
alias gdd='git add'
alias gommit='git commit'
alias gomi='git commit'
alias gomm='git commit -m'
alias grah='git branch'
alias gheo='git checkout'
alias geset='git reset'
alias gg='git grep'

# Load RVM into a shell session *as a function*
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# android tools
## old
#export PATH=${PATH}:/home/myokoym/android/android-sdk-linux_x86/tools
#export PATH=${PATH}:/home/myokoym/android/android-sdk-linux_x86/platform-tools
#export ANDROID_HOME=/home/myokoym/bin/android-sdk-linux
#export PATH=${PATH}:$ANDROID_HOME/tools
#export PATH=${PATH}:$ANDROID_HOME/platform-tools

# touchpad disabled
#xinput set-prop 10 "Device Enabled" 0

export VIMRUNTIME=/usr/share/vim/vim74

# connect wireless lan
#sudo rmmod -f acer-wmi
#rfkill unblock all

# Configure TrackPoint
#sudo sh -c "echo -n 255 > /sys/devices/platform/i8042/serio1/serio2/sensitivity"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# retter settings
#export EDITOR=vim
#export RETTER_HOME=`pwd`/myokoym.github.com

# mikutter settings
#export MIKUTTER_HOME=`pwd`/mikutter

# sylpheed settings
#export LD_LIBRARY_PATH=/usr/local/lib

# groonga building
export GROONGA_DIR=$HOME/work/groonga
export GROONGA_CLONE_DIR=$HOME/work/groonga/groonga.clean
export GROONGA_ORG_PATH=$HOME/work/groonga/groonga.org
export CUTTER_DIR=$HOME/work/cutter
export CUTTER_SOURCE_PATH=$HOME/work/cutter/cutter

export MROONGA_GITHUB_COM_PATH=$HOME/work/groonga/mroonga.github.com

# pkg-config
export PKG_CONFIG_PATH=/tmp/local/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH

export LD_LIBRARY_PATH=/tmp/local/lib:/usr/local/lib:$LD_LIBRARY_PATH
export PATH=/tmp/local/bin:$PATH

# ssh-agent
#eval `ssh-agent`
#ssh-add

# Ruby-GNOME2
rg2home=~/work/ruby/ruby-gnome2
for name in glib2 \
            atk \
            cairo-gobject \
            clutter \
            clutter-gstreamer \
            clutter-gtk \
            gdk3 \
            gdk_pixbuf2 \
            gio2 \
            gobject-introspection \
            gstreamer \
            gtk2 \
            gtk3 \
            gtksourceview2 \
            gtksourceview3 \
            gvlc \
            pango \
            poppler \
            rsvg2 \
            vte \
            vte3 \
            webkit-gtk \
            webkit-gtk2
do
  export LD_LIBRARY_PATH=$rg2home/$name/ext/$name:$LD_LIBRARY_PATH
done

function chpwd {
  [ -n $TMUX ] && tmux setenv TMUXPWD_$(tmux display -p "#I") $PWD
}
function tmux_neww {
  tmux neww "cd $(tmux display -p "\$TMUXPWD_#I"); exec $SHELL"
}
zle -N tmux_neww
bindkey "" tmux_neww

export PATH=$PATH:~/packer/
export GOPATH=~/go
export PATH=$PATH:~/go/bin/

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
