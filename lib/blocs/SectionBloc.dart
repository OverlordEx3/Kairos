import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'BlocBase.dart';

/* Models */
import '../models/SectionModel.dart';
import '../Repository/SectionRepository.dart';

class SectionBloc extends BlocEventStateBase<SectionEvent, SectionState> {
	static final _instance = SectionBloc._internal();

	factory SectionBloc() => _instance;
	SectionBloc._internal() : super(initialState: SectionState.nullState());


	Stream<SectionState> eventHandler(SectionEvent event, SectionState currentState) async* {
		switch(event.type) {
			case SectionEventType.add:
				final result = await SectionRepository().addSection(Section(event.name, event.group));
				final sectionState = SectionState();
				sectionState.queryResults.add(result);
				sectionState.result = SectionResult.ok;
				yield sectionState;

				break;

			case SectionEventType.remove:

				break;

			case SectionEventType.get:
				final result = await SectionRepository().getSectionById(event.section);
				final sectionState = SectionState();
				if(result == null) {
					sectionState.result = SectionResult.notFound;
					yield sectionState;
				}
				sectionState.queryResults.add(result);
				sectionState.result = SectionResult.ok;
				yield sectionState;
				break;

		}
	}
}

enum  SectionEventType {
	add,
	remove,
	get
}

class SectionEvent extends BlocEvent {
	SectionEventType type;
	int id;
	int section;
	int group;
	String name;
	SectionEvent(this.group, {this.type = SectionEventType.get, this.id, this.section, this.name}) : assert(type != null);
}

enum SectionResult{
	ok,
	notFound,
	unknown
}

class SectionState extends BlocState {
	List<Section> queryResults;
	SectionResult result;
	SectionState({this.result = SectionResult.ok, this.queryResults});

	factory SectionState.nullState() {
		return SectionState(result: SectionResult.unknown, queryResults: []);
	}
}
