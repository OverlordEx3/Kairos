import 'package:rxdart/rxdart.dart';
import 'dart:async';

/* Models */
import '../models/AttendanceModel.dart';

class AttendanceBloc {
	/* Repository to handle data and communicate with provider */

/* Control streams */
	final PublishSubject<AttendanceEvent> _eventController = PublishSubject<AttendanceEvent>();
	final BehaviorSubject<AttendanceState> _statusController = BehaviorSubject<AttendanceState>();

	final AttendanceState initialState = AttendanceState.nullState();

	dispose() {
		_eventController?.close();
		_statusController?.close();
	}


	Stream<AttendanceState> eventHandler(AttendanceEvent event, AttendanceState currentState) {
		switch(event.type) {
			case AttendanceEventType.add:

				break;

			case AttendanceEventType.remove:

				break;

			case AttendanceEventType.clear:

				break;

			case AttendanceEventType.get:

				break;

		}
	}

	emitEvent(AttendanceEvent event) {
		_eventController.sink.add(event);
	}

	AttendanceBloc() {
		_eventController.listen((event) {
			AttendanceState currentState = _statusController.value ?? initialState;
			eventHandler(event, currentState).forEach((state) {
				_statusController.sink.add(state);
			});
		});
	}
}

enum  AttendanceEventType {
	add,
	remove,
	clear,
	get
}

class AttendanceEvent {
	AttendanceEventType type;
	int id;
	int section;
	int person;
	AttendanceEvent({this.type = AttendanceEventType.clear, this.id, this.section, this.person}) : assert(type != null);
}

enum AttendanceResult{
	ok,
	notFound,
	unknown
}

class AttendanceState {
	List<Attendance> queryResults;
	AttendanceResult result;
	AttendanceState({this.result = AttendanceResult.ok, this.queryResults});

	factory AttendanceState.nullState() {
		return AttendanceState(result: AttendanceResult.unknown, queryResults: []);
	}
}

