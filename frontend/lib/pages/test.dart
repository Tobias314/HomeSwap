import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dating_app/constants/colors.dart';
import 'package:dating_app/pages/profile_page.dart';
import 'package:dating_app/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/ApartmentPreferenceState.dart';
import '../cubits/currentHomeCubit.dart';
import '../cubits/newHomePreferencesCubit.dart';


class ApartmentPreferencesDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewHomePreferencesCubit, ApartmentPreferenceState>(
      builder: (context, state) {
        return Text(
          'Preferences:\n'
          'Rooms: ${state.minRooms} - ${state.maxRooms}\n'
          'Square Meters: ${state.minSquareMeters} - ${state.maxSquareMeters}\n'
          'Rent: ${state.minRent} - ${state.maxRent}\n'
          'City: ${state.city ?? "Any"}',
          style: TextStyle(fontSize: 16), // Customize your text style
        );
      },
    );
  }
}