package QRSelf::DB::Teng::Row::User;
use Mojo::Base 'Teng::Row';
use QRSelf::Util qw{now_datetime};
use QRSelf::DB::Master;
use Mojo::Util qw{dumper};

sub soft_delete {
    my $self   = shift;
    my $opt    = shift || +{};
    my $params = +{
        deleted     => 1,
        modified_ts => now_datetime(),
        %{$opt},
    };

    # 関連テーブル存在時はここで追加削除
    $self->update($params);
    return;
}

sub fetch_limitation {
    my $self = shift;
    my $opt    = shift || +{};
    my $cond = +{
        user_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'limitation', $cond );
}

sub search_card {
    my $self = shift;
    my $opt  = shift || +{};
    my $attr = shift || +{};
    my $cond = +{
        user_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my @rows = $self->handle->search( 'card', $cond, $attr );
    return if scalar @rows eq 0;
    return \@rows;
}

1

__END__
