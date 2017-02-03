use strict;
use Test::More;
use Pandoc::Elements;
use Pandoc;
use Pod::Simple::Pandoc;
use Pod::Pandoc::Modules;
use Test::Exception;

my $modules = Pod::Pandoc::Modules->new({ 
    'Pod::Simple::Pandoc' => Pod::Simple::Pandoc->new->parse_file('lib/Pod/Simple/Pandoc.pm') 
});

sub is_index {
    my ( $name, $opt, $meta, $url, $title ) = @_;

    is_deeply $modules->index(%$opt),
      Document( $meta, [
            DefinitionList [ [
                [
                    Link attributes {},
                    [ Str 'Pod::Simple::Pandoc' ],
                    [ $url, $title ]
                ],
                [ [ Plain [ Str 'convert Pod to Pandoc document model' ] ] ]
            ] ]
        ]), $name;
}

is_index(
    'index (default)',
    {}, {},
    'Pod/Simple/Pandoc.html', 'Pod::Simple::Pandoc'
);

is_index(
    'index (wiki & title)',
    { wiki => 1, title => 'test' }, { title => MetaString 'test' },
    'Pod-Simple-Pandoc', 'wikilink'
);

$modules = Pod::Simple::Pandoc->parse_modules('t/examples');
is $modules->{Empty}->metavalue('title'), 'Empty', 'title without NAME';

done_testing;
