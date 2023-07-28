import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';
import 'package:intl/intl.dart';

class ScreenTemplateWidget extends StatefulWidget {
  final Widget child;
  final Color color;
  const ScreenTemplateWidget({super.key, required this.child, this.color = ColorStyle.light});

  @override
  State<ScreenTemplateWidget> createState() => _ScreenTemplateWidgetState();
}

class _ScreenTemplateWidgetState extends State<ScreenTemplateWidget> {
  final dateTimeController = Rx<DateTime>(DateTime.now());

  final mobileBarHeight = 44.00;
  final iconSize = 17.00;

  late final timeWidget = Obx(() => Text(DateFormat('H:mm').format(dateTimeController.value), style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.big, fontWeight: FontWeight.bold)));
  late final signalWidget = Icon(Icons.signal_cellular_alt, color: ColorStyle.dark, size: iconSize);
  late final wifiWidget = Icon(Icons.wifi, color: ColorStyle.dark, size: iconSize);
  late final batteryWidget = Icon(Icons.battery_full, color: ColorStyle.dark, size: iconSize);
  late final _lintBottomWidget = Container(width: 134, height: 5, decoration: BoxDecoration(color: ColorStyle.dark, borderRadius: BorderRadius.circular(100)));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      while (true) {
        await Future.delayed(const Duration(minutes: 1), () => dateTimeController.value = DateTime.now());
        if (!mounted) return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: 375,
          height: 812,
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 33, right: 15),
                height: mobileBarHeight,
                color: widget.color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeWidget,
                    Row(children: [signalWidget, wifiWidget, batteryWidget]),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    widget.child,
                    Container(
                      color: widget.color,
                      width: double.infinity,
                      height: 34,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _lintBottomWidget,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
