import 'dart:io';
import 'package:client/core/system/presentation/controller/language_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/data/models/client_model.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/routes/app_router.dart';
import 'injection_container.dart' as ic;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ic.init();
  await _initHive();
  runApp(
    BlocProvider(
      create: (context) => ic.sl<LanguageCubit>(),
      child: const YarbitClient(),
    ),
  );
}

class YarbitClient extends StatefulWidget {
  const YarbitClient({super.key});

  @override
  State<YarbitClient> createState() => YarbitClientState();

  static YarbitClientState? of(BuildContext context) =>
      context.findAncestorStateOfType<YarbitClientState>();
}

class YarbitClientState extends State<YarbitClient> {
  final _appRouter = AppRouter();
  late Locale _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  void initState() {
    _locale = Locale(Platform.localeName.substring(0, 2));
    context.read<LanguageCubit>().getLanguage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
      listener: (context, state) {
        if (state is GetLanguageSuccess) {
          setLocale(Locale(state.languageCode));
        }
      },
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) =>
            MaterialApp.router(
          routerConfig: _appRouter.config(),
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
        ),
      ),
    );
  }
}

Future<void> _initHive() async {
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);

  Hive.registerAdapter(ClientModelAdapter());
}
