package QRSelf;
use Mojo::Base 'Mojolicious';
use QRSelf::Model;

sub startup {
    my $self = shift;
    my $mode = $self->mode;

    # my $moniker = $self->moniker;
    my $moniker = 'qrself';

    my $home   = $self->home;
    my $common = $home->child( 'etc', "$moniker.common.conf" )->to_string;
    my $conf   = $home->child( 'etc', "$moniker.$mode.conf" )->to_string;

    # 設定ファイル (読み込む順番に注意)
    $self->plugin( Config => +{ file => $common } );
    $self->plugin( Config => +{ file => $conf } );
    my $config = $self->config;

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer') if $config->{perldoc};

    # コマンドをロードするための他の名前空間
    push @{ $self->commands->namespaces }, 'QRSelf::Command';

    $self->helper(
        model => sub { QRSelf::Model->new( +{ conf => $config } ); } );

    $self->helper( site_name => sub { 'QRSelf'; } );

    # ルーティング前に共通して実行
    $self->hook(
        before_dispatch => sub {
            my $c   = shift;
            my $url = $c->req->url;

            $self->helper( login_user => sub {undef} );

            # セッション情報からログイン者の情報を取得
            my $params = +{ login_id => $c->session('user') };
            my $model = $self->model->auth->req_params($params);

            if ( my $login_user = $model->session_check ) {
                $self->helper( login_user => sub {$login_user} );
            }

            # # 認証保護されたページ
            # if ( $url =~ m{^/auth/plugin.*} ) {
            #     return $c->redirect_to('/') if !$self->login_user;
            #     return $c->redirect_to('/')
            #         if !$self->login_user->is_admin_function;
            # }
        }
    );

    # Router
    my $r    = $self->routes;
    my $u_id = [ user_id => qr/[0-9]+/ ];

    $r->get('/')->to('Portal#index');

    # auth (認証)
    my $auth_u = $r->under('/auth');
    my $auth_d = 'Auth#';
    $auth_u->get('/create')->to( $auth_d . 'create' );
    $auth_u->get( '/:user_id/edit', $u_id )->to( $auth_d . 'edit' );
    $auth_u->get( '/:user_id',      $u_id )->to( $auth_d . 'show' );
    $auth_u->get('/login')->to( $auth_d . 'login' );
    $auth_u->get('/logout')->to( $auth_d . 'logout' );
    $auth_u->get('/remove')->to( $auth_d . 'remove' );
    $auth_u->post('/login')->to( $auth_d . 'login' );
    $auth_u->post('/logout')->to( $auth_d . 'logout' );
    $auth_u->post( '/:user_id/update', $u_id )->to( $auth_d . 'update' );
    $auth_u->post( '/:user_id/remove', $u_id )->to( $auth_d . 'remove' );
    $auth_u->post('')->to( $auth_d . 'store' );
}

1;
