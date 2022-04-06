//
// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// query : country=eg&apiKey=0f825cc052e54af1ae0c7bf40403a5a7

// https://newsapi.org/
// v2/everything?
// q=tesla & apiKey=0f825cc052e54af1ae0c7bf40403a5a7

import 'package:untitled1/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled1/shared/network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
    ;
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token='';

