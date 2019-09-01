package QRSelf::Model::Card;
use Mojo::Base 'QRSelf::Model::Base';
use QRSelf::Model::Card::Name;

has name => sub {
    QRSelf::Model::Card::Name->new( +{ conf => shift->conf } );
};

sub has_error_easy {
    my $self   = shift;
    my $params = $self->req_params;
    my $v      = $self->validation($params);
    $v->required('name');
    return 1 if $v->has_error;
    return;
}

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

sub to_template_item {
    my $self     = shift;
    my $template = +{};
    return $template;
}

sub to_template_create {
    my $self     = shift;
    my $template = +{};
    return $template;
}

sub store {
    my $self   = shift;
    my $master = $self->db->master;
    return if $self->has_error_easy();

    my $txn         = $self->db->teng->txn_scope;
    my $user_id     = $self->req_params->{login_row}->id;
    my $card_params = +{
        user_id     => $user_id,
        name        => $self->req_params->{name},
        qrcode      => '',
        is_standard => 0,
        deleted     => $master->deleted->constant('NOT_DELETED'),
    };
    my $card_id = $self->db->teng_fast_insert( 'card', $card_params );
    my $qrcode  = $self->create_qrcode($card_id);
    my $card_update_params = +{ qrcode => $qrcode, };
    my $card_update_cond   = +{ id => $card_id, };
    my $card_update_id = $self->db->teng_update( 'card', $card_update_params,
        $card_update_cond );
    $txn->commit;
    my $store = +{
        card_id => $card_id,
        msg     => $master->common->to_word('DONE_REGISTER'),
    };
    return $store;
}

sub update {
    my $self   = shift;
    my $master = $self->db->master;
    return if $self->has_error_easy();

    my $txn         = $self->db->teng->txn_scope;
    my $params      = +{ name => $self->req_params->{name}, };
    my $card_id     = $self->req_params->{card_id};
    my $update_cond = +{ id => $card_id, };
    my $update_id   = $self->db->teng_update( 'card', $params, $update_cond );
    $txn->commit;
    my $update = +{
        card_id => $update_id,
        msg     => $master->common->to_word('DONE_UPDATE'),
    };
    return $update;
}

sub to_template_show {
    my $self     = shift;
    my $card_row = $self->db->teng->single( 'card',
        +{ id => $self->req_params->{card_id} } );
    my $template = $card_row->get_card_show;
    return $template;
}

sub to_template_edit {
    my $self     = shift;
    my $card_row = $self->db->teng->single( 'card',
        +{ id => $self->req_params->{card_id} } );
    my $template = $card_row->get_card_show;
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
