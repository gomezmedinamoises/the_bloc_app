import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bloc_app/data/model/user.dart';
import 'package:the_bloc_app/data/repository/user_repository.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
              '${widget.user.firstName} ${widget.user.lastName} detail screen',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          floating: true,
        ),
        SliverFillRemaining(
          child: FadeTransition(
            opacity: _animation,
            child: ScaleTransition(
              scale: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      maxRadius: 60,
                      backgroundImage: NetworkImage(widget.user.avatar),
                    ),
                  ),
                  Text('${widget.user.firstName} ${widget.user.lastName}'),
                  Text(widget.user.email)
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
