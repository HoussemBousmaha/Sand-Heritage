import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/size_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/music_player.dart';

class ExperienceView extends StatefulHookConsumerWidget {
  const ExperienceView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends ConsumerState<ExperienceView> {
  late final GoogleTranslator translator;

  @override
  void initState() {
    translator = GoogleTranslator();
    super.initState();
  }

  @override
  Widget build(BuildContext contextf) {
    final isDescriptionVisibleNotifier = useState(false);
    final isMusicPlayingNotifier = useState(false);

    final descriptionScaleAnimation = useAnimationController(duration: const Duration(milliseconds: 200));

    final imageFileNotifier = useState<XFile?>(null);
    final imageNotifier = useState<ImageProvider<Object>?>(null);
    final translatedTextNotifier = useState<String>('');

    void getRecognisedText(XFile image) async {
      final inputImage = GoogleVisionImage.fromFilePath(image.path);
      final textDetector = GoogleVision.instance.textRecognizer();
      VisionText recognisedText = await textDetector.processImage(inputImage);
      await textDetector.close();

      String scannedText = "";
      for (TextBlock block in recognisedText.blocks) {
        final List<RecognizedLanguage> languages = block.recognizedLanguages;
        for (var lan in languages) {
          print('recognized langs: ${lan.languageCode}');
        }
        for (TextLine line in block.lines) {
          scannedText += '${line.text} ';
        }
      }

      print('scanned text: $scannedText');

      final translatedText = await translator.translate(scannedText, to: 'ar');

      print('translated text: $translatedText');

      translatedTextNotifier.value = translatedText.text;
    }

    void getImage(ImageSource source) async {
      try {
        final pickedImage = await ImagePicker().pickImage(source: source);
        if (pickedImage == null) return;
        setState(() async {
          imageFileNotifier.value = pickedImage;
          getRecognisedText(pickedImage);
        });
      } catch (e) {
        imageFileNotifier.value = null;
        setState(() {});
      }
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // image
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: imageNotifier.value != null
                  ? Image(
                      image: imageNotifier.value!,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: AssetsManager.alulahUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    ),
            ),

            // translated text
            if (translatedTextNotifier.value.isNotEmpty)
              Positioned(
                bottom: getHeight(context, 300),
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: getWidth(context, 360)),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 40), vertical: getHeight(context, 20)),
                      decoration: BoxDecoration(
                        color: ColorManager.kBlack.withOpacity(.4),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        translatedTextNotifier.value,
                        style: const TextStyle(
                          color: ColorManager.kWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(onPressed: () => translatedTextNotifier.value = '', icon: const Icon(Icons.delete)),
                  ],
                ),
              ),
            if (translatedTextNotifier.value.isEmpty)
              // description text
              Positioned(
                bottom: getHeight(context, 130),
                child: ScaleTransition(
                  scale: descriptionScaleAnimation,
                  child: Container(
                    width: getWidth(context, 400),
                    padding: EdgeInsets.all(getHeight(context, 20)),
                    decoration: BoxDecoration(color: ColorManager.kBlack.withOpacity(.5), borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: const Text(StringManager.alola, style: TextStyle(color: ColorManager.kWhite, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            if (translatedTextNotifier.value.isEmpty)
              // show description button
              Positioned(
                right: getWidth(context, 80),
                bottom: getHeight(context, 500),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isDescriptionVisibleNotifier.value = !isDescriptionVisibleNotifier.value;
                        if (isDescriptionVisibleNotifier.value) {
                          descriptionScaleAnimation.reverse();
                        } else {
                          descriptionScaleAnimation.forward();
                        }
                      },
                      child: Container(
                        height: getHeight(context, 60),
                        width: getWidth(context, 60),
                        decoration: BoxDecoration(
                          color: ColorManager.kBlack.withOpacity(.5),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: ColorManager.kWhite),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(AssetsManager.placeDetails),
                      ),
                    ),
                    Container(
                      height: getHeight(context, 70),
                      width: getWidth(context, 2),
                      decoration: const BoxDecoration(color: ColorManager.kWhite),
                    ),
                    Container(
                      height: getHeight(context, 25),
                      width: getWidth(context, 25),
                      decoration: BoxDecoration(
                        color: ColorManager.kBlack.withOpacity(.5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: getHeight(context, 10),
                        width: getWidth(context, 10),
                        decoration: const BoxDecoration(
                          color: ColorManager.kWhite,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // music player
            Positioned(
              top: getHeight(context, 90),
              child: GestureDetector(
                onTap: () => isMusicPlayingNotifier.value = !isMusicPlayingNotifier.value,
                child: isMusicPlayingNotifier.value
                    ? const MusicPlayer()
                    : Container(
                        height: getHeight(context, 60),
                        width: getWidth(context, 60),
                        decoration: BoxDecoration(
                          color: ColorManager.kBlack.withOpacity(.5),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: ColorManager.kWhite),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.music_note,
                          color: ColorManager.kWhite,
                        ),
                      ),
              ),
            ),

            // camera button
            Positioned(
              bottom: getHeight(context, 20),
              child: GestureDetector(
                onTap: () => getImage(ImageSource.gallery),
                child: Container(
                  height: getHeight(context, 50),
                  width: getWidth(context, 50),
                  decoration: BoxDecoration(
                    color: ColorManager.kBlack.withOpacity(.5),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: ColorManager.kWhite),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.camera, color: ColorManager.kWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
