data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ec2policydoc" {
	statement {
			sid = "Statement1"
			effect = "Allow"
			actions = [
			    "ec2:*"]
			resources = [
			    "*"
			    ]
		}
}

data "aws_iam_policy_document" "ec2assumerole" {
 statement {
             effect = "Allow"
             actions = ["sts:AssumeRole"]
             principals {
                type = "Service"
                identifiers = ["ec2.amazonaws.com"]
             }
           }
}

resource "aws_iam_role" "ec2Role" {
  name = "RoleforEC2"
  assume_role_policy = data.aws_iam_policy_document.ec2assumerole.json

}

resource "aws_iam_policy" "ec2RolePolicy" {
 name = "Policy-EC2"
 description = "Policy granting full EC2 access"
 policy = data.aws_iam_policy_document.ec2policydoc.json
}


resource "aws_iam_role_policy_attachment" "role-attachment" {
 role = aws_iam_role.ec2Role.name
 policy_arn = aws_iam_policy.ec2RolePolicy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2Role.name
}