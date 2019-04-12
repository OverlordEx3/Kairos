import 'package:rxdart/rxdart.dart';

import '../models/ShiftModel.dart';
import '../resources/ShiftRepository.dart';

final ShiftBloc shiftBloc = ShiftBloc();

class ShiftBloc {
  final _shiftRepository = ShiftRepository();

  final _shiftFetch = new PublishSubject<ShiftStatus>();

  /* Fetch possible changes in status */
  Observable<ShiftStatus> get fetchShift => _shiftFetch.stream;

  ShiftStatus fetchShiftStatus() {
    return _shiftRepository.shiftStatus();
  }

  requestNewShift() async {
    final result = await _shiftRepository.requestNewShift();
    if(result != ShiftStatus.SHIFT_ERROR) {
      await _shiftFetch.stream.drain();
      _shiftFetch.sink.add(_shiftRepository.shiftStatus());
    }
  }
}