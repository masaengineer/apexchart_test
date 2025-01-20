# Rails DaisyUI Template

Rails 7.1 + Hotwire + TailwindCSS + daisyUI を使用したモダンなRailsアプリケーションのテンプレートです。

## 特徴

- 🚀 Rails 7.1
- ⚡️ Hotwire (Turbo + Stimulus)
- 🎨 TailwindCSS
- 🎯 daisyUI
- 🐳 Docker対応
- 🔄 ライブリロード
- 🌓 ダークモード対応

## 必要要件

- Ruby 3.3.6
- Node.js 20.11.1以上
- PostgreSQL 14以上
- Docker & Docker Compose（Dockerを使用する場合）

## セットアップ

### Dockerを使用する場合

```bash
# リポジトリのクローン
git clone [repository-url]
cd rails-daisyui-template

# Dockerイメージのビルドと起動
docker compose build
docker compose up

# データベースの作成
docker compose exec web bin/rails db:create
```

### ローカルで実行する場合

```bash
# 依存関係のインストール
bundle install
npm install

# データベースの作成と初期化
bin/rails db:create
bin/rails db:migrate

# 開発サーバーの起動
bin/dev
```

## 主な機能

### レイアウト
- レスポンシブなサイドバーナビゲーション
- ダークモード切り替え
- モバイル対応のドロワーメニュー

### コンポーネント
- daisyUIの各種コンポーネント
  - ボタン
  - カード
  - アラート
  - フォーム要素
  - タブ
  - プログレスバー
  など

## 開発環境

- Hotwire Livereloadによる自動リロード
- TailwindCSSの自動コンパイル
- JavaScriptのバンドル（esbuild）

## デプロイ

本テンプレートには本番環境用のDockerfileが含まれています。以下の環境変数を設定してください：

- `RAILS_MASTER_KEY`
- `POSTGRES_HOST`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
