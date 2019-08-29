package Test::Mojo::Role::Auth;
use Mojo::Base -role;
use Test::More;
use Mojo::Util qw{dumper};

sub login_ok {
    my $t       = shift;
    my $user_id = shift || 1;
    my $master  = $t->app->test_db->master;
    my $msg     = $master->common->to_word('DONE_LOGIN');

    my $cond     = +{ id => $user_id, };
    my $user     = $t->app->test_db->teng->single( 'user', $cond );
    my $login_id = $user->login_id;
    my $password = $user->password;

    # セッション開始から確認
    $t->get_ok('/')->status_is(200);
    is( $t->tx->res->cookie('mojolicious'), undef, 'session' );

    # ログイン画面
    $t->get_ok('/auth/login')->status_is(200);
    my $dom        = $t->tx->res->dom;
    my $form       = 'form[name=form_login]';
    my $action_url = $dom->at($form)->attr('action');

    # 値の入力から取得
    $dom->at('input[name=login_id]')->attr( +{ value => $login_id } );
    my $params = $t->get_input_val( $dom, $form );

    # ログイン実行からセッション確認
    $t->post_ok( $action_url => form => $params )->status_is(302);
    my $location_url = $t->tx->res->headers->location;
    $t->get_ok($location_url)->status_is(200);
    $t->content_like(qr{\Q<b>$msg</b>\E});
    ok( $t->tx->res->cookie('mojolicious'), 'session' );
    return $t;
}

# sub logout_ok {
#     my $t = shift;

#     # ログアウトボタンの存在する画面(ログイン中のみ)
#     $t->get_ok('/')->status_is(200);

#     my $dom        = $t->tx->res->dom;
#     my $form       = 'form[name=form_logout]';
#     my $action_url = $dom->at($form)->attr('action');
#     my $master     = $t->app->test_db->master;

#     # ログアウト実行
#     $t->post_ok($action_url)->status_is(302);
#     my $location_url = $t->tx->res->headers->location;
#     $t->get_ok($location_url)->status_is(200);

#     # 成功画面
#     my $msg = $master->auth->to_word('IS_LOGOUT');
#     $t->content_like(qr{\Q<b>$msg</b>\E});

#     # セッション確認
#     is( $t->tx->res->cookie('mojolicious'), undef, 'session' );
#     return $t;
# }

sub create_user_ok {
    my $t      = shift;
    my $params = shift;
    my $opt    = shift;
    my $master = $t->app->test_db->master;
    my $msg    = $master->common->to_word('DONE_REGISTER');

    my $create = '/auth/create';
    $t->get_ok($create)->status_is(200);
    my $dom        = $t->tx->res->dom;
    my $form       = 'form[name=form_store]';
    my $action_url = $dom->at($form)->attr('action');
    my $login_id   = $params->{login_id};

    # 値を入力
    $dom->at('input[name=login_id]')->attr( +{ value => $login_id } );

    # input val 取得
    my $input_params = $t->get_input_val( $dom, $form );

    # 登録実行
    $t->post_ok( $action_url => form => $input_params )->status_is(302);
    my $location_url = $t->tx->res->headers->location;
    $t->get_ok($location_url)->status_is(200);

    # 成功画面
    $t->content_like(qr{\Q<b>$msg</b>\E});

    # セッション確認
    ok( $t->tx->res->cookie('mojolicious'), 'session' );

    # データの確認
    my $cond = +{
        login_id => $login_id,
        deleted  => $master->deleted->constant('NOT_DELETED'),
    };
    my $user = $t->app->test_db->teng->single( 'user', $cond );
    ok( $user, 'user count' );

    # 関連データ
    ok( $user->fetch_limitation, 'limitation count' );
    my $card = $user->search_card;
    is( scalar @{$card}, 1, 'card count' );
    return $t;
}

1;

__END__
