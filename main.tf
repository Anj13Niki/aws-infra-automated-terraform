resource "aws_key_pair" "infrakey" {
  key_name = "automated-infra-key"
  public_key = file("automatedinfrakey.pub")
}



resource "aws_s3_bucket" "automatedtestbucket" {
  bucket = "my-tf-automated-test-bucket"

  tags = {
    Name        = "my-tf-automated-test-bucket"
    Environment = "Dev"
  }
}

#iam role
resource "aws_iam_role" "ec2_s3_access_role" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

#atach s3 policy to the role
resource "aws_iam_role_policy" "s3_access_policy" {
  name = "ec2_s3_access_policy"
  role = aws_iam_role.ec2_s3_access_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.automatedtestbucket.arn,
          "${aws_s3_bucket.automatedtestbucket.arn}/*"
        ]
      }
    ]
  })
}

#create an instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_s3_profile"
  role = aws_iam_role.ec2_s3_access_role.name
}


