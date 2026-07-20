import 'package:flutter/material.dart';
import 'package:partfolio_app/core/initialization/models/dependencies_container.dart';

/// {@template dependencies_scope}
/// DependenciesScope widget.
/// {@endtemplate}
class DependenciesScope extends InheritedWidget {
  /// {@macro dependencies_scope}
  const DependenciesScope({
    required super.child,
    required this.dependencies,
    super.key, // ignore: unused_element_parameter
  });

  final DependenciesContainer dependencies;

  static DependenciesScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependenciesScope>();
  }

  @override
  bool updateShouldNotify(covariant DependenciesScope oldWidget) => false;
}
