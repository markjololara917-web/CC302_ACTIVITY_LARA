import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class UsersPage extends StatelessWidget {
  Future getUsers() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var users = snapshot.data;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index]['name']),
                subtitle: Text(users[index]['email']),
              );
            },
          );
        },
      ),
    );
  }
}
