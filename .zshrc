setopt PROMPT_SUBST
autoload -U colors && colors
# export CLICOLOR=1
# export LSCOLORS=GxBxCxDxexegedabagaced

# Functions
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Exports
export PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}:/usr/local/sbin:/opt/local/bin:/opt/local/sbin"

# Aliases
alias ll='ls -alF'
alias spiderfoot="python ~/git_clones/spiderfoot/sf.py"
alias kali='docker run -u kali -w /home/kali -it --rm -e DISPLAY=docker.for.mac.localhost:0 -p 1337:1337 -p 7777:7777 -p 5900:5900 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --name kali kali'
# --mount src=/Users/forrest/.Linux_Files/docker_files/kali/kali-root,dst=/root --mount src=/Users/forrest/.Linux_Files/docker_files/kali/kali-postgres,dst=/var/lib/postgresql

OS=$(uname)
if [[ $OS != "Linux" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

function prompt_func() {
    NEWLINE=$'\n'
    if [[ $OS != "Linux" ]]; then
        PS1="%B%F{green}┌──[HQ🚀🌐$(ip -4 addr sh dev en0 | grep inet | awk '{print $2}' | cut -d '/' -f1)"
            if [[ $(ip a sh dev utun6 2>/dev/null) ]]; then
                PS1+="%f%b%F{red}%B⚔️ Attacker:AppleTree📡 IP:$(ip -4 a sh dev utun6 2>/dev/null | grep inet | awk '{print $2}')"
            fi
    else
        PS1="%B%F{green}┌──[HQ🚀🌐$(ip -4 addr sh dev eth0 | grep inet | awk '{print $2}' | cut -d '/' -f1)"
            if [[ $(ip a sh dev utun6 2>/dev/null) ]]; then
                PS1+="%f%b%F{red}%B⚔️ Attacker:AppleTree📡 IP:$(ip -4 a sh dev utun6 2>/dev/null | grep inet | awk '{print $2}')"
            fi
    fi
    PS1+="%f%b🔥%F{green}%B%n]$(parse_git_branch)${NEWLINE}"
    PS1+="└──╼[👾]%F{cyan}%~ %# %f%b"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_func
