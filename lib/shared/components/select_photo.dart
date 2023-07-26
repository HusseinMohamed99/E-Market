import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_marko/shared/cubit/cubit.dart';
import 'package:super_marko/shared/styles/colors.dart';

class SelectPhotoOptions extends StatelessWidget {
  const SelectPhotoOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return Container(
      color:
          cubit.isDark ? AppMainColors.whiteColor : AppColorsLight.primaryColor,
      padding: const EdgeInsets.all(20).r,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -30.h,
            child: Container(
              width: 50.w,
              height: 6.h,
              margin: const EdgeInsets.only(bottom: 20).r,
              decoration: BoxDecoration(
                color: cubit.isDark
                    ? AppColorsLight.primaryColor
                    : AppMainColors.whiteColor,
                borderRadius: BorderRadius.circular(2.5).r,
                // color: ThemeApp.secondaryColor,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Column(children: [
            SelectPhoto(
              onTap: () {
                cubit.getImagePicker(ImageSource.gallery);
              },
              icon: Icons.image,
              textLabel: 'Browse Gallery',
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                'OR',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 10.h),
            SelectPhoto(
              onTap: () {
                cubit.getImagePicker(ImageSource.camera);
              },
              icon: Icons.camera_alt_outlined,
              textLabel: 'Use a Camera',
            ),
          ])
        ],
      ),
    );
  }
}

class SelectPhoto extends StatelessWidget {
  final String textLabel;
  final IconData icon;

  final void Function()? onTap;

  const SelectPhoto({
    Key? key,
    required this.textLabel,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: cubit.isDark
            ? AppColorsLight.primaryColor
            : AppMainColors.whiteColor,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
            ),
            SizedBox(width: 14.w),
            Text(
              textLabel,
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
