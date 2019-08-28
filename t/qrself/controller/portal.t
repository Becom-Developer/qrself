use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Mojo::Util qw{dumper};

my $t = Test::Mojo->with_roles('+Basic')->new('QRSelf')->init;

subtest 'GET - `/` - index' => sub {
    my $title = 'QRSelf - Top';
    $t->get_ok('/')->status_is(200)->text_is( 'html head title' => $title );
};

done_testing();
