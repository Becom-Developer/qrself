use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Mojo::Util qw{dumper};

my $t = Test::Mojo->with_roles('+Basic')->new('QRSelf')->init;

# - GET - `/card/name/:id` - show カード項目詳細
# subtest 'GET - show' => sub {
#     $t->login_ok();
#     my $card_row
#         = $t->app->test_db->teng->single( 'card', +{ deleted => 0 } );
#     my $card_id = $card_row->id;
#     my $url     = "/card/$card_id";
#     my $title   = 'QRSelf - card show';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     $t->logout_ok();
# };

# - GET - `/card/name/create` - create カード項目新規作成画面
subtest 'GET - create' => sub {
    $t->login_ok();
    my $url   = "/card/name/create";
    my $title = 'QRSelf - card name create';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    $t->logout_ok();
};

# # - GET - `/card/name/:id/edit` - edit カード項目編集画面
# subtest 'GET - edit' => sub {
#     $t->login_ok();
#     my $card_row
#         = $t->app->test_db->teng->single( 'card', +{ deleted => 0 } );
#     my $card_id = $card_row->id;
#     my $url     = "/card/$card_id/edit";
#     my $title   = 'QRSelf - card edit';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     $t->logout_ok();
# };

# # - POST - `/card/name` - store カード項目新規登録
# subtest 'POST - store' => sub {
#     $t->login_ok();
#     my $params = +{ name => '仕事用のカード', };
#     $t->create_card_ok($params);
#     $t->logout_ok();
# };

# # - POST - `/card/name/:id/update` - update カード項目編集実行
# subtest 'POST - update' => sub {
#     $t->login_ok();
#     my $card_row
#         = $t->app->test_db->teng->single( 'card', +{ deleted => 0 } );
#     my $card_id = $card_row->id;
#     my $params  = +{ name => '仕事用のカード、変更', };
#     $t->update_card_ok( $card_id, $params );
#     $t->logout_ok();
# };

# - POST - `/card/name/:id/remove` - remove カード項目削除
# subtest 'POST - remove' => sub {
#     ok(1);
# };

done_testing();
