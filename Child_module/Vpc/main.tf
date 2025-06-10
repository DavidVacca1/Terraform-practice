# VPC Resource

resource "aws_vpc" "Vpc_eks" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "Vpc_eks"
  }
}

#  Resource Subnets

data "aws_availability_zones" "available" {}

resource "aws_subnet" "Public_eks_subnets" {
  count             = length(var.Public_eks_subnets) # crea subnet basada en el numero (length) de cird que estan en la variante public
  vpc_id            = aws_vpc.Vpc_eks.id
  cidr_block        = var.Public_eks_subnets[count.index] #adjudica el cidr_block de la lista de Public_eks_subnets 
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  # busca las AZ disponibles y las distribulle segun cada subnet y si son mas subnets se repiten las AZ

  tags = {
    Name = "Public_subnet_${count.index + 1}" # anade un numero para cada subnet
  }
}

resource "aws_subnet" "Private_eks_subnets" {
  count             = length(var.Private_eks_subnets)
  vpc_id            = aws_vpc.Vpc_eks.id
  cidr_block        = var.Private_eks_subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "Private_subnet_${count.index + 1}"

  }
}

# internet Gateway


