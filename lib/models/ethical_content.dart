/// Modelos fuertemente tipados para los datos de Proyección Ética
class HeaderContent {
  final String kicker;
  final String title;
  final String subtitle;

  const HeaderContent({
    required this.kicker,
    required this.title,
    required this.subtitle,
  });

  factory HeaderContent.fromJson(Map<String, dynamic> json) {
    return HeaderContent(
      kicker: json['kicker'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
    );
  }
}

class StationItem {
  final String id;
  final String num;
  final String title;
  final String desc;
  final String route;

  const StationItem({
    required this.id,
    required this.num,
    required this.title,
    required this.desc,
    required this.route,
  });

  factory StationItem.fromJson(Map<String, dynamic> json) {
    return StationItem(
      id: json['id'] as String? ?? '',
      num: json['num'] as String? ?? '',
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      route: json['route'] as String? ?? '',
    );
  }
}

class HomeContent {
  final String title;
  final String description;
  final List<StationItem> stations;

  const HomeContent({
    required this.title,
    required this.description,
    required this.stations,
  });

  factory HomeContent.fromJson(Map<String, dynamic> json) {
    final list = (json['stations'] as List<dynamic>? ?? [])
        .map((e) => StationItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return HomeContent(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      stations: list,
    );
  }
}

class Station1Option {
  final String id;
  final String tag;
  final String title;
  final String subtitle;
  final String emoji;
  final String virtue;
  final String resultTitle;
  final String feedback;
  final String closing;

  const Station1Option({
    required this.id,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.virtue,
    required this.resultTitle,
    required this.feedback,
    required this.closing,
  });

  factory Station1Option.fromJson(Map<String, dynamic> json) {
    return Station1Option(
      id: json['id'] as String? ?? '',
      tag: json['tag'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
      virtue: json['virtue'] as String? ?? '',
      resultTitle: json['resultTitle'] as String? ?? '',
      feedback: json['feedback'] as String? ?? '',
      closing: json['closing'] as String? ?? '',
    );
  }
}

class Station1Content {
  final String kicker;
  final String title;
  final String description;
  final String keyIdea;
  final String careerPrompt;
  final String careerPlaceholder;
  final String question;
  final List<Station1Option> options;

  const Station1Content({
    required this.kicker,
    required this.title,
    required this.description,
    required this.keyIdea,
    required this.careerPrompt,
    required this.careerPlaceholder,
    required this.question,
    required this.options,
  });

  factory Station1Content.fromJson(Map<String, dynamic> json) {
    final opts = (json['options'] as List<dynamic>? ?? [])
        .map((e) => Station1Option.fromJson(e as Map<String, dynamic>))
        .toList();
    return Station1Content(
      kicker: json['kicker'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      keyIdea: json['keyIdea'] as String? ?? '',
      careerPrompt: json['careerPrompt'] as String? ?? '',
      careerPlaceholder: json['careerPlaceholder'] as String? ?? '',
      question: json['question'] as String? ?? '',
      options: opts,
    );
  }
}

class Scenario {
  final String text;
  final String answer; // "medio" or "fin"
  final String explain;

  const Scenario({
    required this.text,
    required this.answer,
    required this.explain,
  });

  factory Scenario.fromJson(Map<String, dynamic> json) {
    return Scenario(
      text: json['text'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
      explain: json['explain'] as String? ?? '',
    );
  }
}

class AreaOption {
  final String id;
  final String label;
  final List<Scenario> scenarios;

  const AreaOption({
    required this.id,
    required this.label,
    required this.scenarios,
  });

  factory AreaOption.fromJson(Map<String, dynamic> json) {
    final sc = (json['scenarios'] as List<dynamic>? ?? [])
        .map((e) => Scenario.fromJson(e as Map<String, dynamic>))
        .toList();
    return AreaOption(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      scenarios: sc,
    );
  }
}

class ChoiceOption {
  final String id;
  final String label;
  final String desc;

  const ChoiceOption({
    required this.id,
    required this.label,
    required this.desc,
  });

  factory ChoiceOption.fromJson(Map<String, dynamic> json) {
    return ChoiceOption(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
    );
  }
}

class CertificateContent {
  final String title;
  final String text;
  final String footer;

  const CertificateContent({
    required this.title,
    required this.text,
    required this.footer,
  });

  factory CertificateContent.fromJson(Map<String, dynamic> json) {
    return CertificateContent(
      title: json['title'] as String? ?? '',
      text: json['text'] as String? ?? '',
      footer: json['footer'] as String? ?? '',
    );
  }
}

class Station2Content {
  final String kicker;
  final String title;
  final String description;
  final String keyIdea;
  final String areaPrompt;
  final String areaSubtitle;
  final String namePrompt;
  final String namePlaceholder;
  final String question;
  final List<ChoiceOption> choices;
  final List<AreaOption> areas;
  final String closing;
  final CertificateContent certificate;

  const Station2Content({
    required this.kicker,
    required this.title,
    required this.description,
    required this.keyIdea,
    required this.areaPrompt,
    required this.areaSubtitle,
    required this.namePrompt,
    required this.namePlaceholder,
    required this.question,
    required this.choices,
    required this.areas,
    required this.closing,
    required this.certificate,
  });

  factory Station2Content.fromJson(Map<String, dynamic> json) {
    final chList = (json['choices'] as List<dynamic>? ?? [])
        .map((e) => ChoiceOption.fromJson(e as Map<String, dynamic>))
        .toList();
    final arList = (json['areas'] as List<dynamic>? ?? [])
        .map((e) => AreaOption.fromJson(e as Map<String, dynamic>))
        .toList();
    return Station2Content(
      kicker: json['kicker'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      keyIdea: json['keyIdea'] as String? ?? '',
      areaPrompt: json['areaPrompt'] as String? ?? '',
      areaSubtitle: json['areaSubtitle'] as String? ?? '',
      namePrompt: json['namePrompt'] as String? ?? '',
      namePlaceholder: json['namePlaceholder'] as String? ?? '',
      question: json['question'] as String? ?? '',
      choices: chList,
      areas: arList,
      closing: json['closing'] as String? ?? '',
      certificate: CertificateContent.fromJson(
        json['certificate'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class StepGuide {
  final int number;
  final String title;
  final String description;

  const StepGuide({
    required this.number,
    required this.title,
    required this.description,
  });

  factory StepGuide.fromJson(Map<String, dynamic> json) {
    return StepGuide(
      number: json['number'] as int? ?? 1,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}

class Station3Content {
  final String kicker;
  final String title;
  final String description;
  final String questionsHeading;
  final List<String> reflectiveQuestions;
  final List<String> dilemmas;
  final String resultHeading;
  final String resultSubtitle;
  final List<StepGuide> steps;

  const Station3Content({
    required this.kicker,
    required this.title,
    required this.description,
    required this.questionsHeading,
    required this.reflectiveQuestions,
    required this.dilemmas,
    required this.resultHeading,
    required this.resultSubtitle,
    required this.steps,
  });

  factory Station3Content.fromJson(Map<String, dynamic> json) {
    final rq = (json['reflectiveQuestions'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    final dil = (json['dilemmas'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    final st = (json['steps'] as List<dynamic>? ?? [])
        .map((e) => StepGuide.fromJson(e as Map<String, dynamic>))
        .toList();
    return Station3Content(
      kicker: json['kicker'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      questionsHeading: json['questionsHeading'] as String? ?? '',
      reflectiveQuestions: rq,
      dilemmas: dil,
      resultHeading: json['resultHeading'] as String? ?? '',
      resultSubtitle: json['resultSubtitle'] as String? ?? '',
      steps: st,
    );
  }
}

class EthicalContent {
  final HeaderContent header;
  final HomeContent home;
  final Station1Content station1;
  final Station2Content station2;
  final Station3Content station3;

  const EthicalContent({
    required this.header,
    required this.home,
    required this.station1,
    required this.station2,
    required this.station3,
  });

  factory EthicalContent.fromJson(Map<String, dynamic> json) {
    return EthicalContent(
      header: HeaderContent.fromJson(
        json['header'] as Map<String, dynamic>? ?? {},
      ),
      home: HomeContent.fromJson(json['home'] as Map<String, dynamic>? ?? {}),
      station1: Station1Content.fromJson(
        json['station1'] as Map<String, dynamic>? ?? {},
      ),
      station2: Station2Content.fromJson(
        json['station2'] as Map<String, dynamic>? ?? {},
      ),
      station3: Station3Content.fromJson(
        json['station3'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
