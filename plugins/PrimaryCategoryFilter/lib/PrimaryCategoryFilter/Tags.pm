
package PrimaryCategoryFilter::Tags;

use strict;
use warnings;

sub primary_category_filter {
    my ( $ctx, $args, $cond ) = @_;

    my $cat_arg = $args->{primary_category} or return;
    my $blog_ids = $ctx->{terms}->{blog_id};

    require MT::Category;
    my @cats = MT::Category->load(
        { ( $blog_ids ? ( blog_id => $blog_ids ) : () ), label => $cat_arg },
        { fetchonly => ['id'] } );

    unless (@cats) {
        # can't find a category
        # can't raise an error
        # so we'll force all entries to not pass the filter
        push @{$ctx->{filters}}, sub { 0 };
        return;
    }

    require MT::Placement;
    $ctx->{args}->{join} =
      MT::Placement->join_on( 'entry_id',
        { category_id => [ map { $_->id } @cats ], is_primary => 1 } );
}

1;
