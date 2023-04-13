import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/pages/bloc/home_event.dart';
import 'package:flutter_bloc_architecture/pages/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(HomeLoadingState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    var state;
    switch (event.runtimeType) {
      case HomeFetchList:
        state = await _fetchList();
        break;
      case HomeFetchListWithError:
        state = await _fetchListWithError();
        break;
      case HomeFetchListWithEmptyList:
        state = await _fetchListWithEmptyList();
        break;
    }
    yield state;
  }

  Future<HomeState> _fetchList() async {
    var list = await Future.delayed(
      Duration(
        seconds: 3,
      ),
      () => <String>[
        'Item 1',
        'Item 2',
        'Item 3',
        'Item 4',
        'Item 5',
        'Item 6',
        'Item 7',
        'Item 8',
        'Item 9',
        'Item 10',
        'Item 11',
        'Item 12',
        'Item 13',
        'Item 14',
        'Item 15',
        'Item 16',
        'Item 17',
      ],
    );
    return HomeStateLoaded(list: list);
  }

  Future<HomeState> _fetchListWithEmptyList() async {
    return await Future.delayed(
        Duration(
          seconds: 3,
        ),
        () => HomeStateEmptyList());
  }

  Future<HomeState> _fetchListWithError() async {
    return await Future.delayed(
        Duration(
          seconds: 3,
        ),
        () => HomeErrorState(message: 'Não foi possível carregar os dados.'));
  }
}
