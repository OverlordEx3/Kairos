import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'BlocBase.dart';

/* Models */
import '../models/AttendanceModel.dart';
import '../Repository/ShiftAttendanceRepository.dart';

class AttendanceBloc extends BlocEventStateBase<AttendanceEvent, AttendanceState>{
	static final _instance = AttendanceBloc._internal();

	factory AttendanceBloc() => _instance;
	AttendanceBloc._internal() : super(initialState: AttendanceState.nullState());

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
}

enum  AttendanceEventType {
	add,
	remove,
	clear,
	get
}

class AttendanceEvent extends BlocEvent {
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

class AttendanceState extends BlocState {
	List<Attendance> queryResults;
	AttendanceResult result;
	AttendanceState({this.result = AttendanceResult.ok, this.queryResults});

	factory AttendanceState.nullState() {
		return AttendanceState(result: AttendanceResult.unknown, queryResults: []);
	}
}

