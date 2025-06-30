resource "aws_instance" "web_instance1" {
    ami = var.ec2_ami
    instance_type = var.ec2_type
    vpc_security_group_ids = [aws_security_group.mysg.id]
    subnet_id = aws_subnet.automated_subnet1.id
    key_name = aws_key_pair.infrakey.key_name
    user_data = base64encode(file("user_data.sh"))
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    
}


resource "aws_instance" "web_instance2" {
    ami = var.ec2_ami
    instance_type = var.ec2_type
    vpc_security_group_ids = [aws_security_group.mysg.id]
    subnet_id = aws_subnet.automated_subnet2.id
    key_name = aws_key_pair.infrakey.key_name
    user_data = base64encode(file("userdata1.sh"))
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    
}