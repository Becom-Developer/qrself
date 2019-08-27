package QRSelf::Controller::Auth;
use Mojo::Base 'QRSelf::Controller::Base';

sub index {
    my $self = shift;
    $self->render(text => 'index');
    return;
}

1;
