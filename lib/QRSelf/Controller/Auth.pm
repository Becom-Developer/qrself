package QRSelf::Controller::Auth;
use Mojo::Base 'QRSelf::Controller::Base';

sub create {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'auth/create';
    $self->stash(
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    $self->render();
    return;
}

sub store {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $params      = $self->req->params->to_hash;
    my $model       = $self->model->auth->req_params($params);
    my $master      = $model->db->master;
    my $template    = 'auth/create';
    $self->stash(
        public_path => $public_path,
        msg         => $master->common->to_word('HAS_ERROR_INPUT'),
        format      => 'html',
        handler     => 'ep',
    );
    if ( my $store = $model->store ) {
        $self->session( user => $params->{login_id} );
        $self->flash( msg => $store->{msg} );
        $self->redirect_to("/");
        return;
    }
    $self->render_fillin( $template, $params );
    return;
}

1;
