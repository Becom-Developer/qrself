# NAME

qrself/controller/card - QRSelf (自己紹介カード)

# SYNOPSIS

## URL

- GET - `/card` - index 自己紹介カードの一覧
- GET - `/card/:id/qr` - qr 自己紹介ページのQRコード表示
- GET - `/card/:id` - show 自己紹介ページ
- GET - `/card/create` - create 自己紹介ページ新規作成画面
- GET - `/card/:id/edit` - edit 自己紹介ページ編集画面
- POST - `/card` - store 自己紹介ページ新規登録
- POST - `/card/:id/update` - update 自己紹介ページ編集実行
- POST - `/card/:id/remove` - remove 自己紹介ページ削除

# DESCRIPTION

## 共通事項

```
ログイン中のみアクセス可能
show 自己紹介ページのみ認証なしでもアクセス
```

# - GET - `/card` - index 自己紹介カードの一覧

```
登録済み紹介カードリスト
リンク: 追加, 詳細
```

# - GET - `/card/:id/qr` - qr 自己紹介ページのQRコード表示

```
```

# - GET - `/card/:id` - show 自己紹介ページ

```
```

# - GET - `/card/create` - create 自己紹介ページ新規作成画面

```
```

# - GET - `/card/:id/edit` - edit 自己紹介ページ編集画面

```
```

# - POST - `/card` - store 自己紹介ページ新規登録

```
```

# - POST - `/card/:id/update` - update 自己紹介ページ編集実行

```
```

# - POST - `/card/:id/remove` - remove 自己紹介ページ削除

```
```


# TODO

```
- GET - `/example/create` - create
- GET - `/example/search` - search
- GET - `/example` - index
- GET - `/example/:id/edit` - edit
- GET - `/example/:id` - show
- POST - `/example` - store
- POST - `/example/:id/update` - update
- POST - `/example/:id/remove` - remove
```

# SEE ALSO

- `lib/QRSelf/Controller/Card.pm` -
- `lib/QRSelf/Model/Card.pm` -
- `templates/card/` -
- `t/qrself/controller/card.t` -
