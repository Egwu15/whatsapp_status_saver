import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_status_saver/src/config/config.dart';

lunchUrl(String phoneNumber, String message) async {
  String urlEncodedMessage = Uri.encodeComponent(message);
  String link = "${Config.chatLink}${phoneNumber.trim().replaceAll(' ', '')}?text=$urlEncodedMessage";
  Uri url = Uri.parse(link);

  if (!await launchUrl(url,mode: LaunchMode.externalApplication)) throw 'Could not launch $link}';
}
