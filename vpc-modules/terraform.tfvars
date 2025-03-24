region    	   = "us-east-2"
vpc_cidr	   = "10.25.0.0/16"
azs    		   = ["us-east-2a", "us-east-2b"]
single_nat_gateway = true
vpc_name	   = "aws"
public_destination_cidr_block = "0.0.0.0/0"
private_destination_cidr_block = "0.0.0.0/0" 
map_public_ip_on_launch = true
enable_dns_support = true
enable_dns_hostnames = true
