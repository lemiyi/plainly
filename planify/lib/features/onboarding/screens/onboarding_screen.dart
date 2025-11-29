import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planify/core/constants/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      image: AppAssets.onboarding1,
      title: "Organise ta journée facilement",
      description:
          "Planifie tes tâches, visualise ton emploi du temps et garde toujours un coup d’avance.",
    ),
    OnBoardingModel(
      image: AppAssets.onboarding2,
      title: "Boost ta productivité",
      description:
          "Priorise l’essentiel, élimine le stress et avance vers tes objectifs plus rapidement.",
    ),
    OnBoardingModel(
      image: AppAssets.onboarding3,
      title: "Suis ta progression",
      description:
          "Analyse tes performances, garde ta motivation et célèbre chaque réussite.",
    ),
  ];

  void _finish() {
    if (widget.onDone != null) {
      widget.onDone!();
      return;
    }

    // Default behaviour: navigate to root route. Update this if your app
    // uses named routes (e.g. Routes.todo) or GetX navigation.
    Get.to('/');
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
                      SvgPicture.asset(
                        page.image,
                        height: 220,
                        fit: BoxFit.contain,
                        // placeholderBuilder is shown while the SVG is being loaded
                        placeholderBuilder: (context) => const SizedBox(),
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
