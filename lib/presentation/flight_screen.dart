import 'package:flight_ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key});

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);

  List tabs = ['Economy', 'Business', 'Analysis'];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.backgroundColor,
      body: SafeArea(
          child: Column(
        children: [
          const Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ColorPicker.lightColor,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: ColorPicker.primaryColor,
                  ),
                ),
                Text(
                  'Search Result',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorPicker.primaryColor,
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: ColorPicker.lightColor,
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 20,
                    color: ColorPicker.primaryColor,
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '251 Flight',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: ColorPicker.primaryColor,
                          ),
                        ),
                        Text(
                          'Available',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: ColorPicker.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Image.asset(
                      'assets/map_img.png',
                      color: const Color.fromARGB(255, 1, 119, 26),
                      height: MediaQuery.of(context).size.height * 0.14,
                    )),
                  ],
                ),
                TabBar(
                  unselectedLabelColor: ColorPicker.primaryColor,
                  indicatorWeight: 0,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorPicker.primaryColor,
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  controller: tabController,
                  onTap: (value) {
                    selectedIndex = value;
                    setState(() {});
                  },
                  tabs: tabs
                      .map((e) => Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: tabs.indexOf(e) == selectedIndex
                                  ? ColorPicker.primaryColor
                                  : ColorPicker.lightColor,
                            ),
                            child: Center(
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: tabs.indexOf(e) == selectedIndex
                                      ? ColorPicker.backgroundColor
                                      : ColorPicker.primaryColor,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 6,
            child: TabBarView(controller: tabController, children: [
              flightCard(),
              const Center(
                child: Text(
                  'Business',
                ),
              ),
              const Center(
                child: Text(
                  'Analysis',
                ),
              ),
            ]),
          ),
        ],
      )),
    );
  }

  Widget flightCard() => ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Stack(children: [
              ClipPath(
                clipper: FlightCardDesign(radius: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorPicker.primaryColor),
                  child: Column(children: [
                    Expanded(
                      flex: 2,
                      child: Row(children: [
                        Expanded(
                          flex: 2,
                          child: timeLocation('12:30', 'Dhaka'),
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomPaint(
                            painter: DottedCurve(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Transform(
                                transform: Matrix4.translationValues(0, 10, 0),
                                child: const RotatedBox(
                                    quarterTurns: 1,
                                    child: Icon(
                                      Icons.flight,
                                      size: 30,
                                      color: Color.fromRGBO(255, 255, 124, 1),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: timeLocation('11:30', 'Ottawa'),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text('Emirates',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: ColorPicker.backgroundColor,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: const Text('\$ 1270',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: ColorPicker.backgroundColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              CustomPaint(
                painter: DottedLine(radius: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                bottom: 60,
                left: MediaQuery.of(context).size.width / 2.5,
                child: const Text('20h 20m',
                    style: TextStyle(
                      backgroundColor: ColorPicker.primaryColor,
                      color: ColorPicker.backgroundColor,
                    )),
              ),
            ]),
          ),
      separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
      itemCount: 4);

  Widget timeLocation(String time, String location) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 25,
                color: ColorPicker.backgroundColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              location,
              style: const TextStyle(
                fontSize: 18,
                color: ColorPicker.backgroundColor,
              ),
            ),
          ],
        ),
      );
}

class DottedCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    var sp = Offset(10, h - 50);
    var cp1 = Offset(w / 5, h / 5);
    var cp2 = Offset(4 * w / 5, h / 5);
    var ep = Offset(w - 10, h - 50);

    var path = Path();
    path.moveTo(sp.dx, sp.dy);
    path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, ep.dx, ep.dy);
    var curvePath = dashPath(path, dashArray: CircularIntervalList([2, 4]));
    canvas.drawPath(
        curvePath,
        Paint()
          ..color = ColorPicker.backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedLine extends CustomPainter {
  double radius;
  DottedLine({required this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 4;
    double startX = radius;

    final paint = Paint()
      ..color = ColorPicker.backgroundColor
      ..strokeWidth = 1;
    while (startX < size.width - radius) {
      canvas.drawLine(Offset(startX, size.height / 1.5),
          Offset(startX + dashWidth, size.height / 1.5), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FlightCardDesign extends CustomClipper<Path> {
  double radius;
  FlightCardDesign({required this.radius});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height / 1.5), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 1.5), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
