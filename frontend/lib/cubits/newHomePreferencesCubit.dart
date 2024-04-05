import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/ApartmentPreferenceState.dart';

class NewHomePreferencesCubit extends Cubit<ApartmentPreferenceState> {
  NewHomePreferencesCubit() : super(ApartmentPreferenceState());

  void updatePreference({String? minRooms, String? maxRooms, String? minSquareMeters, String? maxSquareMeters, String? minRent, String? maxRent, String? city}) {
    emit(state.copyWith(minRooms: minRooms, maxRooms: maxRooms, minSquareMeters: minSquareMeters, maxSquareMeters: maxSquareMeters, minRent: minRent, maxRent: maxRent, city: city));
  }

    // Individual update methods for each preference
  void updateMinRooms(String? minRooms) {
    emit(state.copyWith(minRooms: minRooms));
  }

  void updateMaxRooms(String? maxRooms) {
    emit(state.copyWith(maxRooms: maxRooms));
  }

  void updateMinSquareMeters(String? minSquareMeters) {
    emit(state.copyWith(minSquareMeters: minSquareMeters));
  }

  void updateMaxSquareMeters(String? maxSquareMeters) {
    emit(state.copyWith(maxSquareMeters: maxSquareMeters));
  }

  void updateMinRent(String? minRent) {
    emit(state.copyWith(minRent: minRent));
  }

  void updateMaxRent(String? maxRent) {
    emit(state.copyWith(maxRent: maxRent));
  }

  void updateCity(String? city) {
    emit(state.copyWith(city: city));
  }
}