require('dotenv').config();
const express = require('express');
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const jwt = require("jsonwebtoken");
const authRouter = express.Router();
const auth = require("../middleware/auth");

authRouter.get("/test", (req, res) => {
    res.json({
        test: "this is the testing api"
    });
});

authRouter.post("/api/signin", async(req, res) => {
    try {
        const {email, password} = req.body;
        const user = await User.findOne( {email} );
        if (!user) {
            return res.status(400).json({
                msg: "No user found!"
            });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json( {
                msg: "incorrect password!"
            });
        }
        const token = jwt.sign({id: user._id}, process.env.SECRET_KEY);
        res.json({token, ...user._doc});
    } catch (e) {
        res.status(500).json( {
                error: e.message
            }
        );
    }
});

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {name, email, password} = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ 
                msg: 'User with same email already exists!' 
            });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        })
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, process.env.SECRET_KEY);
        if (!verified) return res.json(false);
        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
  
// get user data
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter; //allow public access