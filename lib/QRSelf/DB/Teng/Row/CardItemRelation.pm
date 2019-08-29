package QRSelf::DB::Teng::Row::CardItemRelation;
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

sub fetch_card_name {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        id      => $self->card_name_id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'card_name', $cond );
}

sub fetch_card_group {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        id      => $self->card_group_id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'card_group', $cond );
}

sub fetch_card_contact {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        id      => $self->card_contact_id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'card_contact', $cond );
}

sub fetch_card_address {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        id      => $self->card_address_id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'card_address', $cond );
}

sub fetch_card_personal {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        id      => $self->card_personal_id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'card_personal', $cond );
}

sub fetch_card_note {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        id      => $self->card_note_id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'card_note', $cond );
}

sub fetch_card_icon {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        id      => $self->card_icon_id,
        deleted => 0,
        %{$opt},
    };
    return $self->handle->single( 'card_icon', $cond );
}

1

__END__
