package QRSelf::Controller::Portal;
use Mojo::Base 'QRSelf::Controller::Base';

sub index {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'portal/index';
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
