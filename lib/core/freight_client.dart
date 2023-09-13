// import 'dart:core';
import 'package:http/http.dart' as http;

class FreightClient {
  
  

  Uri getUri(String unencodedPath, { Map<String, dynamic>? queryParameters } ){
    return Uri.http('158.180.82.177:3000',unencodedPath, queryParameters);
  }


  Future<http.Response> get(String endpoint) async {
    http.Response res = 
      await http.get(getUri(endpoint));
    return res;
  }
  
  
}