// search_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:dil_hack_e_commerce/api/search_api.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchTermChanged>(_onSearchTermChanged);
  }

  Future<void> _onSearchTermChanged(
      SearchTermChanged event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    try {
      final products = await fetchSearchResults(event.searchTerm);

      if (products.isEmpty) {
        emit(SearchSuccess([]));
      } else {
        emit(SearchSuccess(products));
      }
    } catch (error) {
      emit(SearchFailure(error.toString()));
    }
  }
}
