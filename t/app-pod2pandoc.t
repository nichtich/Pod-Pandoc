use strict;
use Test::More;
use App::pod2pandoc;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Test::Output qw(:functions);
use File::stat;

plan skip_all => 'these tests are for release candidate testing'
  unless $ENV{RELEASE_TESTING};

my $dir = tempdir(CLEANUP => 1);
my $target = catfile($dir, 'Pandoc-Elements.html');
sub slurp { local (@ARGV, $/) = @_; <> }


# convert a single file
my @source = 'lib/Pod/Pandoc.pm';
pod2pandoc( \@source, -o => $target, '--template' => 't/template.html' );

is slurp($target),
    "Pod::Pandoc: process Plain Old Documentation format with Pandoc\n".
    ": lib/Pod/Pandoc.pm\n",
    "pod2pandoc single file";


# convert multiple files
unshift @source, 'lib/App/pod2pandoc.pm';
pod2pandoc( \@source, -o => $target, '--template' => 't/template.html' );

is slurp($target), 
    "App::pod2pandoc: implements pod2pandoc command line script\n".
    ": lib/App/pod2pandoc.pm, lib/Pod/Pandoc.pm\n", 
    "pod2pandoc multiple files";

#my $mtime = stat($target)->[9];

# convert directory

my ($stdout, $stderr) = output_from {
    pod2pandoc( ['lib/', 'script', 't', $dir], 
                {'ext' => 'md', wiki => 1, update => 1} );
};
note $stdout;
is( (scalar split "\n", $stdout), 6, 'pod2pandoc directory');
is $stderr, "no .pm, .pod or Perl script found in t\n", 'warning';

ok -e catfile($dir, 'Pod-Simple-Pandoc.md'), 'option wiki';

# TODO: test passes although not implemented
#is stat($target)->[9], $mtime, 'option update';

done_testing;
