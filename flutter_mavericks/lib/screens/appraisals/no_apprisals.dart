import 'package:flutter/material.dart';

import '../../design_system/color_system.dart';
import '../../design_system/padding_system.dart';
import '../../design_system/sizesystem.dart';

class Noappraisals extends StatefulWidget {
  const Noappraisals({super.key});

  @override
  State<Noappraisals> createState() => _NoappraisalsState();
}

class _NoappraisalsState extends State<Noappraisals> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal:  PaddingSystem.padding40),
        child: Center(child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: PaddingSystem.padding10),
                child: Image.asset('assets/images/no_apprisal.png'),
              ),
              const SizedBox(
                height: PaddingSystem.padding30,
              ),
              const Text(
                'No Appraisals Yet!',
                style: TextStyle(
                    fontSize: SizeSystem.size20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: PaddingSystem.padding20,
              ),
              const Text(
                'You don\'t have any appraisals to respond ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorSystem.gray, fontSize: SizeSystem.size14),
              )
            ])));
  }
}
