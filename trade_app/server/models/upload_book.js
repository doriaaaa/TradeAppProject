const mongoose = require('mongoose');

const upload_bookSchema = mongoose.Schema({
    bookInfo: {
        require: true,
        type: Object
    },
    image: {
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