class ApartmentPreferenceState {
  final String minRooms;
  final String maxRooms;
  final String minSquareMeters;
  final String maxSquareMeters;
  final String minRent;
  final String maxRent;
  final String city;

  ApartmentPreferenceState({
    this.minRooms = '1',
    this.maxRooms = '10+',
    this.minSquareMeters = '<10',
    this.maxSquareMeters = '>200',
    this.minRent = '<100',
    this.maxRent = '>2000',
    this.city = 'Berlin',
  });

  ApartmentPreferenceState copyWith({
    String? minRooms,
    String? maxRooms,
    String? minSquareMeters,
    String? maxSquareMeters,
    String? minRent,
    String? maxRent,
    String? city,
  }) {
    return ApartmentPreferenceState(
      minRooms: minRooms ?? this.minRooms,
      maxRooms: maxRooms ?? this.maxRooms,
      minSquareMeters: minSquareMeters ?? this.minSquareMeters,
      maxSquareMeters: maxSquareMeters ?? this.maxSquareMeters,
      minRent: minRent ?? this.minRent,
      maxRent: maxRent ?? this.maxRent,
      city: city ?? this.city,
    );
  }
}
