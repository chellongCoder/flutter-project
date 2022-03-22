import 'package:eps_hisoft/models/project.dart';
import 'package:eps_hisoft/models/select_date.dart';
import 'package:eps_hisoft/models/select_project.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectProject extends StatefulWidget {
  final SelectProjectController? controller;

  const SelectProject({Key? key, this.controller}) : super(key: key);

  @override
  State<SelectProject> createState() => _SelectProjectState();
}

class _SelectProjectState extends State<SelectProject> {
  int _selectedItem = -1;

  void onSelectItem() {}

  void showSelect(List<Project> projects) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (context) {
          return Container(
            height: 400,
            color: Colors.white,
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${projects[index].name}'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedItem = index;
                      widget.controller?.setValue(projects[index]);
                    });
                  },
                );
              },
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final projectModel = Provider.of<ProjectProvider>(context, listen: true);

    return InkWell(
      onTap: () => showSelect(projectModel.projects),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dự án'),
          SizedBox(
            height: 10,
          ),
          Consumer<SelectProjectController>(
            builder: (context, selectProject, child) {
              if (!selectProject.hasError) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: _selectedItem == -1
                            ? Text(
                                'Chọn dự án',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              )
                            : Text(projectModel.projects
                                .elementAt(_selectedItem)
                                .name
                                .toString()),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: _selectedItem == -1
                                ? Text(
                                    'Select',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  )
                                : Text(projectModel.projects
                                    .elementAt(_selectedItem)
                                    .name
                                    .toString()),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.error),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dự án không được để trống',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
