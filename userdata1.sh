#!/bin/bash
apt update
apt install -y apache2
# Install the AWS CLI
apt install -y unzip curl

# Download and install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Check AWS CLI version
/usr/local/bin/aws --version

#  Create a test file to upload
echo "This is a test file from EC2." > /home/ubuntu/myfile.txt


# Upload a file to the bucket
aws s3 cp /home/ubuntu/myfile.txt s3://my-tf-automated-test-bucket/

sleep 5

# List contents of the bucket
aws s3 ls s3://my-tf-automated-test-bucket >> /home/ubuntu/s3_list.txt

# Log success
echo "S3 upload complete" >> /home/ubuntu/s3_log.txt
# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  
</head>
<body>
  <h1>Terraform Project Server 2</h1>
  
  <p>Welcome to WEB SERVER2</p>
  
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2