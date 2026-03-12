import 'package:dailytaro/utils/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../controller/userController.dart';
import '../../utils/utils.dart';

class GenderEnter extends StatefulWidget {
  const GenderEnter({super.key});

  @override
  State<GenderEnter> createState() => _GenderEnterState();
}

class _GenderEnterState extends State<GenderEnter> {
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: .center,
          children: [
            genderButton(78, 'S'),
            const SizedBox(width: 25,),
            genderButton(78, 'M'),
          ],
        )
      ],
    );
  }

  Widget genderButton(double size, gender) => Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: .circular(18),
      onTap: () {
        UserController.user.value.gender = gender;
        UserController.pageIndex.value++;
        setState(() {});
      },
      child: Container(
        padding: const .all(10),
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: .all(width: 1.2, color: Colors.white.withAlpha(180)),
          borderRadius: .circular(18)
        ),
        child: Center(
          child: SizedBox(
            child: SvgPicture.asset('assets/icons/${gender == 'M' ? '' : 'fe' }male.svg'),
          ),
        ),
      ),
    ),
  );
}