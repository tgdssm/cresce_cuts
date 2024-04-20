import 'package:flutter/material.dart';

import 'bloc.dart';

class ConsumerWidget<T> extends StatefulWidget {
  final Bloc<T> bloc;
  final Widget Function(BuildContext context, T? state) builder;
  const ConsumerWidget({
    super.key,
    required this.bloc,
    required this.builder,
  });

  @override
  State<ConsumerWidget<T>> createState() => _ConsumerWidgetState<T>();
}

class _ConsumerWidgetState<T> extends State<ConsumerWidget<T>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.bloc.state,
      builder: (context, snapshot) => widget.builder(
        context,
        snapshot.data,
      ),
    );
  }
}
