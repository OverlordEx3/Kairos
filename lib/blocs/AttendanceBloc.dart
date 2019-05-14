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

	Stream<AttendanceState> eventHandler(AttendanceEvent event, AttendanceState currentState) async* {
		AttendanceState state;
		switch(event.type) {
			case AttendanceEventType.add:
				ShiftAttendanceRepository().setCurrentAttendanceItem(event.person, true, event.group, section: event.section);
				state = AttendanceState(result: AttendanceResult.ok);
				break;

			case AttendanceEventType.remove:
				ShiftAttendanceRepository().setCurrentAttendanceItem(event.person, false, event.group, section: event.section);
				state = AttendanceState(result: AttendanceResult.ok);
				break;

			case AttendanceEventType.clear:
				ShiftAttendanceRepository().clearAttendanceList();
				state = AttendanceState(result: AttendanceResult.ok);
				break;

			case AttendanceEventType.get:
				ShiftAttendanceRepository().getAttendanceBy(section: event.section, group: event.group, personId: event.person, shift: event.shift);
				state = AttendanceState(result: AttendanceResult.ok);
				break;
		}

		yield state;
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
	int group;
	int shift;
	AttendanceEvent({this.type = AttendanceEventType.clear, this.id, this.section, this.person, this.group, this.shift}) : assert(type != null);
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

