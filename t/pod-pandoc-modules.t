use strict;
use Test::More;
use Pandoc::Elements;
use Pandoc;
use Pod::Simple::Pandoc;
use Pod::Pandoc::Modules;
use Test::Exception;

plan skip_all => 'these tests are for release candidate testing'
  unless $ENV{RELEASE_TESTING};

# TODO: modify to do basic tests without pandoc executable

my $file = 'lib/Pod/Simple/Pandoc.pm';

my $modules = { 
    'Pod::Simple::Pandoc' => Pod::Simple::Pandoc->new->parse_file($file)
};
bless $modules, 'Pod::Pandoc::Modules';

is $modules->index->to_markdown,
   "[Pod::Simple::Pandoc](Pod/Simple/Pandoc.html \"Pod::Simple::Pandoc\")\n",
   'index';

is $modules->index( wiki => 1 )->to_markdown,
   "[Pod::Simple::Pandoc](Pod-Simple-Pandoc \"wikilink\")\n",
   'wiki index';

done_testing;
