#!/usr/bin/perl -w
use Net::Amazon::EC2;
use Data::Dumper;
#use Date::Manip qw(Date_Cmp DateCalc UnixDate);
#use Date::Format;
#use feature 'say';

my $volumeid="vol-63c8960f";

my $ec2 = Net::Amazon::EC2->new(
        AWSAccessKeyId => 'AKIAI6KPBZSBNDNMX7PQ', 
        SecretAccessKey => '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'
    );

my $DSC = localtime();
print "Print DSC: " . $DSC . "\n";

my $snapshot = $ec2->create_snapshot(VolumeId => $volumeid, Description => $DSC);
print Dumper($snapshot), "\n";






