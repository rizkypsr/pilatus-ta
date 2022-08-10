import 'package:pilatus/domain/entities/city.dart';
import 'package:pilatus/domain/entities/cost.dart';

class Ongkir {
  final City origin;
  final City destination;
  final List<Cost> costs;

  Ongkir(
      {required this.origin, required this.destination, required this.costs});
}
