import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lab2/model/config.dart';
import 'package:lab2/model/user.dart';

import 'package:http/http.dart' as http;

class TabPage3 extends StatefulWidget {
  final User user;
  const TabPage3({Key? key, required this.user}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  late double screenHeight, screenWidth, resWidth;
  File? _image;
  final df = DateFormat('dd/MM/yyyy');
  var pathAsset = "assets/images/profile.png";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            child: Row(
          children: [
            _image == null
                ? Flexible(
                    child: SizedBox(
                        child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: CachedNetworkImage(
                          imageUrl: Config.server +
                              "/mobile_lab2/images/profile/" +
                              widget.user.id.toString() +
                              ".png",
                          placeholder: (context, url) =>
                              const LinearProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      ),
                    )),
                  )
                : SizedBox(
                    height: screenHeight * 0.25,
                    child: SizedBox(
                      child: GestureDetector(
                        child: Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image == null
                                ? AssetImage(pathAsset)
                                : FileImage(_image!) as ImageProvider,
                            fit: BoxFit.fill,
                          ),
                        )),
                      ),
                    )),
          ],
        )),
      ),
      Flexible(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.user.name.toString(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 2, 30, 8),
            child: Divider(
              color: Colors.blueGrey,
              height: 2,
              thickness: 2.0,
            ),
          ),
          Table(
            columnWidths: const {
              0: FractionColumnWidth(0.2),
              1: FractionColumnWidth(0.8)
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                const Icon(Icons.email),
                Text(widget.user.email.toString()),
              ]),
              TableRow(children: [
                const Icon(Icons.phone),
                Text(widget.user.phone.toString()),
              ]),
              TableRow(children: [
                const Icon(Icons.location_city),
                Text(widget.user.address.toString()),
              ]),
              widget.user.regdate.toString() == ""
                  ? TableRow(children: [
                      const Icon(Icons.date_range),
                      Text(df.format(
                          DateTime.parse(widget.user.regdate.toString())))
                    ])
                  : TableRow(children: [
                      const Icon(Icons.date_range),
                      Text(df.format(
                          DateTime.parse(widget.user.regdate.toString())))
                    ]),
            ],
          ),
        ],
      ))
    ]);
  }
}
