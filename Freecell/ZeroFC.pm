package Freecell::ZeroFC;

use strict;
use warnings;
use integer;

sub new
{
    my $class = shift;
    my $arg   = shift;
    my $self  = {};

    bless( $self, $class );
    return $self;
}

use Path::Tiny qw/ cwd path tempdir tempfile /;

if (0)
{
    my $dir = tempdir();

    my $fh = $dir->child("foo.txt");
}

sub _key
{
    my ( $self, $deal_idx ) = @_;
    my $ret = int( $deal_idx / 100_000_000 );
    return $ret;
}

sub _reached_deal
{
    my ( $self, $logs_dir_paths, ) = @_;

    my $ret_deal = -1;
    foreach my $path (@$logs_dir_paths)
    {
        my $dh       = path($path);
        my @children = $dh->children();

        foreach my $fh (@children)
        {
            my $bn = $fh->basename();
            if ( my ($idx) =
                ( $bn =~ m#\Adepth-dbm-freecell.*?ms([0-9]+)-#ms ) )
            {
                if ( $idx > $ret_deal )
                {
                    $ret_deal = $idx;
                }
            }
        }
    }

    return $ret_deal;
}

sub _next_deal
{
    my ( $self, $lists_dirpath, $reached_deal, ) = @_;

    if ( not( $reached_deal > 0 ) )
    {
        Carp::confess("reached_deal is invalid");
    }

    my $ret_deal = -1;
    foreach my $fh ( sort { $a->basename() cmp $b->basename() }
        path($lists_dirpath)->child('./0fc-logs/')->children(qr/\.log\.txt\z/) )
    {
        my @lines = $fh->lines_utf8();
        foreach my $l (@lines)
        {
            if ( my ($n) = $l =~ /\AInt\t([0-9]+)\n\z/ )
            {
                if ( $n > $reached_deal )
                {
                    return $n;
                }
            }
        }
    }

    Carp::confess("error");
}

if ( ( my $mode = delete( $ENV{MODE} ) ) eq "nextdeal" )
{
    my $self    = Freecell::ZeroFC->new();
    my $dirname = $ENV{FREECELL_ZEROFC_LOGS_DIR}
        or Carp::confess("no FREECELL_ZEROFC_LOGS_DIR");
    my $reached_deal = $self->_reached_deal( [ path($dirname) ] );
    print $self->_next_deal( ".", $reached_deal, );
}

1;

__END__

# # Below is stub documentation for your module. You'd better edit it!
