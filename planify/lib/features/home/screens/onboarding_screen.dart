import 'package:flutter/material.dart';
import 'package:planify/data/models/onboarding/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.onDone});

  /// Optional callback called when the user finishes OnboardingScreen.
  final VoidCallback? onDone;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _index = 0;

  final List<OnBoardingModel> boards = [
    OnBoardingModel(
      image: 'assets/images/OnboardingScreen1.png',
      title: 'Welcome to Planify',
      description: 'Your personal task manager to boost productivity.',
    ),
    OnBoardingModel(
      image: 'assets/images/OnboardingScreen2.png',
      title: 'Organize Your Tasks',
      description: 'Easily create, edit, and manage your daily tasks.',
    ),
    OnBoardingModel(
      image: 'assets/images/OnboardingScreen3.png',
      title: 'Stay Notified',
      description: 'Get timely reminders to never miss a deadline.',
    ),
  ];

  void _finish() {
    if (widget.onDone != null) {
      widget.onDone!();
      return;
    }

    // Default behaviour: navigate to root route. Update this if your app
    // uses named routes (e.g. Routes.todo) or GetX navigation.
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    final page = boards[_index];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (page.image.isNotEmpty)
                      Image.asset(
                        page.image,
                        height: 220,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stack) =>
                            const SizedBox(),
                      ),
                    const SizedBox(height: 24),
                    Text(
                      page.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      page.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              // Dots & buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  boards.length,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: _index == i ? 12 : 8,
                    height: _index == i ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _index == i
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  TextButton(onPressed: _finish, child: const Text('Skip')),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (_index < boards.length - 1) {
                        setState(() => _index++);
                      } else {
                        _finish();
                      }
                    },
                    child: Text(
                      _index < boards.length - 1 ? 'Next' : 'Get started',
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
