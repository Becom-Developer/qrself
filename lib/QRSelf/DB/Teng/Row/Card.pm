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

1

__END__
