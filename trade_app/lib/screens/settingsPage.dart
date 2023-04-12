import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/user/userAccountService.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  File? pickedImage;
  bool _isToggled = false;

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    return prefs.setBool("switchState", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isToggled = prefs.getBool("switchState")!;

    if(context.mounted) {
      if (Theme.of(context).brightness == Brightness.dark) {
        setState(() {
          _isToggled = true;
        });
      } else {
        setState(() {
          _isToggled = false;
        });
      }
    }
    // setState(() {});
    return _isToggled;
  }

  @override
  void initState() {
    super.initState();
    getSwitchState();
  }

  @override
  Widget build(BuildContext context) {
    String username = context.watch<UserProvider>().user.name;
    String profilePicture = context.watch<UserProvider>().user.profilePicture;
    // print(profilePicture);

    void _updateProfilePicture(File? pickedImage) {
      userAccountService().updateProfilePicture(context: context, image: pickedImage);
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
              : CachedNetworkImageProvider(profilePicture),
          ),
          SettingsGroup(
            settingsGroupTitle: "Personalization",
            items: [
              SettingsItem(
                onTap: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? image = await picker.pickImage(source: ImageSource.gallery);
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
                subtitle: "Change app theme",
                trailing: Switch.adaptive(
                  value: _isToggled,
                  onChanged: (value) {
                    setState(() {
                      _isToggled = value;
                      saveSwitchState(value);
                    });
                    if (_isToggled) {
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                    } else {
                      MyApp.of(context).changeTheme(ThemeMode.light);
                    }
                  },
                ),
              ),
            ],
          ),
          SettingsGroup(
            settingsGroupTitle: "Enquiry",
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
                  userAccountService().logout(context);
                },
                icons: Icons.exit_to_app_rounded,
                title: "Sign Out",
              ),
              SettingsItem(
                onTap: () { Navigator.pushNamed(context, '/changePassword'); },
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
