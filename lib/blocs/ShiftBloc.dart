import 'package:rxdart/rxdart.dart';

import '../models/ShiftModel.dart';
import '../Provider/ShiftProvider.dart' show ShiftLocalProvider;
import 'package:count_me_in/Repository/ShiftRepository.dart';

final ShiftBloc shiftBloc = ShiftBloc();

class ShiftBloc {
  /* Keep track of the last shift. If one is active */
  bool _shiftActive = false;

  final _shiftRepository = ShiftRepository(provider: ShiftLocalProvider());

  final _shiftFetchController = new PublishSubject<Shift>();
  Sink<Shift> get _shiftAdd => _shiftFetchController.sink;
  Observable<Shift> get currentShift => _shiftFetchController.stream;





}