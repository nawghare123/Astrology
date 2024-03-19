
import 'dart:convert';

import 'package:consultant_product/src/modules/user/KundaliPages/MatchMakingModel.dart';
import 'package:consultant_product/src/modules/user/KundaliPages/panchangModel.dart';
import 'package:http/http.dart' as http;

import '../../../api_services/urls.dart';

class ApiKundali {

  static Future<PanchangModel?> panchangclass(String year, String time) async {


    var url= kundaliurl;
   var request = http.MultipartRequest('POST', Uri.parse(url));
request.fields.addAll({
  'year': year,
  'time': time,
 
});

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  // print(await response.stream.bytesToString());
 
  var res = await response.stream.bytesToString();
List<String> words = res.toString().split(''); // Split the sentence into a list of words
List<String> remainingWords = words.skip(3).toList(); // Skip the first 3 words
String result = remainingWords.join(''); // Join the remaining words back into a string
  
  // print("panchang");
  // print(result);
   final jsonStudent =jsonDecode(result);
     return PanchangModel.fromJson(jsonStudent);
  // print(await response.stream.bytesToString());
    print(jsonStudent);
}
else {
  print(response.reasonPhrase);
}

    // print(jsonDecode(response.body));
    // if(response.statusCode == 200) {
    //   final jsonStudent =jsonDecode(response.body);
    //   return PanchangModel.fromJson(jsonStudent);
    // }
    // else if (response.statusCode == 404) {
    //   return PanchangModel.fromJson(jsonDecode(response.body));
    // } else if (response.statusCode == 400) {
    //   return PanchangModel.fromJson(jsonDecode(response.body));
    // } else if (response.statusCode == 401) {
    //   return PanchangModel.fromJson(jsonDecode(response.body));
    // }else{
    //   throw Exception();
    // }

  }

 static Future<MatchMakingModel?> matchmakingclass(String femaleYear, String femaleTime,String maleYear, String maleTime) async {

var headers = {
  'Content-Type': 'application/json',
  'x-api-key': 'OUuM8UrSzy8FttqZkcaQP3fEro41NORd7AEWO0K6'
};
var request = http.Request('POST', Uri.parse('https://json.freeastrologyapi.com/match-making/ashtakoot-score'));
request.body = json.encode({
  "female": {
    "year": int.parse(maleYear.split('-')[0]),
    "month": int.parse(maleYear.split('-')[1]),
    "date": int.parse(maleYear.split('-')[2]),
    "hours": int.parse(maleTime.split(':')[0]),
    "minutes": int.parse(maleTime.split(':')[1]),
    "seconds": 0,
    "latitude": 16.16667,
    "longitude": 81.1333,
    "timezone": 5.5
  },
  "male": {
    "year": int.parse(femaleYear.split('-')[0]),
    "month": int.parse(femaleYear.split('-')[1]),
    "date": int.parse(femaleYear.split('-')[2]),
    "hours": int.parse(femaleTime.split(':')[0]),
    "minutes": int.parse(femaleTime.split(':')[1]),
    "seconds": 0,
    "latitude": 16.51667,
    "longitude": 80.61667,
    "timezone": 5.5
  },
  "config": {
    "observation_point": "topocentric",
    "language": "en",
    "ayanamsha": "lahiri"
  }
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

  var foo = await response.stream.bytesToString();
  print(request.body);
  print("+++++++++++++++++++++++  pilint kalva diya....");
  print(foo);
if (response.statusCode == 200) {
   final jsonStudent =jsonDecode(foo);
     return MatchMakingModel.fromJson(jsonStudent);
  
}
else {
  print(response.reasonPhrase);
}


// working
// var headers = {
//   'Content-Type': 'application/json',
//   'x-api-key': 'OUuM8UrSzy8FttqZkcaQP3fEro41NORd7AEWO0K6'
// };
// var request = http.Request('POST', Uri.parse('https://json.freeastrologyapi.com/match-making/ashtakoot-score'));
// request.body = json.encode({
//   "female": {
//     "year": 1984,
//     "month": 7,
//     "date": 17,
//     "hours": 11,
//     "minutes": 45,
//     "seconds": 0,
//     "latitude": 16.16667,
//     "longitude": 81.1333,
//     "timezone": 5.5
//   },
//   "male": {
//     "year": 1984,
//     "month": 4,
//     "date": 3,
//     "hours": 9,
//     "minutes": 15,
//     "seconds": 0,
//     "latitude": 16.51667,
//     "longitude": 80.61667,
//     "timezone": 5.5
//   },
//   "config": {
//     "observation_point": "topocentric",
//     "language": "en",
//     "ayanamsha": "lahiri"
//   }
// });
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }




// return 0;
 }
}