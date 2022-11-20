const express = require('express');
const User = require("../models/user");

const authRouter = express.Router();

authRouter.get("/hello-world", (req, res) => {
    res.json({
        hi: "hello world"
    });
})

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {name, email, password} = req.body;
        // {
        //     'name':name,
        //     'email':email,
        //     'password':password
        // }
        
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res
                .status(400)
                .json({ msg: 'User with same email already exists!' });
        }

        let user = new User({
            email,
            password,
            name,
        })
        user = await user.save();
        res.json(user);

        // 200 OK
        // get the data from client, 
        // post that data in db
        // return that data to the user
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = authRouter; //allow public access