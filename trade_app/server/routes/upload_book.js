const express = require('express');
const User = require("../models/user");
const uploadBookRouter = express.Router();
const auth = require("../middleware/auth");
// const {parse, stringify, toJSON, fromJSON} = require('flatted');
// const multer = require('multer');

uploadBookRouter.post("/api/user/upload", auth, async (req, res) => {
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
module.exports = uploadBookRouter;