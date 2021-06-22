import 'package:clup/bloc/bottom_bar/page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit(HomeState initialState) : super(initialState);

  void emitHomeSelected() => emit(HomeState());

  void emitPreferenceSelected() => emit(PreferencesState());

  void emitBookingSelected() => emit(BookingState());

  void emitSettingsSelected() => emit(SettingsState());
}
