# module "servers" {
#   for_each = var.components
#
#   source         = "./module"
#   component_name = each.value["name"]
#   env            = var.env
#   instance_type  = each.value["instance_type"]
#   password       = lookup(each.value, "password", "null")
# }
variable "components" {
  default = {
    frontend = {
      name          = "frontend"
      instance_type = "t2.micro"
    }
    mongodb = {
      name          = "mongodb"
      instance_type = "t2.micro"
    }
    catalogue = {
      name          = "catalogue"
      instance_type = "t3.medium"
    }
    redis = {
      name          = "redis"
      instance_type = "t3.micro"
    }
    user = {
      name          = "user"
      instance_type = "t3.micro"
    }
    cart = {
      name          = "cart"
      instance_type = "t3.micro"
    }
    mysql = {
      name          = "mysql"
      instance_type = "t3.small"
      password      = "RoboShop@1"
    }
    shipping = {
      name          = "shipping"
      instance_type = "t3.medium"
      password      = "RoboShop@1"
    }
    rabbitmq = {
      name          = "rabbitmq"
      instance_type = "t2.micro"
      password      = "roboshop123"

    }
    payment = {
      name          = "payment"
      instance_type = "t3.micro"
      password      = "roboshop123"
    }
  }
}

resource "aws_instance" "instance" {
  for_each       = var.components
  ami           = data.aws_ami.centos.image_id
  instance_type =each.value["instance_type"]

  vpc_security_group_ids = [data.aws_security_group.launch-wizard-16.id]

  tags = {
    Name = each.value["name"]
  }
}
#
# resource "null_resource" "provisioner" {
#
#   depends_on = [aws_instance.instance, aws_route53_record.records]
#   provisioner "remote-exec" {
#
#     connection {
#       type     = "ssh"
#       user     = "root"
#       password = "DevOps321"
#       host     = aws_instance.instance.private_ip
#     }
#
#     inline = [
#       "rm -rf roboshop-shell",
#       "git clone https://github.com/Madhuri-Bandreddi/roboshop-shell.git",
#       "cd roboshop-shell",
#       "sudo bash ${var.component_name}.sh.${var.password}"
#     ]
#   }
# }
#
resource "aws_route53_record" "records" {
  for_each       = var.components
  zone_id        = "Z06377673P2QZ3HGG0TOY"
  name           = "${each.value["name"]}.madhari123.shop"
  type           = "A"
  ttl            = 30
  records        = [aws_instance.instance[each.value["name"]].private_ip]
}
