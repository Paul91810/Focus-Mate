import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_view_event.dart';
part 'page_view_state.dart';

class PageViewBloc extends Bloc<PageViewEvent, PageViewState> {
  PageViewBloc() : super(PageViewInitial()) {
    on<PageViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
