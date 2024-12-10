import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/ebraheem_form_field.dart';
import '../widgets/ebraheem_button.dart';

class EbraheemFormScreen extends StatefulWidget {
  const EbraheemFormScreen({Key? key}) : super(key: key);

  @override
  State<EbraheemFormScreen> createState() => _EbraheemFormScreenState();
}

class _EbraheemFormScreenState extends State<EbraheemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _numberOnlyController = TextEditingController();
  final TextEditingController _textOnlyController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _numberController.dispose();
    _textController.dispose();
    _numberOnlyController.dispose();
    _textOnlyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'نموذج إبراهيم',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          EbraheemFormField(
                            controller: _emailController,
                            labelText: 'البريد الإلكتروني',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال البريد الإلكتروني';
                              }
                              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'الرجاء إدخال بريد إلكتروني صحيح';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          EbraheemFormField(
                            controller: _numberController,
                            labelText: 'الرقم',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال رقم';
                              }
                              if (double.tryParse(value) == null) {
                                return 'الرجاء إدخال رقم صحيح';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          EbraheemFormField(
                            controller: _textOnlyController,
                            labelText: 'نص فقط',
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال نص';
                              }
                              if (RegExp(r'[^a-zA-Z\s]').hasMatch(value)) {
                                return 'الرجاء إدخال حروف فقط';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          EbraheemFormField(
                            controller: _numberOnlyController,
                            labelText: 'أرقام فقط',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال أرقام';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          EbraheemFormField(
                            controller: _textController,
                            labelText: 'نص عام',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  EbraheemButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم إرسال النموذج بنجاح!'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    text: 'إرسال',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
