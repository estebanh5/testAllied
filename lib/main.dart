import 'package:ckuck_norris/joke.dart';
import 'package:ckuck_norris/random_joke_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  Joke? currentJoke;

  @override
  void initState() {
    super.initState();
    _searchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: TextFormField(
                controller: _controller,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
              onPressed: _searchJoke,
              child: const Text("Search Joke"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _searchJoke() async {
    var receivedJoke = await RandomJokesService.loadJoke();
    if (currentJoke == null) {
      _controller.text = receivedJoke.value;
      setState(() {
        currentJoke = receivedJoke;
      });
    } else {
      _checkJoke();
    }
  }

  void _checkJoke() async {
    var receivedJoke = await RandomJokesService.loadJoke();

    if (receivedJoke.id == currentJoke!.id) {
      _checkJoke();
    } else {
      _controller.text = receivedJoke.value;
      setState(() {
        currentJoke = receivedJoke;
      });
    }
  }
}
