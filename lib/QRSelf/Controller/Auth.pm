package QRSelf::Controller::Auth;
use Mojo::Base 'QRSelf::Controller::Base';

sub create {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'auth/create';
    $self->stash(
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',

    );
    $self->render();
    return;
}

1;
