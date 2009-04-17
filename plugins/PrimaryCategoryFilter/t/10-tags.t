
use lib qw( t/lib lib extlib );

use strict;
use warnings;

use MT::Test qw( :db :data );
use Test::More qw(no_plan);

require MT::Blog;
my $blog = MT::Blog->load(1);

tmpl_out_like(
    '!!<mt:entries primary_category="foo">[[ <mt:entrytitle> ]]</mt:entries>!!',
    {},
    { blog_id => 1, blog => $blog },
    qr/^\Q!![[ Verse 3 ]]!!\E$/,
    "primary_category with existing category with primary placements"
);

tmpl_out_like(
    '!!<mt:entries primary_category="bar">[[ <mt:entrytitle> ]]</mt:entries>!!',
    {},
    { blog_id => 1, blog => $blog },
    qr/^!!!!$/,
    "primary_category with existing category without primary placements"
);

tmpl_out_like(
'!!<mt:entries primary_category="randomjunk">[[ <mt:entrytitle> ]]</mt:entries>!!',
    {},
    { blog_id => 1, blog => $blog },
    qr/^!!!!$/,
    "primary_category with nonexistant category"
);
