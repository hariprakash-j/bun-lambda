export async function handler(event, context) {
  let output;
  if (event.data === "marco") {
    output = "polo";
  } else if (event.data === "alpha") {
    output = "beta";
  }
  return {
    body: output,
    statuscode: 200,
  };
}
