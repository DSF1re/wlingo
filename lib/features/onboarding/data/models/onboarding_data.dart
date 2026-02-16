import 'package:wlingo/l10n/app_localizations.dart';

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;
  final String buttonText;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.buttonText,
  });

  static List<OnboardingData> getOnboardingData(AppLocalizations loc) {
    return [
      OnboardingData(
        title: loc.onboardingTitle1,
        description: loc.onboardingDesc1,
        imagePath: 'assets/images/ob1.png',
        buttonText: loc.onboardingBtn1,
      ),
      OnboardingData(
        title: loc.onboardingTitle2,
        description: loc.onboardingDesc2,
        imagePath: 'assets/images/ob2.png',
        buttonText: loc.onboardingBtn2,
      ),
      OnboardingData(
        title: loc.onboardingTitle3,
        description: loc.onboardingDesc3,
        imagePath: 'assets/images/ob3.png',
        buttonText: loc.onboardingBtn3,
      ),
    ];
  }
}
