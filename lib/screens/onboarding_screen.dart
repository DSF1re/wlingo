import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/services/preferences_service.dart';
import 'package:wlingo/models/onboarding.dart';
import 'package:wlingo/screens/auth_screen.dart';
import 'package:wlingo/widgets/dots_indicator.dart';

import '../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingData> get _onboardingData {
    final loc = AppLocalizations.of(context)!;
    return [
      OnboardingData(
        title: loc.onboardingTitle1,
        description: loc.onboardingDesc1,
        imagePath: 'assets/images/onboarding1.png',
        buttonText: loc.onboardingBtn1,
      ),
      OnboardingData(
        title: loc.onboardingTitle2,
        description: loc.onboardingDesc2,
        imagePath: 'assets/images/onboarding2.png',
        buttonText: loc.onboardingBtn2,
      ),
      OnboardingData(
        title: loc.onboardingTitle3,
        description: loc.onboardingDesc3,
        imagePath: 'assets/images/onboarding3.png',
        buttonText: loc.onboardingBtn3,
      ),
    ];
  }

  late PreferencesService _preferencesService;
  late OptionsRepository _optionsRepository;

  @override
  void initState() {
    super.initState();
    _preferencesService = GetIt.I<PreferencesService>();
    _optionsRepository = GetIt.I<OptionsRepository>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Flexible(
                  flex: 7,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      return _buildOnboardingPage(_onboardingData[index]);
                    },
                  ),
                ),
                DotsW(
                  onboardingData: _onboardingData,
                  currentPage: _currentPage,
                ),
                SizedBox(
                  height: screenHeight * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _onboardingData[_currentPage].title,
                          style: theme.textTheme.labelLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _onboardingData[_currentPage].description,
                          style: theme.textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage < _onboardingData.length - 1) {
                              _nextPage();
                            } else {
                              _skipOnboarding();
                            }
                          },
                          child: Text(
                            _onboardingData[_currentPage].buttonText,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _skipOnboarding,
                        child: Text(
                          AppLocalizations.of(context)!.skipOnboarding,
                          style: theme.textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                mini: true,
                heroTag: 1,
                onPressed: _optionsRepository.toggleLanguage,
                child: const Icon(Icons.translate),
              ),
              SizedBox(width: 8),
              FloatingActionButton(
                mini: true,
                heroTag: 2,
                onPressed: () {
                  _optionsRepository.toggleTheme();
                },
                child: const Icon(Icons.brightness_6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Center(
      child: AspectRatio(
        aspectRatio: 0.6,
        child: Image.asset(data.imagePath, fit: BoxFit.contain),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _skipOnboarding() async {
    await _preferencesService.saveOnboardingCompleted(true);
    if (mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
