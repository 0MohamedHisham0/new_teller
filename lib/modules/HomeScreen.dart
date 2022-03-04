import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_teller/shared/components/components.dart';
import 'package:new_teller/shared/components/constants.dart';
import 'package:new_teller/shared/cubit/cubit.dart';
import 'package:new_teller/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  var searchController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..initSpeech(),
      child: BlocConsumer<NewsCubit, NewsStates>(listener: (context, state) {
        if (state is OnSpeechResultState) {
          var cubit = NewsCubit.get(context);
          searchController.text = cubit.lastWords;
          String inComingValue = getCategoryFromText(cubit.lastWords.toLowerCase());
          if (inComingValue.isNotEmpty) {
            cubit.getNews(inComingValue);
          }
        }
      }, builder: (context, state) {
        var cubit = NewsCubit.get(context);


        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: defaultFormField(
                        controller: searchController,
                        prefix: Icons.search,
                        label: 'بحث..',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Search must be not empty';
                          }
                          return null;
                        },
                        onTap: () {},
                        suffixPressed: cubit.speechToText.isNotListening
                            ? cubit.startListening
                            : cubit.stopListening,
                        suffix: Icons.mic,
                        type: TextInputType.text,
                        onChange: (String value) {
                          String inComingValue = getCategoryFromText(value.toLowerCase());
                          if (inComingValue.isNotEmpty) {
                            cubit.getNews(inComingValue);
                          }
                        }),
                  ),
                  Text(
                    // If listening is active show the recognized words
                    cubit.speechToText.isListening
                        ? '...Listening'
                        // If listening isn't active but could be tell the user
                        // how to start it, otherwise indicate that speech
                        // recognition is not yet ready or not supported on
                        // the target device
                        : cubit.speechEnabled
                            ? '...Tap the microphone to start listening'
                            : 'Speech not available',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            newsItem(cubit.news[index], context),
                        itemCount: cubit.news.length),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
