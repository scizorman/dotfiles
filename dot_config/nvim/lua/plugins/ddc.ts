import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddc-vim@9.4.0/config";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "pum",
      autoCompleteEvents: [
        "CmdlineEnter",
        "CmdlineChanged",
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "TextChangedT",
      ],
      sources: ["around", "file"],
      cmdlineSources: {
        ":": ["cmdline", "cmdline_history", "around"],
        "/": ["around", "line"],
        "?": ["around", "line"],
        "@": ["input", "cmdline_history", "file", "around"],
      },
      sourceOptions: {
        _: {
          matchers: ["matcher_head"],
          sorters: ["sorter_rank"],
          converters: ["converter_remove_overlap"],
          ignoreCase: true,
        },
        around: {
          mark: "Around",
        },
        line: {
          mark: "Line",
        },
        lsp: {
          mark: "LSP",
          forceCompletionPattern: String.raw`\.\w*|::\w*|->\w`,
        },
        cmdline: {
          mark: "Command",
        },
        cmdline_history: {
          mark: "History",
        },
        shell: {
          mark: "Shell",
          isVolatile: true,
          forceCompletionPattern: String.raw`\S/\S*`,
          minAutoCompleteLength: 3,
        },
        shell_history: {
          mark: "History",
          sorters: [],
        },
        shell_native: {
          mark: "Shell",
          forceCompletionPattern: String.raw`\S/\S*`,
          minAutoCompleteLength: 3,
        },
      },
      sourceParams: {
        shell_history: {
          paths: [
            "~/.cache/nvim/ddt/ddt-shell-history",
            "~/.cache/zsh/.zsh_history",
          ],
        },
        shell_native: {
          shell: "zsh",
        },
        lsp: {
          confirmBehavior: "replace",
          enableAdditionalTextEdit: true,
          enableMatchLabel: true,
          enableResolveItem: true,
        },
      },
    });

    for (
      const filetype of [
        "go",
        "lua",
        "terraform",
        "typescript",
        "typescriptreact",
        "yaml",
      ]
    ) {
      args.contextBuilder.patchFiletype(filetype, {
        sources: ["lsp", "around", "file"],
      });
    }
  }
}
