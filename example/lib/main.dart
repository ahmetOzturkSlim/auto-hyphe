import 'package:auto_hyphe/auto_hyphe.dart';
import 'package:flutter/material.dart';

void main() {
	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Auto Hyphe Demo',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),
			home: const GermanExample(title: 'Auto Hyphe Demo'),
		);
	}
}

class GermanExample extends StatefulWidget {
	const GermanExample({super.key, required this.title});

	final String title;

	@override
	State<GermanExample> createState() => _GermanExampleState();
}

class _GermanExampleState extends State<GermanExample> {

	late Future<void> initOperation;

	@override
	void initState() {
		super.initState();
		initOperation = initHyphenation(DefaultResourceLoaderLanguage.de1996);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: FutureBuilder<void>(
				future: initOperation,
				builder: (_, AsyncSnapshot<void> snapshot) {
					if (snapshot.connectionState == ConnectionState.done) {
						return Center(
							child: Container(color:Colors.amber,width: 100,child: AutoHyphe('Ändern Sie die Größe dieses Fensters, um die automatische Silbentrennung in Aktion zu sehen.',maxWidthOfLine: 0.7,)),
						);
					} else {
						return const Center(
							child: SizedBox(
								height: 40,
								width: 40,
								child: CircularProgressIndicator(),
							),
						);
					}
				},
			),
		);
	}
}
