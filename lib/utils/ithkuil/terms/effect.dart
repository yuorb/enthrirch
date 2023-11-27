enum Effect {
  neutral,
  ben1,
  ben2,
  ben3,
  benSlf,
  unk,
  detSlf,
  det3,
  det2,
  det1;

  String romanize(String charPrecedingThis) {
    return switch (this) {
      neutral => throw "unreachable",
      ben1 => charPrecedingThis == 'y' ? 'uä' : 'ia',
      ben2 => charPrecedingThis == 'y' ? 'uë' : 'ie',
      ben3 => charPrecedingThis == 'y' ? 'üä' : 'io',
      benSlf => charPrecedingThis == 'y' ? 'üë' : 'iö',
      unk => 'eë',
      detSlf => charPrecedingThis == 'w' ? 'öë' : 'uö',
      det3 => charPrecedingThis == 'w' ? 'öä' : 'uo',
      det2 => charPrecedingThis == 'w' ? 'ië' : 'ue',
      det1 => charPrecedingThis == 'w' ? 'iä' : 'ua',
    };
  }

  String path() {
    return switch (this) {
      neutral => "",
      ben1 => "M -7.05 -17.50 L -14.55 -10.00 7.10 17.50 14.55 10.00 -7.05 -17.50 Z",
      ben2 =>
        "M -18.30 -2.50 L -17.10 -1.30 -9.75 -8.65 10.85 17.50 18.30 10.00 -3.30 -17.50 -18.30 -2.50 Z",
      ben3 =>
        "M 9.75 8.65 L -10.80 -17.50 -18.30 -10.00 3.35 17.50 18.30 2.50 17.10 1.30 9.75 8.65 Z",
      benSlf =>
        "M -20.85 -1.30 L -13.50 -8.65 7.10 17.50 22.05 2.50 20.85 1.30 13.50 8.65 -7.05 -17.50 -22.05 -2.50 -20.85 -1.30 Z",
      unk =>
        "M -5.60 -11.90 Q -5.71 -12.20 -5.85 -12.55 L 1.65 -20.05 0.45 -21.25 -14.55 -6.25 7.10 21.25 14.55 13.75 -5.60 -11.90 Z",
      detSlf =>
        "M -7.05 -21.25 L -14.55 -13.75 5.65 11.90 Q 5.76 12.21 5.90 12.55 L -1.60 20.05 -0.40 21.25 14.55 6.25 -7.05 -21.25 Z",
      det3 =>
        "M -23.38 -1.30 L -16.03 -8.65 4.57 17.50 14.57 17.50 24.57 7.50 10.02 7.50 -9.58 -17.50 -24.58 -2.50 -23.38 -1.30 Z",
      det2 =>
        "M -20.80 -7.50 L -6.35 -7.50 13.35 17.50 20.80 10.00 -0.80 -17.50 -10.80 -17.50 -20.80 -7.50 Z",
      det1 =>
        "M -13.32 -17.50 L -20.82 -10.00 0.83 17.50 10.83 17.50 20.83 7.50 6.27 7.50 -13.32 -17.50 Z",
    };
  }
}
