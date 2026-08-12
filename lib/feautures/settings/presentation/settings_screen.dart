import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/initialization/widgets/dependencies_scope.dart';
import '../../auth/domain/entity/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late StreamSubscription<User> userStreamSubcription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = DependenciesScope.of(context)!.dependencies;
    final repository = dependencies.authenticationRepository;
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Text(
              "Settings Screen",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),

          StreamBuilder(
            stream: repository.userStream,
            builder: (context, snapshot) {
              if (snapshot.hasData == true) {
                return Text(
                  "Name: ${snapshot.data!.name} \n Login: ${snapshot.data!.login}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              } else {
                return Text("No user");
              }
            },
          ),
          // CustomPaint(
          //   size: Size(150, 150),
          //   painter: ShapePainter(),
          // ),
          // MyAnimatedContainerWidget(),
          LogoApp(),
        ],
      ),
    );
  }
}

// Defines custom painter to draw a line and circle
class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // Draw diagonal line
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);

    // Draw filled circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      40,
      Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyAnimatedContainerWidget extends StatefulWidget {
  const MyAnimatedContainerWidget({super.key});

  @override
  State<MyAnimatedContainerWidget> createState() =>
      _MyAnimatedContainerWidgetState();
}

class _MyAnimatedContainerWidgetState extends State<MyAnimatedContainerWidget> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          width: _selected ? 200.0 : 100.0,
          height: _selected ? 100.0 : 200.0,
          color: _selected ? Colors.blueGrey : Colors.white,
          alignment: _selected
              ? Alignment.center
              : AlignmentDirectional.topCenter,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: const FlutterLogo(size: 75),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object's value.
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
