import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/pages/bloc/home_bloc.dart';
import 'package:flutter_bloc_architecture/pages/bloc/home_event.dart';
import 'package:flutter_bloc_architecture/pages/bloc/home_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final bloc = HomeBloc();

  @override
  void initState() {
    bloc.add(HomeFetchList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Flutter Bloc Architeture Example'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
          bloc: BlocProvider.of<HomeBloc>(context),
          builder: (context, state) {
            if (state is HomeStateLoaded)
              return Scaffold(
                body: ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.list[index]),
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(onPressed: () {
                  bloc.add(HomeFetchListWithEmptyList());
                }),
              );

            if (state is HomeErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is HomeStateEmptyList) {
              return Center(
                child: Text('Não há dados disponíveis.'),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
