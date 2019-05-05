import 'package:rxdart/rxdart.dart';
import 'dart:async';

/* Models */
import '../models/SectionModel.dart';

class SectionBloc {
	/* Repository to handle data and communicate with provider */

/* Control streams */
	final PublishSubject<SectionEvent> _eventController = PublishSubject<SectionEvent>();
	final BehaviorSubject<SectionState> _statusController = BehaviorSubject<SectionState>();

	final SectionState initialState = SectionState.nullState();

	dispose() {
		_eventController?.close();
		_statusController?.close();
	}


	Stream<SectionState> eventHandler(SectionEvent event, SectionState currentState) {
		switch(event.type) {
			case SectionEventType.add:

				break;

			case SectionEventType.remove:

				break;

			case SectionEventType.get:

				break;

		}
	}

	emitEvent(SectionEvent event) {
		_eventController.sink.add(event);
	}

	SectionBloc() {
		_eventController.listen((event) {
			SectionState currentState = _statusController.value ?? initialState;
			eventHandler(event, currentState).forEach((state) {
				_statusController.sink.add(state);
			});
		});
	}
}

enum  SectionEventType {
	add,
	remove,
	get
}

class SectionEvent {
	SectionEventType type;
	int id;
	int section;
	int group;
	SectionEvent(this.group, {this.type = SectionEventType.get, this.id, this.section}) : assert(type != null);
}

enum SectionResult{
	ok,
	notFound,
	unknown
}

class SectionState {
	List<Section> queryResults;
	SectionResult result;
	SectionState({this.result = SectionResult.ok, this.queryResults});

	factory SectionState.nullState() {
		return SectionState(result: SectionResult.unknown, queryResults: []);
	}
}
