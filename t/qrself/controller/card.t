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

# # - GET - `/card/:id/qr` - qr 自己紹介ページのQRコード表示
# subtest 'GET - qr' => sub {
#     ok(1);
# };

# # - GET - `/card/:id` - show 自己紹介ページ
# subtest 'GET - show' => sub {
#     ok(1);
# };

# # - GET - `/card/create` - create 自己紹介ページ新規作成画面
# subtest 'GET - create' => sub {
#     ok(1);
# };

# # - GET - `/card/:id/edit` - edit 自己紹介ページ編集画面
# subtest 'GET - edit' => sub {
#     ok(1);
# };

# # - POST - `/card` - store 自己紹介ページ新規登録
# subtest 'POST - store' => sub {
#     ok(1);
# };

# # - POST - `/card/:id/update` - update 自己紹介ページ編集実行
# subtest 'POST - update' => sub {
#     ok(1);
# };

# # - POST - `/card/:id/remove` - remove 自己紹介ページ削除
# subtest 'POST - remove' => sub {
#     ok(1);
# };


done_testing();
