import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Notes Screen",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
