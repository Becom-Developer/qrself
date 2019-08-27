package QRSelf::Model::Base;
use Mojo::Base -base;
use QRSelf::DB;

has [qw{conf req_params}];

has db => sub {
    QRSelf::DB->new( +{ conf => shift->conf } );
};

1;
