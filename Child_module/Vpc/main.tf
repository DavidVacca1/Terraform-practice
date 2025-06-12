# VPC Resource

resource "aws_vpc" "Vpc_eks" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.project_name}vpc"
  }
}

#  Resource Subnets

data "aws_availability_zones" "available" {}

resource "aws_subnet" "Public_subnets" {
  count             = length(var.Public_subnets) # crea subnet basada en el numero (length) de cird que estan en la variante public
  vpc_id            = aws_vpc.Vpc_eks.id
  cidr_block        = var.Public_subnets[count.index] #adjudica el cidr_block de la lista de Public_eks_subnets 
  map_public_ip_on_launch = true # <- esto asigna IP pública automáticamente
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  # busca las AZ disponibles y las distribulle segun cada subnet y si son mas subnets se repiten las AZ

  tags = {
    Name = "${var.project_name}-public_subnet_${count.index + 1}" # anade un numero para cada subnet
  }
}

resource "aws_subnet" "Private_eks_subnets" {
  count             = length(var.Private_subnets)
  vpc_id            = aws_vpc.Vpc_eks.id
  cidr_block        = var.Private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "${var.project_name}-private_subnet_${count.index + 1}"

  }
}

# internet Gateway


resource "aws_internet_gateway" "eks_IG" {
  vpc_id = aws_vpc.Vpc_eks.id

   tags = {
    Name = "${var.project_name}-igw"
  }
}


# Route tables and table association public

resource "aws_route_table" "Public_route_table" {
  vpc_id = aws_vpc.Vpc_eks.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.eks_IG.id
  }

  tags = {
  Name = "${var.project_name}-publc-rt"
  }
}

resource "aws_route_table_association" "Public_RT_association" {
  count          = length(aws_subnet.Public_subnets)
  subnet_id      = aws_subnet.Public_subnets[count.index].id
  route_table_id = aws_route_table.Public_route_table.id
}


# elastic ip

# resource "aws_eip" "eip_Nat_gateway" {}

# nat gateway

# resource "aws_nat_gateway" "eks_NG" {
#   allocation_id = aws_eip.eip_Nat_gateway.id
#   subnet_id     = aws_subnet.Public_subnets[0].id
# }

# Route tables and table association private

# resource "aws_route_table" "Private_route_table" {
#   vpc_id = aws_vpc.Vpc_eks.id

#   route {
#     cidr_block     = var.cidr_block
#     nat_gateway_id = aws_nat_gateway.eks_NG.id
#   }
tags = {
  Name = "${var.project_name}-publc-rt"
  }
# }

# resource "aws_route_table_association" "Private_RT_association" {
#   count          = length(aws_subnet.Private_subnets)
#   subnet_id      = aws_subnet.Private_subnets[count.index].id
#   route_table_id = aws_route_table.Private_route_table.id
# }

