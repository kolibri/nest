#[23:57] [aerith] [ko] [~/Development/projects/ko] [master] ⚑ ◒
# >
PROMPT='
%{$fg[blue]%}[%T]%{$reset_color%} %{$fg[red]%}[%m]%{$reset_color%} %{$fg[green]%}[%n]%{$reset_color%} %{$fg[cyan]%}[%~]%{$reset_color%} $(git_prompt_info) $(git_prompt_status)
${_return_status}> '

local _current_dir="%{$fg[blue]%}%3~%{$reset_color%} "
local _return_status="%{$fg[red]%}%(?. .!)%{$reset_color%}"


if [[ $USER == "root" ]]; then
  CARETCOLOR="red"
else
  CARETCOLOR="white"
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}& "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}- "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}◒ "

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'
