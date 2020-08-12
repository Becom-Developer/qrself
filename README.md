# NAME

qrself - QRコードを使って自己紹介をするアプリ

## SYNOPSIS

### URL

- <https://qrself.becom.co.jp/> - 開発版

### SETUP

のちほどまとめる

開発環境の実行手順

plenv: 2.3.0-10-gb8ca5d3
perl: 5.30.0

```
(perl 準備)
$ cd ~/.plenv/ && git pull
$ cd ~/.plenv/plugins/perl-build/ && git pull
$ cd ~/github/qrself/
$ plenv install 5.30.0
$ plenv rehash
$ plenv global 5.30.0
$ plenv install-cpanm
$ cpanm Carton
$ cpanm Perl::Tidy

(mojo ほか、準備)
$ echo '5.30.0' > .perl-version; echo "requires 'Mojolicious', '== 7.94';" >> cpanfile; echo "requires 'Teng', '0.31';" >> cpanfile; echo "requires 'DBD::SQLite', '1.64';" >> cpanfile; echo "requires 'HTML::FillInForm::Lite', '1.15';" >> cpanfile; echo "requires 'Imager::QRCode', '0.035';" >> cpanfile;
$ carton install

(雛形作成)
$ carton exec -- mojo generate app QRSelf
$ mv qrself/* .
$ rmdir qrself

(git設定)
$ echo 'local/' >> .gitignore; echo 'log/' >> .gitignore; echo 'db/*.db' >> .gitignore; echo '.DS_Store' >> .gitignore;

(mojo 拡張コマンド)
$ git clone git@github.com:ykHakata/Mojolicious-Command-generate-doc.git
$ git clone git@github.com:ykHakata/Mojolicious-Command-generate-mvc.git
$ git clone git@github.com:ykHakata/Mojolicious-Command-generate-sqlitedb.git
$ git clone git@github.com:ykHakata/Mojolicious-Command-generate-etc.git
$ mv Mojolicious-Command-generate-doc/lib/* lib/
$ mv Mojolicious-Command-generate-mvc/lib/Mojolicious/Command/generate/* lib/Mojolicious/Command/generate/
$ mv Mojolicious-Command-generate-sqlitedb/lib/Mojolicious/Command/generate/* lib/Mojolicious/Command/generate/
$ mv Mojolicious-Command-generate-etc/lib/Mojolicious/Command/generate/* lib/Mojolicious/Command/generate/

(いらなくなったフォルダをコマンドで消すのはいろいろ面倒なので、手動で削除)

(１回目テンプレ自動作成)
$ carton exec -- script/qrself generate mvc

(基本認証機能テンプレ自動作成)
$ carton exec -- script/qrself generate mvc Auth

(試しテスト)
$ carton exec -- script/qrself test -v --mode testing t/qrself.t
(開発用のテンプレ配置完成)
```

サーバー側の手順

ドメインを結びつける(お名前.com)
qrself.becom.co.jp - TYPE: A, TTL: 3600, VALUE: 153.127.18.40

vps インストール: CentOS7 x86_64
root, パスワード設定: (パスワードは別途管理)
スタートアップスクリプト: CentOS_LetsEncrypt
使用するドメイン: qrself.becom.co.jp
Let's Encryptから連絡を受信するメールアドレス: yosizuka1@gmail.com

インストール完了後サーバー情報をまとめておく

```
IP アドレス: 153.127.18.40
名前: qrself
説明: qrself - QRコードを使って自己紹介をするアプリ

サーバーアクセスからアカウントの作成
id: root
pass: ****
id: app
pass: ****
id: kusakabe
pass: ****
```

```
(手元より)
$ ssh root@qrself.becom.co.jp
(pass必要)
(vps ログイン後)
# yum update
# useradd app
# passwd app
(****)
# useradd kusakabe
# passwd kusakabe
(****)
# usermod -G wheel app
# usermod -G wheel kusakabe

(nginx 情報をコピペしておく)
# cat /etc/nginx/conf.d/https.conf
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}
server {
    listen 443 ssl http2;
    server_name qrself.becom.co.jp;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    ssl_protocols TLSv1.2;
    ssl_ciphers EECDH+AESGCM:EECDH+AES;
    ssl_ecdh_curve prime256v1;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;

    ssl_certificate /etc/letsencrypt/live/qrself.becom.co.jp/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/qrself.becom.co.jp/privkey.pem;

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
# exit
(本番用の nginx 用 conf 作成しておく nginx_production.conf)
```

```
(鍵認証の設定)
$ ssh kusakabe@qrself.becom.co.jp
$ mkdir ~/.ssh
$ chmod 700 ~/.ssh
$ exit
$ scp ~/.ssh/id_rsa.pub kusakabe@qrself.becom.co.jp:~/.ssh/authorized_keys

(鍵認証でログインできる)
$ ssh kusakabe@qrself.becom.co.jp
$ sudo su - app
$ mkdir ~/.ssh
$ chmod 700 ~/.ssh
$ ssh-keygen -t rsa -C 'qrself'
(さくら VPS 側で鍵の生成、いろいろ聞かれるがすべてリターン)
```

```
(Github サイトに行き公開鍵を登録)
Deploy keys -> Add deploy key
Title -> qrself centos7 production
key -> 公開鍵の内容をコピペする
```

```
(公開鍵の内容表示)
$ cat ~/.ssh/id_rsa.pub
(接続確認)
$ ssh -T git@github.com
(yes と入力)

(perlインストール一式)
$ git clone git://github.com/tokuhirom/plenv.git ~/.plenv
$ echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(plenv init -)"' >> ~/.bash_profile
$ exec $SHELL -l
$ git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/

$ plenv install 5.30.0
$ plenv rehash
$ plenv global 5.30.0
$ plenv install-cpanm
$ cpanm Carton
$ cpanm Perl::Tidy

(gitclone app 配置)
$ git clone git@github.com:Becom-Developer/qrself.git
$ cd ~/qrself/
$ carton install

(nginx 設定ファイル変更)
$ sudo su - root

# cd /etc/nginx/conf.d/
# ln -s /home/app/qrself/etc/nginx_production.conf qrself.conf
# mv default.conf default.conf.org
# mv https.conf https.conf.org
# ls -al /etc/nginx/conf.d/
# systemctl reload nginx
# logout

(アプリの起動)
$ cd ~/qrself/ && git pull && carton exec -- script/qrself generate sqlitedb --mode production
$ carton exec -- hypnotoad script/qrself

(もう一回)
$ cd ~/qrself/ && git pull && carton exec -- hypnotoad script/qrself

(アクセス確認)
$ curl -v https://qrself.becom.co.jp
```

### START APP

## TODO

開発メモ

紹介文面

```
これからは QRコードで自己紹介をする時代

スマホでQRコードを見せるだけ
簡単、手早く自己紹介

取引先やお友達の情報をスマホで簡単管理

オプション追加で動物占いや google カレンダーへの誕生日情報登録など
楽しい機能も盛りだくさんだよ!
```

url 暫定案

- 自己紹介カード - card
    - GET - `/card` - index 自己紹介カードの一覧
    - GET - `/card/:id/qr` - qr 自己紹介ページのQRコード表示
    - GET - `/card/:id` - show 自己紹介ページ
    - GET - `/card/create` - create 自己紹介ページ新規作成画面
    - GET - `/card/:id/edit` - edit 自己紹介ページ編集画面
    - POST - `/card` - store 自己紹介ページ新規登録
    - POST - `/card/:id/update` - update 自己紹介ページ編集実行
    - POST - `/card/:id/remove` - remove 自己紹介ページ削除
    - カード項目 - card_name
        - GET - `/card/name/:id/edit` - edit カード項目編集画面
        - POST - `/card/name/:id/update` - update カード項目編集実行
    - カード項目 - card_group
        - GET - `/card/group/:id/edit` - edit カード項目編集画面
        - POST - `/card/group/:id/update` - update カード項目編集実行
    - カード項目 - card_contact
        - GET - `/card/contact/:id/edit` - edit カード項目編集画面
        - POST - `/card/contact/:id/update` - update カード項目編集実行
    - カード項目 - card_address
        - GET - `/card/address/:id/edit` - edit カード項目編集画面
        - POST - `/card/address/:id/update` - update カード項目編集実行
    - カード項目 - card_personal
        - GET - `/card/personal/:id/edit` - edit カード項目編集画面
        - POST - `/card/personal/:id/update` - update カード項目編集実行
    - カード項目 - card_note
        - GET - `/card/note/:id/edit` - edit カード項目編集画面
        - POST - `/card/note/:id/update` - update カード項目編集実行
    - カード項目 - card_icon
        - GET - `/card/icon/:id/edit` - edit カード項目編集画面
        - POST - `/card/icon/:id/update` - update カード項目編集実行
- 自己紹介仲間の管理 - friend
    - GET - `/friend` - index 自己紹介仲間の一覧
    - GET - `/friend/search` - search 自己紹介仲間の検索
    - GET - `/friend/:id` - show 仲間の詳細
    - GET - `/friend/:id/update` - update 仲間情報の編集画面
    - POST - `/friend` - store 仲間の追加実行
    - POST - `/friend/:id/update` - update 仲間情報の編集実行
    - POST - `/friend/:id/remove` - remove 仲間の削除
- 追加したい機能
    - 生年月日から動物占いをする機能
    - 生年月日から指定の google カレンダーに誕生日情報を自動入力する機能

sql 暫定案

```sql
DROP TABLE IF EXISTS user;
CREATE TABLE user (                                     -- ユーザー
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    login_id        TEXT,                               -- ログインID名 (例: 'info@becom.co.jp')
    password        TEXT,                               -- ログインパスワード (例: 'info')
    approved        INTEGER,                            -- 承認フラグ (例: 0: 承認していない, 1: 承認済み)
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS limitation;
CREATE TABLE limitation (                               -- 制限
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    status          INTEGER,                            -- ステータス (例: 1**: 管理者, 2**: 一般)
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card;
CREATE TABLE card (                                     -- 紹介カード
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    name            TEXT,                               -- 名前 (例: '会社の営業用紹介カード')
    qrcode          TEXT,                               -- QRコード画像リンク (例: 'qrcode.png')
    is_standard     INTEGER,                            -- 標準フラグ (例: 0: 標準カードではない, 1: 標準カードである)
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_item_relation;
CREATE TABLE card_item_relation (                               -- 紹介カードの項目と項目内容の関係
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    cart_id                 INTEGER,                            -- 紹介カードID (例: 1)
    card_name_id            INTEGER,                            -- 紹介カードにつかう名前情報ID (例: 1)
    card_group_id           INTEGER,                            -- 紹介カードにつかう団体情報ID (例: 1)
    card_contact_id         INTEGER,                            -- 紹介カードにつかう連絡先情報ID (例: 1)
    card_address_id         INTEGER,                            -- 紹介カードにつかう住所情報ID (例: 1)
    card_personal_id        INTEGER,                            -- 紹介カードにつかう個人情報ID (例: 1)
    card_note_id            INTEGER,                            -- 紹介カードにつかうメモ情報ID (例: 1)
    card_icon_id            INTEGER,                            -- 紹介カードにつかうアイコン情報ID (例: 1)
    deleted                 INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts              TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts             TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_name;
CREATE TABLE card_name (                                -- 紹介カードにつかう名前情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    name            TEXT,                               -- 名前 (例: '松野 おそ松')
    rubi            TEXT,                               -- ふりがな (例: 'まつの おそまつ')
    nickname        TEXT,                               -- ニックネーム (例: 'おそまつ')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_group;
CREATE TABLE card_group (                               -- 紹介カードにつかう団体情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    name            TEXT,                               -- 団体名 (例: 'Becom')
    rubi            TEXT,                               -- ふりがな (例: 'ベーコン')
    position        TEXT,                               -- 肩書き (例: '課長')
    belongs         TEXT,                               -- 所属 (例: '営業課')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_contact;
CREATE TABLE card_contact (                             -- 紹介カードにつかう連絡先情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    name            TEXT,                               -- コンタクト名 (例: '会社用メール')
    contact         TEXT,                               -- Eメール (例: 'info@becom.co.jp')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_address;
CREATE TABLE card_address (                             -- 紹介カードにつかう住所情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    name            TEXT,                               -- 住所名 (例: '会社用住所')
    zipcode         TEXT,                               -- 郵便番号 (例: '812-8577')
    address         TEXT,                               -- 住所 (例: '福岡県福岡市博多区東公園7番7号')
    address_map     TEXT,                               -- 住所の地図情報 (例: '35.7014561,139.7446664,16')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_personal;
CREATE TABLE card_personal (                            -- 紹介カードにつかう個人情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    name            TEXT,                               -- 個人情報名 (例: 'お見合い用')
    birthday        TEXT,                               -- 生年月日 (例: '1974-05-20')
    gender          INTEGER,                            -- 性別 (例: 1: 男性, 2: 女性)
    height          TEXT,                               -- 身長 (例: '158')
    weight          TEXT,                               -- 体重 (例: '50')
    bust            INTEGER,                            -- バスト (例: '84')
    waist           INTEGER,                            -- ウエスト (例: '63')
    hip             INTEGER,                            -- ヒップ (例: '86')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_note;
CREATE TABLE card_note (                                -- 紹介カードにつかうメモ情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    note            TEXT,                               -- ノート (例: '最近は山登りにはまっています')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS card_icon;
CREATE TABLE card_icon (                                -- 紹介カードにつかうアイコン情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    icon            TEXT,                               -- アイコン画像 (例: 'icon.jpg')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS friend;
CREATE TABLE friend (                                   -- 仲間情報
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    user_id         INTEGER,                            -- ユーザーID (例: 5)
    name            TEXT,                               -- 名前 (例: '会社のお得意先')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS friend_category;
CREATE TABLE friend_category (                          -- 仲間情報のカテゴリー
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    name            TEXT,                               -- カテゴリー名 (例: 'レッド')
    note            TEXT,                               -- 備考 (例: 'おもに営業マン')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts     TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
DROP TABLE IF EXISTS friend_category_relation;
CREATE TABLE friend_category_relation (                         -- 仲間情報のカテゴリーとの関係
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    friend_id               INTEGER,                            -- 仲間ID (例: 1)
    friend_category_id      INTEGER,                            -- 仲間のカテゴリーID (例: 1)
    deleted                 INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts              TEXT,                               -- 登録日時 (例: '2019-08-22 17:01:29')
    modified_ts             TEXT                                -- 修正日時 (例: '2019-08-22 17:01:29')
);
```

## MEMO

2020/08/12: 開発再開の見通しがたたないため、公開サーバーの利用を中止

## SEE ALSO

- <https://metacpan.org/pod/Imager::QRCode> -
- <https://www.qrcode.com/> -
- <http://twilio.kddi-web.com/> -
- <https://wrapbootstrap.com/theme/macbeath-3-in-1-admin-front-end-e-com-WB0G69690> -
