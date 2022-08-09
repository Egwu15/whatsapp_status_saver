import '../services/lunch_url.dart';

class DirectMessageController {
  sendMessage(String phoneNumber, String message) =>
      lunchWhatsappMessage(phoneNumber, message);
}
