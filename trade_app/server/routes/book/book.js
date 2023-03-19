const express = require('express');
const isbn = require('node-isbn');
const bookInfoRouter = express.Router();
const User = require("../../models/user");
const Book = require("../../models/book");
const auth = require("../../middleware/auth");
// for uploading books to bookshelf

// get book info
bookInfoRouter.post("/api/book/info", async (req, res) => {
    const { book_isbn } = req.body;

    isbn.resolve(book_isbn).then(function (book) {
        return res.json(book);
    }).catch(function (err) {
        res.status(401).json({ error: err });
    });
});

// upload book to bookshelf
bookInfoRouter.post("/api/book/upload", auth, async (req, res) => {
    // req.body only consists of book json from /api/book/info and image link
    const { bookInfo, image } = req.body;
    try {
        // create a new Book document
        let newBook = new Book({
            bookInfo: bookInfo,
            image: image
        });
        await newBook.save();
        const user = await User.findOne({ _id: req.user});
        user.bookList.push(newBook);
        const result = await user.save();
        if (result) {
            res.status(200).json({
                msg: "success",
                result: newBook
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

// delete a book in bookshelf

module.exports = bookInfoRouter;