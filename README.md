# bun on lambda
A bun runtime for AWS Lambda.
An example lambda handler...
```js
export async handler(event, context) {
  let output = "Hello world from bun runtime";
  return {
    "body" : output,
    "statuscode" : 200
  }
}
```
