# エイリアス
setopt complete_aliases
alias ls="ls --color=auto"
alias vi="vim"

# 環境変数
export EDITOR="vim"

# 補完機能
autoload -U compinit
compinit

# プロンプト
case ${UID} in
0)
	PROMPT="%{[32;01m%}%n%%%{[m%} " # 平常時のプロンプト
	RPROMPT="[%~]" # 右プロンプト 
	PROMPT2="%B%{[32;01m%}%_#%{[m%}%b " # コマンドの続き
	SPROMPT="%B%{[32;01m%}%r? [n,y,a,e]:%{[m%}%b " # 合ってる？
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="%{[31;01m%}${HOST%%.*} ${PROMPT}"
	;;
*)
	PROMPT="%{[32;01m%}%n%%%{[m%} "
	RPROMPT="[%~]"
	PROMPT2="%{[32;01m%}%_%%%{[m%} "
	SPROMPT="%{[32;01m%}%r? [n,y,a,e]:%{[m%} "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
		PROMPT="%{[31;01m%}${HOST%%.*} ${PROMPT}"
	;;
esac

# ターミナルタイトル
case "${TERM}" in
kterm*|xterm)
	precmd() {
		echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
	;;
esac

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups
setopt share_history

# コマンド履歴
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

# オプション
setopt auto_pushd	# 移動履歴(cd -[Tab])
setopt correct	# コマンド訂正
setopt list_packed	# 補完候補の詰め詰め
setopt nolistbeep # ビープ消す
bindkey -v
