const express = require('express');
const User = require("../models/user");
const Book = require("../models/book");
const bcryptjs = require('bcryptjs');
const socialRouter = express.Router();

socialRouter.get('/api/social/user/:userId/profilePicture', async(req, res) => {
    try {
        const user = await User.findOne({ userId: req.params.userId });
        if (user) {
            res.status(200).json({
                msg: "success",
                result: {
                    "userId": user.userId,
                    "profilePicture": user.profilePicture
                }
            });
        } else {
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});
module.exports = socialRouter;