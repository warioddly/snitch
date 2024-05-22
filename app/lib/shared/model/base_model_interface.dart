
import 'package:equatable/equatable.dart';

abstract class IBaseModel extends Equatable {

  const IBaseModel({required this.id});

  final int? id;

  toJson() { }

}