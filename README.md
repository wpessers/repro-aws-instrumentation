# Minimal AWS-SDK instrumentation issue repro

This repo contains a minimal setup to reproduce the issue where @opentelemetry/aws-sdk-instrumentation is broken in aws lambda since version `0.62.0`
The Lambda handler is a simple handler, using commonjs, that makes one put call to dynamodb to test for aws-sdk-instrumentation.

2 layers are included:

- The new, broken layer: [layer_new](./layer_new.zip) _contains version `0.62.0` of the aws-sdk-instrumentation_
- The old, working layer: [layer_old](./layer_old.zip) _contains version `0.61.2` of the aws-sdk-instrumentation_

The setup is quite simple, to deploy this to your own aws account:

- Make sure you are currently using the correct aws profile
- `cd` into the `/infrastructure` directory
- run `terraform init` to initialize terraform and the custom module
- run `terraform apply` to deploy the infrastructure

When examining the logs, thanks to the DEBUG logs from the opentelemetry instrumentation we can see that in the old layer the aws-sdk is succesfully patched.

```text
2025-11-19T16:43:12.841Z	undefined	DEBUG	@opentelemetry/instrumentation-aws-sdk Applying instrumentation patch for module on require hook {
  module: '@smithy/middleware-stack',
  version: '4.1.1',
  baseDir: '/var/runtime/node_modules/@aws-sdk/node_modules/@smithy/middleware-stack'
}
2025-11-19T16:43:12.844Z	undefined	DEBUG	@opentelemetry/instrumentation-aws-sdk propwrapping aws-sdk v3 constructStack
2025-11-19T16:43:12.846Z	undefined	DEBUG	@opentelemetry/instrumentation-aws-sdk Applying instrumentation patch for module on require hook {
  module: '@smithy/smithy-client',
  version: '4.6.4',
  baseDir: '/var/runtime/node_modules/@aws-sdk/node_modules/@smithy/smithy-client'
}
```

And we can also see that the dynamodb span is among the spans that are exported.

In the function using the new layer there are no such logs to be found, as one would expect we also do not see the dynamodb span exported.
