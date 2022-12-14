import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:login/provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xl;

import 'Api.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  HttpParse httpParse = HttpParse();
  Future<void> wait() async {
    final shared = Provider.of<Prov>(context, listen: false);
    shared.role.clear();
    var res = await httpParse.profile();
    setState(() {
      shared.role.add(res.toJson());
      print(res.toJson());
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wait();
    });
  }

  @override
  Widget build(BuildContext context) {
    final shared = Provider.of<Prov>(context);
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    icon: const Icon(Icons.download_outlined),
                    label: const Text(
                      'Generate Excel',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _createExcel(context),
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Table(
                      children: [
                        TableRow(children: [
                          Container(
                            color: Colors.grey,
                            child: Column(children: const [
                              Text('Amount', style: TextStyle(fontSize: 25)),
                            ]),
                          ),
                          Container(
                            color: Colors.grey,
                            child: Column(children: const [
                              Text('CID', style: TextStyle(fontSize: 25)),
                            ]),
                          ),
                          Container(
                            color: Colors.grey,
                            child: Column(children: const [
                              Text('Pushed Date',
                                  style: TextStyle(fontSize: 25)),
                            ]),
                          ),
                          Container(
                            color: Colors.grey,
                            child: Column(children: const [
                              Text('Ref ID', style: TextStyle(fontSize: 25)),
                            ]),
                          ),
                          Container(
                            color: Colors.grey,
                            child: Column(children: const [
                              Text('Status', style: TextStyle(fontSize: 25)),
                            ]),
                          ),
                          Container(
                            color: Colors.grey,
                            child: Column(children: const [
                              Text('Transacted Date',
                                  style: TextStyle(fontSize: 25)),
                            ]),
                          ),
                        ])
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (shared.role.isNotEmpty)
                          for (var j = 0;
                              j < shared.role[0]['data'].length;
                              j++)
                            shared.role.isNotEmpty
                                ? Table(
                                    border: TableBorder.all(color: Colors.grey),
                                    children: [
                                      TableRow(children: [
                                        Column(children: [
                                          (Text(
                                              shared.role[0]['data'][j]
                                                      ['amount']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18, height: 2.0)))
                                        ]),
                                        Column(children: [
                                          (Text(
                                              shared.role[0]['data'][j]['cid']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18, height: 2.0)))
                                        ]),
                                        Column(children: [
                                          (Text(
                                              shared.role[0]['data'][j]
                                                      ['pushed_date']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18, height: 2.0)))
                                        ]),
                                        Column(children: [
                                          (Text(
                                              shared.role[0]['data'][j]
                                                      ['ref_id']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18, height: 2.0)))
                                        ]),
                                        Column(children: [
                                          (Text(
                                              shared.role[0]['data'][j]
                                                      ['status']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18, height: 2.0)))
                                        ]),
                                        Column(children: [
                                          (Text(
                                              shared.role[0]['data'][j]
                                                      ['transacted_date']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 18, height: 2.0)))
                                        ]),
                                      ])
                                    ],
                                  )
                                // DataTable(
                                //         columns: const [
                                //           DataColumn(label: Text('Amount')),
                                //           DataColumn(label: Text('CID')),
                                //           DataColumn(label: Text('Pushed Date')),
                                //           DataColumn(label: Text('Ref ID')),
                                //           DataColumn(label: Text('Status')),
                                //           DataColumn(label: Text('Transacted Date')),
                                //         ],
                                //         rows: [
                                //           DataRow(cells: [
                                //             DataCell(Text(shared.role[0]['data'][j]
                                //                     ['amount']
                                //                 .toString())),
                                //             DataCell(Text(shared.role[0]['data'][j]['cid']
                                //                 .toString())),
                                //             DataCell(Text(shared.role[0]['data'][j]
                                //                     ['pushed_date']
                                //                 .toString())),
                                //             DataCell(Text(shared.role[0]['data'][j]
                                //                     ['ref_id']
                                //                 .toString())),
                                //             DataCell(Text(shared.role[0]['data'][j]
                                //                     ['status']
                                //                 .toString())),
                                //             DataCell(Text(shared.role[0]['data'][j]
                                //                     ['transacted_date']
                                //                 .toString())),
                                //           ]),
                                //         ],
                                //       )
                                : const Text('Wala pang Data'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _createExcel(context) async {
  final xl.Workbook workbook = xl.Workbook();
  HttpParse httpParse = HttpParse();
  var res = await httpParse.profile();
  print(res.data!.length);
  print(res.data![0].toJson().length);

  final xl.Worksheet sheet = workbook.worksheets[0];

  sheet.enableSheetCalculations();

  sheet.getRangeByName('A2').columnWidth = 5.00;
  sheet.getRangeByName('B2').columnWidth = 15.00;
  sheet.getRangeByName('C2').columnWidth = 25.00;
  sheet.getRangeByName('D2').columnWidth = 20.00;
  sheet.getRangeByName('E2').columnWidth = 30.00;
  sheet.getRangeByName('F2').columnWidth = 25.00;

  sheet.getRangeByName('B1:F2').cellStyle.backColor = '#333F4F';
  sheet.getRangeByName('B1:F2').merge();
  sheet.getRangeByName('B4:D6').merge();

  sheet.getRangeByName('B3:F14').cellStyle.backColor = '#ffffff';
  sheet.getRangeByName('B2:F2').cellStyle.backColor = '#333F4F';
  sheet.getRangeByName('B4:F6').merge();
  sheet.getRangeByName('B4').setText('WebTool Report');
  sheet.getRangeByName('B4').cellStyle.fontSize = 28;
  sheet.getRangeByName('B4').cellStyle.hAlign = xl.HAlignType.center;

  sheet.getRangeByName('B8').setText('Transaction Report:');
  sheet.getRangeByName('B8').cellStyle.fontSize = 12;
  sheet.getRangeByName('B8').cellStyle.bold = true;

  sheet.getRangeByName('B9').setText('FDSAP');
  sheet.getRangeByName('B9').cellStyle.fontSize = 12;

  sheet.getRangeByName('B10').setText('Makati  City, Philippines.');
  sheet.getRangeByName('B10').cellStyle.fontSize = 9;

  sheet.getRangeByName('B11').setText('9920 BridgePoint Parkway,');
  sheet.getRangeByName('B11').cellStyle.fontSize = 9;

  sheet.getRangeByName('B12').setNumber(9365550136);
  sheet.getRangeByName('B12').cellStyle.fontSize = 9;
  sheet.getRangeByName('B12').cellStyle.hAlign = xl.HAlignType.left;

  final xl.Range range1 = sheet.getRangeByName('F8:F8');
  final xl.Range range2 = sheet.getRangeByName('F9:F9');
  final xl.Range range3 = sheet.getRangeByName('F10:F10');
  final xl.Range range4 = sheet.getRangeByName('F11:F11');
  final xl.Range range5 = sheet.getRangeByName('F12:F12');

  range1.merge();
  range2.merge();
  range3.merge();
  range4.merge();
  range5.merge();

  final xl.Range range6 = sheet.getRangeByName('B15:F15');
  range6.cellStyle.borders.all.lineStyle = xl.LineStyle.thin;
  range6.cellStyle.vAlign = xl.VAlignType.center;
  range6.cellStyle.fontSize = 14;
  range6.cellStyle.hAlign = xl.HAlignType.center;
  range6.cellStyle.backColor = '#ACB9CA';
  range6.cellStyle.bold = true;

  sheet.getRangeByIndex(15, 2).setText('Amount');

  sheet.getRangeByIndex(15, 3).setText('CID');

  sheet.getRangeByIndex(15, 4).setText('Pushed Date');

  sheet.getRangeByIndex(15, 5).setText('Ref ID');

  sheet.getRangeByIndex(15, 6).setText('Transacted Date');

  for (var i = 0; i < res.data!.length; i++) {
    var j = i + 1;
    sheet
        .getRangeByIndex(15 + j, 2)
        .setNumber(double.parse(res.data![i].amount.toString()));
    sheet.getRangeByIndex(15 + j, 2).cellStyle.hAlign = xl.HAlignType.center;
    sheet.getRangeByIndex(15 + j, 3).cellStyle.hAlign = xl.HAlignType.center;
    sheet.getRangeByIndex(15 + j, 3).setText(res.data![i].cid.toString());
    sheet
        .getRangeByIndex(15 + j, 4)
        .setText(res.data![i].pushedDate.toString());
    sheet.getRangeByIndex(15 + j, 5).setText(res.data![i].refId.toString());
    sheet
        .getRangeByIndex(15 + j, 6)
        .setText(res.data![i].transactedDate.toString());
  }
  var c = res.data!.length;
  sheet.getRangeByName('B16:F${16 + c}').cellStyle.fontSize = 12;
  sheet.getRangeByName('B16:F${16 + c}').cellStyle.borders.all.lineStyle =
      xl.LineStyle.thin;

  sheet.getRangeByIndex(16 + c, 2).text =
      '2022 ©CARD Bank Version 2.0. build 20150704.1727';
  sheet.getRangeByIndex(16 + c, 2).cellStyle.fontSize = 10;

  final xl.Range range9 = sheet.getRangeByName('B${16 + c}:F${17 + c}');
  range9.cellStyle.backColor = '#ACB9CA';
  range9.merge();
  range9.cellStyle.hAlign = xl.HAlignType.center;
  range9.cellStyle.vAlign = xl.VAlignType.center;
  range9.cellStyle.borders.all.lineStyle = xl.LineStyle.thin;
  final List<int> data = workbook.saveAsStream();
  AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(data)}")
    ..setAttribute("download", "output.xlsx")
    ..click();
  workbook.dispose();
}
