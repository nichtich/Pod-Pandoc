package Pod::Pandoc::Web;
use strict;
use 5.010;

use Pod::Simple::Pandoc;
use Pod::Perldoc;
use Pandoc;
use Pandoc::Elements;
use parent 'Exporter';

our @EXPORT = qw(web);

sub web(@) {
    Pod::Pandoc::Web->new(@_)->to_app;
}

sub new {
    my $class = shift;

    pandoc->arguments( qw(-t html --toc -s), @_ );

    bless {
        # TODO: support setting option 'parse'
        parser => Pod::Simple::Pandoc->new( podurl => './', parse => ['html'] ),
    }, $class;
}

sub _perldoc_file {
    state %cache;
    $cache{ $_[0] } //= do {

        my $null;    # avoid printing to STDERR
        open local (*STDERR), '>', \$null;
        my ($file) = Pod::Perldoc->new->grand_search_init( [ $_[0] ] );

        $file // 0;
      }
}

sub _perldoc {
    my ( $self, $env ) = @_;
    my $name = substr $env->{PATH_INFO}, 1;

    if ( $name eq '' ) {
        my $url = $env->{REQUEST_URI};
        $url .= ( $url =~ qr{/$} ? '' : '/' ) . 'Pod::Pandoc';

        return Document {
            title  => 'Perl module documentation',
            status => 302
          },
          [
            Para [ Str 'Please append a Perl module name to the base URL!' ],
            Para [
                Strong [ Str 'Example:' ],
                Space,
                Link attributes {},
                [ Str $url ],
                [ $url, '' ],
            ]
          ];
    }

    if ( $name =~ qr/^[_a-z][0-9_a-z]*(?:::[0-9_a-z]+)*$/i ) {
        my $file = _perldoc_file($name);
        if ($file) {
            my $doc = $self->{parser}->parse_file($file);

            # Link to MetaCPAN if not found locally
            $doc->transform(
                'Link.perl-module' => sub {
                    if ( $_->url =~ qr{^\./([^#]+)(\#.*)?}
                        && !_perldoc_file($1) )
                    {
                        my $url = "https://metacpan.org/pod/$1" . ( $2 // '' );
                        [ Link $_->attr, $_->content, [ $url, $_->title ] ];
                    }
                    else {
                        undef;
                    }
                }
            );

            return $doc;
        }
    }

    Document {
        title  => 'Module not Found!',
        status => 404,
      },
      [
        Para [
            Str('No Perl module named '),
            Code( attributes {}, $name ),
            Str ' was found!'
        ]
      ];
}

sub to_app {
    my ($self) = @_;
    sub {
        my $doc = $self->_perldoc(@_);

        # TODO: add footer with include_after

        # TODO: catch error from to_pandoc and return customized 500 then
        # TODO: set encoding to UTF-8 (e.g. Markdown)
        [ $doc->meta->value('status') // 200, [], [ $doc->to_pandoc ] ];
      }
}

1;

=head1 NAME

Pod::Pandoc::Web - PSGI application that serves Perl module documentation

=head1 SYNOPSIS

  # serve modules in lib/ and @INC, restart on changes in lib
  plackup -r -Ilib -MPod::Pandoc::Web -e web

  # serve modules in @INC with Pandoc HTML template
  plackup -MPod::Pandoc::Web -e 'web("--template=template.html")'

=head1 DESCRIPTION

This L<PSGI> application implements HTML browsing through Perl module
documentation. HTML pages are created with L<Pod::Simple::Pandoc>. Arguments
passed to the constructor are passed to L<Pandoc> for each page:

  my $app = Pod::Pandoc::Web->new( ... );
  
The default HTML template is rather ugly so better download an L<Pandoc HTML
template|https://github.com/jgm/pandoc/wiki/User-contributed-templates#html>!

=head1 FUNCTIONS

=head2 web

This utility function to create a new instance and return it as L<PSGI>
compatible code reference is exported by default.

=head1 SEE ALSO

See L<Pod::POM::Web> for a more elaborate web application for browsing locally
installed Perl modules. Other Perl documentation servers include
L<Pod::Webserver>, L<Pod::Server>, and L<Pod::Browser>.

=cut
