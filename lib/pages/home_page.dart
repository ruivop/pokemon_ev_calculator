import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import 'calculate_ev_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: Container(
        width: double.infinity,
        //color: Color(0xffcfe893),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('resources/main_background.png'),
              repeat: ImageRepeat.repeat,
              scale: 4),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xfffde3a1),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: const Color(0xff928640),
                    width: 4,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x55000000),
                      blurRadius: 3,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: const TitleStokeText(
                  text: "IV, EV And Stat Calculator",
                  fontSize: 20,
                  strokeWidth: 3,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xfff4f3de),
                            Color(0xffdfdec9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x55000000),
                            blurRadius: 3,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            HomePageButton(
                              title: "Calculate EV",
                              onPressed: () {
                                Provider.of<CalculationState>(context,
                                        listen: false)
                                    .setCalculationType(CalculationType.EV);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CalculateEVPage(),
                                  ),
                                );
                              },
                            ),
                            HomePageButton(
                              title: "Calculate IV",
                              onPressed: () {},
                            ),
                            HomePageButton(
                              title: "Calculate Stats",
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
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
    return GestureDetector(
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
