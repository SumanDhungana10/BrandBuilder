import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'incognito_state.dart';

class IncognitoCubit extends Cubit<IncognitoState> {
  IncognitoCubit() : super(IncognitoInitial());
}
