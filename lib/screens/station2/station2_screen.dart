import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../../models/ethical_content.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_container.dart';
import '../../widgets/certificate_widget.dart';
import '../../widgets/comic_button.dart';
import '../../widgets/key_idea_box.dart';
import '../../widgets/kicker_tag.dart';
import '../station3/station3_screen.dart';

enum Station2Step { intro, areaSelection, scenario, result }

class Station2Screen extends StatefulWidget {
  final EthicalContent content;

  const Station2Screen({super.key, required this.content});

  @override
  State<Station2Screen> createState() => _Station2ScreenState();
}

class _Station2ScreenState extends State<Station2Screen> {
  Station2Step _currentStep = Station2Step.intro;
  AreaOption? _selectedArea;
  Scenario? _currentScenario;
  bool _isAnswerCorrect = false;

  final TextEditingController _careerController = TextEditingController();
  final TextEditingController _signNameController = TextEditingController();
  bool _showCertificate = false;
  String _signedName = '';
  String _dateString = '';

  @override
  void dispose() {
    _careerController.dispose();
    _signNameController.dispose();
    super.dispose();
  }

  void _onAreaPicked(AreaOption area) {
    setState(() {
      _selectedArea = area;
      // Seleccionar un escenario aleatorio dentro del área
      final random = Random();
      _currentScenario = area.scenarios[random.nextInt(area.scenarios.length)];
      _currentStep = Station2Step.scenario;
    });
  }

  void _onChoiceSelected(String choice) {
    if (_currentScenario == null) return;

    final isCorrect = choice == _currentScenario!.answer;
    setState(() {
      _isAnswerCorrect = isCorrect;
      _showCertificate = false;
      _currentStep = Station2Step.result;
    });
  }

  void _signCommitment() {
    final name = _signNameController.text.trim();
    if (name.isEmpty) return;

    final now = DateTime.now();
    const months = [
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    final dateFormatted = '${now.day} de ${months[now.month - 1]} de ${now.year} · Comparte una captura.';

    setState(() {
      _signedName = name;
      _dateString = dateFormatted;
      _showCertificate = true;
    });
  }

  void _pickAnotherScenario() {
    if (_selectedArea != null) {
      _onAreaPicked(_selectedArea!);
    } else {
      setState(() {
        _currentStep = Station2Step.areaSelection;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s2 = widget.content.station2;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.bgYellow,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          s2.title,
          style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.ink),
        ),
        backgroundColor: AppColors.white,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.back, color: AppColors.ink, size: 22),
              Text('Menú', style: TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700)),
            ],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: AppContainer(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildCurrentStep(s2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep(Station2Content s2) {
    switch (_currentStep) {
      case Station2Step.intro:
        return _buildIntroView(s2);
      case Station2Step.areaSelection:
        return _buildAreaSelectionView(s2);
      case Station2Step.scenario:
        return _buildScenarioView(s2);
      case Station2Step.result:
        return _buildResultView(s2);
    }
  }

  // Vista 1: Intro
  Widget _buildIntroView(Station2Content s2) {
    return Column(
      key: const ValueKey('s2-intro'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KickerTag(
          text: s2.kicker,
          backgroundColor: AppColors.purple.withValues(alpha: 0.3),
          textColor: AppColors.ink,
        ),
        const SizedBox(height: 14),
        Text(
          s2.title,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          s2.description,
          style: const TextStyle(
            color: AppColors.grayMuted,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 20),
        KeyIdeaBox(text: s2.keyIdea),
        const SizedBox(height: 32),
        ComicButton(
          text: 'Comenzar',
          type: ComicButtonType.primary,
          onPressed: () {
            setState(() {
              _currentStep = Station2Step.areaSelection;
            });
          },
        ),
        const SizedBox(height: 12),
        ComicButton(
          text: 'Volver al menú',
          type: ComicButtonType.ghost,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  // Vista 2: Selección de Área
  Widget _buildAreaSelectionView(Station2Content s2) {
    return Column(
      key: const ValueKey('s2-areas'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s2.areaPrompt,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          s2.areaSubtitle,
          style: const TextStyle(
            color: AppColors.grayMuted,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: s2.areas.map((area) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _onAreaPicked(area),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.ink, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.ink,
                      offset: Offset(2, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  area.label,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 28),
        ComicButton(
          text: 'Volver al menú',
          type: ComicButtonType.ghost,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  // Vista 3: Escenario
  Widget _buildScenarioView(Station2Content s2) {
    final area = _selectedArea!;
    final scenario = _currentScenario!;

    return Column(
      key: const ValueKey('s2-scenario'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s2.namePrompt,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: _careerController,
          placeholder: s2.namePlaceholder,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.ink, width: 2),
          ),
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),

        // Tarjeta de Escenario
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.ink, width: 3),
            boxShadow: const [
              BoxShadow(
                color: AppColors.ink,
                offset: Offset(4, 5),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.ink, width: 1.5),
                ),
                child: Text(
                  area.label.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                scenario.text,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Text(
          s2.question,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 16),

        ...s2.choices.map((choice) {
          final isMedio = choice.id == 'medio';
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _onChoiceSelected(choice.id),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.ink, width: 2.5),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.ink,
                      offset: Offset(3, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      choice.label,
                      style: TextStyle(
                        color: isMedio ? AppColors.danger : AppColors.success,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      choice.desc,
                      style: const TextStyle(
                        color: AppColors.grayMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ComicButton(
                text: 'Cambiar área',
                type: ComicButtonType.ghost,
                onPressed: () {
                  setState(() {
                    _currentStep = Station2Step.areaSelection;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ComicButton(
                text: 'Menú',
                type: ComicButtonType.ghost,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Vista 4: Resultado y Compromiso
  Widget _buildResultView(Station2Content s2) {
    final scenario = _currentScenario!;
    final isMedio = scenario.answer == 'medio';
    final resultTitle = isMedio
        ? 'La tratas como medio, no como fin'
        : 'La tratas como fin, no como medio';

    final feedbackText = scenario.explain +
        (isMedio
            ? ' Kant diría que esta acción trata a la persona como instrumento: se violenta su dignidad para conseguir un resultado ajeno.'
            : ' Kant diría que esta acción reconoce la dignidad: la persona es valiosa en sí misma, no por lo que produce.');

    return Column(
      key: const ValueKey('s2-result'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Badge de acierto o advertencia
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isAnswerCorrect ? AppColors.success : AppColors.danger,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.ink, width: 2),
            boxShadow: const [
              BoxShadow(
                color: AppColors.ink,
                offset: Offset(2, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Text(
            _isAnswerCorrect
                ? '¡ACERTASTE! ESCÁNER AFINADO'
                : 'OJO: LA TRAMPA DEL UTILITARISMO',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),

        Text(
          resultTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          feedbackText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),

        // Cierre breve
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.ink, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cierre breve',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                s2.closing,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Sección de firma de compromiso
        if (!_showCertificate) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.ink, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Firma tu Compromiso Categórico',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                CupertinoTextField(
                  controller: _signNameController,
                  placeholder: 'Escribe tu nombre para sellar el compromiso',
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.ink, width: 1.5),
                  ),
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                ComicButton(
                  text: 'Firmar compromiso',
                  type: ComicButtonType.primary,
                  onPressed: _signCommitment,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ] else ...[
          CertificateWidget(
            title: s2.certificate.title,
            name: _signedName,
            careerOrArea: _careerController.text.trim().isNotEmpty
                ? _careerController.text.trim()
                : (_selectedArea?.label ?? ''),
            commitmentText: s2.certificate.text,
            dateText: _dateString,
          ),
          const SizedBox(height: 24),
        ],

        ComicButton(
          text: 'Otro escenario',
          type: ComicButtonType.secondary,
          onPressed: _pickAnotherScenario,
        ),
        const SizedBox(height: 12),
        ComicButton(
          text: 'Ir a Estación 3',
          type: ComicButtonType.primary,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => Station3Screen(content: widget.content),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        ComicButton(
          text: 'Menú',
          type: ComicButtonType.ghost,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
