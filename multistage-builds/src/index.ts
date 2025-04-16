import express from "express";

const app = express();
const port = process.env.PORT;

app.get("/", (req, res) => {
  res.send("Response From Express");
});

app.listen(port, () => {
  console.log("Server starting at " + port);
});
