import 'package:rxdart/rxdart.dart';
import 'dart:async';

/* Models */
import '../models/ShiftModel.dart' show Shift, ShiftStatus;
export '../models/ShiftModel.dart' show ShiftStatus;

class ShiftBloc {
  /* Control streams */
  final PublishSubject<ShiftEvent> _eventController = PublishSubject<ShiftEvent>();
  final BehaviorSubject<ShiftState> _statusController = BehaviorSubject<ShiftState>();

  final ShiftState initialState = ShiftState.nullState();

  dispose() {
    _eventController?.close();
    _statusController?.close();
  }

  ShiftBloc() {
    _eventController.listen((ShiftEvent event) {
      ShiftState currentState = _statusController.value ?? initialState;
      eventHandler(event, currentState).forEach((state) {
        _statusController.sink.add(state);
      });
    });
  }

  Stream<ShiftState> eventHandler(ShiftEvent event, ShiftState currentState) {
    switch(event.type) {
      case ShiftEventType.stop:

        break;

      case ShiftEventType.cancel:

        break;

      case ShiftEventType.retrieve:

        break;

      case ShiftEventType.retrieveAll:

        break;

      case ShiftEventType.start:
        
        break;
    }
  }

  emitEvent(ShiftEvent event) {
    _eventController.sink.add(event);
  }
}

enum ShiftEventType {
  start,
  stop,
  cancel,
  retrieve,
  retrieveAll,
}

class ShiftEvent {
  ShiftEventType type;
  ShiftEvent({this.type = ShiftEventType.stop}) : assert(type != null);
}

class ShiftState {
  ShiftStatus currentState;
  List<Shift> shifts;
  ShiftState({this.currentState: ShiftStatus.closed, this.shifts}) : assert(currentState != null);

  factory ShiftState.nullState() {
    return ShiftState(currentState: ShiftStatus.closed, shifts: []);
  }
}

