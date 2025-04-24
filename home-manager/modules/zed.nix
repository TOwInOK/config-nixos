{
    programs.zed-editor = {
        enable = true;
        extensions = ["nix" "toml" "elixir" "make"];
        load_direnv = "shell_hook";

        hour_format = "hour24";
        auto_update = false;




        ## everything inside of these brackets are Zed options.
        userSettings = {
          edit_predictions = {
            disabled_globs = [
              ".env"
              "Cargo.lock"
              ".gitignore"
              "Cargo.toml"
              "target"
              "node_modules"
              "package-lock.json"
            ];
            mode = "eager";
          };
          always_treat_brackets_as_autoclosed = true;
          ui_font_size = 16.5;
          ui_font_family = "Zed Plex Mono";
          assistant = {
            default_model = {
              provider = "zed.dev";
              model = "claude-3-7-sonnet-latest";
            };
            default_open_ai_model = "gpt-3.5-turbo-0613";
            version = 2;
            button = true;
          };
          features = {
            edit_prediction_provider = "zed";
            copilot = false;
          };
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          vim_mode = false;
          base_keymap = "VSCode";
          theme = "Catppuccin Mocha";
          buffer_font_size = 15.479999542236328;
          cursor_blink = false;


          lsp = {
              rust-analyzer = {
                initialization_options = {
                  checkOnSave = {
                    # command = clippy && leptosfmt ./**/*.rs // rust-analyzer.checkOnSave.command
                    command = "clippy"; # rust-analyzer.checkOnSave.command
                  };
                };
                procMacro = {
                  ignored = [
                    # optional =
                    # component;
                    "server"
                  ];
                };
                  binary = {
                      #                        path = lib.getExe pkgs.rust-analyzer;
                      path_lookup = true;
                  };
              };
              nix = {
                  binary = {
                      path_lookup = true;
                  };
              };

              ruff = {
                initialization_options = {
                  settings = {
                    lineLength = 80;
                    lint = {
                      extendSelect = ["I"  "RUF"  "E"  "W"  "F"  "FAST"  "NPY"  "PL"];
                    };
                  };
                };
                binary = {
                    path_lookup = true;
                };
              };
              elixir-ls = {
                  binary = {
                      path_lookup = true;
                  };
                  settings = {
                      dialyzerEnabled = true;
                  };
              };
          };

          inlay_hints = {
            enabled = true;
            show_type_hints = true;
            show_parameter_hints = true;
            show_other_hints = true;
          };
          notification_panel = {
            button = false;
          };
          chat_panel = {
            button = "never";
          };
          collaboration_panel = {
            button = false;
          };
          terminal = {
              alternate_scroll = "off";
              blinking = "off";
              copy_on_select = false;
              dock = "bottom";
              detect_venv = {
                  on = {
                      directories = [".env" "env" ".venv" "venv"];
                      activate_script = "default";
                  };
              };
              env = {
                  TERM = "ghostty";
              };
              font_family = "FiraCode Nerd Font";
              font_features = null;
              font_size = null;
              line_height = "comfortable";
              option_as_meta = false;
              button = false;
              shell = "system";
              #{
              #                    program = "zsh";
              #};
              toolbar = {
                  title = true;
              };
              working_directory = "current_project_directory";
          };

          languages = {
            Rust = {
              show_edit_predictions = true;
            };
            Python = {
              language_servers = ["pyright" "ruff"];
              format_on_save = "on";
              formatter = [
                {
                  code_actions = {
                    source.organizeImports.ruff = true;
                    source.fixAll.ruff = true;
                  };
                }
                {
                  language_server = {
                    name = "ruff";
                  };
                }
              ];
            };
          };
          file_types = {
            "Tera (HTML)" = ["*.html.tera" "*.tera"];
            "Tera (CSS)" = ["*.css.tera"];
            "Tera (JSON)" = ["*.json.tera"];
            "Tera (YAML)" = ["*.yaml.tera"];
            "Tera (TOML)" = ["*.toml.tera"];
            HTML = ["*.rust" "*.html.tera"];
          };
        };
    };
}
