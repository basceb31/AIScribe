// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:siri_wave/siri_wave.dart';

// class SiriWaveformWidget extends StatefulWidget {
//   const SiriWaveformWidget({
//     super.key,
//     this.width,
//     this.height,
//   });

//   final double? width;
//   final double? height;

//   @override
//   State<SiriWaveformWidget> createState() => _SiriWaveformWidgetState();
// }

// class _SiriWaveformWidgetState extends State<SiriWaveformWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const HomePage(),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.amber,
//         switchTheme: SwitchThemeData(
//           thumbColor: MaterialStateProperty.all(Colors.amber),
//           trackColor: MaterialStateProperty.resolveWith(
//             (states) => states.contains(MaterialState.selected)
//                 ? Colors.amber.shade300
//                 : Colors.grey.withOpacity(.5),
//           ),
//         ),
//       ),
//       themeMode: ThemeMode.dark,
//       title: 'siri_wave Demo',
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   double amplitude = 1.0;
//   Color color = Colors.white;
//   SiriWaveformController controller = IOS9SiriWaveformController();
//   double frequency = 6.0;
//   final selection = [false, true];
//   bool showSupportBar = true;
//   double speed = .2;

//   SiriWaveformStyle get style =>
//       selection[0] ? SiriWaveformStyle.ios_7 : SiriWaveformStyle.ios_9;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: kIsWeb,
//         title: const Text('siri_wave Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Spacer(),
//             CustomSlider(
//               onChanged: (value) {
//                 controller.amplitude = value;
//                 setState(() => amplitude = value);
//               },
//               label: 'Amplitude',
//               value: amplitude,
//             ),
//             CustomSlider(
//               onChanged: (value) {
//                 controller.speed = value;
//                 setState(() => speed = value);
//               },
//               label: 'Speed',
//               value: speed,
//             ),
//             if (style == SiriWaveformStyle.ios_9)
//               CustomSwitch(
//                 onChanged: (value) {
//                   setState(() => showSupportBar = value);
//                 },
//                 value: showSupportBar,
//               )
//             else ...[
//               FrequencySlider(
//                 onChanged: (value) {
//                   (controller as IOS7SiriWaveformController).frequency =
//                       value.round();
//                   setState(() => frequency = value);
//                 },
//                 value: frequency,
//               ),
//               ColorPickerWidget(
//                 onChanged: (value) {
//                   setState(() => color = value);
//                   (controller as IOS7SiriWaveformController).color = value;
//                 },
//                 color: color,
//               ),
//             ],
//             WaveformStyleToggleButtons(
//               onPressed: (index) {
//                 if (selection[index]) return;
//                 for (var i = 0; i < selection.length; i++) {
//                   selection[i] = i == index;
//                 }
//                 controller = index == 0
//                     ? IOS7SiriWaveformController()
//                     : IOS9SiriWaveformController();
//                 setState(() {});
//               },
//               selection: selection,
//             ),
//             const Spacer(),
//             const CustomDivider(),
//             SiriWaveformWidget(
//               controller: controller,
//               showSupportBar: showSupportBar,
//               style: style,
//             ),
//             const CustomDivider(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomSlider extends StatelessWidget {
//   const CustomSlider({
//     required this.onChanged,
//     required this.label,
//     required this.value,
//     super.key,
//   });

//   final ValueChanged<double> onChanged;

//   final String label;
//   final double value;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(label, style: Theme.of(context).textTheme.titleLarge),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: SizedBox(
//             width: 360,
//             child: Slider(
//               value: value,
//               min: 0,
//               max: 1,
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomSwitch extends StatelessWidget {
//   const CustomSwitch({
//     required this.onChanged,
//     required this.value,
//     super.key,
//   });

//   final ValueChanged<bool> onChanged;
//   final bool value;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSize(
//       curve: Curves.fastOutSlowIn,
//       duration: const Duration(milliseconds: 400),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Show support bar',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: Switch(
//               value: value,
//               onChanged: onChanged,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FrequencySlider extends StatelessWidget {
//   const FrequencySlider({
//     required this.onChanged,
//     required this.value,
//     super.key,
//   });

//   final ValueChanged<double> onChanged;
//   final double value;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSize(
//       curve: Curves.fastOutSlowIn,
//       duration: const Duration(milliseconds: 400),
//       child: Column(
//         children: [
//           Text(
//             'Frequency',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: SizedBox(
//               width: 360,
//               child: Slider(
//                 value: value,
//                 divisions: 40,
//                 min: -20,
//                 max: 20,
//                 onChanged: onChanged,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ColorPickerWidget extends StatelessWidget {
//   const ColorPickerWidget({
//     required this.onChanged,
//     required this.color,
//     super.key,
//   });

//   final ValueChanged<Color> onChanged;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSize(
//       curve: Curves.fastOutSlowIn,
//       duration: const Duration(milliseconds: 400),
//       child: Column(
//         children: [
//           Text(
//             'Color',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: ElevatedButton(
//               onPressed: () async {
//                 await showDialog<void>(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       titlePadding: EdgeInsets.zero,
//                       contentPadding: EdgeInsets.zero,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(9),
//                       ),
//                       content: SingleChildScrollView(
//                         child: ColorPicker(
//                           pickerColor: color,
//                           onColorChanged: onChanged,
//                           pickerAreaHeightPercent: .7,
//                           displayThumbColor: true,
//                           paletteType: PaletteType.hsl,
//                           pickerAreaBorderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: const Text('Change color'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WaveformStyleToggleButtons extends StatelessWidget {
//   const WaveformStyleToggleButtons({
//     required this.onPressed,
//     required this.selection,
//     super.key,
//   });

//   final ValueChanged<int> onPressed;
//   final List<bool> selection;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('Style', style: Theme.of(context).textTheme.titleLarge),
//         const SizedBox(height: 15),
//         ToggleButtons(
//           onPressed: onPressed,
//           borderColor: Theme.of(context).primaryColorLight,
//           borderRadius: BorderRadius.circular(16),
//           isSelected: selection,
//           selectedBorderColor: Theme.of(context).colorScheme.primary,
//           children: const [
//             Padding(padding: EdgeInsets.all(16), child: Text('iOS 7')),
//             Padding(padding: EdgeInsets.all(16), child: Text('iOS 9')),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class CustomDivider extends StatelessWidget {
//   const CustomDivider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: kIsWeb ? 600 : 360,
//       child: Divider(
//         color: Theme.of(context).colorScheme.primary,
//         thickness: 1,
//       ),
//     );
//   }
// }
// }
