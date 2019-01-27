package Class::Data::Lite;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.0010";

sub _croak {require Carp; Carp::croak(@_) }

sub import {
    shift;
    my %args = @_;
    my $pkg = caller(0);

    my %key_ctor = (
        rw => \&_mk_accessor,
        ro => \&_mk_ro_accessor,
    );

    no strict 'refs';
    for my $key (keys %key_ctor) {
        if (my $accessors = delete $args{$key}) {
            _croak "value of the '$key' parameter should be an hashref"
                unless ref($accessors) eq 'HASH';
            while (my ($k, $v) = each %$accessors) {
                *{"${pkg}::${k}"} = $key_ctor{$key}->($v);
            }
        }
    }
}

sub _mk_accessor {
    my $data = shift;
    return sub {
        $data = $_[1] if @_>1;
        $data;
    };
}

sub _mk_ro_accessor {
    my $data = shift;
    return sub { $data };
}

1;
__END__

=encoding utf-8

=head1 NAME

Class::Data::Lite - It's new $module

=head1 SYNOPSIS

    use Class::Data::Lite;

=head1 DESCRIPTION

Class::Data::Lite is ...

=head1 LICENSE

Copyright (C) Songmu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Songmu E<lt>y.songmu@gmail.comE<gt>

=cut

