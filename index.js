const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");

const client = new DynamoDBClient({});

exports.handler = async (event) => {
  try {
    const params = {
      TableName: "HelloWorld",
      Item: {
        SomeKey: { S: "test" + Date.now().toString },
      },
    };

    await client.send(new PutItemCommand(params));

    return { message: "Item written" };
  } catch (err) {
    console.error("Error writing to DynamoDB:", err);
    return { message: "Failed to write item" };
  }
};
