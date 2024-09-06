import 'package:app_material_3/provider/provider_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteLogin extends StatelessWidget {
  const RouteLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                      fontSize: 30),
                  "Login"),
              const SizedBox(
                height: 50,
              ),
              const ButtonLoginAsAdmin(),
              const SizedBox(
                height: 15,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepOrange,
                    side: const BorderSide(color: Colors.deepOrange),
                  ),
                  onPressed: () => {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.person), Text("Normal user")],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonLoginAsAdmin extends StatelessWidget {
  const ButtonLoginAsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderLogin(),
      child: FilledButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.deepOrange)),
          onPressed: () => login(context),
          child: Provider.of<ProviderLogin>(context).isLogging
              ? const BodyAdminButtonWhenLogging()
              : const BodyAdminButton()),
    );
  }

  void login(BuildContext context) =>
      Provider.of<ProviderLogin>(context, listen: false).loginAsAdmin();
}

class BodyAdminButton extends StatelessWidget {
  const BodyAdminButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.admin_panel_settings),
        SizedBox(
          width: 8,
        ),
        Text("Admin")
      ],
    );
  }
}

class BodyAdminButtonWhenLogging extends StatelessWidget {
  const BodyAdminButtonWhenLogging({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Transform.scale(
          scale: .5,
          child: const CircularProgressIndicator(
            color: Colors.white,
          )),
      const Padding(
        padding: EdgeInsets.only(left: 5),
        child: Text("Logging as Admin"),
      )
    ]);
  }
}
