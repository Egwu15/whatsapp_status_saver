import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whatsapp_status_saver/src/screens/homepage/appbarPages/direct_message.dart';
import 'appbarPages/saved_status.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Status Saver WhatsApp',
                  style: Theme.of(context).textTheme.headline1),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.save_alt_outlined,
            ),
            title: const Text('Saved Status'),
            onTap: () {
              Get.back();
              Get.to(() => const SavedStatus());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.message_outlined,
            ),
            title: const Text('Direct chat'),
            onTap: () {
              Get.back();
              Get.to(() => const DirectMessage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.offline_share_outlined),
            title: const Text('Share app'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
