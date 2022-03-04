abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class ChangeNumberState extends NewsStates {}

class NewsGetListLoadingState extends NewsStates {}

class NewsGetListSuccessState extends NewsStates {}

class NewsGetListErrorState extends NewsStates {
  NewsGetListErrorState(String error);
}

class ListeningToYouChangeState extends NewsStates {}

class InitSpeechState extends NewsStates {}

class OnStartListeningState extends NewsStates {}

class OnStopListeningState extends NewsStates {}

class OnSpeechResultState extends NewsStates {}
