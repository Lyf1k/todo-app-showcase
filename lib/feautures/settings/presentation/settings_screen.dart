import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/initialization/widgets/dependencies_scope.dart';
import '../../auth/domain/entity/user.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
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
    return Column(
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
      ],
    );
  }
}
