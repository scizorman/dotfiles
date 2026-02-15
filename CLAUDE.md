# CLAUDE.md

Nix flake で複数環境の dotfiles を管理するリポジトリ。

## アーキテクチャ

### ディレクトリ構成

```
flake.nix
hosts/
  powder/default.nix
  groomed/default.nix
modules/
  home/
    default.nix         # imports のみ
    shell/              # zsh, starship, fzf, zoxide, bat, eza, fd, ripgrep 等
      default.nix
    git.nix
    ssh.nix
    neovim/             # config/ を持つのでディレクトリ
      default.nix
      config/
    mise/
      default.nix
      config/
    coding-agent/
      default.nix
      config/
        AGENTS.md       # 全 agent 共通のグローバル指示
        skills/         # Claude + Codex 共有
        claude/
        codex/
        copilot/
        gemini/
  profiles/
    wsl.nix
    darwin.nix
overlays/
```

### 部品と組み立ての分離

`modules/` は再利用可能な部品、`hosts/` は部品を組み合わせる場所。NixOS の `nixos/modules/` に倣った構造。

`flake.nix` はホストを列挙するだけでロジックを持たない。各ホストの `default.nix` が唯一のエントリポイントで、`home.nix` のような分割はしない。

### 差分の2軸

環境差分は2つの独立した軸で発生する。

- **OS 軸**（NixOS / Ubuntu / darwin）— システム管理手段の違い
- **runtime 軸**（WSL / native）— ホスト OS との統合レイヤーの有無

WSL 固有の設定（clipboard、credential helper、IdentityAgent、BROWSER 等）は OS を問わず共通。この2軸は直交しており、混ぜない。

### modules/home/ — 全環境共通のユーザー環境設定

`default.nix` を import すると OS・runtime 非依存な共通設定が全部入る。環境固有のファイルはここに置かない。

外部コマンドに依存する場合は環境非依存なインターフェースを前提とする（例: `pbcopy` / `pbpaste`）。その実体が何であるかは知らない。

### modules/profiles/ — 環境固有の追加設定

NixOS の `nixos/modules/profiles/`（`qemu-guest.nix` 等）に倣い、特定の実行環境に合わせた設定プリセットを配置する。ホスト側が明示的に選んで import する。

profiles の仕事は「home/ が前提とするインターフェースの実体を提供する」「既存設定に環境固有の値を追加する」「環境固有パッケージを追加する」の3つ。Home Manager の module system によるマージに乗る形で注入する。

### home/ と profiles/ の境界

「何を入れるか」が home/ の責務、「何に繋ぐか」が profiles/ の責務。ツールのインストールと基本設定は home/、シークレットストアやエージェントとの接続設定は profiles/。

### システム設定の扱い

NixOS・darwin のシステム設定はホストに直接書く。共通モジュール化は同じ OS のマシンが複数台になって初めて検討する。必要になった時点で `modules/nixos/` や `modules/darwin/` を追加する。

## 設計判断

### 命名は Nix の慣習に従う

`modules/`、`profiles/` は NixOS 自身のディレクトリ構造に由来する。実装詳細に依存する名前（`homeModules`、`nixosModules`）や独自概念（`platform`、`system`、`common`）は避ける。

### ファイル分割の基準

単一ツールの設定ならツール名（`git.nix`、`ssh.nix`）、複数ツールの束なら関心事の名前（`shell/`、`coding-agent/`）。`default.nix` には imports のみを書き、設定は混ぜない。

`mkOutOfStoreSymlink` で管理する設定ファイルを持つツールはディレクトリにする（`neovim/`、`mise/`、`coding-agent/`）。Nix 生成のみのツールはファイルのまま（`git.nix`、`ssh.nix`）。ツールに関する Nix 設定と設定ファイルの実体が一箇所にまとまる。Nix の `import` はディレクトリなら `default.nix` を読むため、`imports` の書き方は統一的になる。

### ファイル管理の2方式

**Nix 生成** — Home Manager の `programs.*` で宣言的に書ける安定した設定。`.nix` で管理し `home-manager switch` で反映。

**mkOutOfStoreSymlink** — 複雑な構造を持つか、頻繁に手で編集するか、Nix 外のツールチェインと連携する設定（Neovim の Lua 設定、mise config、coding agent 設定等）。ツールディレクトリ内の `config/` に実体を置き、リポジトリのファイルに直接 symlink する。編集が即座に反映される。

### 過度な抽象化を避ける

ホストの種類はせいぜい3〜5個。DI 的な provider パターンやモジュールのオプション化は、実際に重複や変更コストが痛くなってから導入する。profiles 間の小さな重複は許容する。
