// imgur upload api
require('dotenv').config();
const express = require('express');
const client = new ImgurClient({ 
    accessToken: process.env.ACCESS_TOKEN 
});

// upload img first, then append the property
// uploaded booklist: 
// {
//      img: xxx
//      details: {
// 
//      }
// }