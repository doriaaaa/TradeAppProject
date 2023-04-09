const express = require('express');
const User = require("../models/user");
const threadRouter = express.Router();
const auth = require("../middleware/auth");
const Thread = require('../models/thread');

// user create a post
threadRouter.post('/api/thread/createThread', auth, async(req, res) => {
    // req body: title, content
    const { title, content } = req.body;
    try {
        const user = await User.findOne({_id: req.user});
        var countCurrentThreads = await Thread.countDocuments();
        countCurrentThreads++;
        let newThread = new Thread({
            title: title, 
            thread_id: countCurrentThreads, // let comments to recognise the current thread
            content: content,
            author: req.user,
            createdAt: Date.now()
        });
        await newThread.save();
        savedThread = user.threads.push(newThread._id);
        const result = await user.save();
        if (result) {
            res.status(200).json({
                msg: "success",
                result: newThread
            });
        } else {
            console.log("failed");
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// user like the post
threadRouter.put('/api/thread/userLikedThread/:threadId', auth, async(req, res) => {
    const threadId = req.params.threadId;
    try {
        const user = await User.findOne({_id: req.user});
        const thread = await Thread.findOne({thread_id: threadId});

        if (thread.isLikedBy.includes(user._id)) {
            res.status(409).json({
                msg: "failed",
                result: "user has liked the thread"
            });
        } else {
            const result = await Thread.findOneAndUpdate(
                {thread_id: threadId},
                {$addToSet: {isLikedBy: user._id}},
                {new: true}
            );
            if (result) {
                res.status(200).json({
                    msg: "success",
                    result: result
                });
            } else {
                res.status(400).json({
                    msg: "failed",
                    result: "unknown error occured"
                });
            }
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});


// user dislike the post
threadRouter.put('/api/thread/userDislikedThread/:threadId', auth, async(req, res) => {
    const threadId = req.params.threadId;
    try {
        const user = await User.findOne({_id: req.user});
        const thread = await Thread.findOne({thread_id: threadId});

        if (thread.isDislikedBy.includes(user._id)) {
            res.status(409).json({
                msg: "failed",
                result: "user has disliked the thread"
            });
        } else {
            const result = await Thread.findOneAndUpdate(
                {thread_id: threadId},
                {$addToSet: {isDislikedBy: user._id}},
                {new: true}
            );
            if (result) {
                res.status(200).json({
                    msg: "success",
                    result: result
                });
            } else {
                res.status(400).json({
                    msg: "failed",
                    result: "unknown error occured"
                });
            }
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

// get all posts
threadRouter.get('/api/thread/showAllThreads', auth, async(req, res) => {
    try {
        const user  = await User.findOne({_id: req.user});
        const threads = await Thread.find({});
        // console.log(threads);
        var threadsMap = [];

        const promises = threads.map(async (thread) => {
            const res = await findAuthorByThread(thread, user);
            // console.log(res);
            return res; // return the result of findAuthorByThread()
        });
        
        threadsMap = await Promise.all(promises); 

        if (threadsMap) {
            res.status(200).json({
                msg: "success",
                result: threadsMap
            });
        } else {
            console.log("failed");
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});

async function findAuthorByThread(thread, user) {
    const author = await User.findOne({_id: thread.author});
    const res = {
        "title": thread.title,
        "thread_id": thread.thread_id,
        "content": thread.content,
        "author": author.name,
        "likes": thread.isLikedBy.length,
        "dislikes": thread.isDislikedBy.length,
        "comments": thread.comments,
        "createdAt": thread.createAt,
        "userLiked": thread.isLikedBy.includes(user._id),
        "userDisliked": thread.isDislikedBy.includes(user._id),
        "totalComments": thread.comments.length
    }
    return res;
}

module.exports = threadRouter;