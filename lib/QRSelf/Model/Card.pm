package QRSelf::Model::Card;
use Mojo::Base 'QRSelf::Model::Base';

sub to_template_index {
    my $self      = shift;
    my $template  = +{ user => +{}, limitation => +{}, cards => [], };
    my $login_row = $self->req_params->{login_row};
    $template->{user}       = $login_row->get_columns;
    $template->{limitation} = $login_row->fetch_limitation->get_columns;
    my $card_rows = $login_row->search_card;
    return $template if !$card_rows;

    for my $card_row ( @{$card_rows} ) {
        push @{ $template->{cards} }, $card_row->get_columns;
    }
    return $template;
}

sub to_template_show {
    my $self      = shift;
    my $login_row = $self->req_params->{login_row};
    my $template  = $login_row->get_card_show;
    return $template;
}

sub to_template_qr {
    my $self     = shift;
    my $template = +{ card => +{}, };
    my $card_id  = $self->req_params->{card_id};
    my $cond     = +{ id => $card_id, deleted => 0 };
    my $card_row = $self->db->teng->single( 'card', $cond );
    return $template if !$card_row;
    $template->{card} = $card_row->get_columns;
    return $template;
}

1;

__END__

該当のユーザーのカード情報一覧
my $card_index = +{
    user       => $user,
    limitation => $limitation,
    cards      => [ $card, ],
};

カード情報の詳細
my $card_show = +{
    user          => $user,
    limitation    => $limitation,
    card          => $card,
    card_name     => $card_name,
    card_group    => $card_group,
    card_contact  => $card_contact,
    card_address  => $card_address,
    card_personal => $card_personal,
    card_note     => $card_note,
    card_icon     => $card_icon,
};
