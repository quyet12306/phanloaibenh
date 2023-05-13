import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'choose_sau_benh.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // list lựa chọn cây
  List<String> options = ["Dưa lưới", "Lúa", "Vải", "Bưởi"];
  late String selectedOption = options[0];
  // camera controlor
  late CameraController _controller;
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'cameraAccessDeniedd':
            print("access war denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "phân loại ảnh".toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * .40,
              height: size.height * .04,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: DropdownButton<String>(
                  value: selectedOption,
                  items: options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newOption) {
                    setState(() {
                      selectedOption = newOption ?? "";
                    });
                  },
                ),
              ),
            ),
            Container(
              width: size.width * 1,
              height: size.height * .65,
              padding: EdgeInsets.only(
                  left: size.width * .05, right: size.width * .05),
              // decoration: BoxDecoration(color: Colors.green),
              // child: Center(
              //     child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(
              //       Icons.camera_alt,
              //       size: 50,
              //       color: Colors.white,
              //     ),
              //     Text(
              //       'camera'.toUpperCase(),
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 30,
              //           fontWeight: FontWeight.bold),
              //     )
              //   ],
              // )),
              child: CameraPreview(_controller),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                print("loai cay la ${selectedOption}");
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ChooseSauBenh(
                //               loaicay: selectedOption,
                //             )));
                if (!_controller.value.isInitialized) {
                  return null;
                }
                if (_controller.value.isTakingPicture) {
                  return null;
                }

                try {
                  await _controller.setFlashMode(FlashMode.auto);
                  XFile file = await _controller.takePicture();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChooseSauBenh(
                                file,
                                loaicay: selectedOption,
                              )));
                } on CameraException catch (e) {
                  debugPrint("error occured while taking picture : ${e}");
                  return null;
                }
              },
              child: Container(
                width: size.width * .15,
                height: size.width * .15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                        width: 3, color: Colors.black.withOpacity(0.1)),
                    boxShadow: []),
                child: Icon(
                  Icons.camera,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
