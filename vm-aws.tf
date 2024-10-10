resource "aws_key_pair" "key" {
  key_name   = "aws-key-pipeline"
  public_key = var.azure_key_pub
}

resource "aws_instance" "vm" {
  ami                    = "ami-0e86e20dae9224db8"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
  subnet_id              = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_id]

  tags = {
    Name = "vm-terraform"
  }
}