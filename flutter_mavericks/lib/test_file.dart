import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/widgets/appraisals_card.dart';

class TestFile extends StatelessWidget {
  const TestFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SizeSystem.size16),
        child: ListView.builder(itemBuilder: (context, index) {
          return AppraisalsCard(
            appraisalYear: 'May 2024',
            employeeName: index % 2 == 0 ? 'Nachiket Labade' : 'Manoj Waghmare',
            employeeDesignation: index % 2 == 0 ? 'Mobile App Developer' : 'Flutter Developer',
            isResponseSubmitted: index % 2 == 0 ? true : false,
          );
        }),
      ),
    );
  }
}
