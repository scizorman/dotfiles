import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddc-vim@9.1.0/config";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments) {
    args.contextBuilder.patchGlobal({
      ui: "pum",
      autoCompleteEvents: [
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineEnter",
        "CmdlineChanged",
      ],
      sources: ["around", "file"],
      cmdlineSources: {
        ":": ["cmdline", "cmdline-history", "around"],
        "/": ["around", "line"],
      },
      sourceOptions: {
        _: {
          converters: ["converter_remove_overlap"],
          ignoreCase: true,
          matchers: ["matcher_head", "matcher_prefix", "matcher_length"],
          sorters: ["sorter_rank"],
          timeout: 1000,
        },
        around: {
          mark: "A",
        },
        line: {
          mark: "L",
        },
        lsp: {
          mark: "LSP",
          forceCompletionPattern: ".w*|:w*|->w*",
        },
        cmdline: {
          forceCompletionPattern: "\\S/\\S*|\\.\\w*",
          isVolatile: true,
          mark: "cmdline",
          matchers: ["matcher_length"],
        },
        "cmdline-history": {
          mark: "history",
          sorters: [],
        },
        rg: {
          mark: "rg",
          minAutoCompleteLength: 5,
          enabledIf: `finddir(".git", ";") != ""`,
        },
      },
      postFilters: ["sorter_head"],
    });

    for (
      const filetype of [
        "markdown",
        "markdown_inline",
        "gitcommit",
        "comment",
      ]
    ) {
      args.contextBuilder.patchFiletype(filetype, {
        sources: ["around", "file", "line"],
      });
    }
    for (
      const filetype of [
        "go",
        "python",
        "typescript",
        "typescriptreact",
        "terraform",
      ]
    ) {
      args.contextBuilder.patchFiletype(filetype, {
        sources: ["lsp", "around", "file"],
      });
    }
  }
}
