package Iterator::Breathe;

# ABSTRACT: Iterate a counter up and back

our $VERSION = '0.0100';

use Carp qw(croak);
use Moo;
use strictures 2;
use namespace::clean;

=head1 SYNOPSIS

  use Iterator::Breathe;

  my $iter = Iterator::Breathe->new(verbose => 1);

=head1 DESCRIPTION

C<Iterator::Breathe> increments and decrements an iterator value in a
wave-like fashion.

=head1 ATTRIBUTES

=head2 direction

  $direction = $iter->direction;

Return the current value of C<direction>.

Default: C<1>

=cut

has direction => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not a boolean" unless $_[0] =~ /^[01]$/ },
    default => sub { 1 },
);

=head2 i

  $i = $iter->i;

Return the current value of C<i>.

Default: C<0>

=cut

has i => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not an integer" unless $_[0] =~ /^\d+$/ },
    default => sub { 0 },
);

=head2 bottom

  $bottom = $iter->bottom;

Return the current value of C<bottom>.

Default: C<0>

=cut

has bottom => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not an integer" unless $_[0] =~ /^\d+$/ },
    default => sub { 0 },
);

=head2 top

  $top = $iter->top;

Return the current value of C<top>.

Default: C<100>

=cut

has top => (
    is      => 'rw',
    isa     => sub { croak "$_[0] is not an integer" unless $_[0] =~ /^\d+$/ },
    default => sub { 100 },
);

=head2 verbose

  $verbose = $iter->verbose;

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

  $iter = Iterator::Breathe->new(verbose => 1);

Create a new C<Iterator::Breathe> object.

=head2 iterate

  $i = $iter->iterate;

=cut

sub iterate {
  my ($self) = @_;

  print $self->i, "\n" if $self->verbose;

  if ( $self->direction ) {
    if ( $self->i >= $self->top ) {
      $self->i( $self->i - 1 );
      $self->direction( 0 );
      print "Change direction to down.\n" if $self->verbose;
    }
    else {
      $self->i( $self->i + 1 );
    }
  }
  else {
    if ( $self->i <= $self->bottom ) {
      $self->i( $self->i + 1 );
      $self->direction( 1 );
      print "Change direction to up.\n" if $self->verbose;
    }
    else {
      $self->i( $self->i - 1 );
    }
  }

  return $self->i;
}

1;
__END__

=head1 SEE ALSO

L<Moo>

=cut
