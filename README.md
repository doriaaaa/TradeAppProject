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
testingDummy
```
2. Changing the IP address in .env
~~3. To access chatGPT function, you need to setup overseas vpn and set up split tunneling config (for emulator?)~~

###### WORK:
1. User login / logout
2. User scan barcode and get the book information
3. User upload the photo of the book to Imgur
4. User upload the Imgur photo link, book information, description to write a post
5. Retrieve the uploaded information
6. Responsive design
7. Implement environment variables for frontend and backend application
8. Light / Dark mode
9. Users change password
10. Home Page UI
11. User upload profile pic
12. ChatGPT replaces searchPage
13. Like / Dislike System for threads
14. Create thread from books / suggestions
15. Recommendations

###### FIX:
- [ ] user profile pic in discussionPage
- [ ] view user info
- [ ] add book to favourites
- [x] search history
- [ ] search result display info --> use upload page template

###### TODO: 
1. User Management API
- [x] user can edit the profile picture
- [x] user can update the password
- [x] user like system
- [x] user dislike system
- [ ] user can list out the category that they are interested in
- [ ] user can send friend request --> notification system
- [ ] assign special name tag to user 
2. ~~Google Analytics~~ 
- [ ] ~~analyse what genres that user likes the most~~
- [x] make suggestions on books
3. Book review API
- [x] Database: set up a book review model
- [x] create review for the book with specified bookID / bookname
- [x] get all reviews
- [ ] ~~get one review entry~~
- [x] edit the review
- [ ] ~~delete the review~~
4. Book search API
- [x] allows users to search by book name

###### BACKEND:
1. [x] Build Post Schema (linked to user) --> adjust the existing book schema
2. [x] Build Comment Schema

###### API ENDPOINTS:
1. User
- [x] POST&nbsp;/api/user/account/signIn
- [x] POST&nbsp;/api/user/account/signUp
- [x] POST&nbsp;/api/user/account/changePassword
- [x] POST&nbsp;/api/user/account/updateProfilePicture
- [x] GET &nbsp;/api/user/book/bookList
- [ ] GET &nbsp;/api/user/info/:username

2. Auth
- [x] POST&nbsp;/api/auth/tokenIsValid

3. Thread
- [x] POST&nbsp;/api/thread/createThread
- [x] GET &nbsp;/api/thread/showAllThreads
- [x] PUT &nbsp;/api/thread/userLikedThread/:threadId
- [x] PUT &nbsp;/api/thread/userDislikedThread/:threadId

4. Comment
- [x] POST&nbsp;/api/comment/createComment
- [x] GET &nbsp;/api/comment/showAllComments/thread/:threadId
- [ ] DELETE&nbsp;/api/comment/deleteComment/thread/:threadId/commentId/:commentId
- [x] PUT &nbsp;/api/comment/editComment/thread/:threadId/commentId/:commentId

4. Book
- [x] POST&nbsp;/api/book/info
- [x] POST&nbsp;/api/book/upload

5. Universal
- [x] POST&nbsp;/api/universal/image