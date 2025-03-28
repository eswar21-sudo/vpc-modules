provider "aws" {
region = var.region
}

module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
  region    = var.region
  vpc_name  = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}
  
module "subnets" {
  source   = "./modules/subnets"
  vpc_id   = module.vpc.vpc_id
  azs      = var.azs
  vpc_cidr = var.vpc_cidr  
  vpc_name = var.vpc_name
  map_public_ip_on_launch = var.map_public_ip_on_launch
}

module "nat" {
  source              = "./modules/nat"
  public_subnet_ids   = module.subnets.public_subnet_ids
  single_nat_gateway  = var.single_nat_gateway
  vpc_name            = var.vpc_name
}

module "routes" {
  source           = "./modules/routes"
  vpc_id           = module.vpc.vpc_id
  vpc_name         = var.vpc_name
  azs              = var.azs
  igw_id           = module.vpc.igw_id
  nat_gateway_ids  = module.nat.nat_gateway_ids
  single_nat_gateway  = var.single_nat_gateway
  public_subnet_ids   = module.subnets.public_subnet_ids
  private_subnet_ids  = module.subnets.private_subnet_ids
  public_destination_cidr_block  = var.public_destination_cidr_block
  private_destination_cidr_block = var.private_destination_cidr_block
}
