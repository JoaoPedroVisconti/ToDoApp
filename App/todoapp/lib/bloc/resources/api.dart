import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todoapp/models/classes/user.dart';
// import 'package:http/http.dart' as http;

class ApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  Future<User> registerUser(String username, String firstname, String lastname, String password, String email) async {
    final response = await client
        .post("http://10.0.2.2:5000/api/register", //Have to use this server for android configure in the emulator proxy as well
        //headers: "",
        body: jsonEncode({
          "email" : email,
        	"username" : username,
	        "password" : password,
        	"firstname" : firstname,
	        "lastname" : lastname	
        }
        )
        );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
      return User.fromJson(result["data"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future signinUser(String username, String password) async {
    final response = await client
        .post("http://10.0.2.2:5000/api/signin", //Have to use this server for android configure in the emulator proxy as well
        body: jsonEncode({
          "username" : username,
	        "password" : password,
        }
        )
        );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
  //Storing the api key on the device
  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("API_Token", api_key);
  }
}