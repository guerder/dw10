import 'package:flutter/material.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: SizedBox(
          width: context.percentWidth(.5),
          height: context.percentHeight(.9),
          // color: context.colors.secondary,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Login')),
                    validator: (value) => 'Erro',
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Botão'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showLoader();
          await Future.delayed(const Duration(seconds: 2));
          hideLoader();
          showError('Erro de alguma coisa');
        },
        child: const Text('Clique'),
      ),
    );
  }
}
