{ ... }:
{
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      # Basic
      model = "gpt-5.4";
      model_reasoning_effort = "medium";
      personality = "pragmatic";
      check_for_update_on_startup = true;

      # Command Settings
      allow_login_shell = true;
      approval_policy = "on-request";
      web_search = "cached";

      # TUI Settings
      file_opener = "code";
      hide_agent_reasoning = false;
      history.persistence = "save-all";
      tui = {
        alternate_screen = "auto";
        animations = true;
        otification_method = "auto";
        notifications = true;
        show_tooltips = true;
        theme = "dracula";
        status_line = [
          "model-with-reasoning"
          "project-root"
          "git-branch"
          "context-usage"
          "five-hour-limit"
          "weekly-limit"
          "thread-title"
        ];
      };

      features = {
        # see https://developers.openai.com/codex/config-basic#supported-features
        app = true;
        codex_hooks = false;
        enable_request_compression = true;
        fast_mode = false;
        multi_agent = true;
        personality = true;
        prevent_idle_sleep = true;
        shell_snapshot = true;
        shell_tool = true;
        skill_mcp_dependency_install = true;
        smart_approvals = true;
        unified_exec = true;
        undo = true;
      };

      # Sub-Agents Settings
      agents = {
        max_depth = 1;
        max_threads = 6;
      };

      # Analytics
      analytics = {
        enable = true;
      };
    };
  };
}
