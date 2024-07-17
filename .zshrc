# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="agnoster"

# Uncomment the following lines to change specific behaviors.
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins to load.
plugins=(git node react-native npm)
source $ZSH/oh-my-zsh.sh

# Load zsh modules for colors and prompt manipulation.
autoload -U colors
colors

# Alias to get the current shell.
alias currentshell='ps -p $$ -o comm='

# Function to run pokemon-colorscripts with a 1/32 chance for a shiny.
run_pokemon_colorscripts() {
  local random_number=$((RANDOM % 32 + 1))
  if [[ $random_number -eq 1 ]]; then
    pokemon-colorscripts -r --no-title -s
    print -P "%F{116}%B[✨✨ %F{11}Congratulations! You found a shiny! %F{116}✨✨] (ツ)%f"
    echo ""
    echo ""
  else
    pokemon-colorscripts -r --no-title
  fi
}

# File to store poke status
POKE_STATUS_FILE="$HOME/.poke_status"

# Function to read poke status
read_poke_status() {
  if [[ -f "$POKE_STATUS_FILE" ]]; then
    POKE_ON=$(cat "$POKE_STATUS_FILE")
  else
    POKE_ON=true  # Default to true if file doesn't exist
  fi
}

# Help message for poke commands
poke-help() {
  echo "poke-on   : Turns on the Pokemon colorscripts."
  echo "poke-off  : Turns off the Pokemon colorscripts."
  echo "poke-status : Displays the current status of the Pokemon colorscripts."
  echo "poke-clear : Clears terminal and displays a pokemon (if on)."
}

# Function to save poke status
save_poke_status() {
  echo "$POKE_ON" > "$POKE_STATUS_FILE"
}

# Initialize poke status
read_poke_status

# Functions to turn pokemon-colorscripts on or off.
poke-on() {
  POKE_ON=true
  save_poke_status
  echo "Pokemon colorscripts are ON"
}

# Clears terminal and runs the pokemon 
poke-clear() {
  clear
  if [[ $POKE_ON == true ]]; then
    run_pokemon_colorscripts
  fi
}

poke-off() {
  POKE_ON=false
  save_poke_status
  echo "Pokemon colorscripts are OFF"
}

# Function to display poke status
poke-status() {
  if [[ $POKE_ON == true ]]; then
    echo "Pokemon colorscripts are ON"
  else
    echo "Pokemon colorscripts are OFF"
  fi
}

# Add the function to run at the start of each new session if POKE_ON is true.
if [[ $POKE_ON == true ]]; then
  run_pokemon_colorscripts
fi

# Custom prompt setup with better colors.
# 10=green
PROMPT='%B%F{216}%n@%m%f%b:%B%F{cyan}%~%f%b| '

# Set a better font (ensure you have installed Powerline fonts).
POWERLINE_FONT="MesloLGS NF"
if [[ -z "$ITERM_SESSION_ID" ]]; then
  export TERM="xterm-256color"
fi

# Add any other custom configurations below.
