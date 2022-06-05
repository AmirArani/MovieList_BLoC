/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImgGen {
  const $AssetsImgGen();

  /// File path: assets/img/error_state.png
  AssetGenImage get errorState =>
      const AssetGenImage('assets/img/error_state.png');

  $AssetsImgIconsGen get icons => const $AssetsImgIconsGen();
}

class $AssetsImgIconsGen {
  const $AssetsImgIconsGen();

  /// File path: assets/img/icons/best_drama.svg
  SvgGenImage get bestDrama =>
      const SvgGenImage('assets/img/icons/best_drama.svg');

  /// File path: assets/img/icons/birthdate.svg
  SvgGenImage get birthdate =>
      const SvgGenImage('assets/img/icons/birthdate.svg');

  /// File path: assets/img/icons/deathdate.svg
  SvgGenImage get deathdate =>
      const SvgGenImage('assets/img/icons/deathdate.svg');

  $AssetsImgIconsNavbarGen get navbar => const $AssetsImgIconsNavbarGen();

  /// File path: assets/img/icons/tmdb_long.png
  AssetGenImage get tmdbLong =>
      const AssetGenImage('assets/img/icons/tmdb_long.png');

  /// File path: assets/img/icons/trending.svg
  SvgGenImage get trending =>
      const SvgGenImage('assets/img/icons/trending.svg');

  /// File path: assets/img/icons/tv_show.svg
  SvgGenImage get tvShow => const SvgGenImage('assets/img/icons/tv_show.svg');
}

class $AssetsImgIconsNavbarGen {
  const $AssetsImgIconsNavbarGen();

  /// File path: assets/img/icons/navbar/home.svg
  SvgGenImage get home => const SvgGenImage('assets/img/icons/navbar/home.svg');

  /// File path: assets/img/icons/navbar/home_selected.svg
  SvgGenImage get homeSelected =>
      const SvgGenImage('assets/img/icons/navbar/home_selected.svg');

  /// File path: assets/img/icons/navbar/search.svg
  SvgGenImage get search =>
      const SvgGenImage('assets/img/icons/navbar/search.svg');

  /// File path: assets/img/icons/navbar/search_selected.svg
  SvgGenImage get searchSelected =>
      const SvgGenImage('assets/img/icons/navbar/search_selected.svg');

  /// File path: assets/img/icons/navbar/star.svg
  SvgGenImage get star => const SvgGenImage('assets/img/icons/navbar/star.svg');

  /// File path: assets/img/icons/navbar/star_selected.svg
  SvgGenImage get starSelected =>
      const SvgGenImage('assets/img/icons/navbar/star_selected.svg');

  /// File path: assets/img/icons/navbar/user.svg
  SvgGenImage get user => const SvgGenImage('assets/img/icons/navbar/user.svg');

  /// File path: assets/img/icons/navbar/user_selected.svg
  SvgGenImage get userSelected =>
      const SvgGenImage('assets/img/icons/navbar/user_selected.svg');
}

class Assets {
  Assets._();

  static const $AssetsImgGen img = $AssetsImgGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
