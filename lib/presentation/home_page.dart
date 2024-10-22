import 'package:apodlivetask/data/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  String selectedDate = '';
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apod: Astronomy Picture of the Day"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: isLoading,
            replacement: SizedBox.square(
              dimension: 500,
              child: Visibility(
                visible: imageUrl.isEmpty,
                replacement: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Text("No image found yet!"),
              ),
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2010),
                    lastDate: DateTime.now(),
                  );

                  if (dateTime != null) {
                    final dateFormat = DateFormat('yyyy-MM-dd');
                    final dateTimeFormatted = dateFormat.format(dateTime);
                    setState(() {
                      selectedDate = dateTimeFormatted;
                    });
                  }
                },
                child: Text("Date: $selectedDate"),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    final api = await Api().getData(selectedDate);
                    if (api.url != null && api.mediaType == 'image') {
                      setState(() {
                        imageUrl = api.url!;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Found a image. Please wait for image load!"),
                        ),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Unable to found a image. Please try with new date"),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Unexpected error found!"),
                      ),
                    );
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: const Text('Load a apod'),
              )
            ],
          )
        ],
      ),
    );
  }
}
