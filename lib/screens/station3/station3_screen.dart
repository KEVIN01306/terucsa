import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../../models/ethical_content.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_container.dart';
import '../../widgets/comic_button.dart';
import '../../widgets/kicker_tag.dart';
import '../../widgets/step_card_widget.dart';
import '../../widgets/timer_bar_widget.dart';

enum Station3Step { intro, spin, dilemma, result }

class Station3Screen extends StatefulWidget {
  final EthicalContent content;

  const Station3Screen({super.key, required this.content});

  @override
  State<Station3Screen> createState() => _Station3ScreenState();
}

class _Station3ScreenState extends State<Station3Screen> {
  Station3Step _currentStep = Station3Step.intro;

  String _spinningDilemma = 'Preparando dilema...';
  String _selectedDilemma = '';

  Timer? _countdownTimer;
  Timer? _spinAnimationTimer;
  int _timeLeft = 30;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _spinAnimationTimer?.cancel();
    super.dispose();
  }

  void _startRoulette() {
    setState(() {
      _currentStep = Station3Step.spin;
    });

    final dilemmas = widget.content.station3.dilemmas;
    final random = Random();
    int count = 0;

    _spinAnimationTimer?.cancel();
    _spinAnimationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      count++;
      setState(() {
        _spinningDilemma = dilemmas[random.nextInt(dilemmas.length)];
      });

      if (count > 16) {
        timer.cancel();
        _launchDilemma();
      }
    });
  }

  void _launchDilemma() {
    final dilemmas = widget.content.station3.dilemmas;
    final random = Random();
    final chosen = dilemmas[random.nextInt(dilemmas.length)];

    setState(() {
      _selectedDilemma = chosen;
      _timeLeft = 30;
      _currentStep = Station3Step.dilemma;
    });

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel();
        _finishDilemma();
      }
    });
  }

  void _finishDilemma() {
    _countdownTimer?.cancel();
    setState(() {
      _currentStep = Station3Step.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s3 = widget.content.station3;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.bgYellow,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          s3.title,
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
          onPressed: () {
            _countdownTimer?.cancel();
            Navigator.of(context).pop();
          },
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
                child: _buildCurrentStep(s3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep(Station3Content s3) {
    switch (_currentStep) {
      case Station3Step.intro:
        return _buildIntroView(s3);
      case Station3Step.spin:
        return _buildSpinView();
      case Station3Step.dilemma:
        return _buildDilemmaView(s3);
      case Station3Step.result:
        return _buildResultView(s3);
    }
  }

  // Vista 1: Intro
  Widget _buildIntroView(Station3Content s3) {
    return Column(
      key: const ValueKey('s3-intro'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KickerTag(
          text: s3.kicker,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
        ),
        const SizedBox(height: 14),
        Text(
          s3.title,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          s3.description,
          style: const TextStyle(
            color: AppColors.grayMuted,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 20),

        // Caja de preguntas clave
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.ink, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: s3.reflectiveQuestions.map((q) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('👉 ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        q,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 32),

        ComicButton(
          text: 'Girar la Ruleta',
          type: ComicButtonType.primary,
          onPressed: _startRoulette,
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

  // Vista 2: Giro de la ruleta
  Widget _buildSpinView() {
    return Column(
      key: const ValueKey('s3-spin'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'La ruleta está girando...',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.bgYellow,
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
            children: [
              const CupertinoActivityIndicator(radius: 18),
              const SizedBox(height: 16),
              Text(
                _spinningDilemma,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Vista 3: Dilema y temporizador de 30s
  Widget _buildDilemmaView(Station3Content s3) {
    return Column(
      key: const ValueKey('s3-dilemma'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TimerBarWidget(
          totalSeconds: 30,
          currentSeconds: _timeLeft,
        ),
        const SizedBox(height: 20),

        // Tarjeta del Dilema
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
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.ink, width: 1.5),
                ),
                child: const Text(
                  'TU DILEMA',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                _selectedDilemma,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Preguntas para reflexionar en voz alta
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cyan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.ink, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s3.questionsHeading,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              ...s3.reflectiveQuestions.map((q) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Expanded(
                          child: Text(
                            q,
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 28),

        ComicButton(
          text: 'Terminar y ver el procedimiento',
          type: ComicButtonType.primary,
          onPressed: _finishDilemma,
        ),
      ],
    );
  }

  // Vista 4: Resultado y Guía de 3 Pasos
  Widget _buildResultView(Station3Content s3) {
    return Column(
      key: const ValueKey('s3-result'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s3.resultHeading,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          s3.resultSubtitle,
          style: const TextStyle(
            color: AppColors.grayMuted,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),

        ...s3.steps.map((st) => StepCardWidget(step: st)),
        const SizedBox(height: 24),

        ComicButton(
          text: 'Girar de nuevo',
          type: ComicButtonType.secondary,
          onPressed: _startRoulette,
        ),
        const SizedBox(height: 12),
        ComicButton(
          text: 'Finalizar',
          type: ComicButtonType.primary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
