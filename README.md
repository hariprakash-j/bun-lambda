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

## Build instructions

### Requirement

- linux, duh
- pipenv is used to install packages and manage virtual env for tests
- yarn is the package manager for the test lambda code written in javascript in the test_src dir
- docker is used to create the test lambda using the environment (sudo might be required depending on the docker installation, makefile has sudo by default where required but remove sudo if your installation does not need sudo to run docker)

Clone the repository and cd into the directory

```sh
git clone <git_url> && cd bun-lambda
```
