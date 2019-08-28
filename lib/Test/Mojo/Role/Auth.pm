package Test::Mojo::Role::Auth;
use Mojo::Base -role;
use Test::More;
use Mojo::Util qw{dumper};

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
