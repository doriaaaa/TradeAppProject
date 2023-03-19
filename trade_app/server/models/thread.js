const mongoose = require('mongoose');

// separate with book
const threadSchema = mongoose.Schema({
    title: {
        required: true,
        type: String,
    }, 
    thread_id: { // let comments to recognise current thread
        type: Number,
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
        type: Number,
        default: 0
    },
    views: {
        type: Number,
        default: 0
    }, 
    createAt: {
        type: Date,
        default: Date.now()
    },
    comments: [{ 
        type: mongoose.Schema.Types.ObjectId, 
        ref: "Comment"
    }]
});

const Thread = mongoose.model("Thread", threadSchema);
module.exports = Thread;
