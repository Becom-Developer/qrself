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
    qrcord          TEXT,                               -- QRコード画像リンク (例: 'qrcord.png')
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
