package QRSelf::Model::Card::Name;
use Mojo::Base 'QRSelf::Model::Base';

sub has_error_easy {
    my $self   = shift;
    my $params = $self->req_params;
    my $v      = $self->validation($params);
    $v->required('name');
    return 1 if $v->has_error;
    return;
}

sub to_template_create {
    my $self     = shift;
    my $template = +{ card_id => $self->req_params->{card_id} };
    return $template;
}

sub to_template_show {
    my $self = shift;
    my $row  = $self->db->teng->single( 'card_name',
        +{ id => $self->req_params->{card_name_id} } );
    my $template = +{ card_name => +{} };

    return $template if !$row;

    $template->{card_name} = $row->get_columns;

    return $template;
}

sub to_template_edit {
    my $self     = shift;
    my $template = $self->to_template_show;
    return $template;
}

sub store {
    my $self   = shift;
    my $master = $self->db->master;
    return if $self->has_error_easy();

    my $txn     = $self->db->teng->txn_scope;
    my $user_id = $self->req_params->{login_row}->id;
    my $params  = +{
        user_id  => $user_id,
        name     => $self->req_params->{name} || '',
        rubi     => $self->req_params->{rubi} || '',
        nickname => $self->req_params->{nickname} || '',
        deleted  => $master->deleted->constant('NOT_DELETED'),
    };
    my $insert_id = $self->db->teng_fast_insert( 'card_name', $params );

    $txn->commit;
    my $store = +{
        card_name_id => $insert_id,
        msg          => $master->common->to_word('DONE_REGISTER'),
    };
    return $store;
}

sub update {
    my $self   = shift;
    my $master = $self->db->master;
    return if $self->has_error_easy();

    my $txn          = $self->db->teng->txn_scope;
    my $params       = +{ %{ $self->req_params }, };
    my $card_name_id = delete $params->{card_name_id};
    delete $params->{login_row};
    my $update_cond = +{ id => $card_name_id, };
    my $update_id
        = $self->db->teng_update( 'card_name', $params, $update_cond );
    $txn->commit;
    my $update = +{
        card_name => $update_id,
        msg       => $master->common->to_word('DONE_UPDATE'),
    };
    return $update;
}

1;
