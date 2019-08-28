package QRSelf::Model;
use Mojo::Base 'QRSelf::Model::Base';
use QRSelf::Model::Portal;
use QRSelf::Model::Auth;

has portal => sub {
    QRSelf::Model::Portal->new( +{ conf => shift->conf } );
};

has auth => sub {
    QRSelf::Model::Auth->new( +{ conf => shift->conf } );
};

# add method
# use QRSelf::Model::Example;
# has example => sub {
#     QRSelf::Model::Example->new( +{ conf => shift->conf } );
# };

# add helper method
# package QRSelf;
# use Mojo::Base 'Mojolicious';
# use QRSelf::Model;
#
# sub startup {
#    my $self = shift;
#    ...
#    my $config = $self->config;
#    $self->helper(
#        model => sub { QRSelf::Model->new( +{ conf => $config } ); } );
#    ...
# }

1;
