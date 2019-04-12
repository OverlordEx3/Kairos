import 'ShiftProvider.dart';
import '../models/ShiftModel.dart';

class ShiftRepository {
  final _shiftProvider = new ShiftProvider();
  ShiftModel _shift;

  Future<ShiftStatus> requestNewShift() async {
    _shift = await _shiftProvider.requestNewShift();
    return _shift.shiftStatus;
  }

  ShiftStatus shiftStatus() {
    if(_shift == Null) {
      return ShiftStatus.SHIFT_ERROR;
    }

    return _shift.shiftStatus;
  }
}