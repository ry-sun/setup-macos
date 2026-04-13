{
  lib,
  args,
  ...
}:
let
  brewDir = "/opt/homebrew";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;

    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-completions"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "MichaelAquilina/zsh-you-should-use"
        "fdellwing/zsh-bat"
        "conda-incubator/conda-zsh-completion"
      ];
    };
    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.ohmyzsh";
      plugins = [
        "brew"
        "bun"
        "colored-man-pages"
        "command-not-found"
        "conda"
        "copybuffer"
        "copyfile"
        "copyfile"
        "dirhistory"
        "docker-compose"
        "docker"
        "dotenv"
        "extract"
        "fzf"
        "gh"
        "git-auto-fetch"
        "git-commit"
        "git-extras"
        "git-flow"
        "git-lfs"
        "git"
        "gitignore"
        "history"
        "iterm2"
        "macos"
        "npm"
        "nvm"
        "pip"
        "pre-commit"
        "python"
        "rsync"
        "rust"
        "ssh"
        "swiftpm"
        "tmux"
        "uv"
        "vscode"
        "xcode"
        "yarn"
      ];
    };
    envExtra = ''
      # Homebrew init
      eval "$(${brewDir}/bin/brew shellenv)"

      # >>> mamba initialize >>>
      # !! Contents within this block are managed by 'mamba shell init' !!
      export MAMBA_EXE='${brewDir}/bin/mamba';
      export MAMBA_ROOT_PREFIX='${args.home}/.local/share/mamba';
      __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__mamba_setup"
      else
          alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
      fi
      unset __mamba_setup
      # <<< mamba initialize <<<

      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      __conda_setup="$('${brewDir}/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__conda_setup"
      else
          if [ -f "${brewDir}/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
              . "${brewDir}/Caskroom/miniforge/base/etc/profile.d/conda.sh"
          else
              export PATH="${brewDir}/Caskroom/miniforge/base/bin:$PATH"
          fi
      fi
      unset __conda_setup
      # <<< conda initialize <<<

      # Node
      [ -s "${brewDir}/opt/nvm/nvm.sh" ] && \. "${brewDir}/opt/nvm/nvm.sh"  # This loads nvm
    '';
    initContent = lib.mkOrder 1000 ''
      # iTerm2
      [ -f "$HOME/.iterm2_shell_integration.zsh" ] && source "$HOME/.iterm2_shell_integration.zsh"

      # Node
      [ -s "${brewDir}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${brewDir}/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    '';
  };
}
