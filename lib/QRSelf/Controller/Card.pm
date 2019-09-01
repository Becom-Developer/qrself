package QRSelf::Controller::Card;
use Mojo::Base 'QRSelf::Controller::Base';

sub index {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/index';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    my $model       = $self->model->card->req_params($params);
    my $to_template = $model->to_template_index;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    $self->render();
    return;
}

sub item {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/item';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    my $model       = $self->model->card->req_params($params);
    my $to_template = $model->to_template_item;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    $self->render();
    return;
}

sub create {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/create';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    my $model       = $self->model->card->req_params($params);
    my $to_template = $model->to_template_create;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    $self->render();
    return;
}

sub edit {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/edit';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    $params->{card_id}   = $self->stash->{card_id};
    my $model       = $self->model->card->req_params($params);
    my $master      = $model->db->master;
    my $to_template = $model->to_template_edit;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        format      => 'html',
        handler     => 'ep',
    );
    my $render_params = $to_template->{card};
    $self->render_fillin( $template, $render_params );
    return;
}

sub store {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/create';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    my $model       = $self->model->card->req_params($params);
    my $master      = $model->db->master;
    my $to_template = $model->to_template_create;

    if ( my $store = $model->store ) {
        my $card_id = $store->{card_id};
        $self->flash( msg => $store->{msg} );
        $self->redirect_to("/card/$card_id");
        return;
    }
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        msg         => $master->common->to_word('HAS_ERROR_INPUT'),
        format      => 'html',
        handler     => 'ep',
    );
    $self->render_fillin( $template, $params );
    return;
}

sub update {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/edit';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    $params->{card_id}   = $self->stash->{card_id};
    my $model       = $self->model->card->req_params($params);
    my $master      = $model->db->master;
    my $to_template = $model->to_template_create;

    if ( my $update = $model->update ) {
        my $card_id = $update->{card_id};
        $self->flash( msg => $update->{msg} );
        $self->redirect_to("/card/$card_id");
        return;
    }
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        msg         => $master->common->to_word('HAS_ERROR_INPUT'),
        format      => 'html',
        handler     => 'ep',
    );
    $self->render_fillin( $template, $params );
    return;
}

sub show {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/show';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    $params->{card_id}   = $self->stash->{card_id};
    my $model       = $self->model->card->req_params($params);
    my $to_template = $model->to_template_show;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    $self->render();
    return;
}

sub qr {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/qr';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    $params->{card_id}   = $self->stash->{card_id};
    my $model       = $self->model->card->req_params($params);
    my $to_template = $model->to_template_qr;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    $self->render();
    return;
}

1;

