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
    if ( my $store = $model->store ) {
        $self->session( user => $params->{login_id} );
        $self->flash( msg => $store->{msg} );
        $self->redirect_to("/");
        return;
    }
    $self->stash(
        public_path => $public_path,
        msg         => $master->common->to_word('HAS_ERROR_INPUT'),
        format      => 'html',
        handler     => 'ep',
    );
    $self->render_fillin( $template, $params );
    return;
}

sub login {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $params      = $self->req->params->to_hash;
    my $model       = $self->model->auth->req_params($params);
    my $master      = $model->db->master;
    my $template    = 'auth/login';
    $self->stash(
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    if ( $self->req->method eq 'GET' ) {
        $self->render();
        return;
    }
    if ( my $login = $model->login ) {
        $self->session( user => $params->{login_id} );
        $self->flash( msg => $login->{msg} );
        $self->redirect_to('/');
        return;
    }
    $self->stash( msg => $master->common->to_word('NOT_LOGIN') );
    $self->render_fillin( $template, $params );
    return;
}

sub logout {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    if ( $self->req->method eq 'POST' ) {
        $self->session( expires => 1 );
        $self->redirect_to('/auth/logout');
        return;
    }
    my $master = $self->model->auth->db->master;
    $self->render(
        public_path => $public_path,
        msg         => $master->common->to_word('DONE_LOGOUT'),
        template    => 'auth/logout',
        format      => 'html',
        handler     => 'ep',
    );
    return;
}

1;
