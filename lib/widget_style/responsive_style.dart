class ResponsiveStyle {
  static const mobileMaxWidth = 767.0;
  static const tabletMaxWidth = 1023.0;

  static double getResponsiveWidth({required double maxWidth, required double mobileWidth, required double tabletWidth, required double desktopWidth}) {
    if (maxWidth <= mobileMaxWidth) {
      return mobileWidth;
    } else if (maxWidth <= tabletMaxWidth) {
      return tabletWidth;
    } else {
      return desktopWidth;
    }
  }
}
