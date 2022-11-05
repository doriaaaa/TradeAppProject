// const request = require('request');
// const cheerio = require('cheerio');
// const fs = require('fs');

const isbn = require('node-isbn');

var isbn_code = '9781451578270';

isbn.resolve(isbn_code).then(function (book) {
    console.log('Book found %j', book);
}).catch(function (err) {
    console.log('Book not found', err);
});