import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Confidence in your words'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'With conversation-based learning you\'ll be talking from lesson one'**
  String get onboardingDesc1;

  /// No description provided for @onboardingBtn1.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingBtn1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Take your time to learn'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Develop a habit of learning and make it a part of your daily routine'**
  String get onboardingDesc2;

  /// No description provided for @onboardingBtn2.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get onboardingBtn2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'The lessons you need to learn'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Using a variety of learning styles to learn and retain'**
  String get onboardingDesc3;

  /// No description provided for @onboardingBtn3.
  ///
  /// In en, this message translates to:
  /// **'Choose a language'**
  String get onboardingBtn3;

  /// No description provided for @skipOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Skip onboarding'**
  String get skipOnboarding;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @promo_auth.
  ///
  /// In en, this message translates to:
  /// **'Join and start learning now'**
  String get promo_auth;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_pass.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgot_pass;

  /// No description provided for @fill_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get fill_email;

  /// No description provided for @fill_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get fill_password;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalid_email;

  /// No description provided for @email_not_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Email isn\'t confirmed'**
  String get email_not_confirmed;

  /// No description provided for @user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User isn\'t found'**
  String get user_not_found;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @fill_field.
  ///
  /// In en, this message translates to:
  /// **'Field required'**
  String get fill_field;

  /// No description provided for @min_lenght.
  ///
  /// In en, this message translates to:
  /// **'6 symbols required'**
  String get min_lenght;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Create one'**
  String get create_account;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// No description provided for @mid_name.
  ///
  /// In en, this message translates to:
  /// **'Middle Name'**
  String get mid_name;

  /// No description provided for @native_lang.
  ///
  /// In en, this message translates to:
  /// **'Native language'**
  String get native_lang;

  /// No description provided for @reg_promo.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get reg_promo;

  /// No description provided for @reg_success.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get reg_success;

  /// No description provided for @reg_fail.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get reg_fail;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @pronunciation.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation'**
  String get pronunciation;

  /// No description provided for @ex_pronunce.
  ///
  /// In en, this message translates to:
  /// **'Words pronunciation'**
  String get ex_pronunce;

  /// No description provided for @new_word.
  ///
  /// In en, this message translates to:
  /// **'New word'**
  String get new_word;

  /// No description provided for @check_pronunciation.
  ///
  /// In en, this message translates to:
  /// **'Сheck pronunciation'**
  String get check_pronunciation;

  /// No description provided for @you_pronounced.
  ///
  /// In en, this message translates to:
  /// **'You pronounced:'**
  String get you_pronounced;

  /// No description provided for @listening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listening;

  /// No description provided for @study_materials.
  ///
  /// In en, this message translates to:
  /// **'Study materials'**
  String get study_materials;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @select_course.
  ///
  /// In en, this message translates to:
  /// **'Selected course'**
  String get select_course;

  /// No description provided for @no_materials.
  ///
  /// In en, this message translates to:
  /// **'No materials for this course'**
  String get no_materials;

  /// No description provided for @zoom_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset zoom'**
  String get zoom_reset;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @of_total.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get of_total;

  /// No description provided for @ask_somethink.
  ///
  /// In en, this message translates to:
  /// **'Ask something...'**
  String get ask_somethink;

  /// No description provided for @ai_chat.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get ai_chat;

  /// No description provided for @add_study_materials.
  ///
  /// In en, this message translates to:
  /// **'Add study materials'**
  String get add_study_materials;

  /// No description provided for @issue_found.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get issue_found;

  /// No description provided for @book_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get book_name;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @select_upload.
  ///
  /// In en, this message translates to:
  /// **'Upload file'**
  String get select_upload;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalid_credentials;

  /// No description provided for @email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get email_already_in_use;

  /// No description provided for @network_error.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get network_error;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @materials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materials;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
