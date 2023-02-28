const express = require('express');
const User = require("../models/user");
const uploadRouter = express.Router();
const auth = require("../middleware/auth");
const {parse, stringify, toJSON, fromJSON} = require('flatted');
// const multer = require('multer');

uploadRouter.post("/api/user/upload", auth, async (req, res) => {
    // const { title, author, publisher, pics_url, description } = req.body;
    const bookToAdd = req.body;
    console.log(bookToAdd);
    // let user = await User.findById(req.user);
    console.log(req.user);
    try {
        const uploadedBook = await User.findOneAndUpdate({_id: req.user}, { $push: { uploadedBookList: bookToAdd } }, {new: true});
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