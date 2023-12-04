import 'package:flutter/cupertino.dart';

import 'app_localizations.dart';

abstract class LocalizedString {
  static LocalizedString fromString(String string) => FactoryLocalizedString((_) => string, string);

  static LocalizedString empty() => FactoryLocalizedString((_) => '', '');

  static LocalizedString locale(
    Function(AppLocalizations) locales, [
    String? key,
  ]) =>
      FactoryLocalizedString(
        (context) => locales(AppLocalizations.of(context)),
        key ?? UniqueKey().toString(),
      );

  static LocalizedString fromFactory(
    String Function(BuildContext) factory, [
    String? key,
  ]) =>
      FactoryLocalizedString(factory, key ?? UniqueKey().toString());

  LocalizedString operator +(LocalizedString other) {
    return ConcatLocalizedString(this, other);
  }

  String localize(BuildContext context);
}

class FactoryLocalizedString extends LocalizedString {
  final String Function(BuildContext) _localize;
  final String key;

  FactoryLocalizedString(this._localize, this.key) : super();

  @override
  String localize(BuildContext context) {
    return _localize(context);
  }

  @override
  List<Object> get props => [key];
}

class ConcatLocalizedString extends LocalizedString {
  final LocalizedString lhs;
  final LocalizedString rhs;

  ConcatLocalizedString(this.lhs, this.rhs) : super();

  @override
  String localize(BuildContext context) {
    return lhs.localize(context) + rhs.localize(context);
  }

  @override
  List<Object> get props => [lhs, rhs];
}

extension JoinLocalize on List<LocalizedString> {
  LocalizedString joinLocalizedS(String separator) {
    return joinLocalized(LocalizedString.fromString(separator));
  }

  LocalizedString joinLocalized(LocalizedString separator) {
    var result = LocalizedString.fromString('');

    for (var i = 0; i < length; i++) {
      final component = this[i];
      result += component;

      if (i < length - 1) {
        result += separator;
      }
    }

    return result;
  }
}
