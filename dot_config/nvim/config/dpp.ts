import type { Denops } from "jsr:@denops/std@7.4.0";
import type {
  LazyMakeStateArgs,
  LazyMakeStateResult,
} from "jsr:@shougo/dpp-ext-lazy@1.5.0";
import type { LoadArgs, Toml } from "jsr:@shougo/dpp-ext-toml@1.3.0";
import {
  BaseConfig,
  type ConfigArguments,
  type ConfigReturn,
} from "jsr:@shougo/dpp-vim@4.1.0/config";
import type { Dpp } from "jsr:@shougo/dpp-vim@4.1.0/dpp";
import type { Context, DppOptions } from "jsr:@shougo/dpp-vim@4.1.0/types";

const loadToml = async (
  dpp: Dpp,
  denops: Denops,
  context: Context,
  options: DppOptions,
  loadArgs: LoadArgs,
): Promise<Toml> =>
  (await dpp.extAction(
    denops,
    context,
    options,
    "toml",
    "load",
    loadArgs,
  )) as Toml;

export class Config extends BaseConfig {
  private readonly nvimConfigDir = `${Deno.env.get("XDG_CONFIG_HOME")}/nvim`;

  override async config(args: ConfigArguments): Promise<ConfigReturn> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);
    const tomls = await Promise.all(
      (
        [
          {
            path: `${this.nvimConfigDir}/config/dpp.toml`,
            options: {
              lazy: false,
            },
          },
          {
            path: `${this.nvimConfigDir}/config/lazy.toml`,
            options: {
              lazy: true,
            },
          },
          {
            path: `${this.nvimConfigDir}/config/denops.toml`,
            options: {
              lazy: true,
            },
          },
          {
            path: `${this.nvimConfigDir}/config/ddc.toml`,
            options: {
              lazy: true,
            },
          },
          {
            path: `${this.nvimConfigDir}/config/ddu.toml`,
            options: {
              lazy: true,
            },
          },
        ] as LoadArgs[]
      ).map((loadArgs) =>
        loadToml(args.dpp, args.denops, context, options, loadArgs)
      ),
    );
    const plugins = tomls.flatMap((toml) =>
      toml.plugins === undefined ? [] : toml.plugins
    );

    const lazyMakeStateResult = (await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: plugins,
      } as LazyMakeStateArgs,
    )) as LazyMakeStateResult;

    return {
      plugins: lazyMakeStateResult.plugins,
      stateLines: lazyMakeStateResult.stateLines,
    };
  }
}
