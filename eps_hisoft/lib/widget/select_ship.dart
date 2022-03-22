import 'package:eps_hisoft/models/project.dart';
import 'package:eps_hisoft/models/select_ship.dart';
import 'package:eps_hisoft/models/ship.dart';
import 'package:eps_hisoft/provider/project.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectShip extends StatefulWidget {
  SelectShipController? controller;
  SelectShip({Key? key, this.controller}) : super(key: key);

  @override
  State<SelectShip> createState() => _SelectShipState();
}

class _SelectShipState extends State<SelectShip> {
  int _selectedItem = -1;

  void onSelectItem() {}

  void showSelect() {
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
              itemCount: Ship.values.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:
                      Text('${Ship.values[index].toString().split(".").last}'),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedItem = index;
                    });
                    widget.controller?.setValue(Ship.values[index]);
                  },
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final projectModel = Provider.of<ProjectProvider>(context, listen: true);

    return InkWell(
      onTap: showSelect,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ca'),
          SizedBox(
            height: 10,
          ),
          Consumer<SelectShipController>(builder: (ctx, selectShip, child) {
            if (!selectShip.hasError) {
              return Container(
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )
                          : Text(Ship.values[_selectedItem]
                              .toString()
                              .split(".")
                              .last),
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
                              : Text(Ship.values[_selectedItem]
                                  .toString()
                                  .split(".")
                                  .last),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ca không được để trống',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  )
                ],
              );
            }
          })
        ],
      ),
    );
  }
}
