const express = require('express');
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const userActionRouter = express.Router();
const auth = require("../middleware/auth");

// perform user actions
userActionRouter.get('/api/user/getUploadedBookInfo', auth, async(req, res) => {
    try {
        const userInfo = await User.findOne({ _id: req.user });
        if (userInfo) {
            res.status(200).json({
                msg: "success",
                result: userInfo.uploadedBookList
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

userActionRouter.post('/api/user/changePassword', auth, async(req, res) => {
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

userActionRouter.post('/api/user/updateProfilePicture', auth, async(req, res) => {
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

userActionRouter.post("/api/user/upload", auth, async (req, res) => {
    // const { title, author, publisher, pics_url, description } = req.body;
    const bookToAdd = req.body;
    // console.log(bookToAdd);
    // console.log(bookToAdd);
    // let user = await User.findById(req.user);
    // console.log(req.user);
    try {
        const uploadedBook = await User.findOneAndUpdate({_id: req.user}, { $push: { uploadedBookList: bookToAdd } }, {new: true});
        console.log(uploadedBook);
        if (uploadedBook) {
            console.log("book uploaded successfully");
            res.status(200).json({
                msg: "success",
                result: uploadedBook
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

module.exports = userActionRouter;