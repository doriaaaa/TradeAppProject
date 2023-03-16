import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:trade_app/widgets/reusableWidget.dart';
import 'package:trade_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    var username = context.watch<UserProvider>().user.name;
    return Scaffold(
      appBar: ReusableWidgets.persistentAppBar('Settings'),
      backgroundColor: Colors.white.withOpacity(.94),
      body: ListView(
        padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
        children: <Widget> [
          SimpleUserCard( 
            userName: username, 
            userProfilePic: const AssetImage("assets/avatar.jpg")
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () async {
                  // calling upload image api
                }, 
                icons: CupertinoIcons.person,
                iconStyle: IconStyle(),
                title: 'Appearance',
                subtitle: "Change your avatar!",
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
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () {  Navigator.pushNamed(context, '/about'); },
                icons: Icons.info_rounded,
                iconStyle: IconStyle( backgroundColor: Colors.purple),
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
                onTap: () { Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);},
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
