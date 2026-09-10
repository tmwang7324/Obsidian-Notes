A `.zshrc` file is a hidden configuration script used by the Z shell (Zsh). It runs every time I open a new terminal window or tab in macOS or Linux. It allows me to sutomize my command line by setting up shortcuts (aliases), defining environment variables (**very important**), and personalizing themes.

# Why We Need `~/.zshrc`?
1. Customizing the Terminal Experience
	* Set **aliases** for frequently used commands. 
	* Configure **prompt appearance.**
	* Enable **syntax highlighting and auto-suggestions.**
2. Managing Envrionment Variables
	* Set up **PATH** variables for tools like Node.js, Python, and Java.
	* Configure API keys or other development-related variables.
3. Enhancing Productivity
	* Enable **autocompletion** for tools like Git and Docker.
	* Load **custom scripts** automatically.
	* Integrate **powerful plugins** like `zsh-autosuggestions` and `oh-my-zsh`

# Where is it located
The file is located in my computer's user directory (home folder). In bash, this location is `~/.zshrc.`


# Common Practices
## Alisases
Aliases allow me to create shortcuts for commands. For example:
```bash
# shorten 'ls' command with colors
alias ls='ls -G'
# Quickly navigate to projects folder
alias projects='cd ~/Developer/Projects'

# Start a local server instantly
alias serve='python3 -m http.server 8000'
```

## Loading Software onto Terminal
To add Node.js with **NVM (Node Version Manager)**, add this to `~/.zshrc`:
```bash
export NVM_DIR='$HOME/.nvm'
[ -s '$NVM_DIR/nvm.sh' ] && \. '$NVM_DIR/nvm.sh'
[ -s  '$NVM_DIR/bash_completion' ] && \. '$NVM_DIR/bash_completion'
```
This ensures that `nvm` installed in `$HOME` is loaded everytime I open a terminal.

## Updating the PATH for Custom Tools
If I have tools installed in a custom location such as Python3 and Node.js, I can add them to my **PATH:**
```bash
export PATH='$HOME/.local/bin:$PATH'
```

## Enable Git Auto-Completion + Plugins
This helps with Git command suggestions while typing.
```bash
autoload -Uz compinit && compinit
```
