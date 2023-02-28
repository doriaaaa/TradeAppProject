const mongoose = require('mongoose');

// var isbn_code = '9781451578270';

const bookSchema = mongoose.Schema({
    book_isbn: {
        required: true,
        type: String, 
        trim: true,
    }
});

const Book = mongoose.model("Book", bookSchema);
module.exports = Book; // allow public access