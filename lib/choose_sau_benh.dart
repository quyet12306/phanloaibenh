import 'package:flutter/material.dart';
import 'dart:math';

class ChooseSauBenh extends StatefulWidget {
  ChooseSauBenh({
    super.key,
    this.loaicay,
  });
  final String? loaicay;
  @override
  State<ChooseSauBenh> createState() => _ChooseSauBenhState();
}

class _ChooseSauBenhState extends State<ChooseSauBenh> {
  // list sau benh tung loai
  List<String> optiondualuoi = [
    "sương mai",
    "thán thư",
    "chảy nhựa",
    "héo thân",
    "phấn trắng"
  ];
  List<String> optionlua = [
    "đạo ôn",
    "khô vằn",
    "vàng lùn",
  ];
  List<String> optionvai = ["sương mai", "mất màu", "nứt quả", "sém mép lá"];
  List<String> optionbuoi = [
    "vàng lá",
    "chảy mủ",
    "ghẻ nhám",
    "loét khuẩn",
    "thán thư"
  ];
  List<List<String>> optioncay = [
    ["sương mai", "thán thư", "chảy nhựa", "héo thân", "phấn trắng"],
    [
      "đạo ôn",
      "khô vằn",
      "vàng lùn",
    ],
    ["sương mai", "mất màu", "nứt quả", "sém mép lá"],
    ["vàng lá", "chảy mủ", "ghẻ nhám", "loét khuẩn", "thán thư"]
  ];
  // list options
  List<String> options = ["Dưa lưới", "Lúa", "Vải", "Bưởi"];
  // flag of loai sau benh
  int _flag_cay = 0;
  // ham check loai sau benh cho cay

  int? hamcheckLoaiCay(loaicay) {
    for (int i = 0; i < options.length; i++) {
      if (loaicay == options[i]) {
        return _flag_cay = i;
      }
    }
  }
  // ham add them nut

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chon sau benh cho ${widget.loaicay ?? ""}",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * .60,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Center(
                child: Text(
                  "picture".toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: List.generate(
                    optioncay[hamcheckLoaiCay(widget.loaicay) ?? 0].length,
                    (index) {
                  // return Chip(
                  //   label: Text(optioncay[hamcheckLoaiCay(widget.loaicay)??0][index]),
                  // );
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 50,
                        maxWidth: 200,
                      ),
                      child: Text(
                        optioncay[hamcheckLoaiCay(widget.loaicay) ?? 0][index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width,
              height: size.height * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.red,
                        border: Border.all(
                            width: 2, color: Colors.black.withOpacity(.2))),
                    width: size.width * .40,
                    height: size.height * .05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 20,
                        ),
                        Text(
                          "delete".toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: size.width * .40,
                      height: size.height * .05,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              width: 2, color: Colors.black.withOpacity(.2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            "add new sick".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
