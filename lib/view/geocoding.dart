import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GeocodingScreen extends StatefulWidget {
  const GeocodingScreen({super.key});

  @override
  State<GeocodingScreen> createState() => _GeocodingScreenState();
}

class _GeocodingScreenState extends State<GeocodingScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String _outPut = '';

  @override
  void initState() {
    _addressController.text = 'Rupganj, Narayanganj, Dhaka';
    _latitudeController.text = '23.48';
    _longitudeController.text = '90.32';
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoCoding'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: _latitudeController,
                      decoration: const InputDecoration(hintText: 'Latitude'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      controller: _longitudeController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const InputDecoration(hintText: 'Longitude'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final latitude = double.parse(_latitudeController.text);
                  final longitude = double.parse(_longitudeController.text);
                  placemarkFromCoordinates(latitude, longitude).then((placeMarks) {
                    var output = 'No Result Found';
                    if (placeMarks.isNotEmpty) {
                      output = placeMarks[0].toString();
                    }
                    setState(() {
                      _outPut = output;
                    });
                  });
                },
                child: const Text('Look Up Address'),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addressController,
                    autocorrect: false,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(hintText: 'Address'),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    locationFromAddress(_addressController.text).then((locations) {
                      var output = 'No Result Found';
                      if (locations.isNotEmpty) {
                        output = locations[0].toString();
                      }
                      setState(() {
                        _outPut = output;
                      });
                    });
                  },
                  child: const Text('Look Up Location'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      isPresent().then((isPresent) {
                        var output = isPresent ? 'Is Present' : 'Is Not Present';
                        setState(() {
                          _outPut = output;
                        });
                      });
                    },
                    child: const Text('Is Present'),
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      setLocaleIdentifier('bn-BD').then((_) {
                        setState(() {});
                      });
                    },
                    child: const Text('Set Locale bn-BD'),
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      setLocaleIdentifier('dh-DH').then((_) {
                        setState(() {});
                      });
                    },
                    child: const Text('Set Locale dh-DH'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _outPut,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
