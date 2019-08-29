package QRSelf::Model::Base;
use Mojo::Base -base;
use QRSelf::DB;
use Mojolicious::Validator;
use Mojolicious::Validator::Validation;
use Imager::QRCode;
use Mojo::Util qw{dumper};
use QRSelf::Util qw{easy_filename};

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

# QRコード作成
sub create_qrcode {
    my $self    = shift;
    my $card_id = shift;

    my $qrcode = Imager::QRCode->new(
        size          => 50,
        margin        => 2,
        version       => 1,
        level         => 'M',
        casesensitive => 1,
        lightcolor    => Imager::Color->new( 255, 255, 255 ),
        darkcolor     => Imager::Color->new( 0, 0, 0 ),
    );

    my $url       = "https://qrself.becom.co.jp/portal/card/$card_id";
    my $img       = $qrcode->plot($url);
    my $home      = Mojo::Home->new;
    my $file      = easy_filename('qrcode.png');
    my $file_name = $home->child( 'public', 'img', $file )->to_string;

    if ( $self->conf->{mode} ne 'testing' ) {
        $img->write( file => $file_name )
            or die "Failed to write: " . $img->errstr;
    }
    return $file;
}

1;
