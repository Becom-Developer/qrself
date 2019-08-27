package QRSelf;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
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

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('example#welcome');
}

1;
