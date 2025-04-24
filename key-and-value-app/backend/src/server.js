const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const { keyValueRouter } = require("./routes/store");
const { healthRouter } = require("./routes/health");

const port = process.env.PORT;

const app = express();
app.use(bodyParser.json());
app.use("/health", healthRouter);
app.use("/store", keyValueRouter);

mongoose
  .connect(`mongodb://mongodb/${process.env.KEY_VALUE_DB}`, {
    auth: {
      username: process.env.KEY_VALUE_USER,
      password: process.env.KEY_VALUE_PASSWORD,
    },
    connectTimeoutMS: 500,
  })
  .then(() => {
    app.listen(port, () => {
      console.log("Listening on port 3000");
    });
    console.log("Connected to DB");
  })
  .catch((err) => console.log(err));
