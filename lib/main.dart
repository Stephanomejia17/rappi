import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/app_database.dart';
import 'firebase_options.dart';
import 'pages/pedidos_page.dart';
import 'services/app_logger.dart';
import 'services/pedido_remote_service.dart';
import 'services/pedido_repository.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      var firebaseReady = false;

      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        firebaseReady = true;
        AppLogger.info('Firebase inicializado correctamente.');
      } catch (error, stackTrace) {
        AppLogger.warning(
          'Firebase no quedó configurado todavía. La app funcionará en modo local.',
        );
        AppLogger.error(
          'Error inicializando Firebase',
          error: error,
          stackTrace: stackTrace,
        );
      }

      final repository = PedidoRepository(
        localDb: AppDatabase(),
        remoteService: PedidoRemoteService(firebaseEnabled: firebaseReady),
      );

      runApp(RappiPedidosApp(repository: repository));
    },
    (error, stackTrace) {
      AppLogger.error(
        'Error global no controlado',
        error: error,
        stackTrace: stackTrace,
      );
    },
  );
}

class RappiPedidosApp extends StatelessWidget {
  final PedidoRepository repository;

  const RappiPedidosApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rappi',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      home: PedidosPage(repository: repository),
    );
  }
}
