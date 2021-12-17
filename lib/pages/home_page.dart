import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_stats_calculator/data/stats.dart';
import 'package:pokemon_stats_calculator/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../state.dart';
import 'calculate_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    calculateNames(context);
    computeStatNames(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
          body: Container(
        width: double.infinity,
        //color: Color(0xffcfe893),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4a5d9d),
                Color(0xFF2a3560),
              ]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xfffde3a1),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x55000000),
                      spreadRadius: 2,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    S.of(context).appTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: HomePageCard(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          HomePageButton(
                            title: S.of(context).homePageCalculateEvButton,
                            onPressed: () {
                              Provider.of<CalculationState>(context,
                                      listen: false)
                                  .setCalculationType(CalculationType.ev);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CalculatePage(),
                                ),
                              );
                            },
                          ),
                          HomePageButton(
                            title: S.of(context).homePageCalculateIvButton,
                            onPressed: () {
                              Provider.of<CalculationState>(context,
                                      listen: false)
                                  .setCalculationType(CalculationType.iv);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CalculatePage(),
                                ),
                              );
                            },
                          ),
                          HomePageButton(
                            title: S.of(context).homePageCalculateStatsButton,
                            onPressed: () {
                              Provider.of<CalculationState>(context,
                                      listen: false)
                                  .setCalculationType(CalculationType.stat);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CalculatePage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
              HomePageCard(
                verticalMargin: 0,
                child: Text(S.of(context).homePageVersionInfo,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              HomePageCard(
                  verticalMargin: 8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              launch(
                                  "https://github.com/ruivop/pokeStatsCalculator/issues");
                            },
                            child:
                                Text(S.of(context).homePageCreateIssueButton),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              backgroundColor: Colors.white.withAlpha(220),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              launch(
                                  "http://pokestatscalculator.ruivop.com/privacy_policy/index.html");
                            },
                            child: Text(
                              S.of(context).homePagePrivacyPolicy,
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              backgroundColor: Colors.white.withAlpha(220),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              HomePageCard(
                verticalMargin: 0,
                child: Text(S.of(context).homepageDisclaimer,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      )),
    );
  }
}

class HomePageCard extends StatelessWidget {
  final Widget child;
  final double verticalMargin;
  const HomePageCard({
    Key? key,
    required this.child,
    this.verticalMargin = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: verticalMargin),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2a3560),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x55000000),
                blurRadius: 0,
                spreadRadius: 1,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: child,
        ));
  }
}

class HomePageButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const HomePageButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: 300,
      height: 60,
      child: OutlinedButton(
        onPressed: onPressed,
        child: AutoSizeText(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          backgroundColor: Colors.white.withAlpha(220),
        ),
      ),
    ));
  }
}
