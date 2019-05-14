import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'BlocBase.dart';

/* Models */
import '../models/ShiftModel.dart' show Shift, ShiftStatus;
export '../models/ShiftModel.dart' show ShiftStatus;

import '../Repository/ShiftAttendanceRepository.dart';

class ShiftBloc extends BlocEventStateBase<ShiftEvent, ShiftState>{

  Stream<ShiftState> eventHandler(ShiftEvent event, ShiftState currentState) async* {
    ShiftState state;
    switch(event.type) {
      case ShiftEventType.stop:
        state = ShiftState(currentState: ShiftStatus.error);
        if(currentState.currentState == ShiftStatus.open || currentState.currentState == ShiftStatus.empty) {
          ShiftAttendanceRepository().saveAttendanceList();
          ShiftAttendanceRepository().updateShift(ShiftStatus.closed);
          state.currentState = ShiftStatus.closed;
        }
        break;

      case ShiftEventType.cancel:
        //Todo
        break;

      case ShiftEventType.retrieve:

        break;

      case ShiftEventType.retrieveAll:

        break;

      case ShiftEventType.start:
        state = ShiftState(currentState: ShiftStatus.error);
        if(currentState.currentState != ShiftStatus.empty || currentState.currentState != ShiftStatus.open) {
          final result = ShiftAttendanceRepository().createNewShift(ShiftStatus.empty);
          state.shifts.add(await result);
          state.currentState = ShiftStatus.empty;
        }
        break;
    }
    yield state;
  }
}

enum ShiftEventType {
  start,
  stop,
  cancel,
  retrieve,
  retrieveAll,
}

class ShiftEvent extends BlocEvent{
  ShiftEventType type;
  ShiftEvent({this.type = ShiftEventType.stop}) : assert(type != null);
}

class ShiftState extends BlocState{
  ShiftStatus currentState;
  List<Shift> shifts;
  ShiftState({this.currentState: ShiftStatus.closed, this.shifts}) : assert(currentState != null);

  factory ShiftState.nullState() {
    return ShiftState(currentState: ShiftStatus.closed, shifts: []);
  }
}

