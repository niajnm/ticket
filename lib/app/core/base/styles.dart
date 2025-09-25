import 'package:flutter/material.dart';

/// Gradient background for header
BoxDecoration contactHeaderDecoration(ColorScheme colorScheme) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        colorScheme.shadow.withOpacity(0.3),
        colorScheme.secondaryContainer,
      ],
    ),
  );
}

/// Shadow around profile image
BoxDecoration contactImageDecoration(ColorScheme colorScheme) {
  return BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: colorScheme.shadow.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );
}

/// AppBar button style
BoxDecoration contactAppBarButtonDecoration(ColorScheme colorScheme) {
  return BoxDecoration(
    color: colorScheme.surface.withOpacity(0.9),
    borderRadius: BorderRadius.circular(12),
  );
}
