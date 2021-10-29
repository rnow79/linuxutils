#!/usr/bin/perl -w

use strict;

use IO::Socket;

my $server = "irc.terra.es";
my $nick = "_nick77";
my $login = "_nick77";

my $channel = "#linux";

my $sock = new IO::Socket::INET(PeerAddr => $server, PeerPort => 6667, Proto => 'tcp') or die "Can't connect\n";

print $sock "NICK $nick\r\n";
print $sock "USER $login 8 * :Agaporni rocks\r\n";

while (my $input = <$sock>) {
    if ($input =~ /004/) {
        last;
    }
    elsif ($input =~ /433/) {
        die "Nickname is already in use.";
    }
    elsif ($input =~ /^PING(.*)$/i) {
       print $sock "PONG $1\r\n";
    }

    print "$input\n";
}

# Join the channel.
print $sock "JOIN $channel\r\n";

# Keep reading lines from the server.
while (my $input = <$sock>) {
    chop $input;
    if ($input =~ /^PING(.*)$/i) {
        # We must respond to PINGs to avoid being disconnected.
        print $sock "PONG $1\r\n";
    }
    else {
        # Print the raw line received by the bot.
        print "$input\n";
    }
}

