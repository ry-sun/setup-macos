{ args, ... }:
let
  brewDir = "/opt/homebrew";
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      # Homebrew init
      eval "$(${brewDir}/bin/brew shellenv)"

      # >>> mamba initialize >>>
      # !! Contents within this block are managed by 'mamba shell init' !!
      export MAMBA_EXE='${brewDir}/bin/mamba';
      export MAMBA_ROOT_PREFIX='${args.home}/.local/share/mamba';
      __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__mamba_setup"
      else
          alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
      fi
      unset __mamba_setup
      # <<< mamba initialize <<<

      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      __conda_setup="$('${brewDir}/Caskroom/miniforge/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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
      [ -s "${brewDir}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${brewDir}/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    '';
  };

}
