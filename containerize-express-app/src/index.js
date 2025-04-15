const express = require("express");
const bodyParser = require("body-parser");

const app = express();
const port = 3000;

const users = [];

app.use(bodyParser.json());

app.get("/", (req, res) => {
  res.send("Hello World");
});

//Register New User
app.post("/users", (req, res) => {
  const userId = req.body.userId;
  if (!userId) {
    return res.status(400).send("Missing Id");
  }

  if (users.includes(userId)) {
    return res.status(400).send("Dupplicate Id");
  }

  users.push(userId);
  return res.status(201).send("User Registered");
});

app.get("/users", (req, res) => {
  return res.json({ users });
});

app.listen(port, () => {
  console.log(`Server start at port ${port} `);
});
