import 'package:flutter/widgets.dart';

abstract class Bloc {
  void init() {}

  void dispose();
}

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key? key, required this.bloc, required this.child})
      : super(key: key);

  @override
  State createState() => _BlocProviderState();

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T>? provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider!.bloc;
  }
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
