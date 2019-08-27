package QRSelf::DB;
use Mojo::Base 'QRSelf::DB::Base';
use QRSelf::DB::Master;

has master => sub { QRSelf::DB::Master->new(); };

1;
