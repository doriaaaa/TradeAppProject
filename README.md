# trade_app
CUHK final year project

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

Minimum requirement for android: API 30 (in emulator and physical device)
```
flutter run
```

###### TODO: 
1. upload page -- scan isbn button
- [x] information is fetched and store in a variable --> user can access the variable by clicking "view details"
2. upload page -- upload image
- [x] clicking the grey button should appear an image picker
- [x] after user selects the image, it should display in the image box
3. upload page -- upload book
- [x] information should be stored in database
4. upload page -- cancel button
- [x] clear the form
- replaced with back --> cancel button
5. upload page -- beautify camera page
- [x] when barcode is found, use a sliding panel to display information
- [x] found barcode should redirect user to the upload page
6. upload page -- save information temporarily
- [x] create a form variable to store the photo path / book info

## add-ons:
what extra features to add
--> forumlise the apps

- google analytics --> search by keywords (filter by categories)
- user A can add the categories --> user B can search by categories, or auto notifications
- users can send a request --> allow other users to see that

- auto matching in a group 
- create a community, knowledge exchange (reddit/futu)