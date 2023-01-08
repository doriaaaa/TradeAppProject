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

- export PATH="$PATH:Desktop/flutter/bin"
- cd server --> run npm run dev

Account: 
adminregister@gmail.com, tradeApp@hku --> login as super@dmin

TODO: 
- Chatroom: 
1. Remove the search function, replace as chatroom UI

Main chatroom page:
When user clicks on the chatroom page
It should display a list of chatroom records
chatroom records should include the message, name and icon of other user
Then user clicks into the chatroom and navigate to the chat page

When user clicks on the chatroom page
User can click the write message button on the top right corner
Then it will display a list of contacts (hardcode for friends temporarily)

Chat page: 
When user navigates to the chat page
It can retrieve latest 10 messages from the database (lazy load when user scrolls up)
User can view the message

When user types a message in the input field and clicks the send button
message will be sent to the api and save to database
database will be uploaded

When the database is uploaded
it will automatically upload the other side of the client