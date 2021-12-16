// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `IV, EV and Stats Calculator`
  String get appTitle {
    return Intl.message(
      'IV, EV and Stats Calculator',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate EV`
  String get homePageCalculateEvButton {
    return Intl.message(
      'Calculate EV',
      name: 'homePageCalculateEvButton',
      desc: '',
      args: [],
    );
  }

  /// `Calculate IV`
  String get homePageCalculateIvButton {
    return Intl.message(
      'Calculate IV',
      name: 'homePageCalculateIvButton',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Stats`
  String get homePageCalculateStatsButton {
    return Intl.message(
      'Calculate Stats',
      name: 'homePageCalculateStatsButton',
      desc: '',
      args: [],
    );
  }

  /// `"Pokemon" is a trademark of "The Pokémon Company". This app is not affiliated with or endorsed by "The Pokémon Company".`
  String get homepageDisclaimer {
    return Intl.message(
      '"Pokemon" is a trademark of "The Pokémon Company". This app is not affiliated with or endorsed by "The Pokémon Company".',
      name: 'homepageDisclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get headerOptions {
    return Intl.message(
      'Options',
      name: 'headerOptions',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get headerOptionsClear {
    return Intl.message(
      'Clear',
      name: 'headerOptionsClear',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get headerOptionsCancel {
    return Intl.message(
      'Cancel',
      name: 'headerOptionsCancel',
      desc: '',
      args: [],
    );
  }

  /// `Please select a nature.`
  String get validationNature {
    return Intl.message(
      'Please select a nature.',
      name: 'validationNature',
      desc: '',
      args: [],
    );
  }

  /// `Please select all stats.`
  String get validationStats {
    return Intl.message(
      'Please select all stats.',
      name: 'validationStats',
      desc: '',
      args: [],
    );
  }

  /// `Please select all IVs.`
  String get validationIVs {
    return Intl.message(
      'Please select all IVs.',
      name: 'validationIVs',
      desc: '',
      args: [],
    );
  }

  /// `Please select all EVs.`
  String get validationEVs {
    return Intl.message(
      'Please select all EVs.',
      name: 'validationEVs',
      desc: '',
      args: [],
    );
  }

  /// `Invalid {statName} stat. Must be between {minStat} and {maxStat}.`
  String validationStatRange(Object statName, Object minStat, Object maxStat) {
    return Intl.message(
      'Invalid $statName stat. Must be between $minStat and $maxStat.',
      name: 'validationStatRange',
      desc: '',
      args: [statName, minStat, maxStat],
    );
  }

  /// `Invalid {statName} IV. Must be between 0 and 31.`
  String validationIVRange(Object statName) {
    return Intl.message(
      'Invalid $statName IV. Must be between 0 and 31.',
      name: 'validationIVRange',
      desc: '',
      args: [statName],
    );
  }

  /// `Invalid {statName} EV. Must be between 0 and 255.`
  String validationEVRange(Object statName) {
    return Intl.message(
      'Invalid $statName EV. Must be between 0 and 255.',
      name: 'validationEVRange',
      desc: '',
      args: [statName],
    );
  }

  /// `Sum of all EVs must be less than 510.`
  String get validationEVMax {
    return Intl.message(
      'Sum of all EVs must be less than 510.',
      name: 'validationEVMax',
      desc: '',
      args: [],
    );
  }

  /// `unknown`
  String get statsTableTitleLabelSuffixUnknown {
    return Intl.message(
      'unknown',
      name: 'statsTableTitleLabelSuffixUnknown',
      desc: '',
      args: [],
    );
  }

  /// `EV`
  String get statsTableTitleLabelSuffixEv {
    return Intl.message(
      'EV',
      name: 'statsTableTitleLabelSuffixEv',
      desc: '',
      args: [],
    );
  }

  /// `IV`
  String get statsTableTitleLabelSuffixIv {
    return Intl.message(
      'IV',
      name: 'statsTableTitleLabelSuffixIv',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get statsTableTitleLabelSuffixLevel {
    return Intl.message(
      'Level',
      name: 'statsTableTitleLabelSuffixLevel',
      desc: '',
      args: [],
    );
  }

  /// `Stats per {suffix}`
  String statsTableTitleLabel(Object suffix) {
    return Intl.message(
      'Stats per $suffix',
      name: 'statsTableTitleLabel',
      desc: '',
      args: [suffix],
    );
  }

  /// `View Stats by {suffix}`
  String statsTableActivateButton(Object suffix) {
    return Intl.message(
      'View Stats by $suffix',
      name: 'statsTableActivateButton',
      desc: '',
      args: [suffix],
    );
  }

  /// `Problems`
  String get problemsTitle {
    return Intl.message(
      'Problems',
      name: 'problemsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Species Name or Number`
  String get pokemonSelectorTitle {
    return Intl.message(
      'Species Name or Number',
      name: 'pokemonSelectorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Nature/Mint`
  String get natureSelectorTitle {
    return Intl.message(
      'Select Nature/Mint',
      name: 'natureSelectorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Nature`
  String get natureSelectorNoNatureSelected {
    return Intl.message(
      'Select Nature',
      name: 'natureSelectorNoNatureSelected',
      desc: '',
      args: [],
    );
  }

  /// `Select Nature`
  String get natureSelectorScreenTitle {
    return Intl.message(
      'Select Nature',
      name: 'natureSelectorScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select Level`
  String get levelSelectorScreenTitle {
    return Intl.message(
      'Select Level',
      name: 'levelSelectorScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get tableSelectorTitle {
    return Intl.message(
      'Stats',
      name: 'tableSelectorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Nature Effect`
  String get tableSelectorNatureRow {
    return Intl.message(
      'Nature Effect',
      name: 'tableSelectorNatureRow',
      desc: '',
      args: [],
    );
  }

  /// `Base Stats`
  String get tableSelectorBaseStatsRow {
    return Intl.message(
      'Base Stats',
      name: 'tableSelectorBaseStatsRow',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get tableSelectorStatsRow {
    return Intl.message(
      'Stats',
      name: 'tableSelectorStatsRow',
      desc: '',
      args: [],
    );
  }

  /// `IVs`
  String get tableSelectorIVsRow {
    return Intl.message(
      'IVs',
      name: 'tableSelectorIVsRow',
      desc: '',
      args: [],
    );
  }

  /// `EVs`
  String get tableSelectorEVsRow {
    return Intl.message(
      'EVs',
      name: 'tableSelectorEVsRow',
      desc: '',
      args: [],
    );
  }

  /// `Result EVs`
  String get tableSelectorResultEVsRow {
    return Intl.message(
      'Result EVs',
      name: 'tableSelectorResultEVsRow',
      desc: '',
      args: [],
    );
  }

  /// `Result IVs`
  String get tableSelectorResultIVsRow {
    return Intl.message(
      'Result IVs',
      name: 'tableSelectorResultIVsRow',
      desc: '',
      args: [],
    );
  }

  /// `Result Stats`
  String get tableSelectorResultStatsRow {
    return Intl.message(
      'Result Stats',
      name: 'tableSelectorResultStatsRow',
      desc: '',
      args: [],
    );
  }

  /// `HP`
  String get statHP {
    return Intl.message(
      'HP',
      name: 'statHP',
      desc: '',
      args: [],
    );
  }

  /// `ATK`
  String get statAtk {
    return Intl.message(
      'ATK',
      name: 'statAtk',
      desc: '',
      args: [],
    );
  }

  /// `DEF`
  String get statDef {
    return Intl.message(
      'DEF',
      name: 'statDef',
      desc: '',
      args: [],
    );
  }

  /// `SP. A`
  String get statSpA {
    return Intl.message(
      'SP. A',
      name: 'statSpA',
      desc: '',
      args: [],
    );
  }

  /// `SP. D`
  String get statSpD {
    return Intl.message(
      'SP. D',
      name: 'statSpD',
      desc: '',
      args: [],
    );
  }

  /// `SPD`
  String get statSpd {
    return Intl.message(
      'SPD',
      name: 'statSpd',
      desc: '',
      args: [],
    );
  }

  /// `HP`
  String get statFullHP {
    return Intl.message(
      'HP',
      name: 'statFullHP',
      desc: '',
      args: [],
    );
  }

  /// `Attack`
  String get statFullAtk {
    return Intl.message(
      'Attack',
      name: 'statFullAtk',
      desc: '',
      args: [],
    );
  }

  /// `Defense`
  String get statFullDef {
    return Intl.message(
      'Defense',
      name: 'statFullDef',
      desc: '',
      args: [],
    );
  }

  /// `Special Attack`
  String get statFullSpA {
    return Intl.message(
      'Special Attack',
      name: 'statFullSpA',
      desc: '',
      args: [],
    );
  }

  /// `Special Defense`
  String get statFullSpD {
    return Intl.message(
      'Special Defense',
      name: 'statFullSpD',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get statFullSpd {
    return Intl.message(
      'Speed',
      name: 'statFullSpd',
      desc: '',
      args: [],
    );
  }

  /// `Bashful`
  String get natureBashful {
    return Intl.message(
      'Bashful',
      name: 'natureBashful',
      desc: '',
      args: [],
    );
  }

  /// `Docile`
  String get natureDocile {
    return Intl.message(
      'Docile',
      name: 'natureDocile',
      desc: '',
      args: [],
    );
  }

  /// `Hardy`
  String get natureHardy {
    return Intl.message(
      'Hardy',
      name: 'natureHardy',
      desc: '',
      args: [],
    );
  }

  /// `Serious`
  String get natureSerious {
    return Intl.message(
      'Serious',
      name: 'natureSerious',
      desc: '',
      args: [],
    );
  }

  /// `Quirky`
  String get natureQuirky {
    return Intl.message(
      'Quirky',
      name: 'natureQuirky',
      desc: '',
      args: [],
    );
  }

  /// `Bold`
  String get natureBold {
    return Intl.message(
      'Bold',
      name: 'natureBold',
      desc: '',
      args: [],
    );
  }

  /// `Modest`
  String get natureModest {
    return Intl.message(
      'Modest',
      name: 'natureModest',
      desc: '',
      args: [],
    );
  }

  /// `Calm`
  String get natureCalm {
    return Intl.message(
      'Calm',
      name: 'natureCalm',
      desc: '',
      args: [],
    );
  }

  /// `Timid`
  String get natureTimid {
    return Intl.message(
      'Timid',
      name: 'natureTimid',
      desc: '',
      args: [],
    );
  }

  /// `Lonely`
  String get natureLonely {
    return Intl.message(
      'Lonely',
      name: 'natureLonely',
      desc: '',
      args: [],
    );
  }

  /// `Mild`
  String get natureMild {
    return Intl.message(
      'Mild',
      name: 'natureMild',
      desc: '',
      args: [],
    );
  }

  /// `Gentle`
  String get natureGentle {
    return Intl.message(
      'Gentle',
      name: 'natureGentle',
      desc: '',
      args: [],
    );
  }

  /// `Hasty`
  String get natureHasty {
    return Intl.message(
      'Hasty',
      name: 'natureHasty',
      desc: '',
      args: [],
    );
  }

  /// `Adamant`
  String get natureAdamant {
    return Intl.message(
      'Adamant',
      name: 'natureAdamant',
      desc: '',
      args: [],
    );
  }

  /// `Impish`
  String get natureImpish {
    return Intl.message(
      'Impish',
      name: 'natureImpish',
      desc: '',
      args: [],
    );
  }

  /// `Careful`
  String get natureCareful {
    return Intl.message(
      'Careful',
      name: 'natureCareful',
      desc: '',
      args: [],
    );
  }

  /// `Jolly`
  String get natureJolly {
    return Intl.message(
      'Jolly',
      name: 'natureJolly',
      desc: '',
      args: [],
    );
  }

  /// `Naughty`
  String get natureNaughty {
    return Intl.message(
      'Naughty',
      name: 'natureNaughty',
      desc: '',
      args: [],
    );
  }

  /// `Lax`
  String get natureLax {
    return Intl.message(
      'Lax',
      name: 'natureLax',
      desc: '',
      args: [],
    );
  }

  /// `Rash`
  String get natureRash {
    return Intl.message(
      'Rash',
      name: 'natureRash',
      desc: '',
      args: [],
    );
  }

  /// `Naive`
  String get natureNaive {
    return Intl.message(
      'Naive',
      name: 'natureNaive',
      desc: '',
      args: [],
    );
  }

  /// `Brave`
  String get natureBrave {
    return Intl.message(
      'Brave',
      name: 'natureBrave',
      desc: '',
      args: [],
    );
  }

  /// `Relaxed`
  String get natureRelaxed {
    return Intl.message(
      'Relaxed',
      name: 'natureRelaxed',
      desc: '',
      args: [],
    );
  }

  /// `Quiet`
  String get natureQuiet {
    return Intl.message(
      'Quiet',
      name: 'natureQuiet',
      desc: '',
      args: [],
    );
  }

  /// `Sassy`
  String get natureSassy {
    return Intl.message(
      'Sassy',
      name: 'natureSassy',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
