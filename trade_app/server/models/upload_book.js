const mongoose = require('mongoose');

const upload_bookSchema = mongoose.Schema({
    title: {
        require: true,
        type: String,
    },
    author: {
        require: true,
        type: String,
    },
    publisher: {
        require: false,
        type: String,
    },
    bookPictureURL: {
        require: true,
        type: String
    },
    description: {
        require: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 0 || value.length < 100
            },
            message: "Description cannot be null or exceeed word limit"
        }
    }
})

module.exports = upload_bookSchema; // allow public access