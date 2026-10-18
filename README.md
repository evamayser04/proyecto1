# proyecto1

## Configuración de Firebase

La app usa Firebase Authentication y Cloud Firestore. Estos archivos contienen la configuración del proyecto y deben estar en el repositorio:

- `lib/firebase_options.dart`: configuración que usa Flutter para conectarse a Firebase.
- `firebase.json`: configuración del proyecto para las herramientas de Firebase.
- `android/app/google-services.json`: configuración de la app Android.

No se deben subir claves privadas de cuentas de servicio, contraseñas ni tokens. No son necesarios para ejecutar la app Flutter.

Para volver a configurar Firebase se utiliza FlutterFire CLI con `flutterfire configure`.
