const mongoose = require("mongoose");
const Book = require("./book");
const Thread = require("./thread");
const Comment = require("./comment");

// set user model
// link the booklist to user
// suppose to fetch things from user, you dont associate user with other things

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  userId: {
    required: true,
    type: Number,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
    validate: {
      validator: (value) => {
        return value.length > 6;
      },
      message: "Please enter a valid password",
    },
  },
  profilePicture: {
    required: false,
    default: "",
    type: String,
  },
  type: {
    type: String,
    default: "user",
  },
  bookList: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Book",
    },
  ],
  threads: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Thread",
    },
  ],
});
const User = mongoose.model("User", userSchema);
module.exports = User; // allow public access
