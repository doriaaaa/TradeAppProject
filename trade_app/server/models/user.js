const mongoose = require('mongoose');
const upload_bookSchema = require("./upload_book");

// set user model
// link the booklist to user

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String, 
        trim: true,
    },
    email: {
        required: true,
        type: String, 
        trim: true, 
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter a valid email address',
        }
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 6;
            },
            message: 'Please enter a valid password',
        }
    },
    profilePicture: {
        required: false,
        default: '',
        type: String
    },
    type: {
        type: String,
        default: 'user',
    },
    uploadedBookList: {
        type: Array,
        of: upload_bookSchema
    }
});
const User = mongoose.model("User", userSchema);
module.exports = User; // allow public access