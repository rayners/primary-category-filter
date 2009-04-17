
use lib qw( t/lib lib extlib );

use strict;
use warnings;

use MT::Test;
use Test::More tests => 2;

require MT;
ok(
    MT->component('primarycategoryfilter'),
    "Primary Category Filter plugin loaded"
);
require_ok('PrimaryCategoryFilter::Tags');

1;
