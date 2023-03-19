//IMPORT FROM PACKAGES
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
console.log("hello server");

//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');
const bookInfoRouter = require('./routes/book/book');
const imgurRouter = require('./routes/upload/image');
const userActionRouter = require('./routes/user/user_action');
const postRouter = require('./routes/upload/thread');
const commentRouter = require('./routes/upload/comment');

//INIT
const app = express();

//middleware
app.use(express.json({limit: '10mb'})); // allow image string to send to nodejs server
app.use(bodyParser.json({limit : '10mb'}));  
app.use(express.json());
app.use(authRouter);
app.use(bookInfoRouter);
app.use(imgurRouter);
app.use(userActionRouter);
app.use(postRouter);
app.use(commentRouter);

// connections

mongoose.connect(process.env.DB)
    .then(() => {
        console.log("Connected to MongoDB successfully");
    }).catch((e) => {
        console.log("Error: " + e);
    })

app.listen(process.env.PORT, "0.0.0.0", () => {
    console.log(`connected at PORT ${process.env.PORT}`);
}) //access anywhere, for android to locate localhost
//localhost, 127.0.0.1