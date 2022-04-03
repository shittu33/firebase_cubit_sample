import 'package:flutter/material.dart';
import 'package:liberty_app/presentation/widget/widgets.dart';

import '../../../../app/theme.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  static route() =>
      MaterialPageRoute<void>(builder: (_) => const AddProjectScreen());

  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  @override
  Widget build(BuildContext context) {
    var inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    return SliverAppScaffold(
      backIcon: AssetsSvg.backArrowIos(),
      bodyWidgets: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 10),
        ),

        /// Page Title
        SliverToBoxAdapter(
          child: Text('Create Project',
              style: Theme.of(context).textTheme.headline2),
        ),

        /// Project form
        Form(
          child: SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CircleAvatar(backgroundColor: AppColors.lightGray),
                    SizedBox(width: 15),
                    Expanded(
                        child: UnderLinedTextFormField(
                      label: Text('Project Name'),
                    )),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: DateFormPicker(
                      label: 'Created (from)',
                      selectedDateHandler: (DateTime? dateTime) {},
                    )),
                    const SizedBox(width: 15),
                    Expanded(
                        child: DateFormPicker(
                      label: 'End (to)',
                      selectedDateHandler: (DateTime? dateTime) {},
                    )),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Assign to:',
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: AppColors.lightGray, fontSize: 13),
                ),
                const SizedBox(height: 10),
                const UnderLinedTextFormField(
                  label: Text('Add team members'),
                  suffix: CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                ),
                const SizedBox(height: 20),
                const UnderLinedTextFormField(
                  label: Text('Tags'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Description:',
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: AppColors.lightGray, fontSize: 13),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 2,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: (inputDecorationTheme.border as OutlineInputBorder)
                        .copyWith(borderRadius: BorderRadius.circular(4)),
                    focusedBorder: (inputDecorationTheme.focusedBorder
                            as OutlineInputBorder)
                        .copyWith(borderRadius: BorderRadius.circular(4)),
                    enabledBorder: (inputDecorationTheme.enabledBorder
                            as OutlineInputBorder)
                        .copyWith(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(height: 20),
                // for(int i=0; i<17;i++)
                ActionButton(text: 'Create Project', onPressed: () {}),
                const SizedBox(height: 120)
              ],
            ),
          ),
        ),
        // ),
      ],
    );
  }
}
