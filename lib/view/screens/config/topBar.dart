// ignore: file_names
import 'package:flutter/material.dart';

//logo and name with cni
class AppName extends StatelessWidget {
  const AppName({Key? key, this.name, this.email}) : super(key: key);
  final String? name;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Image.asset(
              'assets/images/TABIBI.png',
              width: 160,
              height: 100,
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " $name",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      ' $email',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
