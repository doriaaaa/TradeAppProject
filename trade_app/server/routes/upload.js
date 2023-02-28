const express = require('express');
const User = require("../models/user");
const uploadBookInfo = require("../models/upload_book");
const authRouter = express.Router();
const multer = require('multer')

authRouter.post("/api/user/upload", async (req, res) => {
    const { user_email, title, author, publisher, pics_url, description } = req.body;
    const bookToAdd = { title, author, publisher, pics_url, description };
    const user = await User.findOne( { user_email } );
    try {
        if (!user) {
            return res.status(400).json({
                msg: "Error in finding user"
            });
        } else {
            user.uploadedBookList.push(bookToAdd);
            user.save((err) => {
                if(err) {
                    console.log("failed to save the book");
                    res.status(400).json({
                        msg: "failed to save the book"
                    })
                } else {
                    console.log("book is uploaded successfully");
                    res.status(200).json({ 
                        msg: "success"
                    });
                }
            });
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
// upload book to database, sample response below
// {
//     user_email: xxx,
//     book_name: xxx,
//     author: xxx,
//     publisher: xxx, //optional
//     pics_url: xxx,
//     description: xxx
//     this part should link with user
// }
module.exports = authRouter;