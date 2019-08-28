package QRSelf::Model::Base;
use Mojo::Base -base;
use QRSelf::DB;
use Mojolicious::Validator;
use Mojolicious::Validator::Validation;

has [qw{conf req_params}];

has db => sub {
    QRSelf::DB->new( +{ conf => shift->conf } );
};

sub validation {
    my $self      = shift;
    my $params    = shift;
    my $validator = Mojolicious::Validator->new;
    my $v
        = Mojolicious::Validator::Validation->new( validator => $validator );
    $v->input($params);
    return $v;
}

1;
