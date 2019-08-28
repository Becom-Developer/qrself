package QRSelf::Model::Auth;
use Mojo::Base 'QRSelf::Model::Base';
use Mojo::Util qw{dumper};

sub has_error_easy {
    my $self   = shift;
    my $params = $self->req_params;
    my $v      = $self->validation($params);
    $v->required('login_id')->like(qr/^[0-9]+$/)->size( 9, 11 );
    return 1 if $v->has_error;
    return;
}

sub store {
    my $self   = shift;
    my $master = $self->db->master;
    return if $self->has_error_easy();

    my $user_params = +{
        login_id => $self->req_params->{login_id},
        password => $self->req_params->{login_id},
        approved => $master->approved->constant('APPROVED'),
        deleted  => $master->deleted->constant('NOT_DELETED'),
    };
    my $txn     = $self->db->teng->txn_scope;
    my $user_id = $self->db->teng_fast_insert( 'user', $user_params );
    my $limitation_params = +{
        user_id => $user_id,
        status  => $master->limitation->constant('GENERAL'),
        deleted => $master->deleted->constant('NOT_DELETED'),
    };
    my $limitation_id
        = $self->db->teng_fast_insert( 'limitation', $limitation_params );
    my $card_params = +{
        user_id     => $user_id,
        name        => 'standard',
        qrcord      => '',
        is_standard => 1,
        deleted     => $master->deleted->constant('NOT_DELETED'),
    };
    my $card_id = $self->db->teng_fast_insert( 'card', $card_params );
    $txn->commit;
    my $store = +{
        user_id => $user_id,
        msg     => $master->common->to_word('DONE_REGISTER'),
    };
    return $store;
}

1;
