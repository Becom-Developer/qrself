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
    my $opt  = shift || +{};
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

# 該当のユーザーのカード情報一覧
# my $card_index = +{
#     user       => $user,
#     limitation => $limitation,
#     cards      => [ $card, ],
# };
sub get_card_index {
    my $self = shift;
    my $opt  = shift || +{};
    my $attr = shift || +{};
    my $cond = +{
        user_id => $self->id,
        deleted => 0,
        %{$opt},
    };

    my $params = +{
        user       => +{},
        limitation => +{},
        cards      => [],
    };
    $params->{user}       = $self->get_columns;
    $params->{limitation} = $self->fetch_limitation->get_columns;
    my $card_rows = $self->search_card( $cond, $attr );
    return $params if !$card_rows;

    for my $card_row ( @{$card_rows} ) {
        push @{ $params->{cards} }, $card_row->get_columns;
    }
    return $params;
}

# カード情報の詳細
# my $card_show = +{
#     user          => $user,
#     limitation    => $limitation,
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
        user_id => $self->id,
        deleted => 0,
        %{$opt},
    };

    my $params = +{
        user          => +{},
        limitation    => +{},
        card          => +{},
        card_name     => +{},
        card_group    => +{},
        card_contact  => +{},
        card_address  => +{},
        card_personal => +{},
        card_note     => +{},
        card_icon     => +{},
    };
    $params->{user}       = $self->get_columns;
    $params->{limitation} = $self->fetch_limitation->get_columns;
    my $card_rows = $self->search_card( $cond, $attr );
    return $params if !$card_rows;

    my $card_row = shift @{$card_rows};

    $params->{card} = $card_row->get_columns;

    if ( my $card_name_row = $card_row->fetch_card_name ) {
        $params->{card_name} = $card_name_row->get_columns;
    }
    if ( my $card_group_row = $card_row->fetch_card_group ) {
        $params->{card_group} = $card_group_row->get_columns;
    }
    if ( my $card_contact_row = $card_row->fetch_card_contact ) {
        $params->{card_contact} = $card_contact_row->get_columns;
    }
    if ( my $card_address_row = $card_row->fetch_card_address ) {
        $params->{card_address} = $card_address_row->get_columns;
    }
    if ( my $card_personal_row = $card_row->fetch_card_personal ) {
        $params->{card_personal} = $card_personal_row->get_columns;
    }
    if ( my $card_note_row = $card_row->fetch_card_note ) {
        $params->{card_note} = $card_note_row->get_columns;
    }
    if ( my $card_icon_row = $card_row->fetch_card_icon ) {
        $params->{card_icon} = $card_icon_row->get_columns;
    }
    return $params;
}

1

__END__
