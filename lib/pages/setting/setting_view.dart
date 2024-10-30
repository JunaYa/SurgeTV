import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/config/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SettingLogic>();
    final state = Bind.find<SettingLogic>().state;
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.setting),
      ),
      body: Column(
        children: [
          Row(
            children: [
              _BrightnessButton(
                handleBrightnessChange: () => logic.toggleThemeMode(),
              ),
              const Text('主题'),
              Expanded(child: Container()),
              Switch(
                  value: Theme.of(context).brightness == Brightness.light,
                  onChanged: (_) {
                    logic.toggleThemeMode();
                  })
            ],
          ),
          Row(
            children: [
              _Material3Button(
                handleMaterialVersionChange: () =>
                    logic.toggleMaterialVersion(),
              ),
              Theme.of(context).useMaterial3
                  ? const Text('Material 3')
                  : const Text('Material 2'),
              Expanded(child: Container()),
              Switch(
                  value: state.useMaterial3,
                  onChanged: (_) {
                    logic.toggleMaterialVersion();
                  })
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.radio_button_unchecked),
                color: state.colorSelected.color,
                isSelected: true,
                selectedIcon: const Icon(Icons.circle),
                onPressed: () {},
              ),
              Expanded(child: Container()),
              _ColorSeedButton(
                handleColorSelect: logic.handleColorSelect,
                colorSelected: state.colorSelected,
                colorSelectionMethod: state.colorSelectionMethod,
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 32),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child:
                          Image(image: NetworkImage(state.imageSelected.url)),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              _ColorImageButton(
                handleImageSelect: logic.handleImageSelect,
                imageSelected: state.imageSelected,
                colorSelectionMethod: state.colorSelectionMethod,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.light_mode_outlined)
            : const Icon(Icons.dark_mode_outlined),
        onPressed: () => handleBrightnessChange(),
      ),
    );
  }
}

class _Material3Button extends StatelessWidget {
  const _Material3Button({
    required this.handleMaterialVersionChange,
    this.showTooltipBelow = true,
  });

  final void Function() handleMaterialVersionChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Switch to Material ${useMaterial3 ? 2 : 3}',
      child: IconButton(
        icon: useMaterial3
            ? const Icon(Icons.filter_3)
            : const Icon(Icons.filter_2),
        onPressed: handleMaterialVersionChange,
      ),
    );
  }
}

class _ColorSeedButton extends StatelessWidget {
  const _ColorSeedButton({
    required this.handleColorSelect,
    required this.colorSelected,
    required this.colorSelectionMethod,
  });

  final void Function(int) handleColorSelect;
  final ColorSeed colorSelected;
  final ColorSelectionMethod colorSelectionMethod;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.palette_outlined,
      ),
      tooltip: 'Select a seed color',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          ColorSeed currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor != colorSelected ||
                colorSelectionMethod != ColorSelectionMethod.colorSeed,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor == colorSelected &&
                            colorSelectionMethod != ColorSelectionMethod.image
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: handleColorSelect,
    );
  }
}

class _ColorImageButton extends StatelessWidget {
  const _ColorImageButton({
    required this.handleImageSelect,
    required this.imageSelected,
    required this.colorSelectionMethod,
  });

  final void Function(int) handleImageSelect;
  final ColorImageProvider imageSelected;
  final ColorSelectionMethod colorSelectionMethod;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.image_outlined,
      ),
      tooltip: 'Select a color extraction image',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorImageProvider.values.length, (index) {
          final currentImageProvider = ColorImageProvider.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentImageProvider != imageSelected ||
                colorSelectionMethod != ColorSelectionMethod.image,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 48),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          image: NetworkImage(currentImageProvider.url),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentImageProvider.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: handleImageSelect,
    );
  }
}
