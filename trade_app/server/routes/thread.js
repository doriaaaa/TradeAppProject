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

// user delete a post

// user edit a post

// get all posts
threadRouter.get('/api/thread/showAllThreads', async(req, res) => {
    try {
        const threads = await Thread.find({});
        console.log(threads);
        var threadsMap = [];

        const promises = threads.map(async (thread) => {
            const res = await findAuthorByThread(thread);
            console.log(res);
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

async function findAuthorByThread(thread) {
    const author = await User.findOne({_id: thread.author});
    // console.log(author.name);
    // console.log(thread.title)
    const res = {
        "title": thread.title,
        "thread_id": thread.thread_id,
        "content": thread.content,
        "author": author.name,
        "likes": thread.likes,
        "comments": thread.comments,
        "views": thread.views,
        "createdAt": thread.createAt
    }
    return res;
}

module.exports = threadRouter;