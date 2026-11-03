import 'package:flutter/cupertino.dart';

import '../../models/ethical_content.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_container.dart';
import '../../widgets/comic_button.dart';
import '../../widgets/key_idea_box.dart';
import '../../widgets/kicker_tag.dart';
import '../station2/station2_screen.dart';

enum Station1Step { intro, question, result }

class Station1Screen extends StatefulWidget {
  final EthicalContent content;

  const Station1Screen({super.key, required this.content});

  @override
  State<Station1Screen> createState() => _Station1ScreenState();
}

class _Station1ScreenState extends State<Station1Screen> {
  Station1Step _currentStep = Station1Step.intro;
  final TextEditingController _careerController = TextEditingController();
  Station1Option? _selectedOption;

  @override
  void dispose() {
    _careerController.dispose();
    super.dispose();
  }

  void _onAnswerSelected(Station1Option option) {
    setState(() {
      _selectedOption = option;
      _currentStep = Station1Step.result;
    });
  }

  void _resetQuestion() {
    setState(() {
      _careerController.clear();
      _selectedOption = null;
      _currentStep = Station1Step.question;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s1 = widget.content.station1;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.bgYellow,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          s1.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        backgroundColor: AppColors.white,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.back, color: AppColors.ink, size: 22),
              Text(
                'Menú',
                style: TextStyle(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
                child: _buildCurrentStep(s1),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep(Station1Content s1) {
    switch (_currentStep) {
      case Station1Step.intro:
        return _buildIntroView(s1);
      case Station1Step.question:
        return _buildQuestionView(s1);
      case Station1Step.result:
        return _buildResultView(s1);
    }
  }

  // Vista 1: Intro
  Widget _buildIntroView(Station1Content s1) {
    return Column(
      key: const ValueKey('s1-intro'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KickerTag(
          text: s1.kicker,
          backgroundColor: AppColors.cyan,
          textColor: AppColors.ink,
        ),
        const SizedBox(height: 14),
        Text(
          s1.title,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 26,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          s1.description,
          style: const TextStyle(
            color: AppColors.grayMuted,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 20),
        KeyIdeaBox(text: s1.keyIdea),
        const SizedBox(height: 32),
        ComicButton(
          text: 'Comenzar',
          type: ComicButtonType.primary,
          onPressed: () {
            setState(() {
              _currentStep = Station1Step.question;
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

  // Vista 2: Pregunta
  Widget _buildQuestionView(Station1Content s1) {
    return Column(
      key: const ValueKey('s1-question'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s1.careerPrompt,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: _careerController,
          placeholder: s1.careerPlaceholder,
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
        const SizedBox(height: 24),
        Text(
          s1.question,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 18),
        ...s1.options.map((opt) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _onAnswerSelected(opt),
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: opt.id == 'mean'
                            ? AppColors.success.withValues(alpha: 0.2)
                            : (opt.id == 'excess'
                                  ? AppColors.warning.withValues(alpha: 0.2)
                                  : AppColors.cyan.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.ink, width: 1.5),
                      ),
                      child: Text(
                        opt.tag.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      opt.title,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      opt.subtitle,
                      style: const TextStyle(
                        color: AppColors.grayMuted,
                        fontSize: 13,
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
        ComicButton(
          text: 'Volver al menú',
          type: ComicButtonType.ghost,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  // Vista 3: Resultado
  Widget _buildResultView(Station1Content s1) {
    final opt = _selectedOption!;
    final careerText = _careerController.text.trim();

    return Column(
      key: const ValueKey('s1-result'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (careerText.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.ink, width: 1.5),
            ),
            child: Text(
              'Participante: $careerText',
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Sticker badge de virtud
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
              Text(opt.emoji, style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 8),
              const Text(
                'VIRTUD A CULTIVAR',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                opt.virtue,
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        Text(
          opt.resultTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          opt.feedback,
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
                opt.closing,
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
        const SizedBox(height: 28),

        ComicButton(
          text: 'Volver a intentar',
          type: ComicButtonType.primary,
          onPressed: _resetQuestion,
        ),
        const SizedBox(height: 12),
        ComicButton(
          text: 'Ir a la Estación 2',
          type: ComicButtonType.secondary,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => Station2Screen(content: widget.content),
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
