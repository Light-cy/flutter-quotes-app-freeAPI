import 'package:http/http.dart' as http;
import 'package:quotes_app/constants/get_responses.dart';
import 'package:quotes_app/constants/strings.dart';
import 'package:quotes_app/services/quotes.dart';

class QuotesApi {
  Future<Quotes> getRandomQuote() async {
    Uri url = Uri.parse(randomQuote);
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      return quotesFromJson(res.body);
    } else {
      throw (HttpStatusHandler.getMessage(res.statusCode));
    }
  }
}
