package BlogVillain::Post;

use strict;
use warnings;
use Data::Dumper;
use Pod::Simple::HTML;
use HTML::TreeBuilder;
use Mojo::DOM::HTML;
use Sub::Override;

my %langs = (
    C => 'c',
    Java => 'java',
    Perl => 'perl',
    Bash => 'bash',
);

sub new {
	my ($class, $self) = @_;
	bless $self, $class;
}

sub validate {
	my $self = shift;
	$self->makehtml() unless defined $self->{html};
	if ( ! defined $self->{errors_seen} ) {
		return 1;
	} else {
		return 0;
	}
}

sub makehtml {
	my $self = shift;

    my $category = $self->{category};
    my $lang = 'none';
    $lang = $langs{$category} if defined $langs{$category};
    my $class_attr = 'language-'.$lang;

    # my $lang = 'language-'.$langs{$self->{category}};
    # 문서에 나오는 
    # $Pod::Simple::HTML::Computerese =  ' class="some_class_name';
    # 설정은 잘못된 것.
    # 모듈이 로드되면서 Tagmap의 값이 설정되어버림.
    local $Pod::Simple::HTML::Tagmap{VerbatimFormatted} = qq{\n<pre><code class="$lang">};
    #local $Pod::Simple::HTML::Tagmap{VerbatimFormatted} = qq{\n<pre><code class="$class_attr">};
    local $Pod::Simple::HTML::Tagmap{'/VerbatimFormatted'} = qq{</code></pre>};
	my $p = Pod::Simple::HTML->new;
	$p->index(1);
	$p->output_string(\my $html);
	$p->parse_string_document($self->{pod});
	$self->{errors_seen} = $p->{errors_seen};
	$self->{all_errata} = $p->{all_errata} if defined $self->{errors_seen};
	$self->{html} = HTML::TreeBuilder->new_from_content($html);
}

sub make_idx_and_content {
	my $self = shift;
	$self->makehtml() unless defined $self->{html};
	$self->{index} = $self->{html}->look_down(_tag=>'div', class=>'indexgroup');
	$self->{index}->detach if defined $self->{index};
	$self->{content} = $self->{html}->look_down(_tag=>'body')->content;
}

1;

package Pod::Simple::HTML;

sub new_do_middle_main_loop {
  my $self = $_[0];
  my $fh = $self->{'output_fh'};
  my $tagmap = $self->{'Tagmap'};

  $self->__adjust_html_h_levels;

  my($token, $type, $tagname, $linkto, $linktype);
  my @stack;
  my $dont_wrap = 0;

  while($token = $self->get_token) {

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    if( ($type = $token->type) eq 'start' ) {
      if(($tagname = $token->tagname) eq 'L') {
        $linktype = $token->attr('type') || 'insane';

        $linkto = $self->do_link($token);

        if(defined $linkto and length $linkto) {
          esc($linkto);
            #   (Yes, SGML-escaping applies on top of %-escaping!
            #   But it's rarely noticeable in practice.)
          print $fh qq{<a target=_blank href="$linkto" class="podlink$linktype"\n>};
        } else {
          print $fh "<a>"; # Yes, an 'a' element with no attributes!
        }

      } elsif ($tagname eq 'item-text' or $tagname =~ m/^head\d$/s) {
        print $fh $tagmap->{$tagname} || next;

        my @to_unget;
        while(1) {
          push @to_unget, $self->get_token;
          last if $to_unget[-1]->is_end
              and $to_unget[-1]->tagname eq $tagname;

          # TODO: support for X<...>'s found in here?  (maybe hack into linearize_tokens)
        }

        my $name = $self->linearize_tokens(@to_unget);
        $name = $self->do_section($name, $token) if defined $name;

        print $fh "<a ";
        if ($tagname =~ m/^head\d$/s) {
            print $fh "class='u'", $self->index
                ? " href='#___top' title='click to go to top of document'\n"
                : "\n";
        }

        if(defined $name) {
          my $esc = esc(  $self->section_name_tidy( $name ) );
          print $fh qq[name="$esc"];
          DEBUG and print STDERR "Linearized ", scalar(@to_unget),
           " tokens as \"$name\".\n";
          push @{ $self->{'PSHTML_index_points'} }, [$tagname, $name]
           if $ToIndex{ $tagname };
            # Obviously, this discards all formatting codes (saving
            #  just their content), but ahwell.

        } else {  # ludicrously long, so nevermind
          DEBUG and print STDERR "Linearized ", scalar(@to_unget),
           " tokens, but it was too long, so nevermind.\n";
        }
        print $fh "\n>";
        $self->unget_token(@to_unget);

      } elsif ($tagname eq 'Data') {
        my $next = $self->get_token;
        next unless defined $next;
        unless( $next->type eq 'text' ) {
          $self->unget_token($next);
          next;
        }
        DEBUG and print STDERR "    raw text ", $next->text, "\n";
        # The parser sometimes preserves newlines and sometimes doesn't!
        (my $text = $next->text) =~ s/\n\z//;
        print $fh $text, "\n";
        next;

      } else {
        if( $tagname =~ m/^over-/s ) {
          push @stack, '';
        } elsif( $tagname =~ m/^item-/s and @stack and $stack[-1] ) {
          print $fh $stack[-1];
          $stack[-1] = '';
        }
        print $fh $tagmap->{$tagname} || next;
        ++$dont_wrap if $tagname eq 'Verbatim' or $tagname eq "VerbatimFormatted"
          or $tagname eq 'X';
      }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    } elsif( $type eq 'end' ) {
      if( ($tagname = $token->tagname) =~ m/^over-/s ) {
        if( my $end = pop @stack ) {
          print $fh $end;
        }
      } elsif( $tagname =~ m/^item-/s and @stack) {
        $stack[-1] = $tagmap->{"/$tagname"};
        if( $tagname eq 'item-text' and defined(my $next = $self->get_token) ) {
          $self->unget_token($next);
          if( $next->type eq 'start' ) {
            print $fh $tagmap->{"/item-text"},$tagmap->{"item-body"};
            $stack[-1] = $tagmap->{"/item-body"};
          }
        }
        next;
      }
      print $fh $tagmap->{"/$tagname"} || next;
      --$dont_wrap if $tagname eq 'Verbatim' or $tagname eq 'X';

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    } elsif( $type eq 'text' ) {
      esc($type = $token->text);  # reuse $type, why not
      $type =~ s/([\?\!\"\'\.\,]) /$1\n/g unless $dont_wrap;
      print $fh $type;
    }

  }
  return 1;
}

our $override;
$override = Sub::Override->new(
                _do_middle_main_loop => \&new_do_middle_main_loop
            ) unless defined $override;


1;
