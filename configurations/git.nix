{ pkgs, args, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    diff-so-fancy.enable = true;
    lfs.enable = true;
    userName = args.fullName;
    userEmail = args.email;
    extraConfig = {
      core = {
        compression = "-1";
        eol = "lf";
        autocrlf = "false";
        editor = "nvim";
        excludesfile = "${args.home}/.config/git/.gitignore_global";
      };
      init = {
        defaultBranch = "main";
      };
      diff = {
        tool = "nvimdiff";
        guitool = "cursor";
      };
      difftool = {
        prompt = false;
        nvimdiff = {
          cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
        cursor = {
          cmd = "cursor --wait --diff \"$LOCAL\" \"$REMOTE\"";
        };
      };
      merge = {
        tool = "nvimdiff";
        guitool = "cursor";
      };
      mergetool = {
        prompt = false;
        nvimdiff = {
          cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$MERGED\"";
        };
        cursor = {
          cmd = "cursor --wait --merge \"$LOCAL\" \"$REMOTE\" \"$MERGED\"";
        };
      };
      pull = {
        ff = "only";
      };
      fetch = {
        prune = true;
        parallel = 0;
      };
      submodule = {
        recurse = true;
        fetchJobs = 0;
      };
      color = {
        ui = true;
        diff = {
          meta = "yellow";
          frag = "magenta bold";
          func = "146 bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
        diff-highlight = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };
      };
      gitflow = {
        branch = {
          master = "main";
          develop = "dev";
        };
      };
      alias = {
        list-ignored = "! cd -- \"\${GIT_PREFIX:-.}\" && git ls-files -v \"\${1:-.}\" | sed -n -e \"s,^[a-z] \\\\(.*\\\\)\\$,\${GIT_PREFIX:-./}\\\\1,p\" && git status --ignored --porcelain \"\${1:-.}\" 2>/dev/null | sed -n -e \"s/^\\\\(\\\\!\\\\! \\\\)\\\\(.*\\\\)$/\\\\2/p\";";
        config-push-remote = "! cd -- \"\${GIT_PREFIX:-.}\" && GIT_BRANCH=\"\${1:-\"$(git branch --show-current)\"}\" && git config branch.\"\${GIT_BRANCH}\".remote upstream; git config branch.\"\${GIT_BRANCH}\".pushremote origin;";
        sync-remote = "! cd -- \"\${GIT_PREFIX:-.}\"; git status --porcelain && (GIT_CURRENT_BRANCH=\"$(git branch --show-current)\"; GIT_BRANCH=\"\${1:-\"\${GIT_CURRENT_BRANCH}\"}\"; GIT_REMOTE=\"$(git remote show | grep -E \"^upstream$\" || echo \"origin\")\"; [ \"\${GIT_CURRENT_BRANCH}\" != \"\${GIT_BRANCH}\" ] && gut checkout \"\${GIT_BRANCH}\"; git fetch --all --tags --prune --force --jobs=16; git pull --ff-only \"\${GIT_REMOTE}\" \"\${GIT_BRANCH}\"; [ \"\${GIT_REMOTE}\" != \"origin\" ] && git push origin \"\${GIT_BRANCH}:\${GIT_BRANCH}\"; [ \"\${GIT_CURRENT_BRANCH}\" != \"\${GIT_BRANCH}\" ] && gut checkout \"\${GIT_CURRENT_BRANCH}\")";
        build = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"build\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        chore = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"chore\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        ci = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"ci\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        docs = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"docs\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        feat = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"feat\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        fix = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"fix\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        perf = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"perf\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        refactor = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"refactor\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        rev = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"revert\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        style = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"style\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        test = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"test\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
        wip = "!a() {\nlocal _scope _attention _message\nwhile [ $# -ne 0 ]; do\ncase $1 in\n  -s | --scope )\n    if [ -z $2 ]; then\n      echo \"Missing scope!\"\n      return 1\n    fi\n    _scope=\"$2\"\n    shift 2\n    ;;\n  -a | --attention )\n    _attention=\"!\"\n    shift 1\n    ;;\n  * )\n    _message=\"\${_message} $1\"\n    shift 1\n    ;;\nesac\ndone\ngit commit -m \"wip\${_scope:+(\${_scope})}\${_attention}:\${_message}\"\n}; a";
      };
    };
  };

  home.file.".config/git/.gitignore_global".source = ../dotfiles/.gitignore_global;
  home.shellAliases = {
    glg1 = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
    glg2 = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
    glg = "glg2";
  };
}
