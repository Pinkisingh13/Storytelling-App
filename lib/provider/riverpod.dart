import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/authentication.dart';
import 'package:storytelling_app/models/storymodel.dart';
import 'package:storytelling_app/screens/storyoverview.dart';

final authenticationProvider = Provider<Authentication>((ref) {
  return Authentication();
});

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final bodyInformationProvider = StateProvider((ref) {
  return (BuildContext context, StoryBodyModel story) {
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.scale,
      alignment: Alignment.bottomCenter,
      isIos: true,
      duration: const Duration(milliseconds: 800),
      reverseDuration: const Duration(milliseconds: 800),
      child: StoryOverView(story: story),
    ));
  };
});
