const mongoose = require('mongoose');

// separate with book
const threadSchema = mongoose.Schema({
    title: {
        required: true,
        type: String,
    }, 
    thread_id: { // let comments to recognise current thread
        type: Number,
        required: true
    },
    content: {
        required: true,
        type: String
    },
    author: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User", 
        required: true 
    },
    likes: {
        // length of `isLikedBy`
        type: Number,
        default: 0,
        required: true
    },
    dislikes: {
        // length of `isDislikedBy`
        type: Number,
        default: 0,
        required: true
    }, 
    createAt: {
        type: Date,
        default: Date.now(),
        required: true
    },
    comments: [{ 
        type: mongoose.Schema.Types.ObjectId, 
        ref: "Comment"
    }],
    isLikedBy: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
    }],
    isDislikedBy: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
    }]
});

const Thread = mongoose.model("Thread", threadSchema);
module.exports = Thread;
