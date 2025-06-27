setopt PROMPT_SUBST
autoload -U colors && colors

# Bindkeys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

OS=$(uname)
VPN=$(ip -4 a sh dev utun6 2>/dev/null | grep inet | awk '{print $2}')
# export CLICOLOR=1
# export LSCOLORS=GxBxCxDxexegedabagaced

# Functions
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Exports

# Keg-only brew exports
export PATH="/usr/local/opt/whois/bin:$PATH"

if [[ $OS == "Linux" ]]; then
    export USER=kali
fi

# Aliases
alias ll='ls -alF'
alias spiderfoot="python ~/git_clones/spiderfoot/sf.py"
alias startvnc='tightvncserver :0 -geometry 1280x800 -depth 16 -pixelformat rgb565'
alias fix_gui="sudo rm -rf /tmp/.X11-unix/ && ln -s /mnt/wslg/.X11-unix /tmp/"
alias zaproxy="zaproxy >/dev/null 2&>1 &"
if [[ -f $(which glow) ]]; then
    alias cat='glow'
fi

if [[ $OS != "Linux" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

function prompt_func() {
    NEWLINE=$'\n'
    if [[ $OS != "Linux" ]]; then
        PS1="%B%F{green}┌──[%m🚀🌐$(ip -4 addr sh dev en0 | grep inet | awk '{print $2}' | cut -d '/' -f1 | tail -1)"
            if [[ $(ip -4 a sh | grep -A 2 "utun" | grep "inet " 2>/dev/null) ]]; then
                PS1+="%f%b%F{red}%B⚔️ Attacker:AppleTree📡 IP:$(ip -4 a sh | grep -A 2 tun | grep inet | awk '{print $2}' | cut -d '/' -f1 | tail -1)"
            fi
    else
        PS1="%B%F{green}┌──[%m🚀🌐$(ip -4 addr sh dev eth0 | grep inet | awk '{print $2}' | cut -d '/' -f1 | tail -1)"
            if [[ $(ip -4 a sh | grep -A 2 "tun" | grep inet ) ]]; then
                PS1+="%f%b%F{red}%B⚔️ Attacker:AppleTree📡 IP:$(ip -4 a sh | grep inet | awk '{print $2}' | cut -d '/' -f1 | tail -1)"
            fi
    fi
    PS1+="%f%b🔥%F{green}%B%n]$(parse_git_branch)${NEWLINE}"
    PS1+="└──╼[👾]%F{cyan}%~ %# %f%b"
    alias kali="docker run -u kali -w /home/kali -it --rm -e DISPLAY=docker.for.mac.localhost:0 -e VPN=$(ip -4 a sh dev utun6 2>/dev/null | grep inet | awk '{print $2}') -p 80:80 -p 443:443 -p 1337-1369:1337-1369 -p 11601:11601 -p 25900:5900 --security-opt seccomp=unconfined --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --name kali kali zsh"
    alias nessus="docker run --name 'nessus' -d -p 8834:8834 --rm nessus-live"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_func
#source /usr/local/opt/chruby/share/chruby/chruby.sh
#source /usr/local/opt/chruby/share/chruby/auto.sh
#chruby ruby-3.1.3 # run chruby to see actual version
export PATH="/usr/local/opt/binutils/bin:$PATH"

# Created by `pipx` on 2025-05-05 01:47:08
export PATH="$PATH:/Users/forrest/.local/bin"
