import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/res/colors.dart';
import 'package:riverpod_todo/common/res/image_res.dart';
import 'package:riverpod_todo/common/utils/core_utils.dart';
import 'package:riverpod_todo/common/widgets/filled_field.dart';
import 'package:riverpod_todo/common/widgets/white_space.dart';
import 'package:riverpod_todo/features/auth/authentication/app/country_code_provider.dart';
import 'package:riverpod_todo/features/auth/controllers/auth_controller.dart';
import 'package:riverpod_todo/features/onboarding/widgets/round_button.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final code = ref.watch(countryCodeProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
            children: [
              Image.asset(ImageRes.todo),
              const WhiteSpace(height: 20),
              Text(
                "Please enter your number to get the verification code",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colours.light,
                    fontWeight: FontWeight.w500),
              ),
              const WhiteSpace(height: 20),
              FilledField(
                keyboardType: TextInputType.phone,
                controller : phoneController,
                readOnly: code == null,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 14),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          onSelect: (code) {
                            ref.read(countryCodeProvider.notifier).
                            changeCountry(code);
                          },
                          countryListTheme: CountryListThemeData(
                              backgroundColor: Colours.darkBackground,
                              bottomSheetHeight:
                              MediaQuery.of(context).size.height * 0.6,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              textStyle:
                              GoogleFonts.poppins(color: Colours.light),
                              searchTextStyle:
                              GoogleFonts.poppins(color: Colours.light),
                              inputDecoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Search',
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colours.lightGrey),
                                  hintText: 'Search')));
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(top: code ==  null ? 6.h : (0.6).h),
                      child: Text(
                        code == null ? 'Pick country' : '${code.flagEmoji} +${code.phoneCode} ',
                        style: GoogleFonts.poppins(
                            fontSize: code == null? 13 : 18,
                            color: code == null ? Colours.lightBlue : Colours.darkBackground,
                            fontWeight: code == null ? FontWeight.w500 : FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const WhiteSpace(height: 30),
              RoundButton(
                text: 'Send Code',
                onPressed: () async {
                  if(code  == null) return;
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(context);
                  await ref.read(authControllerProvider).sendOTP(context: context,
                      phoneNumber: '+${code.phoneCode}${phoneController.text}');
                  navigator.pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
