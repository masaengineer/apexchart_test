# Rails DaisyUI Template

Rails 7.1 + Hotwire + TailwindCSS + daisyUI を使用したモダンな Rails アプリケーションのテンプレートです。

## 特徴

- 🚀 Rails 7.1
- ⚡️ Hotwire (Turbo + Stimulus)
- 🎨 TailwindCSS
- 🎯 daisyUI
- 🐳 Docker 対応
- 🔄 ライブリロード
- 🌓 ダークモード対応

## 必要要件

- Ruby 3.3.6
- Node.js 20.11.1 以上
- PostgreSQL 14 以上
- Docker & Docker Compose（Docker を使用する場合）

## セットアップ

### Docker を使用する場合

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

- daisyUI の各種コンポーネント
  - ボタン
  - カード
  - アラート
  - フォーム要素
  - タブ
  - プログレスバー
    など

## 開発環境

- Hotwire Livereload による自動リロード
- TailwindCSS の自動コンパイル
- JavaScript のバンドル（esbuild）

## デプロイ

本テンプレートには本番環境用の Dockerfile が含まれています。以下の環境変数を設定してください：

- `RAILS_MASTER_KEY`
- `POSTGRES_HOST`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`

# master.key ファイルの存在確認

ls config/master.key

# credentials ファイルの存在確認

ls config/credentials.yml.enc

# ファイルの内容を確認

cat config/master.key
cat config/credentials.yml.enc
