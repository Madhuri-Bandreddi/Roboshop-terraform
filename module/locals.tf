# locals {
#   name = var.env != "" ? "${var.component_name}-${var.env}" : var.component_name
#   db_commands = [
#     "rm -rf roboshop-shell",
#     "git clone https://github.com/Madhuri-Bandreddi/roboshop-shell",
#     "cd roboshop-shell",
#     "sudo bash ${var.component_name}.sh ${var.password}"
#   ]
#   app_commands = [
#     "sudo labauto ansible",
#     "ansible-pull -i localhost, - U https://github.com/Madhuri-Bandreddi/roboshop-shell roboshop.yml -e env=${var.env} -e role_name=${var.component_name}"
#     # "echo OK"
#   ]
# }

locals {
  name = var.env != "" ? "${var.component_name}-${var.env}" : var.component_name
  db_commands = [
    "sudo yum install -y git ansible || echo 'Failed to install Git and Ansible'",
    "rm -rf roboshop-shell || echo 'Failed to remove directory'",
    "git clone https://github.com/Madhuri-Bandreddi/roboshop-shell || echo 'Git clone failed'",
    "cd roboshop-shell || echo 'Failed to change directory'",
    "chmod +x ${var.component_name}.sh || echo 'Failed to set execute permissions'",
    "sudo bash ${var.component_name}.sh ${var.password} || echo 'Script execution failed'"
  ]
  app_commands = [
    "sudo labauto ansible || echo 'labauto command failed'",
    "ansible-pull -i localhost, -U https://github.com/Madhuri-Bandreddi/roboshop-ansible roboshop.yml -e env=${var.env} -e role_name=${var.component_name} || echo 'ansible-pull failed'"
  ]
}
