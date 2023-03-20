const express = require('express');
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const userRouter = express.Router();
const auth = require("../middleware/auth");
const jwt = require("jsonwebtoken");

// user change password
userRouter.post('/api/user/account/changePassword', auth, async(req, res) => {
    try {
        const { oldPassword, newPassword} = req.body;
        const user = await User.findOne({ _id: req.user }); // retrieve user password by fetching user query
        const isMatch = await bcryptjs.compare(oldPassword, user.password); // compare the hashed password
        if (!isMatch) {
            return res.status(403).json( {
                msg: "The old password does not match."
            });
        } else {
            const hashedPassword = await bcryptjs.hash(newPassword, 8);
            const updateUserPassword = await User.findOneAndUpdate(
                { _id: req.user }, 
                { $set: { password: hashedPassword } }, 
                {new: true}
            );
            // console.log(updateUserPassword);
            if (updateUserPassword) {
                res.status(200).json({
                    msg: "success",
                    result: "password updated successfully. "
                });
            } else {
                console.log("failed");
                res.status(400).json({
                    msg: "failed",
                    result: "unknown error occured"
                });
            }
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// user update profile picture
userRouter.post('/api/user/account/updateProfilePicture', auth, async(req, res) => {
    try {
        const { profilePicture } = req.body;
        const updateProfilePicture = await User.findOneAndUpdate(
            {_id: req.user},
            { $set: { profilePicture: profilePicture}},
            { new: true }
        );
        if (updateProfilePicture) {
            res.status(200).json({
                msg: "success",
                result: updateProfilePicture.profilePicture
            });
        } else {
            console.log("failed");
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});
// user sign in
userRouter.post("/api/user/account/signIn", async(req, res) => {
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
// user sign up
userRouter.post("/api/user/account/signUp", async (req, res) => {
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

// get user book list
userRouter.get('/api/user/book/bookList', auth, async(req, res) => {
    try {
        const userInfo = await User.findOne({ _id: req.user });
        if (userInfo) {
            res.status(200).json({
                msg: "success",
                result: userInfo.bookList
            });
        } else {
            console.log("failed");
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// get user info

module.exports = userRouter;