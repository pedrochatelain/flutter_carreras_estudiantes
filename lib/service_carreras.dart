import 'dart:convert';

import 'package:app_material_3/Album.dart';
import 'package:http/http.dart' as http;

class ServiceCarrera {
  Future<Album> fetchAlbum() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () async {
        final response = await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          return Album.fromJson(jsonDecode(response.body));
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      },
    );
  }
}
