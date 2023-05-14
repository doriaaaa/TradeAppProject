//IMPORT FROM PACKAGES
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
console.log("hello server");

//IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth");
const bookRouter = require("./routes/book");
const universalRouter = require("./routes/universal/image");
const threadRouter = require("./routes/thread");
const commentRouter = require("./routes/comment");
const userRouter = require("./routes/user");

//INIT
const app = express();

//middleware
app.use(express.json({ limit: "10mb" })); // allow image string to send to nodejs server
app.use(bodyParser.json({ limit: "10mb" }));
app.use(express.json());
app.use(authRouter);
app.use(bookRouter);
app.use(universalRouter);
app.use(threadRouter);
app.use(commentRouter);
app.use(userRouter);

// connections

mongoose
  .connect(process.env.DB)
  .then(() => {
    console.log("Connected to MongoDB successfully");
  })
  .catch((e) => {
    console.log("Error: " + e);
  });

app.listen(process.env.PORT, "0.0.0.0", () => {
  console.log(`connected at PORT ${process.env.PORT}`);
}); //access anywhere, for android to locate localhost
//localhost, 127.0.0.1
