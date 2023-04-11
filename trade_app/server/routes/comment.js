const express = require('express');
const commentRouter = express.Router();
const Comment = require("../models/comment");
const auth = require("../middleware/auth");
const Thread = require('../models/thread');
const User = require('../models/user');

// user create comment
commentRouter.post("/api/comment/createComment", auth, async (req, res) => {
    const { body, thread_id } = req.body;
    try {
        // count how many comments in the current thread
        var currentThread = await Thread.aggregate(
        [
            { $match: { thread_id: thread_id } },
            { $project: { comments: { $size: '$comments' } }}
        ]);
        console.log(`Current thread data: ${JSON.stringify(currentThread)}`);
        var totalComments = currentThread[0]['comments'];
        console.log(`Current thread_id: ${thread_id}, Total Comments: ${totalComments}`);
        totalComments++;
        let newComment = new Comment({
            body: body,
            date: Date.now(),
            user_id: req.user,
            thread_id: currentThread[0]["_id"],
            comment_id: totalComments
        });
        await newComment.save();
        const thread = await Thread.findOne({ thread_id: thread_id});
        thread.comments.push(newComment); 
        const threadResult = await thread.save();
        if (threadResult) {
            res.status(201).json({
                msg: "success",
                result: newComment
            });
        } else {
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});
// show all comments
commentRouter.get('/api/comment/showAllComments/thread/:threadId', async (req, res) => {
    try {
        const commentsList = await Thread.findOne({ thread_id: req.params.threadId });
        const commentsObjList = commentsList.comments;
        var commentsMap = [];

        const promises = commentsObjList.map(async (commentObjId) => {
            const res = await findCommentById(commentObjId, req.params.threadId);
            return res;
        });
        // console.log(res);
        commentsMap = await Promise.all(promises); 

        if (commentsMap) {
            res.status(200).json({
                msg: "success",
                result: commentsMap
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

// user delete comment
commentRouter.delete('/api/comment/deleteComment/thread/:threadId/commentId/:commentId', async(req,res) => {
    // require comment_id, thread_id, frontend(only allow user to edit the comment)
    // update comment id? --> replace comment as "this comment is deleted", replace comment_id as 9999.


});

// user edit comment
commentRouter.put('/api/comment/editComment/thread/:threadId/commentId/:commentId', async(req, res) => {
    try {
        const { body, thread_id, comment_id } = req.body;
        // console.log(`comment_id = ${comment_id}`);
        // console.log(`thread_id = ${thread_id}`);
        const thread = await Thread.findOne({thread_id: thread_id});
        const comment = await Comment.findOneAndUpdate(
            { thread_id: thread._id, comment_id: comment_id},
            { $set: { 
                body: body,
                date: Date.now()
            } },
            { new: true } 
        );
        console.log(comment);
        if (comment) {
            res.status(200).json({
                msg: "success",
                result: comment
            });
        } else {
            console.log("failed");
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
    } catch(e) {
        return res.status(500).json({ error: e.message });
    }
});

async function findCommentById(commentObjId, thread_id) {
    const comment = await Comment.findOne({ _id: commentObjId});
    const user = await User.findOne({_id: comment.user_id});
    const res = {
        "body": comment.body,
        "username": user.name,
        "userId": user.userId,
        "thread_id": parseInt(thread_id),
        "comment_id": comment.comment_id,
        "date": comment.date
    }
    return res;
}

module.exports = commentRouter;