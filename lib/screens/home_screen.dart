import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quotesapp/screens/second_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> fetchQuoteAndNavigate(BuildContext context) async {
    var url = Uri.parse('https://zenquotes.io/api/random');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        var quoteData = data[0];
        String quote = quoteData['q'] ?? "No quote available";
        String author = quoteData['a'] ?? "Unknown";

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SecondScreen(
              quoteText: quote,
              authorName: author,
            ),
          ),
        );
      } else {
        print("Error: Unexpected API response format.");
      }
    } else {
      print("Failed to fetch quote. Status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Welcome Quotes App"),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => fetchQuoteAndNavigate(context),
            child: const Text("Get Quote"),
          ),
        ),
      ),
    );
  }
}
