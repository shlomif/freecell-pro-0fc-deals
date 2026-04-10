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

1;

__END__

# # Below is stub documentation for your module. You'd better edit it!
