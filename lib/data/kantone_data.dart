// lib/data/kantone_data.dart

class KantonRegel {
  final String name;
  final String kuerzel;
  final String zusammenfassung;
  final String details;
  final String wappenPfad;

  KantonRegel({
    required this.name,
    required this.kuerzel,
    required this.zusammenfassung,
    required this.details,
    required this.wappenPfad,
  });
}

// Die zentrale Liste für die ganze Schweiz
final List<KantonRegel> schweizerKantone = [
  KantonRegel(
    name: 'Aargau',
    kuerzel: 'AG',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ag.png',
  ),
  KantonRegel(
    name: 'Appenzell Ausserrhoden',
    kuerzel: 'AR',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ar.png',
  ),
  KantonRegel(
    name: 'Appenzell Innerrhoden',
    kuerzel: 'AI',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ai.png',
  ),
  KantonRegel(
    name: 'Basel-Landschaft',
    kuerzel: 'BL',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/bl.png',
  ),
  KantonRegel(
    name: 'Basel-Stadt',
    kuerzel: 'BS',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/bs.png',
  ),
  KantonRegel(
    name: 'Bern',
    kuerzel: 'BE',
    zusammenfassung: 'Zelten oft geduldet.',
    details:
        'Wildes Kampieren im Wald ist nicht explizit verboten, wird für 1-2 Nächte abseits von Schutzzonen meist geduldet.',
    wappenPfad: 'assets/images/wappen/be.png',
  ),
  KantonRegel(
    name: 'Freiburg',
    kuerzel: 'FR',
    zusammenfassung: 'Feuern erlaubt (ausser bei Gefahr).',
    details:
        'Zelten im Wald grundsätzlich erlaubt, sofern keine Schäden entstehen (Art. 15 KWaG).',
    wappenPfad: 'assets/images/wappen/fr.png',
  ),
  KantonRegel(
    name: 'Genf',
    kuerzel: 'GE',
    zusammenfassung: 'Strikte Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ge.png',
  ),
  KantonRegel(
    name: 'Glarus',
    kuerzel: 'GL',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/gl.png',
  ),
  KantonRegel(
    name: 'Graubünden',
    kuerzel: 'GR',
    zusammenfassung: 'Gemeinderegeln beachten.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/gr.png',
  ),
  KantonRegel(
    name: 'Jura',
    kuerzel: 'JU',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ju.png',
  ),
  KantonRegel(
    name: 'Luzern',
    kuerzel: 'LU',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/lu.png',
  ),
  KantonRegel(
    name: 'Neuenburg',
    kuerzel: 'NE',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ne.png',
  ),
  KantonRegel(
    name: 'Nidwalden',
    kuerzel: 'NW',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/nw.png',
  ),
  KantonRegel(
    name: 'Obwalden',
    kuerzel: 'OW',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ow.png',
  ),
  KantonRegel(
    name: 'Schaffhausen',
    kuerzel: 'SH',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/sh.png',
  ),
  KantonRegel(
    name: 'Schwyz',
    kuerzel: 'SZ',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/sz.png',
  ),
  KantonRegel(
    name: 'Solothurn',
    kuerzel: 'SO',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/so.png',
  ),
  KantonRegel(
    name: 'St. Gallen',
    kuerzel: 'SG',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/sg.png',
  ),
  KantonRegel(
    name: 'Tessin',
    kuerzel: 'TI',
    zusammenfassung: 'Sehr strikte Regeln.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ti.png',
  ),
  KantonRegel(
    name: 'Thurgau',
    kuerzel: 'TG',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/tg.png',
  ),
  KantonRegel(
    name: 'Uri',
    kuerzel: 'UR',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/ur.png',
  ),
  KantonRegel(
    name: 'Waadt',
    kuerzel: 'VD',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/vd.png',
  ),
  KantonRegel(
    name: 'Wallis',
    kuerzel: 'VS',
    zusammenfassung: 'Feuerverbote beachten.',
    details:
        'Wegen Trockenheit oft strikte Feuerverbote. Zelten stark eingeschränkt.',
    wappenPfad: 'assets/images/wappen/vs.png',
  ),
  KantonRegel(
    name: 'Zug',
    kuerzel: 'ZG',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/zg.png',
  ),
  KantonRegel(
    name: 'Zürich',
    kuerzel: 'ZH',
    zusammenfassung: 'Bitte lokale Regeln prüfen.',
    details: 'Details folgen...',
    wappenPfad: 'assets/images/wappen/zh.png',
  ),
];
