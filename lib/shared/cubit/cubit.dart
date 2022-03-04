import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_teller/shared/cubit/states.dart';
import 'package:new_teller/shared/network/remote/dio_helper.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<dynamic> news = [];

  // country = us
  // apiKey = 73ecf74251894d8bb7d7def422fd04a6
  // category = business entertainment general health science sports technology

  void getNews(String category) {
    if (category.isNotEmpty) {
      emit(NewsGetListLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': category,
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        emit(NewsGetListSuccessState());

        news = value.data['articles'];
        print(news[0]['title']);
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetListErrorState(error.toString()));
      });
    }
  }



  String lastWords = '';
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;

  /// This has to happen only once per app
  void initSpeech() async {
    emit(InitSpeechState());
    speechEnabled = await speechToText.initialize();
    print('_initSpeech()');
  }

  /// Each time to start a speech recognition session
  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult).then((value)
    {
      emit(OnStartListeningState());
      print('_startListening()');
    });

  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    await speechToText.stop().then((value) {
      emit(OnStopListeningState());

      print('_stopListening()');
    });

  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = result.recognizedWords;
    emit(OnSpeechResultState());
    print('_onSpeechResult()');
  }

}
