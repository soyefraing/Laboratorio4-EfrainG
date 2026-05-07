resource "aws_security_group" "lambda_sg_upload" {
  name        = "${var.project_name}-${local.env}-upload-sg"
  vpc_id      = aws_vpc.main.id

  # Solo salida para llegar al endpoint de S3 y Logs
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "lambda_sg_crop" {
  name        = "${var.project_name}-${local.env}-crop-sg"
  vpc_id      = aws_vpc.main.id

  # Solo salida para llegar al endpoint de S3 y Logs
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sqs_endpoint_sg" {
  name        = "${var.project_name}-${local.env}-sqs-vpce-sg"
  description = "Permite trafico HTTPS hacia el endpoint de SQS desde las Lambdas"
  vpc_id      = aws_vpc.main.id

  # Regla de entrada: permite a ambas Lambdas
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [
      aws_security_group.lambda_sg_upload.id, # SG de la Lambda de carga
      aws_security_group.lambda_sg_crop.id     # SG de la Lambda de procesamiento
    ]
  }

  # Regla de salida (Egress): por defecto suele permitirse todo
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-${local.env}-sqs-vpce-sg" }
}