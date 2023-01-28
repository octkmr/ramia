#!/bin/sh

set -eux
# shellcheck disable=SC2086
# shellcheck disable=SC2046
cd $(dirname $(cd $(dirname $0); pwd))

echo ""
echo "initialize_app start"
echo ""

# Docker環境構築
docker compose down --rmi all --volumes --remove-orphans
docker compose build --no-cache
docker compose up -d

#バックエンド
## ライブラリインストール
sh ./scripts/php.sh composer install
## env設定
if [ ! -d ./backend/.env ]; then
  cp ./backend/.env.example ./backend/.env;
fi
## 初期設定
sh ./scripts/php.sh artisan app:initialize

# フロントエンド
## ライブラリインストール
docker compose run yarn yarn

echo ""
echo "initialize_app end"
echo ""