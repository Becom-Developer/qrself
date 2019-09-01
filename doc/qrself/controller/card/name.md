# NAME

qrself/controller/card/name - QRSelf (自己紹介カード、名前情報)

# SYNOPSIS

## URL

- GET - `/card/name/:id` - show カード項目詳細
- GET - `/card/name/create` - create カード項目新規作成画面
- GET - `/card/name/:id/edit` - edit カード項目編集画面
- POST - `/card/name` - store カード項目新規登録
- POST - `/card/name/:id/update` - update カード項目編集実行
- POST - `/card/name/:id/remove` - remove カード項目削除

# DESCRIPTION

## 共通事項

```
ログイン中のみアクセス可能
```

# - GET - `/card/name/:id` - show カード項目詳細

```
```

# - GET - `/card/name/create` - create カード項目新規作成画面

```
```

# - GET - `/card/name/:id/edit` - edit カード項目編集画面

```
```

# - POST - `/card/name` - store カード項目新規登録

```
```

# - POST - `/card/name/:id/update` - update カード項目編集実行

```
```

# - POST - `/card/name/:id/remove` - remove カード項目削除

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

- `lib/QRSelf/Controller/Card/Name.pm` -
- `lib/QRSelf/Model/Card/Name.pm` -
- `templates/card/name/` -
- `t/qrself/controller/card/name.t` -
