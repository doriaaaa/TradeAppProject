# trade_app
Welcome to my CUHK final year project, and let's assume no one will read that lol

###### How-To...
1. Run the backend server
```
cd trade_app/server
npm run dev
```
2. Run on iOS\
The application is incompatible with iOS 16 or above.

3. Run on Android Emulator\
The minimum requirement of Android API is 30.
```
cd trade_app
flutter run
```

###### Testing kit
1. Login as super@dmin (this is a sample account), and I changed the password lol
```
adminregister@gmail.com
tradeApp@hku / TestingDummy
```
2. Changing the IP address in .env

###### WORK:
1. User login / logout
2. User scan barcode and get the book information
3. User upload the photo of the book to Imgur
4. User upload the Imgur photo link, book information, description to write a post
5. Retrieve the uploaded information
6. Responsive design
7. Implement environment variables for frontend and backend application

###### TODO: 
1. User Management API
- [ ] user can edit the profile picture
- [x] user can update the password
- [ ] user can list out the category that they are interested in
- [ ] user can send friend request --> notification system
- [ ] assign special name tag to user
2. Google Analytics 
- [ ] analyse what genres that user likes the most
- [ ] make suggestions on books
3. Book review API
- [ ] Database: set up a book review model
- [ ] create review for the book with specified bookID / bookname
- [ ] get all reviews
- [ ] get one review entry
- [ ] edit the review
- [ ] delete the review
4. Book search API
- [ ] allows users to search for books in the exchange by title, author, genre, or other criteria (simply call google book search api)