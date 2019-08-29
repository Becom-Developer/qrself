use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use Mojo::Util qw{dumper};

my $t = Test::Mojo->with_roles('+Basic')->new('QRSelf')->init;

# - GET - `/portal/card/:id` - show 公開用自己紹介ページ
subtest 'GET - show' => sub {
    $t->login_ok();
    my $card_rows = $t->app->login_user->search_card;
    my $card_row  = shift @{$card_rows};
    my $card_id   = $card_row->id;
    $t->logout_ok();
    my $url   = "/portal/card/$card_id";
    my $title = 'QRSelf - portal card show';
    $t->get_ok($url)->status_is(200)->text_is( 'html head title' => $title );
};

done_testing();
