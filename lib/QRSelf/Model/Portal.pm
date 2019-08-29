package QRSelf::Model::Portal;
use Mojo::Base 'QRSelf::Model::Base';
use QRSelf::Model::Portal::Card;

has card => sub {
    QRSelf::Model::Portal::Card->new( +{ conf => shift->conf } );
};

sub index {
    my $self = shift;
    return;
}

1;
