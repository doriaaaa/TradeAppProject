const express = require('express');
const User = require("../models/user");
const userActionRouter = express.Router();
const auth = require("../middleware/auth");

// perform user actions
userActionRouter.get('/api/user/getAllInfo', auth, async(req, res) => {
    try {
        const userInfo = await User.findOne({ _id: req.user });
        console.log(userInfo);
        if (userInfo) {
            console.log(userInfo.uploadedBookList);
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


module.exports = userActionRouter;