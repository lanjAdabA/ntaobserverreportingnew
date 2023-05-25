import 'package:appntaproject/models/login.model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedInPage extends StatefulWidget {
  final NtaLoginModel alldata;
  const LoggedInPage({super.key, required this.alldata});
  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

@override
class _LoggedInPageState extends State<LoggedInPage> {
  String? latitude;
  String? longitude;
  String finallocation = '';
  Position? _position;
  String? _currentAddress;

  @override
  void initState() {
    _getCurrentLocation(setState);
    super.initState();
  }

  void _getCurrentLocation(void Function(void Function()) setState) async {
    Position position = await determinePosition();
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _position = position;
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      finallocation = "$latitude,$longitude";
    });

    prefs.setString("finalLocation", finallocation);
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/splash.png"),
                      fit: BoxFit.cover)),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Image.asset("assets/ntalogo.png"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: .8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 233, 226)
                              .withOpacity(.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          //? login id name section
                          RichText(
                            text: TextSpan(
                              text: 'Logged in as : ',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.alldata.data.name.toString(),
                                    style: const TextStyle(fontSize: 17)),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.all(12),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 235, 233, 226)
                                  .withOpacity(.3),
                            ),
                            child: Column(
                              children: [
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                    onPressed: () {
                                      // _getCurrentLocation(setState);
                                    },
                                    icon: const Icon(Icons.location_on),
                                    label: const Text("Click to report duty")),
                                _position != null
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "Latitude : ",
                                                ),
                                                Text(
                                                  latitude!,
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Longitude : ',
                                                ),
                                                Text(
                                                  longitude!,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : const Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Latitude : ....................",
                                          ),
                                          Text(
                                            'Longitude : .................. ',
                                          )
                                        ],
                                      ),
                                const Text(
                                    "// readable address to be displayed here"),
                                if (_currentAddress != null)
                                  Text(_currentAddress!),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 56,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout")),
                ],
              ))),
    );
  }
}
// 