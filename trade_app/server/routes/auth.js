const express = require('express');

const authRouter = express.Router();

authRouter.get("/hello-world", (req, res) => {
    res.json({
        hi: "hello world"
    });
})

module.exports = authRouter; //allow public access