import 'package:flutter/material.dart';
import 'package:liberty_app/presentation/widget/widgets.dart';
import 'add_project_form.dart';


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
    return SliverAppScaffold(
      backIcon: AssetsSvg.backArrowIos(),
      bodyWidgets: [

        /// add 10px top gap
        const SliverToBoxAdapter(child: SizedBox(height: 10)),

        /// Page Title
        SliverToBoxAdapter(
            child: Text('Create Project',
                style: Theme.of(context).textTheme.headline2)),

        /// New Project form
        const AddProjectForm(),
      ],
    );
  }
}

