#!/usr/bin/perl -w
use Net::Amazon::EC2;

my $ec2 = Net::Amazon::EC2->new(
        AWSAccessKeyId => 'PUBLIC_KEY_HERE', 
        SecretAccessKey => 'SECRET_KEY_HERE'
 );

my $running_instances = $ec2->describe_instances;

foreach my $reservation (@$running_instances) {
    foreach my $instance ($reservation->instances_set) {
        print $instance->instance_id . "\n";
    }
}

my $instance_id = $instance->instances_set->[0]->instance_id;

print "$instance_id\n";
