{ pkgs, ... }:
let
  common = import ./common.nix;
in
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      editorconfig.editorconfig
      dbaeumer.vscode-eslint
      waderyan.gitblame
      bierner.markdown-mermaid
      pkief.material-icon-theme
      christian-kohler.path-intellisense
      johnpapa.vscode-peacock
      esbenp.prettier-vscode
      bradlc.vscode-tailwindcss
      jnoortheen.nix-ide
    ];
    userSettings = {
      "window.menuBarVisibility" = "toggle";

      "workbench.iconTheme" = "material-icon-theme";

      "explorer.confirmDragAndDrop" = false;
      "explorer.confirmDelete" = false;

      "editor.renderControlCharacters" = true;
      "editor.renderWhitespace" = "all";
      "editor.renderFinalNewline" = "on";
      "editor.tabSize" = 4;
      "editor.cursorStyle" = "line";
      "editor.insertSpaces" = false;
      "editor.lineNumbers" = "on";
      "editor.wordSeparators" = "/\\()\"':,.;<>~!@#$%^&*|+=[]{}`?-";
      "editor.wordWrap" = "on";
      "editor.suggestSelection" = "first";
      "editor.fontFamily" = common.font;
      "editor.fontSize" = 16;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";
      "editor.quickSuggestions" = {
        strings = "on";
      };
      "editor.codeActionsOnSave" = {
        ".source.organizeImports" = true;
      };

      "terminal.integrated.fontFamily" = common.font;

      "files.exclude" = {
        "**/.classpath" = true;
        "**/.project" = true;
        "**/.settings" = true;
        "**/.factorypath" = true;
        "**/__pycache__" = true;
      };

      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = [ "<C-p>" ];
          "commands" = [ "workbench.action.quickOpen" ];
        }
        {
          "before" = [ "<C-b>" ];
          "commands" = [
            "workbench.view.explorer"
            "workbench.action.toggleSidebarVisibility"
          ];
        }
      ];

      "[html]" = {
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[python]" = {
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;
        "editor.formatOnType" = true;
      };
      "[yaml]" = {
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
        "editor.autoIndent" = "advanced";
      };
      "[json]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[java]" = {
        "editor.defaultFormatter" = "redhat.java";
      };
      "[markdown]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[css]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };


      "git.autofetch" = true;
      "json.schemaDownload.enable" = true;
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "typescript.updateImportsOnFileMove.enabled" = "always";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.formatterPath" = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
    };

    keybindings = [
      {
        key = "ctrl+tab";
        command = "workbench.action.nextEditor";
      }
      {
        key = "ctrl+shift+tab";
        command = "workbench.action.previousEditor";
      }
      {
        key = "alt+left";
        command = "workbench.action.navigateBack";
      }
      {
        key = "alt+right";
        command = "workbench.action.navigateForward";
      }
      {
        key = "ctrl+f";
        command = "editor.action.formatDocument";
        when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
    ];
  };
}

