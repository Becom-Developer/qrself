package Test::Mojo::Role::Auth;
use Mojo::Base -role;
use Test::More;
use Mojo::Util qw{dumper};

sub login_ok {
    my $t       = shift;
    my $user_id = shift || 1;
    my $master  = $t->app->test_db->master;
    my $msg     = $master->auth->to_word('IS_LOGIN');

    # # 権限指定でログイン
    # my $status = [qw{ROOT SUDO ADMIN GENERAL GUEST}];
    # my @login = grep {$_ eq $user_id} @{$status};
    # my $limit_status = shift @login;
    # my $cond = +{ id => $user_id, };
    # if ($limit_status) {
    #     my $name = lc $limit_status;
    #     my $login_id = 'iteens.' . $name . '@gmail.com';
    #     $cond = +{ login_id => $login_id, };
    # }
    # my $user = $t->app->test_db->teng->single( 'user', $cond );
    # if ($limit_status) {
    #     is( $user->fetch_limit_status,
    #         $master->limitation->constant($limit_status), 'status' );
    # }
    # my $login_id = $user->login_id;
    # my $password = $user->password;

    # # セッションを開始
    # $t->get_ok('/')->status_is(200);

    # # セッション確認
    # is( $t->tx->res->cookie('mojolicious'), undef, 'session' );

    # # ログイン画面
    # $t->get_ok('/auth/login')->status_is(200);
    # my $dom        = $t->tx->res->dom;
    # my $form       = 'form[name=form_login]';
    # my $action_url = $dom->at($form)->attr('action');

    # # 値を入力
    # $dom->at('input[name=login_id]')->attr( +{ value => $login_id } );
    # $dom->at('input[name=password]')->attr( +{ value => $password } );

    # # input val 取得
    # my $params = $t->get_input_val( $dom, $form );

    # # ログイン実行
    # $t->post_ok( $action_url => form => $params )->status_is(302);
    # my $location_url = $t->tx->res->headers->location;
    # $t->get_ok($location_url)->status_is(200);

    # # 成功画面
    # $t->content_like(qr{\Q<b>$msg</b>\E});

    # # セッション確認
    # ok( $t->tx->res->cookie('mojolicious'), 'session' );
    return $t;
}

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
