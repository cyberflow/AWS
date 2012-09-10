#!/usr/bin/perl -w
use Net::Amazon::EC2;

my $interface="eth0";
my $device="sdb";

sub get_private_ip
{
    my $if = shift;
    my $ifconfig="/sbin/ifconfig";
    @lines=qx|$ifconfig $if| or die("Can't get info from ifconfig: ".$!);
    foreach(@lines){
	if(/inet addr:([\d.]+)/){
	    return "$1";
	}
    }
}

my $ec2 = Net::Amazon::EC2->new(
        AWSAccessKeyId => '', 
        SecretAccessKey => ''
 );

my $running_instances = $ec2->describe_instances;

foreach my $reservation (@$running_instances) {
    foreach my $instance ($reservation->instances_set) {
        if ( $instance->private_ip_address eq get_private_ip($interface) ) {
            my $current_instance_id=$instance->instance_id;
            foreach my $block_dev ($instance->block_device_mapping) {
		# TODO: get volume id from block devices array 

                #if ( $block_dev.device_name eq '/dev/sdb' ) {
                #    print my $block_dev->ebs->volume_id;
                #}
                print "->" . $block_dev->device_name . "\n";
                #say Dumper $block_dev;
            }
        }
    }
}

