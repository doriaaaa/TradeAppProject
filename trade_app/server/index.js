//IMPORT FROM PACKAGES
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser')
console.log("hello server");

//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');
const imgurRouter = require('./middleware/imgur');
const userActionRouter = require('./routes/user_action');

//INIT
const app = express();

//middleware
app.use(express.json());
app.use(authRouter);
app.use(imgurRouter);
app.use(userActionRouter);
app.use(bodyParser.json({limit: '16mb', extended: true}));     // Make sure you add these two lines
app.use(bodyParser.urlencoded({limit: '16mb', extended: true}))

//create API
// app.get("/hello-world", (req, res) => {
//     res.json({
//         hi: "hello world"
//     });
// })
// a get request sample
//GET, PUT, POST, DELETE, UPDATE -> CRUD 

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