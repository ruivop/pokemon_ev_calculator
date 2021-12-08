import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import 'calculate_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      blurRadius: 3,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "IV, EV And Stat Calculator",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a3560),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x55000000),
                              blurRadius: 0,
                              spreadRadius: 2,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            HomePageButton(
                              title: "Calculate EV",
                              onPressed: () {
                                Provider.of<CalculationState>(context,
                                        listen: false)
                                    .setCalculationType(CalculationType.EV);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const CalculatePage(),
                                  ),
                                );
                              },
                            ),
                            HomePageButton(
                              title: "Calculate IV",
                              onPressed: () {
                                Provider.of<CalculationState>(context,
                                        listen: false)
                                    .setCalculationType(CalculationType.IV);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const CalculatePage(),
                                  ),
                                );
                              },
                            ),
                            HomePageButton(
                              title: "Calculate Stats",
                              onPressed: () {
                                Provider.of<CalculationState>(context,
                                        listen: false)
                                    .setCalculationType(CalculationType.Stat);
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
                    ),
                  )),
              Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a3560),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x55000000),
                              blurRadius: 0,
                              spreadRadius: 2,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: const Text(
                            '"Pokemon" is a trademark of "The Pokémon Company". This app is not affiliated with or endorsed by "The Pokémon Company".',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      )))
            ],
          ),
        ),
      )),
    );
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
    )
        /*GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 200,
          height: 180,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.orange[200],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffffcc80),
                Color(0xffe0af65),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffffe0b2),
                  Color(0xffe5c79a),
                ],
              ),
              border: Border.all(
                color: Colors.orange[400]!,
                width: 2,
              ),
            ),
            child: Center(
                child: TitleStokeText(
              text: title,
              fontSize: 40,
              strokeWidth: 4,
              strokeColor: Color.lerp(Colors.orange[400]!, Colors.black, 0.2)!,
            )),
          ),
        ),
      ),*/
        );
  }
}

class TitleStokeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;
  final TextAlign textAlign;

  const TitleStokeText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.color = Colors.white,
    this.strokeColor = const Color(0xff928640),
    this.strokeWidth = 2,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        AutoSizeText(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Solid text as fill.
        AutoSizeText(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
        ),
      ],
    );
  }
}
