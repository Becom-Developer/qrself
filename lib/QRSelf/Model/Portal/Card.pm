package QRSelf::Model::Portal::Card;
use Mojo::Base 'QRSelf::Model::Base';

sub to_template_show {
    my $self     = shift;
    my $template = +{
        card          => +{},
        card_name     => +{},
        card_group    => +{},
        card_contact  => +{},
        card_address  => +{},
        card_personal => +{},
        card_note     => +{},
        card_icon     => +{},
    };
    my $card_id  = $self->req_params->{card_id};
    my $cond     = +{ id => $card_id, deleted => 0 };
    my $card_row = $self->db->teng->single( 'card', $cond );
    return $template if !$card_row;
    $template = $card_row->get_card_show;
    return $template;
}

1;
