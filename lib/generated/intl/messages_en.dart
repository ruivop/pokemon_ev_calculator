// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(suffix) => "View Stats by ${suffix}";

  static String m1(suffix) => "Stats per ${suffix}";

  static String m2(statName) =>
      "Invalid ${statName} EV. Must be between 0 and 255.";

  static String m3(statName) =>
      "Invalid ${statName} IV. Must be between 0 and 31.";

  static String m4(statName, minStat, maxStat) =>
      "Invalid ${statName} stat. Must be between ${minStat} and ${maxStat}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle":
            MessageLookupByLibrary.simpleMessage("IV, EV and Stats Calculator"),
        "headerOptions": MessageLookupByLibrary.simpleMessage("Options"),
        "headerOptionsCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "headerOptionsClear": MessageLookupByLibrary.simpleMessage("Clear"),
        "homePageCalculateEvButton":
            MessageLookupByLibrary.simpleMessage("Calculate EV"),
        "homePageCalculateIvButton":
            MessageLookupByLibrary.simpleMessage("Calculate IV"),
        "homePageCalculateStatsButton":
            MessageLookupByLibrary.simpleMessage("Calculate Stats"),
        "homePageCreateIssueButton":
            MessageLookupByLibrary.simpleMessage("Create an Issue"),
        "homePagePrivacyPolicy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "homePageVersionInfo": MessageLookupByLibrary.simpleMessage(
            "All the information on this app is related to the core version of the game for the consoles and the most recent Base Stats."),
        "homepageDisclaimer": MessageLookupByLibrary.simpleMessage(
            "\"Pokemon\" is a trademark of \"The Pokémon Company\". This app is not affiliated with or endorsed by \"The Pokémon Company\"."),
        "levelSelectorScreenTitle":
            MessageLookupByLibrary.simpleMessage("Select Level"),
        "natureAdamant": MessageLookupByLibrary.simpleMessage("Adamant"),
        "natureBashful": MessageLookupByLibrary.simpleMessage("Bashful"),
        "natureBold": MessageLookupByLibrary.simpleMessage("Bold"),
        "natureBrave": MessageLookupByLibrary.simpleMessage("Brave"),
        "natureCalm": MessageLookupByLibrary.simpleMessage("Calm"),
        "natureCareful": MessageLookupByLibrary.simpleMessage("Careful"),
        "natureDocile": MessageLookupByLibrary.simpleMessage("Docile"),
        "natureGentle": MessageLookupByLibrary.simpleMessage("Gentle"),
        "natureHardy": MessageLookupByLibrary.simpleMessage("Hardy"),
        "natureHasty": MessageLookupByLibrary.simpleMessage("Hasty"),
        "natureImpish": MessageLookupByLibrary.simpleMessage("Impish"),
        "natureJolly": MessageLookupByLibrary.simpleMessage("Jolly"),
        "natureLax": MessageLookupByLibrary.simpleMessage("Lax"),
        "natureLonely": MessageLookupByLibrary.simpleMessage("Lonely"),
        "natureMild": MessageLookupByLibrary.simpleMessage("Mild"),
        "natureModest": MessageLookupByLibrary.simpleMessage("Modest"),
        "natureNaive": MessageLookupByLibrary.simpleMessage("Naive"),
        "natureNaughty": MessageLookupByLibrary.simpleMessage("Naughty"),
        "natureQuiet": MessageLookupByLibrary.simpleMessage("Quiet"),
        "natureQuirky": MessageLookupByLibrary.simpleMessage("Quirky"),
        "natureRash": MessageLookupByLibrary.simpleMessage("Rash"),
        "natureRelaxed": MessageLookupByLibrary.simpleMessage("Relaxed"),
        "natureSassy": MessageLookupByLibrary.simpleMessage("Sassy"),
        "natureSelectorNoNatureSelected":
            MessageLookupByLibrary.simpleMessage("Select Nature"),
        "natureSelectorScreenTitle":
            MessageLookupByLibrary.simpleMessage("Select Nature"),
        "natureSelectorTitle":
            MessageLookupByLibrary.simpleMessage("Select Nature/Mint"),
        "natureSerious": MessageLookupByLibrary.simpleMessage("Serious"),
        "natureTimid": MessageLookupByLibrary.simpleMessage("Timid"),
        "pokemonSelectorTitle":
            MessageLookupByLibrary.simpleMessage("Species Name or Number"),
        "problemsTitle": MessageLookupByLibrary.simpleMessage("Problems"),
        "statAtk": MessageLookupByLibrary.simpleMessage("ATK"),
        "statDef": MessageLookupByLibrary.simpleMessage("DEF"),
        "statFullAtk": MessageLookupByLibrary.simpleMessage("Attack"),
        "statFullDef": MessageLookupByLibrary.simpleMessage("Defense"),
        "statFullHP": MessageLookupByLibrary.simpleMessage("HP"),
        "statFullSpA": MessageLookupByLibrary.simpleMessage("Special Attack"),
        "statFullSpD": MessageLookupByLibrary.simpleMessage("Special Defense"),
        "statFullSpd": MessageLookupByLibrary.simpleMessage("Speed"),
        "statHP": MessageLookupByLibrary.simpleMessage("HP"),
        "statSpA": MessageLookupByLibrary.simpleMessage("SP. A"),
        "statSpD": MessageLookupByLibrary.simpleMessage("SP. D"),
        "statSpd": MessageLookupByLibrary.simpleMessage("SPD"),
        "statsTableActivateButton": m0,
        "statsTableTitleLabel": m1,
        "statsTableTitleLabelSuffixEv":
            MessageLookupByLibrary.simpleMessage("EV"),
        "statsTableTitleLabelSuffixIv":
            MessageLookupByLibrary.simpleMessage("IV"),
        "statsTableTitleLabelSuffixLevel":
            MessageLookupByLibrary.simpleMessage("Level"),
        "statsTableTitleLabelSuffixUnknown":
            MessageLookupByLibrary.simpleMessage("unknown"),
        "tableSelectorBaseStatsRow":
            MessageLookupByLibrary.simpleMessage("Base Stats"),
        "tableSelectorEVsRow": MessageLookupByLibrary.simpleMessage("EVs"),
        "tableSelectorIVsRow": MessageLookupByLibrary.simpleMessage("IVs"),
        "tableSelectorNatureRow":
            MessageLookupByLibrary.simpleMessage("Nature Effect"),
        "tableSelectorResultEVsRow":
            MessageLookupByLibrary.simpleMessage("Result EVs"),
        "tableSelectorResultIVsRow":
            MessageLookupByLibrary.simpleMessage("Result IVs"),
        "tableSelectorResultStatsRow":
            MessageLookupByLibrary.simpleMessage("Result Stats"),
        "tableSelectorStatsRow": MessageLookupByLibrary.simpleMessage("Stats"),
        "tableSelectorTitle": MessageLookupByLibrary.simpleMessage("Stats"),
        "validationEVMax": MessageLookupByLibrary.simpleMessage(
            "Sum of all EVs must be less than 510."),
        "validationEVRange": m2,
        "validationEVs":
            MessageLookupByLibrary.simpleMessage("Please select all EVs."),
        "validationIVRange": m3,
        "validationIVs":
            MessageLookupByLibrary.simpleMessage("Please select all IVs."),
        "validationNature":
            MessageLookupByLibrary.simpleMessage("Please select a nature."),
        "validationStatRange": m4,
        "validationStats":
            MessageLookupByLibrary.simpleMessage("Please select all stats.")
      };
}
