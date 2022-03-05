import 'package:http/http.dart' as http;

class TwilloService {
  static Future<void> sendMessage(String to, String body) async {
    var headers = {
      'Authorization':
          'Basic QUNhNGNkNzFjZTFiZDRiYjRmZWI4ZTYyMTZmZTk4MTE4Nzo2OWRlOTRlOGRmNWM3NTcxNWM4MjYxNmUyNzVmNDU1Zg==',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://api.twilio.com/2010-04-01/Accounts/ACa4cd71ce1bd4bb4feb8e6216fe981187/Messages.json'));
    request.bodyFields = {
      'To': to,
      'MessagingServiceSid': 'MG574e61b7bfd4c5be95fcd93bdc726651',
      'Body': body
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {
    }
  }
}
