import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:snitch/features/onboarding/model/onboard_template_model.dart';


class OnboardPageTemplate extends StatefulWidget {

  const OnboardPageTemplate({super.key, required this.template});

  final OnboardTemplateModel template;

  @override
  State<OnboardPageTemplate> createState() => _OnboardPageTemplateState();
}

class _OnboardPageTemplateState extends State<OnboardPageTemplate> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 1,
      upperBound: 50
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1, end: 50).animate(_controller);

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Stack(
            children: [

              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: _controller.value, sigmaY: _controller.value),
                    child: Image.asset(
                      widget.template.image,
                      height: 150,
                    ),
                  );
                },
              ),


              Image.asset(
                widget.template.image,
                height: 150,
              ),
            ],
          ),

          Text(
            widget.template.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            widget.template.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.secondary
            ),
          ),

          const SizedBox(height: 20),


          if (widget.template.button != null) widget.template.button!

        ],
      ),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

}