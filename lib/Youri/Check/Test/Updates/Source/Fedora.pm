# $Id$
package Youri::Check::Test::Updates::Source::Fedora;

=head1 NAME

Youri::Check::Test::Updates::Source::Fedora - Fedora updates source

=head1 DESCRIPTION

This source plugin for L<Youri::Check::Test::Updates> collects updates
available from Fedora.

=cut

use warnings;
use strict;
use Carp;
use base 'Youri::Check::Test::Updates::Source';

=head2 new(%args)

Creates and returns a new Youri::Check::Test::Updates::Source::Fedora object.

Specific parameters:

=over

=item url $url

URL to Fedora development SRPMS directory (default:
http://fr.rpmfind.net/linux/fedora/core/development/SRPMS)

=back

=cut

sub _init {
    my $self    = shift;
    my %options = (
        url => 'http://fr.rpmfind.net/linux/fedora/core/development/SRPMS',
        @_
    );
    my $agent = LWP::UserAgent->new();
    my $buffer = '';
    my $callback = sub {
        my ($data, $response, $protocol) = @_;

        # prepend text remaining from previous run
        $data = $buffer . $data;

        # process current chunk
        while ($data =~ m/(.*)\n/ogc) {
            my $line = $1;
            next unless $line =~ />([\w-]+)-([\w\.]+)-[\w\.]+\.src\.rpm<\/a>/o;
            $self->{_versions}->{$1} = $2;
        }

        # store remaining text
        $buffer = substr($data, pos $data);
    };

    $agent->get($options{url}, ':content_cb' => $callback);

    $self->{_versions} = $versions;
}

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2002-2006, YOURI project

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

1;
