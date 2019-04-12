import '../models/ShiftModel.dart';
import 'package:http/http.dart';

class ShiftProvider {
  ShiftModel shift;
  Client client;

  ShiftProvider();

  Future<ShiftModel> requestNewShift() async {
    /* TODO request shift creation */
    try {
      shift = ShiftModel.fromJSON({'id' : 1, 'dt' : DateTime.now(), 'st' : ShiftStatus.SHIFT_NEW});
      return shift;
    } catch(e) {
      print("Failed to create or request shift.");
    }
    return Future.value();
  }
}