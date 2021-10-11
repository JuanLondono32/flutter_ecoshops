import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'register_entrepreneurship.dart';

class DonationForm extends FormBloc<String, String> {
  final text1 = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final text2 = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final text3 = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  DonationForm() {
    addFieldBlocs(fieldBlocs: [
      text1,
      text2,
      text3,
    ]);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}

class DonateMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DonationForm(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<DonationForm>(context);

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
                title: Text('Realizar Donación',
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.lightGreen,
              ),
              body: FormBlocListener<DonationForm, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Los datos de usuario fueron actualizados correctamente."),
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
                            labelText: 'Dirección para recoger',
                            prefixIcon: Icon(Icons.maps_home_work_outlined),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          maxLines: 5,
                          textFieldBloc: formBloc.text2,
                          decoration: InputDecoration(
                            labelText: 'Descripción de la donación',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          keyboardType: TextInputType.emailAddress,
                          textFieldBloc: formBloc.text3,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            prefixIcon: Icon(Icons.alternate_email_rounded),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen),
                          onPressed: formBloc.submit,
                          child: Text('Hacer donación'),
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
}
