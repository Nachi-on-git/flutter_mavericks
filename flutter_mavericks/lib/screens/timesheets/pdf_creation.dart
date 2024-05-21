import 'package:flutter_mavericks/design_system/padding_system.dart';
import 'package:flutter_mavericks/models/timehseet.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../design_system/sizesystem.dart';

final pdf = pw.Document();

Future<PdfDocument> generatePDF(
    {required String empName, required ProjectDetails projectDetails}) async {
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
            child: pw.Container(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
              pw.SizedBox(
                height: 30,
              ),
              pw.Center(
                  child: pw.Text(
                'Employee Timesheet Details',
                style: const pw.TextStyle(fontSize: SizeSystem.size25),
              )),
              pw.SizedBox(
                height: 30,
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Employee Name : $empName',
                            style:
                                const pw.TextStyle(fontSize: SizeSystem.size16),
                          ),
                          pw.Text(
                            'Client Name : ${projectDetails.projectName}',
                            style:
                                const pw.TextStyle(fontSize: SizeSystem.size16),
                          ),
                          pw.Text(
                            'Date : ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                            style:
                                const pw.TextStyle(fontSize: SizeSystem.size16),
                          )
                        ]),
                  ]),
              pw.SizedBox(
                height: 30,
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child: pw.Text('Total Working days')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child: pw.Text('${projectDetails.totalWorkingDays}')),
                  ]),
                  pw.TableRow(children: [
                   pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child:  pw.Text('Total Billable Hours')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child: pw.Text('${projectDetails.totalBillableHours.toInt()}')),
                  ]),
                  pw.TableRow(children: [
                   pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child:  pw.Text('Cost per Hour')),
                    pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child: pw.Text('Rs.300')),
                  ]),
                  pw.TableRow(children: [
                   pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child:  pw.Text('Payable Amount')),
                   pw.Padding(
                        padding: const pw.EdgeInsets.all(PaddingSystem.padding10),
                        child:  pw.Text(
                        'Rs.${projectDetails.totalBillableHours.toInt() * 300}')),
                  ])
                ],
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Text(
                'Singnature : ',
                style: const pw.TextStyle(fontSize: SizeSystem.size16),
              )
            ]))); // Center
      }));
  return pdf.document;
}
