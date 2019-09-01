package QRSelf::Controller::Card::Name;
use Mojo::Base 'QRSelf::Controller::Base';

sub create {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/name/create';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    my $model       = $self->model->card->name->req_params($params);
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

sub show {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/name/show';
    my $params      = $self->req->params->to_hash;
    $params->{login_row}    = $self->login_user;
    $params->{card_name_id} = $self->stash->{card_name_id};
    my $model       = $self->model->card->name->req_params($params);
    my $to_template = $model->to_template_show;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        template    => $template,
        format      => 'html',
        handler     => 'ep',
    );
    my $render_params = $to_template->{card_name};
    $self->render_fillin( $template, $render_params );
    return;
}

sub edit {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/name/edit';
    my $params      = $self->req->params->to_hash;
    $params->{login_row}    = $self->login_user;
    $params->{card_name_id} = $self->stash->{card_name_id};
    my $model       = $self->model->card->name->req_params($params);
    my $master      = $model->db->master;
    my $to_template = $model->to_template_edit;
    $self->stash(
        %{$to_template},
        public_path => $public_path,
        format      => 'html',
        handler     => 'ep',
    );
    my $render_params = $to_template->{card_name};
    $self->render_fillin( $template, $render_params );
    return;
}

sub store {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'card/name/create';
    my $params      = $self->req->params->to_hash;
    $params->{login_row} = $self->login_user;
    my $model       = $self->model->card->name->req_params($params);
    my $master      = $model->db->master;
    my $to_template = $model->to_template_create;

    if ( my $store = $model->store ) {
        my $card_name_id = $store->{card_name_id};
        $self->flash( msg => $store->{msg} );
        $self->redirect_to("/card/name/$card_name_id");
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
    my $template    = 'card/name/edit';
    my $params      = $self->req->params->to_hash;
    $params->{login_row}    = $self->login_user;
    $params->{card_name_id} = $self->stash->{card_name_id};
    my $model       = $self->model->card->name->req_params($params);
    my $master      = $model->db->master;
    my $to_template = $model->to_template_create;

    if ( my $update = $model->update ) {
        my $card_name_id = $update->{card_name_id};
        $self->flash( msg => $update->{msg} );
        $self->redirect_to("/card/name/$card_name_id");
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

1;
