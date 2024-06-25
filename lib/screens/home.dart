import 'package:flutter/material.dart';

import 'package:gym_tracker_app/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Ultimos Registros',
            style: mainTitleStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text('Registra y revisa tus ejercicios'),
          const SizedBox(
            height: 24,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 237, 249),
            ),
            child: const Text('Regsitros'),
          )
        ],
      ),
    );
  }
}
