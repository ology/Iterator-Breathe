package Iterator::Breathe;

# ABSTRACT: Iterate a counter up and back

our $VERSION = '0.0200';

use Carp qw( croak );
use Moo;
use Scalar::Util qw( looks_like_number );

use strictures 2;
use namespace::clean;

=head1 SYNOPSIS

  use Iterator::Breathe;

  my $it = Iterator::Breathe->new(
    top    => 255,
    bottom => -1,
  );

  $it = Iterator::Breathe->new(
    top    => 6.28,
    bottom => -3.14,
    step   => 0.1,
  );

  while ( 1 ) {
    $it->iterate;
    say $it->i;
  }

=head1 DESCRIPTION

C<Iterator::Breathe> increments and decrements an iterator value in a
wave-like fashion.

=head1 ATTRIBUTES

=head2 direction

  $direction = $it->direction;
  $it->direction($dir);

Return or set the current value of C<direction>.

Default: C<1> (1=up, 0=down)

=cut

has direction => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not a boolean" unless $_[0] =~ /^[01]$/ },
    default => sub { 1 },
);

=head2 i

  $i = $it->i;
  $it->i($n);

Return or set the current value of C<i>.

Default: C<0>

=cut

has i => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not a number" unless looks_like_number( $_[0] ) },
    default => sub { 0 },
);

=head2 bottom

  $bottom = $it->bottom;
  $it->bottom($x);

Return or set the current value of C<bottom>.

Default: C<0>

=cut

has bottom => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not a number" unless looks_like_number( $_[0] ) },
    default => sub { 0 },
);

=head2 top

  $top = $it->top;
  $it->top($y);

Return or set the current value of C<top>.

Default: C<100>

=cut

has top => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not a number" unless looks_like_number( $_[0] ) },
    default => sub { 100 },
);

=head2 step

  $step = $it->step;
  $it->step($z);

Return or set the current value of C<step>.

Default: C<1>

=cut

has step => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not a number" unless looks_like_number( $_[0] ) },
    default => sub { 1 },
);

=head2 verbose

  $verbose = $it->verbose;

Show progress.

Default: C<0>

=cut

has verbose => (
    is      => 'ro',
    isa     => sub { croak "$_[0] is not a boolean" unless $_[0] =~ /^[01]$/ },
    default => sub { 0 },
);

=head1 METHODS

=head2 new

  $it = Iterator::Breathe->new( %arguments );

Create a new C<Iterator::Breathe> object.

=head2 iterate

  $i = $it->iterate;

=cut

sub iterate {
  my ($self) = @_;

  print $self->i, "\n" if $self->verbose;

  if ( $self->direction ) {
    if ( $self->i >= $self->top ) {
      $self->i( $self->i - $self->step );
      $self->direction( 0 );
      print "Change direction to down.\n" if $self->verbose;
    }
    else {
      $self->i( $self->i + $self->step );
    }
  }
  else {
    if ( $self->i <= $self->bottom ) {
      $self->i( $self->i + $self->step );
      $self->direction( 1 );
      print "Change direction to up.\n" if $self->verbose;
    }
    else {
      $self->i( $self->i - $self->step );
    }
  }

  return $self->i;
}

1;
__END__

=head1 SEE ALSO

L<Moo>

L<Scalar::Util>

=cut
