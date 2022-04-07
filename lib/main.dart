import 'package:api_call/api_response_molde.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    apiCall();
  }

  List<Superheros> _superhero = [];

  setSuperHero(List<Superheros> list) {
    _superhero = list;
    setState(() {});
  }

  apiCall() async {
    var _response = await http.get(
        Uri.parse('https://protocoderspoint.com/jsondata/superheros.json'));

    switch (_response.statusCode) {
      case 200:
        {
          var response = ApiResponse.fromJson(jsonDecode(_response.body));
          setSuperHero(response.superheros!);
          break;
        }

      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: _superhero.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _superhero.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Expanded(
                                flex: 2,

                                child: Center(
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage:
                                        NetworkImage(_superhero[index].url!),
                                  ),
                                )),
                          ),
                          //const Spacer(),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _superhero[index].name!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      _superhero[index].power!,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Divider(
                                      color: Colors.black26,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
