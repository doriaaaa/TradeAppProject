// imgur upload api
require('dotenv').config();
const express = require('express');
const imgurRouter = express.Router();
const request = require('request');

imgurRouter.post('/uploadImage', async (req, res, next) => { 
    console.log(req.body);
    try {
        
    } catch (e) {
        return res.status(500).json({ error: e.message });
    }
});
// upload img first, then append the property
// uploaded booklist: 
// {
//      img: xxx
//      details: {
// 
//      }
// }
