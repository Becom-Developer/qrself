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

1;

