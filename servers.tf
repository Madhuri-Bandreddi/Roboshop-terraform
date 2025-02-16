# module "servers" {
#   for_each = var.components
#
#   source         = "./module"
#   component_name = each.value["name"]
#   env            = var.env
#   instance_type  = each.value["instance_type"]
#   password       = lookup(each.value, "password", "null")
# }

resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.launch-wizard-1 .id]

  tags = {
    Name = each.value["name"]
  }
}
#
# resource "null_resource" "provisioner" {
#
#   depends_on = [aws_instance.instance, aws_route53_record.records]

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "root"
      password = "DevOps321"
      host     = self.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/Madhuri-Bandreddi/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${each.value["name"]}.sh"
    ]
  }
}

resource "aws_route53_record" "records" {
  for_each       = var.components
  zone_id        = "Z06377673P2QZ3HGG0TOY"
  name           = "${each.value["name"]}.madhari123.shop"
  type           = "A"
  ttl            = 30
  records        = [aws_instance.instance[each.value["name"]].private_ip]
}
