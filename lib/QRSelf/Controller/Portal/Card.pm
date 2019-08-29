package QRSelf::Controller::Portal::Card;
use Mojo::Base 'QRSelf::Controller::Base';

sub show {
    my $self        = shift;
    my $public_path = $self->config->{public_path}->{macbeath};
    my $template    = 'portal/card/show';
    my $params      = $self->req->params->to_hash;
    $params->{card_id} = $self->stash->{card_id};
    my $model       = $self->model->portal->card->req_params($params);
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

1;
