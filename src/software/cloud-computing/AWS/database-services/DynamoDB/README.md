# Amazon DynamoDB

<img src="../../../images/dynamodb.png" alt="dynamodb logo" width="100"/>

## Overview

Amazon DynamoDB is a fully managed NoSQL database service that provides single-digit millisecond response times, making it ideal for high-traffic applications. DynamoDB supports both key-value and document data models, allowing for flexible and dynamic data structures.

## Data Model

- **Key-Value:** Optimized for handling large volumes of simple key-value data.
- **Document-Based:** Suitable for more complex, semi-structured data.

## Key Features

- **On-Demand and Provisioned Capacity:** Choose between automatic scaling or pre-allocated capacity for more predictable costs.
- **Global Tables:** Multi-region, fully replicated tables for fast, consistent access across the globe.
- **DynamoDB Streams:** Enable real-time processing of data changes.
- **Integration with AWS Lambda:** Allows for seamless, serverless processing triggered by DynamoDB changes.

## Use Cases

DynamoDB is ideal for:

- Applications needing high throughput and low-latency response times
- Real-time data processing and analytics
- Scalable applications like gaming, IoT, and e-commerce platforms

## Create a table in DynamoDB

You can create a table using:

- AWS Management Console
- AWS CLI
- AWS SDK

Checkout the link below for steps on how to get started:

- **[Create a table in DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/getting-started-step-1.html)**

See the example below on how to create a table using AWS SDK for python(boto3):

```python
import boto3

# Get the service resource.
dynamodb = boto3.resource('dynamodb')

# Create the DynamoDB table.
table = dynamodb.create_table(
    TableName='users',
    KeySchema=[
        {
            'AttributeName': 'username',
            'KeyType': 'HASH'
        },
        {
            'AttributeName': 'last_name',
            'KeyType': 'RANGE'
        }
    ],
    AttributeDefinitions=[
        {
            'AttributeName': 'username',
            'AttributeType': 'S'
        },
        {
            'AttributeName': 'last_name',
            'AttributeType': 'S'
        },
    ],
    ProvisionedThroughput={
        'ReadCapacityUnits': 5,
        'WriteCapacityUnits': 5
    }
)

# Wait until the table exists.
table.wait_until_exists()

# Print out some data about the table.
print(table.item_count)
```

## 📚 Further Reading

- **[AWS DynamoDB](https://aws.amazon.com/dynamodb/)**  
  An overview of the service

- **[Getting started with DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GettingStartedDynamoDB.html)**  
  A step by step Guide on how to start and manage your DynamoDB table

- **[Boto3 RDS Service Reference](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html)**  
  Boto3 documentation for interacting with AWS DynamoDB using the AWS SDK for Python (Boto3).
