import 'dart:convert';
import 'package:pertemuan4_praktikum/helpers/api.dart';
import 'package:pertemuan4_praktikum/helpers/api_url.dart';
import 'package:pertemuan4_praktikum/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;
    var body = {
      "nama": nama,
      "email": email,
      "password": password,
    };

    var response = await Api().post(apiUrl, body);

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonObj = json.decode(response.body);
      return Registrasi.fromJson(jsonObj);
    } else {
      throw Exception("Registrasi gagal: ${response.statusCode} - ${response.body}");
    }
  }
}
