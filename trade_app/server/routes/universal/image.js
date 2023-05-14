// imgur upload api
require("dotenv").config();
const express = require("express");
const universalRouter = express.Router();
const axios = require("axios");
const FormData = require("form-data");

universalRouter.post("/api/universal/image", async (req, res, next) => {
  try {
    const imageData = await req.body["image"];
    const formData = new FormData();
    const imgurURL = process.env.IMGUR_UPLOAD_URL;
    formData.append("image", imageData);
    const options = {
      method: "POST",
      url: imgurURL,
      headers: {
        Authorization: `Client-ID ${process.env.CLIENT_ID}`,
        ...formData.getHeaders(),
      },
      data: formData,
    };
    const result = await axios(options);
    // console.log(`axios response: ${JSON.stringify(result.data.data.link)}`);
    if (result) {
      let imageuri = result.data.data.link;
      res.status(200).json({
        msg: "success",
        result: imageuri,
      });
    } else {
      res.status(400).json({
        msg: "failed",
        result: "unknown error occured",
      });
    }
  } catch (e) {
    console.log(e.message);
    res.status(500).json({ error: e.message });
  }
});
module.exports = universalRouter;
