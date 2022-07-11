import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_status_saver/src/config/config.dart';

lunchUrl(String phoneNumber) async {
  String link = "${Config.chatLink}${phoneNumber.trim().replaceAll(' ', '')}";
  Uri url = Uri.parse(link);

  if (!await launchUrl(url)) throw 'Could not launch $link}';
}
