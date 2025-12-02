import 'package:flutter/material.dart';
import 'package:planify/features/home/widgets/next_task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: NextTaskCard(),
              ),
              // Container(height: 200, color: Colors.green),
              // Container(height: 200, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
