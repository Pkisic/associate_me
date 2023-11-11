import 'package:associate_me/views/create_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                  left: 50,
                  bottom: 130,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Associate',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ME',
                      style: TextStyle(
                        color: Colors.red[900],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                    label: const Text('Profile'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(
                        140,
                        40,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                    label: const Text('Settings'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(
                        140,
                        40,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  elevation: 20,
                  textStyle: const TextStyle(fontSize: 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(width: 5),
                  ),
                ),
                icon: const Icon(
                  Icons.play_circle_outlined,
                  size: 60,
                ),
                label: const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                  ),
                  child: Text('Play'),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CreatePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.fiber_new_rounded),
                    label: const Text('Create'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(
                        140,
                        40,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.list),
                    label: const Text('List'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(
                        140,
                        40,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
