# trade_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

How to run the app:
```
export PATH="$PATH:Desktop/flutter/bin"
npm run dev --> in server folder
```

Login as super@dmin: 
```
adminregister@gmail.com --> account
tradeApp@hku --> password
```
###### TODO: 
1. Primary work:
- [ ] Remove the search function, replace as chatroom UI

2. Chatroom lobby page:
- [ ] Chatroom UI
> When user clicks on the chatroom page\
> It should display a list of chatroom records\
> chatroom records should include the message, name and icon of other user\
> Then user clicks into the chatroom and navigate to the chat page
- [ ] Chatroom button
> When user clicks on the chatroom page\
> User can click the write message button on the top right corner\
> Then it will display a list of contacts (hardcode for friends temporarily)

3. Chatroom page: 
- [ ] Main Chatroom
> When user navigates to the chat page\
> It can retrieve latest 10 messages from the database (lazy load when user scrolls up)\
> User can view the message
- [ ] Send Message
> When user types a message in the input field and clicks the send button\
> message will be sent to the api and save to database\
> database will be uploaded
- [ ] Upload DB
> When the database is uploaded\
> it will automatically upload the other side of the client

###### Wrap up
1. upload page -- scan isbn button
- [ ] information is fetched and store in a variable --> user can access the variable by clicking "view details"
2. upload page -- upload image
- [x] clicking the grey button should appear an image picker
- [x] after user selects the image, it should display in the image box
3. upload page -- upload book
- [ ] information should be stored in database
4. upload page -- cancel button
- [ ] clear the form
5. upload page -- beautify camera page
- [ ] when barcode is found, use a sliding panel to display information
- [ ] found barcode should redirect user to the upload page
6. upload page -- save information temporarily
- [ ] create a form variable to store the photo path / book info