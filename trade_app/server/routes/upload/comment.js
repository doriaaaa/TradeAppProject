const express = require('express');
const commentRouter = express.Router();
const Comment = require("../../models/comment");
const auth = require("../../middleware/auth");
const Thread = require('../../models/thread');

// user create comment
commentRouter.post("/api/upload/createComment", auth, async (req, res) => {
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
commentRouter.get('/api/upload/showAllComments/thread/:thread_id', async (req, res) => {
    try {
        const commentsList = await Thread.findOne({ thread_id: req.params.thread_id });
        const commentsObjList = commentsList.comments;
        var commentsMap = [];

        const promises = commentsObjList.map(async (commentObjId) => {
            const res = await findCommentById(commentObjId);
            return res;
        });
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

async function findCommentById(commentObjId) {
    const comment = await Comment.findOne({ _id: commentObjId});
    const res = {
        "body": comment.body,
        "user_id": comment.user_id,
        "comment_id": comment.coment_id,
        "date": comment.date
    }
    return res;
}

// user edit comment

// user delete comment

module.exports = commentRouter;