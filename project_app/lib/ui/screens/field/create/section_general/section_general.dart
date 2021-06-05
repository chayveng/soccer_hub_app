import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/core/models/FieldLocation.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/field/create/dialog_loading/dialog_loading.dart';
import 'package:project_app/ui/screens/field/create/section_images/title_bar.dart';
import 'package:project_app/ui/screens/field/create/section_location/section_location.dart';
import 'package:project_app/ui/screens/googleMap/google_map_screen.dart';

import 'custom_field.dart';

class SectionGeneral extends StatefulWidget {
  final Field field;
  final FieldLocation fieldLocation;
  final bool isCreate;
  final GlobalKey<FormState> formKey;
  final GestureTapCallback onSubmit;

  const SectionGeneral({
    Key key,
    @required this.field,
    @required this.onSubmit,
    @required this.isCreate,
    @required this.formKey,
    @required this.fieldLocation,
  }) : super(key: key);

  @override
  _SectionGeneralState createState() => _SectionGeneralState();
}

class _SectionGeneralState extends State<SectionGeneral> {
  Map<String, dynamic> focusNode;
  Map<String, dynamic> textCtl;
  List<String> keys = ['title', 'detail', 'open', 'price', 'tel'];

  @override
  void initState() {
    super.initState();
  }

  void setTool() {
    focusNode = SetTools.setFocusNode();
    textCtl = SetTools.setTextCtl(field: widget.field);
  }

  Future<void> _onSubmit() async {
    print('delay');
    var onSubmit = widget.onSubmit;
    print('delayed');
    await Future.delayed(Duration(milliseconds: 500));
    // Navigator.pop(context);
  }

  Widget buildButton() {
    return RoundedButton(
      text: widget.isCreate ? 'Create' : 'Update',
      onTap: widget.onSubmit,
      // onTap: () async {
      //   await showDialog(
      //         context: context,
      //         builder: (context) => DialogLoading(
      //           onSubmit: _onSubmit(),
      //         ),
      //       ) ??
      //       Navigator.pop(context);
      // },
    );
  }

  Widget telField(BuildContext context) {
    int index = 4;
    return CustomField(
      labelText: 'Tel',
      hintText: 'tel',
      onSaved: (input) => widget.field.tel = input,
      onChanged: (input) => widget.field.tel = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: TextEditingController(text: widget.field.tel),
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget priceField(BuildContext context) {
    int index = 3;
    return CustomField(
      labelText: 'Price',
      hintText: 'price',
      onSaved: (input) => widget.field.price = input,
      onChanged: (input) => widget.field.price = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.datetime,
      controller: TextEditingController(text: widget.field.price),
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget openField(BuildContext context) {
    int index = 2;
    return CustomField(
      labelText: 'Open Time',
      hintText: 'open-time',
      onSaved: (input) => widget.field.hours = input,
      onChanged: (input) => widget.field.hours = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      keyboardType: TextInputType.datetime,
      controller: TextEditingController(text: widget.field.hours),
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget detailField(BuildContext context) {
    int index = 1;
    return CustomField(
      labelText: 'Detail',
      hintText: 'detail',
      maxLine: 5,
      onSaved: (input) => widget.field.detail = input,
      onChanged: (input) => widget.field.detail = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: TextEditingController(text: widget.field.detail),
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  Widget titleField(BuildContext context) {
    int index = 0;
    return CustomField(
      labelText: 'Title',
      hintText: 'title',
      onSaved: (input) => widget.field.title = input,
      onChanged: (input) => widget.field.title = input,
      validator: (input) => input.isEmpty ? 'is Empty' : null,
      controller: TextEditingController(text: widget.field.title),
      focusNode: focusNode[keys[index]],
      onFieldSubmitted: (value) {
        focusNode[keys[index]].unfocus();
        FocusScope.of(context).requestFocus(focusNode[keys[index++]]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setTool();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: creamPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle_notifications),
                      SizedBox(width: 10),
                      Text(
                        'General',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  titleField(context),
                  SizedBox(height: 8),
                  detailField(context),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: openField(context)),
                      SizedBox(width: 20),
                      Expanded(child: priceField(context)),
                    ],
                  ),
                  SizedBox(height: 8),
                  telField(context),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(height: 10),
            buildMap(),
            buildButton(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Container buildMap() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: creamPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.add_location_alt),
              SizedBox(width: 10),
              Text(
                'Location',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SectionLocation(
                fieldLocation: widget.fieldLocation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SetTools {
  static Map<String, dynamic> setTextCtl({@required Field field}) {
    return {
      'title': TextEditingController(text: field.title ?? ''),
      'detail': TextEditingController(text: field.detail ?? ''),
      'address': TextEditingController(text: field.detail ?? ''),
      'tel': TextEditingController(text: field.detail ?? ''),
      'hours': TextEditingController(text: field.hours ?? ''),
      'price': TextEditingController(text: field.price ?? ''),
    };
  }

  static Map<String, dynamic> setFocusNode() {
    return {
      'title': FocusNode(),
      'detail': FocusNode(),
      'address': FocusNode(),
      'tel': FocusNode(),
      'hours': FocusNode(),
      'price': FocusNode(),
    };
  }
}
