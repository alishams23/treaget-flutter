import 'package:flutter/material.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/loading.dart';

class Disputes extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => StateDisputes();
  
}

class StateDisputes extends State{
  @override
  Widget build(BuildContext context) {
    return listIsEmpty();
  }
  
}