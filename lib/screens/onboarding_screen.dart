import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wlingo/main.dart';
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
  bool _isLoading = true;

  // Ключи для SharedPreferences
  static const String _currentPageKey = 'onboarding_current_page';
  static const String _languageKey = 'app_language';
  static const String _themeModeKey = 'app_theme_mode';
  static const String _onboardingCompletedKey = 'onboarding_completed';

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  // Загрузка сохраненного состояния
  Future<void> _loadSavedState() async {
    final prefs = await SharedPreferences.getInstance();

    // Загрузить текущую страницу
    final savedPage = prefs.getInt(_currentPageKey) ?? 0;

    setState(() {
      _currentPage = savedPage;
      _isLoading = false;
    });

    // Перейти на сохраненную страницу
    if (savedPage > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(savedPage);
      });
    }
  }

  // Сохранить текущую страницу
  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentPageKey, page);
  }

  // Сохранить язык
  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  // Сохранить тему
  Future<void> _saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode);
  }

  // Очистить состояние онбординга и отметить как завершенный
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentPageKey);
    await prefs.setBool(_onboardingCompletedKey, true);
  }

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

  void _toggleLanguage() async {
    final newLocale = localeNotifier.value.languageCode == 'ru'
        ? const Locale('en')
        : const Locale('ru');

    localeNotifier.value = newLocale;
    await _saveLanguage(newLocale.languageCode);
  }

  void _toggleTheme() async {
    final newThemeMode = themeModeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    themeModeNotifier.value = newThemeMode;
    await _saveThemeMode(newThemeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                    onPageChanged: (index) async {
                      setState(() => _currentPage = index);
                      await _saveCurrentPage(index);
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
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
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
                onPressed: _toggleLanguage,
                child: const Icon(Icons.language),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                mini: true,
                heroTag: 2,
                onPressed: _toggleTheme,
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

  void _skipOnboarding() async {
    await _completeOnboarding(); // Отметить онбординг как завершенный
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
