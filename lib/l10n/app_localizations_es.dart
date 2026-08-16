// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get showOriginal => 'true';

  @override
  String get appName => 'Calendario Bahá’í';

  @override
  String dayDifference(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'En $count días',
      one: 'Mañana',
      zero: 'Hoy',
    );
    return '$_temp0';
  }

  @override
  String get ayyamiha => 'Días de Há';

  @override
  String begin(Object begin) {
    return 'De $begin';
  }

  @override
  String end(Object end) {
    return 'Hasta $end';
  }

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get hideSunsetInDates => 'Ocultar la hora de la puesta de sol';

  @override
  String get dateFormat => 'Formato de fecha';

  @override
  String dateFormatFromIndex(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count not set',
      two: 'mm/dd/aaa',
      one: 'dd.mm.aaa',
      zero: 'aaa-mm-dd',
    );
    return '$_temp0';
  }

  @override
  String get locationSettingsTitle => 'método de localización';

  @override
  String locationSettingsMethod(num index) {
    String _temp0 = intl.Intl.pluralLogic(
      index,
      locale: localeName,
      other: 'No usar localización',
      one: 'localización manual',
      zero: 'localización automática',
    );
    return '$_temp0';
  }

  @override
  String get longitude => 'Longitud';

  @override
  String get longitudeHelper => 'Cifra decimal. Cifras negativas para Oeste.';

  @override
  String get latitude => 'Latitude';

  @override
  String get latitudeHelper => 'Cifra decimal. Cifraas negativas para el Sur.';

  @override
  String get locationError => 'Cifrs errónea. Por favor, verifique.';

  @override
  String get languageSettingsTitle => 'Idioma';

  @override
  String get feasts => 'Fiestas';

  @override
  String get holyDayTab => 'Días Sagrados';

  @override
  String get upcoming => 'Los próximos Días Sagrados y días especiales';

  @override
  String get fullDate => 'Fecha';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'CANCELAR';

  @override
  String get selectADate => 'Selecciona una fecha';

  @override
  String get specialDay => 'Día Sagrado ó día especial:';

  @override
  String get periodOfFast => 'Período de ayuno';

  @override
  String sunset(Object time) {
    return 'Puesta de sol $time';
  }

  @override
  String sunrise(Object time) {
    return 'Salida de sol $time';
  }

  @override
  String noon(Object time) {
    return 'Mediodía $time';
  }

  @override
  String dayAndMonth(Object month, Object day) {
    return 'El nombre del día es $day del mes $month';
  }

  @override
  String get dayAndMonthTitle => 'Nomnre del mes y del día:';

  @override
  String get feastHint =>
      'Este es el primer dá del mes. Es un día de fiesta de 19 días.';

  @override
  String get dayAndMonthExplanation =>
      'Cada uno de los 19 días de un mes tiene un nombre. Los día del mes tienen los mismos nombres que los meses del año.- El primer día del mes es el día Bahá y el último día del mes es el día ‘Alá’.';

  @override
  String dayOfTheWeek(Object day) {
    return 'El día de la semana es $day.';
  }

  @override
  String get weekDayTitle => 'Día de la semana:';

  @override
  String get vahidTitle => 'Año, Vahid, and Kull-i-Shay:';

  @override
  String get vahidExplanation =>
      'El calendario Badí‘ Calendar define un Váḥid como un período de 19 años. Cada año en el Váḥid tiene un nombre. 19 Váḥids (361 años) forman un Kull-i-Shay’.';

  @override
  String vahid(Object vahid, Object yearInVahid, Object yearName, Object year) {
    return 'El año $year en el calendario badí $yearInVahid en el Váḥid $vahid del primer Kull-i-Shay y se llama $yearName.';
  }

  @override
  String get skip => 'OMITIR';

  @override
  String get next => 'SIGUIENTE';

  @override
  String get fin => 'FINALIZAR';

  @override
  String get selectLanguage =>
      'Selecciona un idioma y el formato de fecha deseado';

  @override
  String get selectLocationMethod => 'Selecciona un método de localización';

  @override
  String get locationDescription =>
      'Esta aplicación puede calcular la hora de la puesta de sol a través de tu posición. Puedes usar la localización automática o configurarla manualmente o no utilizar ninguna localización. Si no usas tu posición, la puesta de sol se colocará a las 6 pm. Puedes cambiar tu configuración a tu gusto.';

  @override
  String get darkModeTitle => 'Modo nocturno<';

  @override
  String get faAvailable => 'el idioma persa está disponible de nuevo:';

  @override
  String get darkModeDescription =>
      'El modo nocturno se activa si está activo en tu configuración del teléfono.';

  @override
  String get hideSunsetTimesTitle => 'Inicio del día';

  @override
  String get hideSunsetTimesDescription =>
      'En el calendario Badí el día comienza con la puesta de sol. Si prefieres mostrar el inicio del día a a la medianoche, escoge la siguiente opción.';
}
