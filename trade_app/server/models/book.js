const mongoose = require("mongoose");
// this schema only uploads book and the book image

const bookSchema = mongoose.Schema({
  bookInfo: {
    require: true,
    type: Object,
  },
  image: {
    require: true,
    type: String,
  },
});
const Book = mongoose.model("Book", bookSchema);
module.exports = Book; // allow public access
