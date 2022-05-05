# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:/usr/lib/go-1.16/bin:/home/amaldeme/go/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/home/amaldeme/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl terraform kube-ps1 virtualenv sudo docker docker-compose encode64 helm golang) 

# Prevent the aws plugin to override the prompt
# SHOW_AWS_PROMPT=false


# Load awscli completions
# AWS CLI v2 comes with its own autocompletion. Check if that is there, otherwise fall back
if command -v aws_completer &> /dev/null; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C aws_completer aws
fi

source $ZSH/oh-my-zsh.sh

# User configuration

kubeps1_prompt(){
  prompt_segment blue black "$(_kube_ps1_symbol)$KUBE_PS1_SEPERATOR$KUBE_PS1_CONTEXT$KUBE_PS1_DIVIDER$KUBE_PS1_NAMESPACE"
}

custom_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  kubeps1_prompt
  prompt_aws
  prompt_context
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}

PROMPT='%{%f%b%k%}$(custom_prompt) '

export WORDCHARS='*?_[]~=&;!#$%^(){}/-:".'

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

export EDITOR=nvim
export AWS_PROFILE=alexandre.tooling
export AWS_PAGER=""
export PROMPT_EOL_MARK=''

export GOPATH="$HOME/go"

# disable dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT="1"

# Nexus read only SA
export NEXUS_ALL_READ_USERNAME='nexus-all-read@moodagent.com'
export NEXUS_ALL_READ_PASSWORD='6[WgHCX?Xcg8P2#YV%S4MKBu)6h{s*E)'
export PIP_INDEX_URL_ARG="https://${NEXUS_ALL_READ_USERNAME}:6%5BWgHCX%3FXcg8P2%23YV%25S4MKBu%296h%7Bs%2AE%29@nexus.moodagent.io/repository/pypi-all/simple"

#export MONGODB_ATLAS_PUBLIC_KEY=vsulzmue                           
#export MONGODB_ATLAS_PRIVATE_KEY=8890dfb8-9a45-46d0-ac56-25fe4437d35e


function get_token_staging() {
aws --profile alexandre.staging cognito-idp initiate-auth \
    --client-id 5bso574jksu0e257qagesh8ofd \
    --auth-flow USER_PASSWORD_AUTH \
    --auth-parameters USERNAME='alma@moodagent.com',PASSWORD='Mefaki$10' \
    --query 'AuthenticationResult.AccessToken' \
    --output text
}

function get_token_prod() {
aws --profile alexandre.prod cognito-idp initiate-auth \
    --client-id 640sihpk53hl4pm5kri73l3e1s \
    --auth-flow USER_PASSWORD_AUTH \
    --auth-parameters USERNAME='alma@moodagent.com',PASSWORD='Mefaki$10' \
    --query 'AuthenticationResult.AccessToken' \
    --output text
}


autoload -U compinit && compinit

fpath=($fpath ~/.zsh/completion)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias kctx="kubectx"
alias vim="nvim"

command -v flux >/dev/null && . <(flux completion zsh) && compdef _flux flux

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
