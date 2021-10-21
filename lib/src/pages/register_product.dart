import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/provider.dart';
import 'register_entrepreneurship.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_ecoshops/api/firebase_api.dart';

class Fields extends FormBloc<String, String> {
  final select1 = SelectFieldBloc(
    name: 'category_prod',
    items: ['Aseo', 'Vasos', 'Comida', 'Hogar', 'Otros'],
  );

  final text1 = TextFieldBloc(
    name: 'name_prod',
    validators: [FieldBlocValidators.required],
  );

  final text2 = TextFieldBloc(
    name: "descp",
    validators: [FieldBlocValidators.required],
  );

  final text3 = TextFieldBloc(
    name: 'price',
    validators: [FieldBlocValidators.required],
  );

  late EntrepreneurshipService entServices;
  late String userID;

  Fields(EntrepreneurshipService entrep, String id) {
    entServices = entrep;
    userID = id;

    addFieldBlocs(fieldBlocs: [
      text1,
      text2,
      text3,
      select1,
    ]);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  void onSubmitting() async {
    try {
      var newEntrep = state.toJson();
      newEntrep.remove("raw");
      newEntrep["be_on_kit"] = (newEntrep["be_on_kit"] == "Sí");
      print(newEntrep);

      await entServices.register(newEntrep, userID);

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      print(e.toString());
      emitFailure();
    }
  }
}

class RegisterProductPage extends StatefulWidget {
  @override
  RegisterProduct createState() => RegisterProduct();
}

class RegisterProduct extends State<RegisterProductPage> {
  File? file;
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    final entServices = Provider.of<EntrepreneurshipService>(context);
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return BlocProvider(
      create: (context) => Fields(entServices, authServices.currentUser.id!),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<Fields>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Registrar Producto',
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.lightGreen,
              ),
              body: FormBlocListener<Fields, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  authServices.currentUser.role = 'e';

                  Navigator.pop(context);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("El producto fue agregado correctamente."),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.lightGreen,
                  ));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse!)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: InputDecoration(
                            labelText: 'Nombre Producto',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: InputDecoration(
                            labelText: 'Categoría',
                            prefixIcon: Icon(Icons.category_rounded),
                          ),
                          itemBuilder: (context, item) => item,
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text2,
                          decoration: InputDecoration(
                            labelText: 'Descripción',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text3,
                          decoration: InputDecoration(
                            labelText: 'Precio',
                            prefixIcon: Icon(Icons.attach_money_rounded),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen),
                          onPressed: SelectFile,
                          child: Text('Seleccionar foto'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          fileName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen),
                          onPressed: uploadFile,
                          child: Text('Subir foto'),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen),
                          onPressed: formBloc.submit,
                          child: Text('Registrar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future SelectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'Products/$fileName';

    FirebaseApi.uploadFile(destination, file!);
  }
}


/*
class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => RegisterEntrepreneurship())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
