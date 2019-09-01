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
    my $card_row
        = $t->app->test_db->teng->single( 'card', +{ deleted => 0 } );
    my $card_id = $card_row->id;
    my $url     = "/card/$card_id/qr";
    my $title   = 'QRSelf - card QRCode';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    $t->logout_ok();
};

# - GET - `/card/:id` - show 自己紹介ページ
subtest 'GET - show' => sub {
    $t->login_ok();
    my $card_row
        = $t->app->test_db->teng->single( 'card', +{ deleted => 0 } );
    my $card_id = $card_row->id;
    my $url     = "/card/$card_id";
    my $title   = 'QRSelf - card show';
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

# - GET - `/card/:id/edit` - edit 自己紹介ページ編集画面
subtest 'GET - edit' => sub {
    $t->login_ok();
    my $card_row
        = $t->app->test_db->teng->single( 'card', +{ deleted => 0 } );
    my $card_id = $card_row->id;
    my $url     = "/card/$card_id/edit";
    my $title   = 'QRSelf - card edit';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    $t->logout_ok();
};

# - POST - `/card` - store 自己紹介ページ新規登録
subtest 'POST - store' => sub {
    $t->login_ok();
    my $params = +{ name => '仕事用のカード', };
    $t->create_card_ok($params);
    $t->logout_ok();
};

# - POST - `/card/:id/update` - update 自己紹介ページ編集実行
subtest 'POST - update' => sub {
    $t->login_ok();
    my $card_row
        = $t->app->test_db->teng->single( 'card', +{ deleted => 0 } );
    my $card_id = $card_row->id;
    my $params  = +{ name => '仕事用のカード、変更', };
    $t->update_card_ok( $card_id, $params );
    $t->logout_ok();
};

# # - POST - `/card/:id/remove` - remove 自己紹介ページ削除
# subtest 'POST - remove' => sub {
#     ok(1);
# };

done_testing();
