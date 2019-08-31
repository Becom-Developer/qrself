use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Mojo::Util qw{dumper};

my $t = Test::Mojo->with_roles('+Basic')->new('QRSelf')->init;

# - GET - `/card` - index 自己紹介カードの一覧
subtest 'GET - index' => sub {
    my $url   = '/card';
    my $title = 'QRSelf - card index';
    $t->login_ok();
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    $t->logout_ok();
};

# - GET - `/card/:id/qr` - qr 自己紹介ページのQRコード表示
subtest 'GET - qr' => sub {
    $t->login_ok();
    my $card_rows = $t->app->login_user->search_card;
    my $card_row  = shift @{$card_rows};
    my $card_id   = $card_row->id;
    my $url       = "/card/$card_id/qr";
    my $title     = 'QRSelf - card QRCode';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    $t->logout_ok();
};

# - GET - `/card/:id` - show 自己紹介ページ
subtest 'GET - show' => sub {
    $t->login_ok();
    my $card_rows = $t->app->login_user->search_card;
    my $card_row  = shift @{$card_rows};
    my $card_id   = $card_row->id;
    my $url       = "/card/$card_id";
    my $title     = 'QRSelf - card show';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    $t->logout_ok();
};

# - GET - `/card/create` - create 自己紹介ページ新規作成画面
subtest 'GET - create' => sub {
    $t->login_ok();
    my $url   = "/card/create";
    my $title = 'QRSelf - card create';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    $t->logout_ok();
};

# # - GET - `/card/:id/edit` - edit 自己紹介ページ編集画面
# subtest 'GET - edit' => sub {
#     ok(1);
# };

# - POST - `/card` - store 自己紹介ページ新規登録
subtest 'POST - store' => sub {
    $t->login_ok();
    my $params = +{ name => '仕事用のカード', };
    $t->create_card_ok($params);
    $t->logout_ok();
};

# # - POST - `/card/:id/update` - update 自己紹介ページ編集実行
# subtest 'POST - update' => sub {
#     ok(1);
# };

# # - POST - `/card/:id/remove` - remove 自己紹介ページ削除
# subtest 'POST - remove' => sub {
#     ok(1);
# };

done_testing();
