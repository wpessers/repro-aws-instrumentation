resource "aws_lambda_layer_version" "old_otel_layer" {
  layer_name               = "otel-nodejs-layer-old"
  filename                 = "../layer_old.zip"
  compatible_runtimes      = ["nodejs20.x"]
  compatible_architectures = ["arm64"]
}

resource "aws_lambda_layer_version" "new_otel_layer" {
  layer_name               = "otel-nodejs-layer-new"
  filename                 = "../layer_new.zip"
  compatible_runtimes      = ["nodejs20.x"]
  compatible_architectures = ["arm64"]
}

resource "aws_lambda_layer_version" "patched_otel_layer" {
  layer_name               = "otel-nodejs-layer-patched"
  filename                 = "../layer_patched.zip"
  compatible_runtimes      = ["nodejs20.x"]
  compatible_architectures = ["arm64"]
}
