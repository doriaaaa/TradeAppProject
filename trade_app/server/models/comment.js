const mongoose = require('mongoose');

const commentSchema = mongoose.Schema({
    body: {
        type: String,
        trim: true,
        required: true
    },
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    thread_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Thread'
    },
    comment_id: {
        type: Number
    },
    date: {
        type: Date,
        default: Date.now
    },
});

const Comment = mongoose.model("Comment", commentSchema);
module.exports = Comment;