use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Mojo::Util qw{dumper};

my $t = Test::Mojo->with_roles('+Basic')->new('QRSelf')->init;

# - GET - `/auth/create` - create ユーザー登録画面
subtest 'GET - create' => sub {
    my $url   = '/auth/create';
    my $title = 'QRSelf - auth create';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
    ok(1);
};

# # - GET - `/auth/:id/edit` - edit ユーザー情報更新画面
# subtest 'GET - edit' => sub {
#     my $url   = '/auth/edit';
#     my $title = 'QRSelf - auth edit';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - GET - `/auth/:id` - show ユーザー情報詳細
# subtest 'GET - show' => sub {
#     my $url   = '/auth/show';
#     my $title = 'QRSelf - auth show';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - GET - `/auth/login` - login ログイン入力画面
# subtest 'GET - login' => sub {
#     my $url   = '/auth/login';
#     my $title = 'QRSelf - auth login';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - GET - `/auth/logout` - logout ユーザーログアウト画面
# subtest 'GET - logout' => sub {
#     my $url   = '/auth/logout';
#     my $title = 'QRSelf - auth logout';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - GET - `/auth/remove` - remove ユーザー削除画面
# subtest 'GET - remove' => sub {
#     my $url   = '/auth/remove';
#     my $title = 'QRSelf - auth remove';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - POST - `/auth/login` - login ユーザーログイン実行
# subtest 'POST - login' => sub {
#     my $url   = '/auth/login';
#     my $title = 'QRSelf - auth login';
#     $t->post_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - POST - `/auth/logout` - logout ユーザーログアウト実行
# subtest 'POST - logout' => sub {
#     my $url   = '/auth/logout';
#     my $title = 'QRSelf - auth logout';
#     $t->post_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - POST - `/auth/:id/update` - update ユーザー情報更新実行
# subtest 'POST - update' => sub {
#     my $url   = '/auth/create';
#     my $title = 'QRSelf - auth create';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - POST - `/auth/:id/remove` - remove ユーザー削除実行
# subtest 'POST - remove' => sub {
#     my $url   = '/auth/create';
#     my $title = 'QRSelf - auth create';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

# # - POST - `/auth` - store ユーザー新規登録実行
# subtest 'POST - store' => sub {
#     my $url   = '/auth/create';
#     my $title = 'QRSelf - auth create';
#     $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
#     ok(1);
# };

ok(1);

done_testing();
