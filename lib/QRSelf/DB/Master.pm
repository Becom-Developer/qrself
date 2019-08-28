package QRSelf::DB::Master;
use Mojo::Base -base;

has [qw{master_hash master_constant_hash}];

sub common {
    my $self = shift;
    my $hash = +{
        100 => '登録しました',
        110 => '登録できませんでした',
        120 => '登録済みです',
        200 => '更新しました',
        210 => '更新できませんでした',
        220 => '更新済みです',
        300 => '削除しました',
        310 => '削除できませんでした',
        320 => '削除済みです',
        400 => '有効な値を入力してください',
        500 => '処理を実行しました',
        510 => '処理をできませんでした',
        520 => '処理済みです',
        600 => 'ログインしました',
        610 => 'ログインできません',
        620 => 'ログイン済みです',
        700 => 'ログアウトしました',
        710 => 'ログアウトできません',
        720 => 'ログアウト済みです',
    };

    my $constant = +{
        DONE_REGISTER   => 100,
        NOT_REGISTER    => 110,
        REGISTERED      => 120,
        DONE_UPDATE     => 200,
        NOT_UPDATE      => 210,
        UPDATED         => 220,
        DONE_DELETE     => 300,
        NOT_DELETE      => 310,
        DELETED         => 320,
        HAS_ERROR_INPUT => 400,
        DONE_PROC       => 500,
        NOT_PROC        => 510,
        PROCESSED       => 520,
        DONE_LOGIN      => 600,
        NOT_LOGIN       => 610,
        LOGGED_IN       => 620,
        DONE_LOGOUT     => 700,
        NOT_LOGOUT      => 710,
        LOGGED_OUT      => 720,
    };

    $self->master_hash($hash);
    $self->master_constant_hash($constant);
    return $self;
}

sub limitation {
    my $self = shift;
    my $hash = +{
        100 => 'システム管理者',
        200 => '一般',
    };

    my $constant = +{
        ROOT    => 100,
        GENERAL => 200,
    };

    $self->master_hash($hash);
    $self->master_constant_hash($constant);
    return $self;
}

sub approved {
    my $self = shift;
    my $hash = +{
        0 => '承認していない',
        1 => '承認済み',
    };

    my $constant = +{
        NOT_APPROVED => 0,
        APPROVED     => 1,
    };

    $self->master_hash($hash);
    $self->master_constant_hash($constant);
    return $self;
}

sub deleted {
    my $self = shift;
    my $hash = +{
        0 => 'not_deleted',
        1 => 'deleted',
    };

    my $constant = +{
        NOT_DELETED => 0,
        DELETED     => 1,
    };

    $self->master_hash($hash);
    $self->master_constant_hash($constant);
    return $self;
}

# my $word = 'deleted';
# my $deleted_id = $master->deleted->word_id($word);
sub word_id {
    my $self = shift;
    my $word = shift;
    my $word_id;
    while ( my ( $key, $val ) = each %{ $self->master_hash } ) {
        $word_id = $key;
        return $word_id if $val eq $word;
    }
    die 'error master methode word_id: ';
}

# my $word_id = 5;
# my $deleted_word = $master->deleted->word($word_id);
sub word {
    my $self    = shift;
    my $word_id = shift;
    my $word    = $self->master_hash->{$word_id};
    die 'error master methode word: ' if !defined $word;
    return $word;
}

# my $label = 'DELETED';
# my $deleted_word = $master->deleted->to_word($label);
sub to_word {
    my $self     = shift;
    my $label    = shift;
    my $constant = $self->master_constant_hash->{$label};
    die 'error master methode constant: ' if !defined $constant;
    my $word = $self->master_hash->{$constant};
    die 'error master methode word: ' if !defined $word;
    return $word;
}

# my $label = 'DELETED';
# my $deleted_constant = $master->deleted->constant($label);
sub constant {
    my $self     = shift;
    my $label    = shift;
    my $constant = $self->master_constant_hash->{$label};
    die 'error master methode constant: ' if !defined $constant;
    return $constant;
}

# my $constant = 5;
# my $deleted_label = $master->deleted->label($constant);
sub label {
    my $self     = shift;
    my $constant = shift;
    my $label;
    while ( my ( $key, $val ) = each %{ $self->master_constant_hash } ) {
        $label = $key;
        return $label if $val eq $constant;
    }
    die 'error master methode constant: ';
}

# +{  0 => 'not_deleted',
#     1 => 'deleted',
# };
# my $deleted_to_hash = $master->deleted->to_hash;
sub to_hash {
    my $self = shift;
    my $hash = $self->master_hash;
    my @keys = keys %{$hash};
    die 'error master methode to_hash: ' if !scalar @keys;
    return $hash;
}

# [ 0, 1 ];
# my $deleted_to_ids = $master->deleted->to_ids;
sub to_ids {
    my $self = shift;
    my $hash = $self->master_hash;
    my @keys = keys %{$hash};
    die 'error master methode to_ids: ' if !scalar @keys;
    my @sort_keys = sort { $a <=> $b } @keys;
    return \@sort_keys;
}

# [
#     +{ id => 0, name => 'not_deleted', },
#     +{ id => 1, name => 'deleted', },
# ]
# my $deleted_sort_to_hash = $master->deleted->sort_to_hash;
sub sort_to_hash {
    my $self = shift;
    my $hash = $self->master_hash;
    my @keys = keys %{$hash};
    die 'error master methode sort_to_hash: ' if !scalar @keys;
    my @sort_keys = sort { $a <=> $b } @keys;
    my $sort_hash;
    for my $key (@sort_keys) {
        push @{$sort_hash}, +{ id => $key, name => $hash->{$key} };
    }
    return $sort_hash;
}

1;
