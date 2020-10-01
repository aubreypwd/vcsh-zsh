# If you come from bash you might have to change your $PATH.
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/Applications/Sublime Merge.app/Contents/SharedSupport/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/lib/node_modules:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH" # If you need to have openssl@1.1 first in your PATH run

# For compilers to find openssl@1.1 you may need to set:
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export UPDATE_ZSH_DAYS=90 # Update zsh every 90 days.

# For pkg-config to find openssl@1.1 you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

sleep "0.$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM" # Fixes issue where loading iTerm arrangements can cause issues, sleeping a few miliseconds per session gives each one time to finish what it's doing.

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [ ! -e "$ZSH" ]; then
	echo ".oh-my-zsh isn't installed!"
	return;
fi

###
 # Theme
 #
 # @since Monday, 9/21/2020 frisk
 ##
ZSH_THEME="frisk"

###
 # Builtin Plugins
 ##
plugins=(
	aubreypwd # Should be symlinked to .config
)

source $ZSH/oh-my-zsh.sh

###
 # iTerm2 History Support
 #
 # @since Monday, 9/21/2020
 ##
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

unsetopt inc_append_history
unsetopt share_history

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# This is where you put secure things.
if [ -e "$HOME/.zshrc.secure" ]; then
	source "$HOME/.zshrc.secure"
fi

# From /Users/aubreypwd/.oh-my-zsh/themes/frisk.zsh-theme
PROMPT=$'
%{$fg[red]%}%2/%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)% %{$fg[black]%}[%T]%{$reset_color%}
%{$fg_bold[black]%}$%{$reset_color%} '

export ENHANCD_FILTER=fzf

###
 # Terminus for Sublime Text 3 Support
 #
 # @since Monday, 9/21/2020
 ##
if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then
	bindkey "\e[1;3C" forward-word
	bindkey "\e[1;3D" backward-word
fi

alias edit="subl -n"
alias v="vcsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # Load fzf autocomplete.

###
 # ghq Repositories
 #
 # For repositories you want to persist on your system, add them below.
 # This uses ghq to try and (silently) install repositories you want installed.
 #
 # @since Wednesday, 9/23/2020
 ##
if [[ ! -f "/usr/local/bin/ghq" ]]; then
	echo "Please install ghq:"
	echo "\tbrew install ghq"
	echo "\treload"
else
	ghq get git@github.com:aubreypwd/Alfred.alfredpreferences.git &> /dev/null
	ghq get git@github.com:aubreypwd/system.git &> /dev/null
	ghq get git@github.com:aubreypwd/iTerm2.git &> /dev/null

	# Antigen plugins (source for below):
	ghq get git@github.com:aubreypwd/zsh-plugin-x.git &> /dev/null
fi

###
 # Antigen Plugin Manager
 #
 # @see https://github.com/zsh-users/antigen
 # @since Monday, 9/21/2020
 ##
if [[ ! -f "/usr/local/share/antigen/antigen.zsh" ]]; then
	echo "Please install antigen:"
	echo "\tbrew reinstall antigen"
	echo "\treload"
else
	source /usr/local/share/antigen/antigen.zsh # brew install antigen

	antigen bundle git # Builtin
	antigen bundle wp-cli # Builtin
	antigen bundle svn # Builtin
	antigen bundle git-extras # Builtin
	antigen bundle history-substring-search # Builtin
	antigen bundle osx # Builtin
	antigen bundle z # Builtin
	antigen bundle Tarrasch/zsh-bd # https://github.com/Tarrasch/zsh-bd

	# My plugins (source via ghq above).
	antigen bundle $(ghq root)/github.com/aubreypwd/zsh-plugin-x --no-local-clone # https://github.com/aubreypwd/zsh-plugin-x

	antigen apply
fi
