import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/src/pages/details/components/color_dots.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'register_entrepreneurship.dart';

class UserForm extends FormBloc<String, String> {
  final select1 = SelectFieldBloc(
    items: ['Masculino', 'Femenino', 'Otro'],
  );

  final text1 = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final text2 = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final text3 = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final text4 = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final date1 = InputFieldBloc<DateTime, dynamic>();

  UserForm() {
    addFieldBlocs(fieldBlocs: [
      text1,
      text2,
      text3,
      text4,
      date1,
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
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}

class UpdateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserForm(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<UserForm>(context);

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
                title: Text('Mi perfil', style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.lightGreen,
              ),
              body: FormBlocListener<UserForm, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen()));
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
                            labelText: 'Nombre',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        RadioButtonGroupFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: InputDecoration(
                            labelText: 'Género',
                            prefixIcon: SizedBox(),
                          ),
                          itemBuilder: (context, item) => item,
                        ),
                        TextFieldBlocBuilder(
                          keyboardType: TextInputType.emailAddress,
                          textFieldBloc: formBloc.text2,
                          decoration: InputDecoration(
                            labelText: 'Correo Electrónico',
                            prefixIcon: Icon(Icons.alternate_email_rounded),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text3,
                          decoration: InputDecoration(
                            labelText: 'Dirección',
                            prefixIcon: Icon(Icons.maps_home_work_outlined),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          keyboardType: TextInputType.phone,
                          textFieldBloc: formBloc.text4,
                          decoration: InputDecoration(
                            labelText: 'Celular',
                            prefixIcon: Icon(Icons.phone_android_rounded),
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.date1,
                          format: DateFormat('dd-MM-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Fecha de Nacimiento',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen),
                          onPressed: formBloc.submit,
                          child: Text('Actualizar'),
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
