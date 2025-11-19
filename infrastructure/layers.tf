resource "aws_lambda_layer_version" "old_otel_layer" {
  layer_name               = "otel-nodejs-layer-test"
  filename                 = "../layer_old.zip"
  compatible_runtimes      = ["nodejs20.x"]
  compatible_architectures = ["arm64"]
}

resource "aws_lambda_layer_version" "new_otel_layer" {
  layer_name               = "otel-nodejs-layer-test"
  filename                 = "../layer_new.zip"
  compatible_runtimes      = ["nodejs20.x"]
  compatible_architectures = ["arm64"]
}
