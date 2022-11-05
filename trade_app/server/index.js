//IMPORT FROM PACKAGES
const express = require('express');
console.log("hello server");

//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');

//INIT
const PORT = 3000;
const app = express();

//middleware
app.use(authRouter);

//create API
// app.get("/hello-world", (req, res) => {
//     res.json({
//         hi: "hello world"
//     });
// })
// a get request sample
//GET, PUT, POST, DELETE, UPDATE -> CRUD 

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at PORT ${PORT}`);
}) //access anywhere, for android to locate localhost
//localhost, 127.0.0.1