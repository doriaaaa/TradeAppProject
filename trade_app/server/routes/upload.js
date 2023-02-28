const express = require('express');
const User = require("../models/user");
const uploadRouter = express.Router();
const auth = require("../middleware/auth");
const {parse, stringify, toJSON, fromJSON} = require('flatted');
// const multer = require('multer');

uploadRouter.post("/api/user/upload", auth, async (req, res) => {
    // const { title, author, publisher, pics_url, description } = req.body;
    const bookToAdd = req.body;
    let user = await User.findById(req.user);
    // console.log(stringify(user));
    // console.log(user.name);
    try {
        if (!user) {
            return res.status(400).json({
                msg: "Error in finding user"
            });
        } else {
            user = await User.findOneAndUpdate(user, { $push: {uploadedBookList: bookToAdd} }, function(err, res) {
                if(err) {
                    console.log(err);
                    console.log(res);
                    console.log("failed to save the book");
                } else {
                    console.log("book is uploaded successfully");
                }
            });
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});
// upload book to database, sample response below
// {
//     book_name: xxx,
//     author: xxx,
//     publisher: xxx, //optional
//     pics_url: xxx,
//     description: xxx
//     this part should link with user
// }
module.exports = uploadRouter;