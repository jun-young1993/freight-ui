// import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freight_ui/services/key_store_service.dart';
import 'package:http/http.dart' as http;

class FreightClient {

  // FreightClient({
  //   required this._keyStoreService
  // }) : _keyStoreService = KeyStoreService();
  final host = dotenv.get('API_HOST');

  final KeyStoreService _keyStoreService;

  FreightClient({
    KeyStoreService? keyStoreService,
  }) : _keyStoreService = keyStoreService ?? KeyStoreService();



  // FreightClient({
  //   this._keyStoreService = const KeyStoreService()
  // });

  Uri getUri(String unencodedPath, { Map<String, dynamic>? queryParameters } ){
    
    return Uri.http(
        host,
        unencodedPath,
        queryParameters
    );
  }

  Future<Map<String, String>> headers() async {
    final String token = await _keyStoreService.getAuthToken();

    return {
      'Authorization': token,
      'Content-Type': 'application/json',
      'accept': '*/*',
      'Accept-Charset': 'utf-8'
    };
  }


  Future<http.Response> get(String endpoint, { Map<String, dynamic>? queryParameters }) async {
      http.Response res =
      await http.get(
          getUri(
            endpoint,
            queryParameters: queryParameters,
          ),
          headers: await headers()
      );

      return res;
  }

  Future<http.Response> post(String endpoint, {Object? body}) async {
    http.Response res = 
    await http.post(
      getUri(
        endpoint,
      ),
      headers: await headers(),
      body: body
    );
    return res;
  }

  Future<http.Response> put(String endpoint, {Object? body}) async {
    http.Response res =
    await http.put(
        getUri(
          endpoint,
        ),
        headers: await headers(),
        body: body
    );
    return res;
  }

  Future<http.Response> delete(String endpoint, {Object? body}) async {
    http.Response res =
    await http.delete(
        getUri(
          endpoint,
        ),
        headers: await headers(),
        body: body
    );
    return res;
  }
  
}