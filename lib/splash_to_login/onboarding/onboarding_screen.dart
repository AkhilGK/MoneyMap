import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:moneymap/providers/onboarding_provider.dart';
import 'package:moneymap/splash_to_login/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //to select current page
  int currentPage = 0;
  //to check weather the onboarding is skipped or not

//a pagecontroller to navigate through pages  for next button

  PageController pageToNext = PageController(initialPage: 0);

//creating an animated container and looping it to the bottom row
  @override
  Widget build(BuildContext context) {
    Widget circleBar(bool isActive) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: isActive ? 12 : 8,
        width: isActive ? 18 : 8,
        decoration: BoxDecoration(
          color: isActive
              ? Colors.purple
              : const Color.fromARGB(255, 223, 155, 235),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      );
    }

//appbar of onboarding

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 218, 235),
        title: Padding(
          padding: const EdgeInsets.all(2.0),

          //app bar on top have skip button

          child: TextButton(
            onPressed: () {
              Provider.of<OnboardingProvider>(context, listen: false)
                  .skipOnboarding(context);
            },
            child: textOB(
              caption: 'Skip>',
              captiponSize: 18,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            children: [
              //page viewbuilder to swipe between onboardings

              PageView.builder(
                itemCount: oBlist.length,
                controller: pageToNext,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: ((context, index) {
                  Onboarding boarding = oBlist[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3, child: Image.asset(boarding.imagepathOB)),
                      Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textOB(
                                  caption: boarding.titleOB,
                                  captiponSize: 35.00),
                              G().sBox(h: 10),
                              textOB(
                                  caption: boarding.subtitleOB,
                                  captiponSize: 16),
                            ],
                          )),
                    ],
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < oBlist.length; i++)
                            if (i == currentPage) ...[circleBar(true)] else
                              circleBar(false)
                        ],
                      ),
                      G().sBox(h: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.purple),
                          onPressed: () async {
                            if (currentPage < 2) {
                              pageToNext.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear);
                            } else {
                              Provider.of<OnboardingProvider>(context,
                                      listen: false)
                                  .skipOnboarding(context);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Next",
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//a text widget for costomized font
  Widget textOB({required String caption, required double captiponSize}) {
    return Text(
      caption,
      style: GoogleFonts.dmSans(
          fontSize: captiponSize,
          color: Colors.purple,
          fontWeight: FontWeight.bold),
    );
  }
}
