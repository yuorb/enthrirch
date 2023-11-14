enum Function$ {
  /// The Stative Function
  sta,

  /// The Dynamic Function
  dyn;
}

enum Version {
  /// The Processual Version
  prc,

  /// The Completive Version
  cpt;
}

enum Plexity {
  /// The Uniplex/Multiplex Plexity
  um,

  /// The Duplex Plexity
  d;
}

enum Stem {
  /// Stem 1
  s1,

  /// Stem 2
  s2,

  /// Stem 3
  s3,

  /// Stem 0
  s0;
}

class ComponentD {
  final Function$ function;
  final Version version;
  final Plexity plexity;
  final Stem stem;

  const ComponentD({
    required this.function,
    required this.version,
    required this.plexity,
    required this.stem,
  });

  String id() {
    return '${function.name}_${version.name}_${plexity.name}_${stem.name}';
  }

  String path() {
    return switch (function) {
      Function$.sta => switch (version) {
          Version.prc => switch (plexity) {
              Plexity.um => switch (stem) {
                  Stem.s1 => "",
                  Stem.s2 =>
                    "M -5.00 5.00 L 0.00 0.00 10.00 10.00 17.15 2.85 5.85 -8.35 -1.15 -1.25 Q -4.34 -2.99 -5.00 -1.25 -5.92 0.04 -5.00 5.00 Z",
                  Stem.s3 =>
                    "M 10.00 9.85 L 10.00 -12.50 0.00 -2.40 Q -4.22 -3.06 -6.30 0.30 -7.09 1.29 -6.30 6.30 L 0.00 0.00 0.00 19.95 10.00 9.85 Z",
                  Stem.s0 =>
                    "M 15.05 0.00 L 25.05 -10.00 7.60 -10.00 -1.15 -1.20 Q -8.05 -1.40 -4.95 4.95 L 0.00 0.00 15.05 0.00 Z"
                },
              Plexity.d => switch (stem) {
                  Stem.s1 =>
                    "M -6.40 4.45 Q -3.12 2.62 0.00 0.00 L 7.50 -7.50 6.30 -8.70 -1.20 -1.20 Q -5.31 -2.89 -5.75 -1.55 -6.35 -0.10 -6.40 4.45 Z",
                  Stem.s2 =>
                    "M 17.15 2.85 L 5.85 -8.35 -1.15 -1.25 Q -4.35 -3.00 -5.00 -1.25 -5.90 0.05 -5.00 5.00 L 0.00 0.00 8.80 8.80 1.30 16.30 2.50 17.50 17.15 2.85 Z",
                  Stem.s3 =>
                    "M -6.30 0.30 Q -7.10 1.30 -6.30 6.30 L 0.00 0.00 0.00 17.45 -7.50 24.95 -6.30 26.15 10.00 9.85 10.00 -12.50 0.00 -2.40 Q -4.20 -3.05 -6.30 0.30 Z",
                  Stem.s0 =>
                    "M 0.00 0.00 L 12.65 0.00 5.15 7.50 6.35 8.70 25.05 -10.00 7.60 -10.00 -1.15 -1.20 Q -8.05 -1.40 -4.95 4.95 L 0.00 0.00 Z"
                },
            },
          Version.cpt => switch (plexity) {
              Plexity.um => switch (stem) {
                  Stem.s1 =>
                    "M 0.00 0.00 Q -6.80 0.50 -7.50 7.50 L 7.50 22.50 15.00 15.00 0.00 0.00 Z",
                  Stem.s2 =>
                    "M 5.10 18.49 L -6.70 6.69 -1.70 1.69 Q -9.38 0.00 -8.80 2.19 L -7.85 5.54 -14.90 12.59 -1.90 25.49 5.10 18.49 Z",
                  Stem.s3 =>
                    "M -7.50 7.50 L 0.00 0.00 Q -11.45 -4.90 -8.70 6.30 L -17.50 15.20 -17.50 32.65 -7.50 22.65 -7.50 7.50 Z",
                  Stem.s0 =>
                    "M -8.70 6.20 L -19.90 17.50 2.50 17.50 12.50 7.40 -7.40 7.40 -0.30 0.30 Q -10.75 -0.86 -8.70 6.20 Z"
                },
              Plexity.d => switch (stem) {
                  Stem.s1 =>
                    "M -7.50 7.50 L 6.30 21.30 -1.20 28.80 0.00 30.00 15.00 15.00 0.00 0.00 Q -6.80 0.50 -7.50 7.50 Z",
                  Stem.s2 =>
                    "M 4.80 18.80 L -7.00 7.00 -2.00 2.00 Q -9.70 0.30 -9.10 2.50 L -8.15 5.85 -15.20 12.90 -3.40 24.60 -10.90 32.10 -9.70 33.30 4.80 18.80 Z",
                  Stem.s3 =>
                    "M -7.50 7.50 L 0.00 0.00 Q -11.45 -4.90 -8.70 6.30 L -17.50 15.20 -17.50 30.25 -25.00 37.75 -23.80 38.95 -7.50 22.65 -7.50 7.50 Z",
                  Stem.s0 =>
                    "M 12.80 7.10 L -7.10 7.10 0.00 0.00 Q -10.45 -1.15 -8.40 5.90 L -19.60 17.20 0.30 17.20 -7.10 24.60 -5.90 25.80 12.80 7.10 Z"
                },
            },
        },
      Function$.dyn => switch (version) {
          Version.prc => switch (plexity) {
              Plexity.um => switch (stem) {
                  Stem.s1 =>
                    "M -10.05 -2.47 Q -11.70 0.25 -7.45 7.53 L 7.55 7.53 17.55 -2.47 -2.45 -2.47 Q -9.46 -5.40 -10.05 -2.47 Z",
                  Stem.s2 =>
                    "M 12.50 -2.50 L -2.50 -2.50 Q -9.50 -5.45 -10.10 -2.50 -11.75 0.20 -7.50 7.50 L 2.50 7.50 2.50 22.50 12.50 12.50 12.50 -2.50 Z",
                  Stem.s3 =>
                    "M -1.20 -1.20 Q -7.69 -2.42 -5.95 3.80 -3.03 -0.09 0.00 0.00 L 8.80 -8.80 8.80 -23.80 -1.20 -13.80 -1.20 -1.20 Z",
                  Stem.s0 =>
                    "M -16.15 16.25 L -7.40 7.40 Q -5.65 4.20 -2.55 0.20 -8.25 -0.15 -8.55 6.25 L -28.50 6.25 -38.50 16.25 -16.15 16.25 Z"
                },
              Plexity.d => switch (stem) {
                  Stem.s1 =>
                    "M -2.30 15.00 L -1.10 16.20 17.60 -2.50 -2.40 -2.50 Q -9.40 -5.45 -10.00 -2.50 -11.65 0.20 -7.40 7.50 L 5.20 7.50 -2.30 15.00 Z",
                  Stem.s2 =>
                    "M 23.80 -11.20 L 15.10 -2.50 -2.50 -2.50 Q -9.50 -5.45 -10.10 -2.50 -11.75 0.20 -7.50 7.50 L 7.50 7.50 25.00 -10.00 23.80 -11.20 Z",
                  Stem.s3 =>
                    "M 17.50 2.45 L 16.30 1.25 10.00 7.55 10.00 -12.50 0.00 -2.40 Q -4.20 -3.05 -6.30 0.30 -7.10 1.30 -6.30 6.30 L 0.00 0.00 0.00 19.95 17.50 2.45 Z",
                  Stem.s0 =>
                    "M -15.90 16.00 L -7.15 7.15 Q -5.40 3.95 -2.30 -0.05 -8.00 -0.40 -8.30 6.00 L -25.85 6.00 -19.55 -0.35 -20.75 -1.55 -38.25 16.00 -15.90 16.00 Z",
                },
            },
          Version.cpt => switch (plexity) {
              Plexity.um => switch (stem) {
                  Stem.s1 =>
                    "M -6.40 4.45 Q -3.12 2.62 0.00 0.00 L 7.50 -7.50 6.30 -8.70 -1.20 -1.20 Q -5.31 -2.89 -5.75 -1.55 -6.35 -0.10 -6.40 4.45 Z",
                  Stem.s2 =>
                    "M -8.45 6.05 L -15.95 13.60 Q 1.75 22.10 11.55 6.10 -0.15 13.40 -7.30 7.25 L -3.60 3.60 Q -5.41 2.29 -8.15 1.50 -9.95 1.00 -8.45 6.05 Z",
                  Stem.s3 =>
                    "M 15.20 19.85 Q 15.55 -2.05 5.35 -7.65 L -0.95 -1.30 -1.00 -1.35 Q -9.05 -4.17 -7.30 7.35 L -1.00 1.00 Q 9.80 3.60 15.20 19.85 Z",
                  Stem.s0 =>
                    "M -0.25 0.25 Q -7.85 -3.00 -8.85 0.25 -9.16 2.20 -7.55 6.45 L -8.85 6.60 Q -29.40 9.80 -24.95 0.30 -37.30 14.65 -15.20 15.25 L -0.25 0.25 Z"
                },
              Plexity.d => switch (stem) {
                  Stem.s1 =>
                    "M 0.00 0.00 Q -6.80 0.50 -7.50 7.50 L 7.50 22.50 22.50 7.50 21.30 6.30 13.80 13.80 0.00 0.00 Z",
                  Stem.s2 =>
                    "M -7.05 7.05 L 0.00 0.00 Q -4.30 -1.67 -7.90 0.90 -8.99 3.80 -8.20 5.85 L -15.70 13.40 Q 1.10 12.85 11.80 25.85 7.20 7.50 -7.05 7.05 Z",
                  Stem.s3 =>
                    "M -1.00 -1.35 L -1.00 -1.40 Q -9.10 -4.20 -7.35 7.30 L -1.00 1.00 Q 8.40 18.75 20.20 7.85 7.95 10.00 5.35 -7.65 L -1.00 -1.35 Z",
                  Stem.s0 =>
                    "M -8.65 0.00 Q -9.98 4.08 -7.85 6.70 L -8.65 6.35 Q -27.70 -2.80 -32.35 12.55 -24.70 3.15 -15.00 15.00 L 0.00 0.00 Q -4.65 -1.32 -8.65 0.00 Z"
                },
            },
        },
    };
  }
}
