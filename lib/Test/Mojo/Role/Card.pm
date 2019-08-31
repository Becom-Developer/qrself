package Test::Mojo::Role::Card;
use Mojo::Base -role;
use Test::More;
use Mojo::Util qw{dumper};

sub create_card_ok {
    my $t      = shift;
    my $params = shift;
    my $opt    = shift;
    my $master = $t->app->test_db->master;
    my $msg    = $master->common->to_word('DONE_REGISTER');

    my $create = '/card/create';
    $t->get_ok($create)->status_is(200);

    my $dom        = $t->tx->res->dom;
    my $form       = 'form[name=form_store]';
    my $action_url = $dom->at($form)->attr('action');

    # dom に 値を埋め込み
    $dom = $t->input_val_in_dom( $dom, $form, $params );

    # input val 取得
    my $input_params = $t->get_input_val( $dom, $form );

    # 登録実行
    $t->post_ok( $action_url => form => $input_params )->status_is(302);
    my $location_url = $t->tx->res->headers->location;
    $t->get_ok($location_url)->status_is(200);

    # url から 作成されたidを取得
    my $create_id = pop @{ $t->tx->req->url->to_abs->path->parts };

    # 成功画面
    $t->content_like(qr{\Q<b>$msg</b>\E});

    # データの確認
    my $cond = +{
        id      => $create_id,
        deleted => $master->deleted->constant('NOT_DELETED'),
    };
    my $card = $t->app->test_db->teng->single( 'card', $cond );
    ok( $card, 'card count' );
    return $t;
}

1;

__END__
