{
  pkgs,
  lib,
  args,
  ...
}:
let
  brewDir = if args.arch == "aarch64" then "/opt/homebrew" else "/usr/local";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.custom = "$HOME/.zsh";
    oh-my-zsh.plugins = [
      "macos"
      "zsh-completions"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
      "you-should-use"
      "zsh-bat"
      "conda-zsh-completion"
      "web-search"
      "colorize"
      "colored-man-pages"
      "fzf"
      "copyfile"
      "copypath"
      "copybuffer"
      "dirhistory"
      "cp"
      "rsync"
      "git"
      "git-auto-fetch"
      "git-commit"
      "git-extras"
      "git-lfs"
      "gitignore"
      "python"
      "pip"
      "pylint"
      "docker"
      "docker-compose"
      "swiftpm"
      "npm"
      "nvm"
      "tmux"
      "brew"
      "vscode"
    ];
    plugins = [
      {
        name = "zsh-completions";
        src = builtins.fetchGit {
          url = "https://github.com/zsh-users/zsh-completions.git";
          ref = "master";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = builtins.fetchGit {
          url = "https://github.com/zsh-users/zsh-autosuggestions.git";
          ref = "master";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = builtins.fetchGit {
          url = "https://github.com/zsh-users/zsh-syntax-highlighting.git";
          ref = "master";
        };
      }
      {
        name = "you-should-use";
        src = builtins.fetchGit {
          url = "https://github.com/MichaelAquilina/zsh-you-should-use.git";
          ref = "master";
        };
      }
      {
        name = "zsh-bat";
        src = builtins.fetchGit {
          url = "https://github.com/fdellwing/zsh-bat.git";
          ref = "master";
        };
      }
      {
        name = "conda-zsh-completion";
        src = builtins.fetchGit {
          url = "https://github.com/conda-incubator/conda-zsh-completion.git";
          ref = "main";
        };
      }
    ];
    envExtra = ''
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
