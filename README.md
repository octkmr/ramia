Laravel + Next.jsのテンプレート

## 環境
- Laravel 9
- Next.js 13
- apache + php + mysql

## 初期設定
使用したいリポジトリ名でクローン
```
git clone git@github.com:octkmr/ramia.git {repository_name}
```
リポジトリに移動
```
cd {repository_name}
```
各コンテナにアクセスするポートやDBのパラメータを指定
```
vim .env
```
初期化処理
```
make initialize
```
起動
```
docker compose up
```
