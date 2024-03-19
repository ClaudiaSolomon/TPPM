import "dart:convert";
import 'dart:io';

//4
Map<String,dynamic> jsonSubJson(String jsonPath1, String jsonPath2)
{
  Map<String, dynamic> json1 = jsonDecode(File(jsonPath1).readAsStringSync());
  Map<String, dynamic> json2 = jsonDecode(File(jsonPath2).readAsStringSync());
  json1.removeWhere((key, value) => json2.containsKey(key));

  return json1;
}