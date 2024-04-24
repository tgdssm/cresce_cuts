import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vale_vantagens/core/state_management/bloc.dart';

abstract class StateManagement<W extends StatefulWidget, B extends Object>
    extends State<W> {
  B get bloc => Modular.get<B>();
}
