resource "aws_vpc" "resume-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
            Name = "resume-vpc"
        }
}

resource "aws_internet_gateway" "resume-igw" {
        vpc_id = aws_vpc.resume-vpc.id

        tags = {
            Name = "resume-igw"
        }
}

resource  "aws_route_table" "resume-route" {
        vpc_id = aws_vpc.resume-vpc.id

        route { 
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.resume-igw.id
        }

        tags = {
            Name = "resume-route"
        }
}

resource "aws_route_table_association" "resume-route_table-assoc" {
        subnet_id = aws_subnet.resume-subnet.id
        route_table_id = aws_route_table.resume-route.id
}

resource "aws_subnet" "resume-subnet" {
        vpc_id = aws_vpc.resume-vpc.id
        cidr_block = var.subnet-cidr

         tags = {
            Name = "resume-subnet"
        }
} 

