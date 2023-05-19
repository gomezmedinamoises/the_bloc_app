import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bloc_app/bloc/app_bloc.dart';
import 'package:the_bloc_app/bloc/app_event.dart';
import 'package:the_bloc_app/data/repository/user_repository.dart';
import 'package:the_bloc_app/ui/detail_screen.dart';

import '../data/model/user.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToDetailScreen(User user) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => FadeTransition(
              opacity: _animation,
              child: DetailScreen(user: user),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final userRepository = RepositoryProvider.of<UserRepository>(context);

    return BlocProvider(
      create: (context) =>
          UserBloc(RepositoryProvider.of<UserRepository>(context))
            ..add(LoadUserEvent()),
      child: Scaffold(
        /*appBar: AppBar(
          title: const Text('The BLoC App'),
        ),*/
        body: FutureBuilder<List<User>>(
          future: userRepository.getUsers(),
          builder: (context, snapshot) {
            // Set UI if state is loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Set UI if state is loaded
            if (snapshot.hasData) {
              final userList = snapshot.data!;
              userList.addAll([...userList]);
              userList.addAll([...userList]);

              return CustomScrollView(
                slivers: [
                  const SliverAppBar(
                      title: Text('The BLoC App'), floating: true),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          _navigateToDetailScreen(userList[index]);
                        },
                        child: Card(
                          color: Colors.blue,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(userList[index].firstName,
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(userList[index].lastName,
                                style: const TextStyle(color: Colors.white)),
                            trailing: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userList[index].avatar)),
                          ),
                        ),
                      ),
                    );
                  }, childCount: userList.length))
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('An error was happened'));
            }

            return Container();
          },
        ),
      ),
    );
  }
}
