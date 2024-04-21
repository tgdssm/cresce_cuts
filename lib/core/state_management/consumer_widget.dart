import 'package:flutter/material.dart';

import 'bloc.dart';

class ConsumerWidget<T> extends StatefulWidget {
  final Bloc<T> bloc;
  final Widget Function(BuildContext context, T? state) builder;
  final void Function(BuildContext context, T state)? listener;
  const ConsumerWidget({
    super.key,
    required this.bloc,
    required this.builder,
    this.listener,
  });

  @override
  State<ConsumerWidget<T>> createState() => _ConsumerWidgetState<T>();
}

class _ConsumerWidgetState<T> extends State<ConsumerWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: widget.bloc.state,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            widget.listener?.call(context, snapshot.data as T);
          }
          return widget.builder(
            context,
            snapshot.data,
          );
        });
  }
}
