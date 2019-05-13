import '../models/SectionModel.dart';
import '../Provider/SectionProvider.dart';

class SectionRepository {
	Set<Section> _sections = Set<Section>();

	Future<Section> addSection(Section section) async {
		final newSection = await SectionLocalProvider().addSection(section);
		if(newSection != null) {
			_sections.add(newSection);
		}
		return newSection;
	}

	Future<Section> updateSection(Section section) async {
		final updatedSection = await SectionLocalProvider().updateSection(section);
		if(updatedSection > 0) {
			return section;
		}
		return null;
	}

	Future<bool> deleteSection(Section section) async {
		final result = await SectionLocalProvider().deleteSection(section.id);
		if(result > 0) {
			return true;
		}
		return false;
	}

	Future<Section> getSectionById(int id) async {
		final result = await SectionLocalProvider().getSectionById(id);
		return result;
	}

	Future<List<Section>> getSectionsByGroup(int groupId) async {
		var sections = await SectionLocalProvider().getAllSectionsFromGroup(groupId);
		return sections;
	}
}