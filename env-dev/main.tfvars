app_servers = {
  frontend = {
    name          = "frontend"
    instance_type = "t3.micro"
  }
  catalogue = {
    name          = "catalogue"
    instance_type = "t3.medium"
  }
  user = {
    name          = "user"
    instance_type = "t3.micro"
  }
  cart = {
    name          = "cart"
    instance_type = "t3.micro"
  }
  shipping = {
    name          = "shipping"
    instance_type = "t3.medium"
    password      = "RoboShop@1"
  }
  payment = {
    name          = "payment"
    instance_type = "t3.micro"
    password      = "roboshop123"
  }
}

database_servers = {
  mongodb = {
    name          = "mongodb"
    instance_type = "t2.micro"
  }
  redis = {
    name          = "redis"
    instance_type = "t3.micro"
  }
  rabbitmq = {
    name          = "rabbitmq"
    instance_type = "t2.micro"
    password      = "roboshop123"
  }
  mysql = {
    name          = "mysql"
    instance_type = "t3.small"
    password      = "RoboShop@1"
  }
}

env = "dev"