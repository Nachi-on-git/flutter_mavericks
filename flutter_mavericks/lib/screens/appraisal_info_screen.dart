import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';

import '../design_system/color_system.dart';

class StartAppraisalInfoScreen extends StatelessWidget {
  const StartAppraisalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(SizeSystem.size16).copyWith(top: SizeSystem.size12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/appraisals_dashboard.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: SizeSystem.size2),
                  Padding(
                    padding: const EdgeInsets.all(SizeSystem.size8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Manoj Waghmare",
                          style: TextStyle(
                            fontSize: SizeSystem.size16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size2),
                        Text(
                          "Flutter developer",
                          style: TextStyle(
                            fontSize: SizeSystem.size12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000).withOpacity(.6),
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size6),
                        const Text(
                          "We appreciate your dedication and contribution to the success of our organization. The following Appraisal Form evaluates your performance and provides valuable feedback for professional growth. This comprehensive form covers various job elements and allows for a detailed assessment. ",
                          style: TextStyle(
                            fontSize: SizeSystem.size14,
                            color: Color(0xff3C3A36),
                            height: 20 / 14,
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size6),
                        const Text(
                          "Please refer to the guidelines below to help you complete the form effectively.",
                          style: TextStyle(
                            fontSize: SizeSystem.size14,
                            color: Color(0xff3C3A36),
                            fontWeight: FontWeight.w500,
                            height: 21 / 14,
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size10),
                        DottedBorder(
                          radius: const Radius.circular(SizeSystem.size10),
                          borderType: BorderType.RRect,
                          dashPattern: const [1, 0, 8],
                          color: const Color(0xffE6EDF4),
                          strokeWidth: 1,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                RatingWidget(stars: 5, description: "Exceeds Expectations Always Brilliant"),
                                Divider(color: Color(0xffE6EDF4)),
                                RatingWidget(stars: 4, description: "Exceeds Expectations Mostly Brilliant"),
                                Divider(color: Color(0xffE6EDF4)),
                                RatingWidget(stars: 3, description: "Exceeds Expectations Mostly Good"),
                                Divider(color: Color(0xffE6EDF4)),
                                RatingWidget(stars: 2, description: "Exceeds Expectations Occasionally Good"),
                                Divider(color: Color(0xffE6EDF4)),
                                RatingWidget(stars: 1, description: "Exceeds Expectations Never Good"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size16),
                        InkWell(
                          onTap: () {
                            /// TODO start appraisal form on tap of this button
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                              vertical: SizeSystem.size12,
                            ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(SizeSystem.size12), color: ColorSystem.primaryColor),
                            child: const Center(
                              child: Text(
                                'Start assessment',
                                style: TextStyle(color: ColorSystem.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;

  const StarRating({Key? key, required this.starCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: List.generate(
          5,
          (index) => Icon(
            Icons.star_rounded,
            color: index < starCount ? const Color(0xffFFC500) : const Color(0xffE0E8F1),
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final int stars;
  final String description;

  const RatingWidget({Key? key, required this.stars, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StarRating(starCount: stars),
            Expanded(
              child: Text(
                description,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
