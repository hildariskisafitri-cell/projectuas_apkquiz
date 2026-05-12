import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget that provides a classic and luxurious background with ornamental patterns.
/// 
/// This widget wraps content with an elegant dark background featuring:
/// - Navy/dark blue background with subtle gradients
/// - Damask and Art Deco ornamental patterns
/// - Muted gold/bronze accents
/// - Velvet-like texture effect
/// - 16:9 aspect ratio support
class LuxuryBackground extends StatelessWidget {
  /// The child widget to display on top of the background
  final Widget child;
  
  /// Whether to add a semi-transparent overlay for better text readability
  final bool addOverlay;
  
  /// Overlay opacity (0.0 to 1.0)
  final double overlayOpacity;

  const LuxuryBackground({
    super.key,
    required this.child,
    this.addOverlay = true,
    this.overlayOpacity = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0a1419), // Base dark color
      ),
      child: Stack(
        children: [
          // Background SVG pattern
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/backgrounds/luxury_background.svg',
              fit: BoxFit.cover,
              semanticsLabel: 'Luxury background pattern',
            ),
          ),
          
          // Optional overlay for better text readability
          if (addOverlay)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(overlayOpacity),
              ),
            ),
          
          // Content on top
          Positioned.fill(
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Alternative: Use this for screens that need the background
/// Wrap your Scaffold's body with this widget
class LuxuryBackgroundScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? addBackgroundOverlay;
  final double? overlayOpacity;
  final Color? appBarBackgroundColor;

  const LuxuryBackgroundScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.addBackgroundOverlay = true,
    this.overlayOpacity = 0.15,
    this.appBarBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: LuxuryBackground(
        addOverlay: addBackgroundOverlay ?? true,
        overlayOpacity: overlayOpacity ?? 0.15,
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
