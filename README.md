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
1. Login as super@dmin (this is a sample account)
```
adminregister@gmail.com
tradeApp@hku
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
1. User Management 
- [ ] user can edit the profile picture
- [ ] user can update the password
- [ ] user can list out the category that they are interested in
- [ ] user can send friend request --> notification system
2. Google Analytics 
- [ ] analyse what genres that user likes the most
- [ ] make suggestions on books
3. Comment section in the post
- [ ] other user can comment on the book
- [ ] other user can give ratings to the book
4. Tag system
- [ ] application track how many days that the user has logged in, assign name tag to them