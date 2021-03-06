# NAME

qrself/controller/auth - QRSelf (認証)

# SYNOPSIS

## URL

- GET - `/auth/create` - create ユーザー登録画面
- GET - `/auth/:id/edit` - edit ユーザー情報更新画面
- GET - `/auth/:id` - show ユーザー情報詳細
- GET - `/auth/login` - login ログイン入力画面
- GET - `/auth/logout` - logout ユーザーログアウト画面
- GET - `/auth/remove` - remove ユーザー削除画面
- POST - `/auth/login` - login ユーザーログイン実行
- POST - `/auth/logout` - logout ユーザーログアウト実行
- POST - `/auth/:id/update` - update ユーザー情報更新実行
- POST - `/auth/:id/remove` - remove ユーザー削除実行
- POST - `/auth` - store ユーザー新規登録実行

# DESCRIPTION

# - GET - `/auth/create` - create ユーザー登録画面

```
ユーザー登録入力フォーム一式
```

# - GET - `/auth/:id/edit` - edit ユーザー情報更新画面

```
```

# - GET - `/auth/:id` - show ユーザー情報詳細

```
```

# - GET - `/auth/login` - login ログイン入力画面

```
ログイン入力フォーム一式
```

# - GET - `/auth/logout` - logout ユーザーログアウト画面

```
ログアウト実行後に表示
```

# - GET - `/auth/remove` - remove ユーザー削除画面

```
```

# - POST - `/auth/login` - login ユーザーログイン実行

```
```

# - POST - `/auth/logout` - logout ユーザーログアウト実行

```
ログアウト実行
成功: 実行してログアウト画面へ遷移
```

# - POST - `/auth/:id/update` - update ユーザー情報更新実行

```
```

# - POST - `/auth/:id/remove` - remove ユーザー削除実行

```
```

# - POST - `/auth` - store ユーザー新規登録実行

```
ユーザー新登録実行
成功: 実行してトップ画面へ遷移
失敗: 実行せずに登録画面へ遷移
```

# TODO

編集中

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

- `lib/QRSelf/Controller/Auth.pm` -
- `lib/QRSelf/Model/Auth.pm` -
- `templates/auth/` -
- `t/qrself/controller/auth.t` -
