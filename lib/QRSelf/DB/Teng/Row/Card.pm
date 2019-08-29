package QRSelf::DB::Teng::Row::Card;
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
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my $card_item_relation
        = $self->handle->single( 'card_item_relation', $cond );
    return if !$card_item_relation;

    return $card_item_relation->fetch_card_name;
}

sub fetch_card_group {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my $card_item_relation
        = $self->handle->single( 'card_item_relation', $cond );
    return if !$card_item_relation;

    return $card_item_relation->fetch_card_group;
}

sub fetch_card_contact {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my $card_item_relation
        = $self->handle->single( 'card_item_relation', $cond );
    return if !$card_item_relation;

    return $card_item_relation->fetch_card_contact;
}

sub fetch_card_address {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my $card_item_relation
        = $self->handle->single( 'card_item_relation', $cond );
    return if !$card_item_relation;

    return $card_item_relation->fetch_card_address;
}

sub fetch_card_personal {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my $card_item_relation
        = $self->handle->single( 'card_item_relation', $cond );
    return if !$card_item_relation;

    return $card_item_relation->fetch_card_personal;
}

sub fetch_card_note {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my $card_item_relation
        = $self->handle->single( 'card_item_relation', $cond );
    return if !$card_item_relation;

    return $card_item_relation->fetch_card_note;
}

sub fetch_card_icon {
    my $self = shift;
    my $opt  = shift || +{};
    my $cond = +{
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };
    my $card_item_relation
        = $self->handle->single( 'card_item_relation', $cond );
    return if !$card_item_relation;

    return $card_item_relation->fetch_card_icon;
}


# カード情報の詳細
# my $card_show = +{
#     card          => $card,
#     card_name     => $card_name,
#     card_group    => $card_group,
#     card_contact  => $card_contact,
#     card_address  => $card_address,
#     card_personal => $card_personal,
#     card_note     => $card_note,
#     card_icon     => $card_icon,
# };
sub get_card_show {
    my $self = shift;
    my $opt  = shift || +{};
    my $attr = shift || +{};
    my $cond = +{
        card_id => $self->id,
        deleted => 0,
        %{$opt},
    };

    my $params = +{
        card          => +{},
        card_name     => +{},
        card_group    => +{},
        card_contact  => +{},
        card_address  => +{},
        card_personal => +{},
        card_note     => +{},
        card_icon     => +{},
    };

    $params->{card} = $self->get_columns;

    if ( my $card_name_row = $self->fetch_card_name ) {
        $params->{card_name} = $card_name_row->get_columns;
    }
    if ( my $card_group_row = $self->fetch_card_group ) {
        $params->{card_group} = $card_group_row->get_columns;
    }
    if ( my $card_contact_row = $self->fetch_card_contact ) {
        $params->{card_contact} = $card_contact_row->get_columns;
    }
    if ( my $card_address_row = $self->fetch_card_address ) {
        $params->{card_address} = $card_address_row->get_columns;
    }
    if ( my $card_personal_row = $self->fetch_card_personal ) {
        $params->{card_personal} = $card_personal_row->get_columns;
    }
    if ( my $card_note_row = $self->fetch_card_note ) {
        $params->{card_note} = $card_note_row->get_columns;
    }
    if ( my $card_icon_row = $self->fetch_card_icon ) {
        $params->{card_icon} = $card_icon_row->get_columns;
    }
    return $params;
}

1

__END__
