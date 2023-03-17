import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/services/userAction.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  File? pickedImage;
  bool _isToggled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String username = context.watch<UserProvider>().user.name;
    String profilePicture = context.watch<UserProvider>().user.profilePicture;

    void _updateProfilePicture(File? pickedImage) {
      AuthService().updateProfilePicture(context: context, image: pickedImage);
    }

    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Settings'),
      // backgroundColor: Colors.white.withOpacity(.94),
      body: ListView(
        padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
        children: <Widget>[
          SimpleUserCard(
            userName: username,
            userProfilePic: profilePicture == ""
                ? const AssetImage('assets/default.jpg') as ImageProvider
                : NetworkImage(profilePicture),
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    pickedImage = File(image.path);
                    // debugPrint(image.path);
                    _updateProfilePicture(pickedImage);
                  }
                },
                icons: CupertinoIcons.person,
                iconStyle: IconStyle(),
                title: 'Appearance',
                subtitle: "Change profile picture",
              ),
              SettingsItem(
                onTap: () {},
                icons: Icons.dark_mode_rounded,
                iconStyle: IconStyle(
                  iconsColor: Colors.white,
                  withBackground: true,
                  backgroundColor: Colors.black54,
                ),
                title: 'Dark mode',
                subtitle: "TODO",
                trailing: Switch.adaptive(
                  value: _isToggled,
                  onChanged: (value) {
                    setState(() {
                      _isToggled = value;
                    });
                    if (_isToggled) {
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                    } else {
                      MyApp.of(context).changeTheme(ThemeMode.light);
                    }
                    // MyApp.of(context).changeTheme(ThemeMode.dark);
                  },
                ),
              ),
            ],
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
                icons: Icons.info_rounded,
                iconStyle: IconStyle(backgroundColor: Colors.purple),
                title: 'About',
                subtitle: "More details",
              ),
            ],
          ),
          // You can add a settings title
          SettingsGroup(
            settingsGroupTitle: "Account",
            items: [
              SettingsItem(
                onTap: () {
                  AuthService().userLogout(context);
                },
                icons: Icons.exit_to_app_rounded,
                title: "Sign Out",
              ),
              SettingsItem(
                onTap: () {
                  Navigator.pushNamed(context, '/changePassword');
                },
                icons: CupertinoIcons.repeat,
                title: "Change Password",
              ),
              SettingsItem(
                onTap: () {},
                icons: CupertinoIcons.delete_solid,
                title: "Delete account",
                subtitle: "Wait for implementation",
                titleStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
