import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) => const Scaffold(
            body: Center(
              child: Text(
                'Hello Guys !',
                style: TextStyle(color: Color(0xff8C822D), fontSize: 30),
              ),
            ),
          ),
    ),
  ],
);
