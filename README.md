# 09-backend

# README

## 環境構築

* リポジトリをcloneする

### docker setup

* .env.localからDB関係の記述を削除する（空白文字が読み込まれてしまうため）
* dockerのビルド、DB作成を行い、コンテナを起動する

```bash
make build
make db-create
make migrate
make seed
```

## API Endpoints

```
http://localhost:4001
```

## command

- Makefile 参照

| コマンド            | 機能                           |
| ------------------ | ------------------------------ |
| make up            | docker起動           |
| make down          | docker停止          |
| make build         |                    |
| make db-create          | db作成 |
| make migrate | migrationを実行       |
| make seed  | seedデータの注入        |
| make migrate-reset   | dbの再生成とmigrationの実行       |
| make console   | railsのコンソール起動       |
| make routes   | ルーティングの確認       |
