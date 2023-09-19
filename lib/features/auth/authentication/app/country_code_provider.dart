
import 'package:country_picker/country_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_code_provider.g.dart';

@riverpod
class CountryCode extends _$CountryCode {
  @override
  Country? build() => null;

  void changeCountry(Country newCountry){
    state = newCountry;
  }


}