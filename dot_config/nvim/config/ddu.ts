import { win_execute } from "jsr:@denops/std@7.4.0/function";
import type { Params as FfParams } from "jsr:@shougo/ddu-ui-ff@1.6.0";
import type { Params as FileParams } from "jsr:@shougo/ddu-ui-filer@1.5.0";
import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddu-vim@9.4.0/config";
import {} from "jsr:@shougo/ddu-vim@9.4.0/types";

export class Config extends BaseConfig {
  override config(args: ConfigArguments): void | Promise<void> {
    args.setAlias("files", "source", "file_rg", "file_external");
    args.setAlias("files", "source", "file_git", "file_external");

    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiOptions: {
        filer: {
          toggle: true,
        },
      },
      uiParams: {
        ff: {
          autoAction: {
            name: "preview",
          },
          autoResize: true,
          displaySourceName: "long",
          floatingBorder: "rounded",
          highlights: {
            filterText: "Statement",
            floating: "Normal",
            floatingBorder: "Special",
          },
          onPreview: async ({ denops, previewWinId }) => {
            await win_execute(denops, previewWinId, "normal! zt");
          },
          previewFloating: true,
          previewFloatingBorder: "rounded",
          previewSplit: "horizontal",
          prompt: "> ",
          split: "floating",
          startAutoAction: true,
        } as FfParams,
        file: {
          autoAction: {
            name: "preview",
          },
          autoResize: true,
          previewCol: "right",
          previewFloating: true,
          previewFloatingBorder: "solid",
          sort: "filename",
          sortTreesFirst: true,
          split: "no",
        } as FileParams,
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: ["matcher_substring"],
          smartCase: true,
        },
        file: {
          converters: ["converter_hl_dir"],
          matchers: ["matcher_substring", "matcher_hidden"],
          sorters: ["sorter_alpha"],
        },
        file_rec: {
          converters: ["converter_hl_dir"],
          matchers: ["matcher_substring", "matcher_hidden"],
        },
        file_git: {
          converters: ["converter_hl_dir"],
          matchers: ["matcher_relative", "matcher_substring"],
          sorters: ["sorter_alpha"],
        },
        rg: {
          matchers: ["matcher_substring", "matcher_files"],
        },
      },
      sourceParams: {
        file_git: {
          cmd: [
            "git",
            "ls-files",
            "--cached",
            "--others",
            "--exclude-standard",
          ],
        },
        file_rg: {
          cmd: [
            "rg",
            "--glob='!.git",
            "--color=never",
            "--no-messages",
            "--files",
          ],
        },
        rg: {
          args: ["--smart-case", "--color=never", "--column", "--no-heading"],
        },
      },
      filterParams: {
        converter_hl_dir: {
          hlGroup: ["Directory", "Keyword"],
        },
        matcher_substring: {
          highlightMatched: "Search",
        },
      },
      kindOptions: {
        file: {
          defaultAction: "open",
        },
        word: {
          defaultAction: "append",
        },
        url: {
          defaultAction: "browse",
        },
      },
    });
  }
}
