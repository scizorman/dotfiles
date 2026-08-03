import {
  BaseConfig,
  type ConfigArguments,
} from "jsr:@shougo/ddt-vim@2.0.0/config";

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    const cacheDirectory = await args.denops.call("stdpath", "cache") as string;

    args.contextBuilder.patchGlobal({
      nvimServer: `${cacheDirectory}/server.pipe`,
      uiParams: {
        shell: {
          noSaveHistoryCommands: ["exit"],
          shellHistoryPath: `${cacheDirectory}/ddt/ddt-shell-history`,
          split: "floating",
        },
        terminal: {
          command: ["zsh"],
          split: "horizontal",
          winHeight: 30,
        },
      },
    });
  }
}
