package QRSelf::DB::Base;
use Mojo::Base -base;
use QRSelf::Util qw{now_datetime};
use Teng;
use Teng::Schema::Loader;

has [qw{conf}];

sub teng {
    my $self = shift;
    my $db   = $self->conf->{db};

    my $dsn_str = $db->{dsn_str};
    my $user    = $db->{user};
    my $pass    = $db->{pass};
    my $option  = $db->{option};
    my $dbh     = DBI->connect( $dsn_str, $user, $pass, $option );
    my $teng    = Teng::Schema::Loader->load(
        dbh       => $dbh,
        namespace => 'QRSelf::DB::Teng',
    );
    $teng->load_plugin('Count');
    $teng->load_plugin('Pager');
    return $teng;
}

# teng fast insert 日付つき
sub teng_fast_insert {
    my $self   = shift;
    my $table  = shift;
    my $params = shift;

    $params = +{
        %{$params},
        created_ts  => now_datetime(),
        modified_ts => now_datetime(),
    };
    return $self->teng->fast_insert( $table, $params );
}

# teng insert 日付つき (row で返却)
sub teng_insert {
    my $self   = shift;
    my $table  = shift;
    my $params = shift;

    $params = +{
        %{$params},
        created_ts  => now_datetime(),
        modified_ts => now_datetime(),
    };
    return $self->teng->insert( $table, $params );
}

# teng update 日付つき
sub teng_update {
    my $self   = shift;
    my $table  = shift;
    my $params = shift;
    my $cond   = shift;

    $params = +{ %{$params}, modified_ts => now_datetime(), };
    my $update_count = $self->teng->update( $table, $params, $cond, );
    return $cond->{id} if $update_count;
    return;
}

1;
