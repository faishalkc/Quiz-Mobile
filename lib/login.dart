import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response =
        await http.post(Uri.parse('https://aovui.my.id/login.php'), body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = jsonDecode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = 'Login gagal';
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/InPage');
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/main.jpg'),
          fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text('Username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: user,
                decoration: const InputDecoration(
                    hintText: 'Masukkan Username',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Masukkan Password',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255)),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: background),
                  onPressed: () {
                    _login();
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 15))),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/Register");
                },
                child: const Text(
                  "Daftar Sekarang!",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                msg,
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
