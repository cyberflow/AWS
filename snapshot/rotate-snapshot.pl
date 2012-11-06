#!/usr/bin/perl -w
use Net::Amazon::EC2;
use Date::Manip qw(Date_Cmp DateCalc);
use Data::Dumper;

#===> Configure
my $volumeid='vol-63c8960f';
my $threshold=30; # day

my $ec2 = Net::Amazon::EC2->new(
    AWSAccessKeyId => 'AKIAI6KPBZSBNDNMX7PQ',
    SecretAccessKey => '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'
    );

my $descr_snap = $ec2->describe_snapshots(Owner => 'self');
foreach my $snapshot (@$descr_snap) {
    if (($snapshot->volume_id eq $volumeid) && ($snapshot->status eq 'completed') && (Date_Cmp($snapshot->start_time,DateCalc("today","-$threshold day"))  < 0)) {
	#print $snapshot->snapshot_id . " - " . $snapshot->start_time . "\n";
	$ec2->delete_snapshot(SnapshotId => $snapshot->snapshot_id);
    }
}

