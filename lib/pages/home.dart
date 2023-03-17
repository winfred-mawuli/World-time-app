import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/choose_location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments;
    print(data);

    //set Background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    dynamic bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic results = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ChooseLocation();
                        },
                      ),
                    );
                    setState(() {
                      data = {
                        'time': results['time'],
                        'location': results['location'],
                        'isDaytime': results['isDaytime'],
                        'flags': results['flags'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location, color: Colors.grey[300]),
                  label: Text(
                    'Edit location',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: const TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(data['time'],
                    style:
                        const TextStyle(fontSize: 66.0, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
