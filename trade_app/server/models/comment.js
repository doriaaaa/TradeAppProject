const mongoose = require("mongoose");

const commentSchema = mongoose.Schema({
  body: {
    type: String,
    trim: true,
    required: true,
  },
  user_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  thread_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Thread",
    required: true,
  },
  comment_id: {
    type: Number,
    required: true,
  },
  date: {
    type: Date,
    default: Date.now(),
    required: true,
  },
});

const Comment = mongoose.model("Comment", commentSchema);
module.exports = Comment;
