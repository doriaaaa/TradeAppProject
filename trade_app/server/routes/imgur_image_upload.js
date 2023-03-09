// imgur upload api
require('dotenv').config();
const express = require('express');
const imgurRouter = express.Router();
const axios = require('axios');
const fs = require('fs');
const FormData = require('form-data');

imgurRouter.post('/uploadImage', async (req, res, next) => { 
    // console.log(req.body);
    try {
        const imageData = fs.readFileSync(req.body['image'], {encoding: 'base64'});
        const formData = new FormData();
        const imgurURL = process.env.IMGUR_UPLOAD_URL;
        formData.append("image", imageData);
        const options = {
            method: "POST",
            url: imgurURL, 
            headers: {
                'Authorization': `Client-ID ${process.env.CLIENT_ID}`,
                ...formData.getHeaders()
            },
            data: formData
        }
        const result = await axios(options);
        console.log(`axios response: ${JSON.stringify(result.data.data.link)}`);
        if (result) {
            let imageuri = result.data.data.link;
            res.status(200).json({
                msg: "success",
                result: imageuri
            });
        } else {
            res.status(400).json({
                msg: "failed",
                result: "unknown error occured"
            });
        }
        // console.log(res.status(200).send(result.data));
        // return result.data;
    } catch (e) {
        res.status(500).json({ error: e.message });
        // return res.status(500).json({ error: e.message });
    }
});
module.exports = imgurRouter;
