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

git初期化
```
rm -rf .git
```

git追加
```
git init
```

remote追加
```
git remote add origin {repository_url}
```

各コンテナにアクセスするポートやDBのパラメータを指定

※以下も同様の修正をする
- backend/.env.example
- docker/db/init/create_test_db.sql
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
