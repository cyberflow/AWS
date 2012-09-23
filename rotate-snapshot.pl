#!/usr/bin/perl -w
use Net::Amazon::EC2;
use Data::Dumper;
#use Logger::Syslog;

my $volumeid='vol-63c8960f';

my $ec2 = Net::Amazon::EC2->new(
    AWSAccessKeyId => 'AKIAI6KPBZSBNDNMX7PQ',
    SecretAccessKey => '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'
    );

my $descr_snap = $ec2->describe_snapshots(Owner => 'self');
#print Dumper(@descr_snap), "\n";
foreach my $snapshot (@$descr_snap) {
    if (($snapshot->volume_id eq $volumeid) && ($snapshot->status eq 'completed')){
	#print $snapshot->snapshot_id . "\n";
	#TODO: get snapshot time ant compare with local time
    }
}

