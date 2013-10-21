ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}%B["
ZSH_THEME_GIT_PROMPT_SUFFIX="%b]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_RUBY_PROMPT_PREFIX="%{$reset_color%}%{$fg[red]%}["
ZSH_THEME_RUBY_PROMPT_SUFFIX="%{$fg_no_bold[red]%}]%{$reset_color%}"
ZSH_THEME_RUBY_PROMPT_INTER="%{$fg_bold[red]%}"
ZSH_THEME_PYTHON_PROMPT_PREFIX="%{$reset_color%}%{$fg[blue]%}["
ZSH_THEME_PYTHON_PROMPT_SUFFIX="%{$fg_no_bold[blue]%}]%{$reset_color%}"
ZSH_THEME_PYTHON_PROMPT_INTER="%{$fg_bold[blue]%}"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

collapsed_wd() {
  echo $(pwd | perl -pe "s|^$HOME|~|g; s|/([^/])[^/]*(?=/)|/\$1|g")
}

rb_status() {
	if [[ -a "~/.rvm/bin/rvm-prompt" ]]; then
  	echo "$ZSH_THEME_RUBY_PROMPT_PREFIX`~/.rvm/bin/rvm-prompt | sed "s/ruby-/rb:/;s/-p[0-9]*//;s/@/@$ZSH_THEME_RUBY_PROMPT_INTER/"`$ZSH_THEME_RUBY_PROMPT_SUFFIX"
	fi;
}

py_status() {
  local pfx="${ZSH_THEME_PYTHON_PROMPT_PREFIX}py:`python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))'`"
  if [[ $VIRTUAL_ENV != "" ]]; then
    echo "$pfx@$ZSH_THEME_PYTHON_PROMPT_INTER${VIRTUAL_ENV##*/}$ZSH_THEME_PYTHON_PROMPT_SUFFIX"
  else
    echo "$pfx$ZSH_THEME_PYTHON_PROMPT_SUFFIX"
  fi
}

#RVM and git settings
# if [[ -s ~/.rvm/scripts/rvm ]] ; then 
#   RPS1='$(git_custom_status)%{$fg[red]%}[`~/.rvm/bin/rvm-prompt | sed "s/ruby-/rb:/;s/-p[0-9]*//"`]%{$reset_color%} $EPS1'
# else
#   if which rbenv &> /dev/null; then
#     RPS1='$(git_custom_status)%{$fg[red]%}[`rbenv version | sed -e "s/ (set.*$//"`]%{$reset_color%} $EPS1'
#   else
#     RPS1='$(git_custom_status) $EPS1'
#   fi
# fi

RPS1='$(git_custom_status)$(rb_status)$(py_status) $EPS1'


if [[ `whoami` == *will* ]] then;
	UN=""
else;
	UN="%{$fg[magenta]%}%n"
fi; 

if [[ `hostname` == *deepthought* ]] then;
 	HN="$UN"
else;
	if [[ -n "$UN" ]] then;
		UN="$UN@"
	fi;
	
	if [[ `hostname` == *42.beiju.me* ]] then;
		HN_CODE="hactar"
	else;
		HN_CODE="%m"
	fi; 
	
	HN="$UN%{$fg[yellow]%}$HN_CODE:"
fi;

PROMPT='$HN%{$fg[cyan]%}[$(collapsed_wd)% ]%(?.%{$fg[green]%}.%{$fg[red]%})%B%(!.#.$)%b '
