package QRSelf::Model::Card;
use Mojo::Base 'QRSelf::Model::Base';

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

1;
