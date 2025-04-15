const express = require("express");

const app = express();
const port = process.env.PORT;

app.get("/", (req, res) => {
  res.send(`Hello World from ${process.env.APP_NAME} !`);
});

app.listen(port, () => {
  console.log("Server starting on port" + port);
});
