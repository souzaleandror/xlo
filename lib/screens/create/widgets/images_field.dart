import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo/screens/create/widgets/image_source_sheet.dart';

class ImagesField extends StatelessWidget {
  ImagesField({this.onSaved, this.initialValue});

  final FormFieldSetter<List> onSaved;
  final List initialValue;

  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      initialValue: [],
      onSaved: onSaved,
      validator: (images) {
        if (images.isEmpty) {
          return "Campo Obrigatorio";
        } else {
          return null;
        }
      },
      builder: (state) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.value.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.value.length) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ImageSourceSheet(
                            (image) {
                              if (image != null) {
                                state.didChange(state.value..add(image));
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, bottom: 16),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.camera,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                "+ Inserir",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.file(state.value[index]),
                                    FlatButton(
                                      child: const Text("Excluir"),
                                      textColor: Colors.red,
                                      onPressed: () {
                                        state.didChange(
                                            state.value..removeAt(index));
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(state.value[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state.hasError)
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    state.errorText,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
