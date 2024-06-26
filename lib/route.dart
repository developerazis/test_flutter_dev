import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_maha_dev/presentation/provider/material_provider.dart';
import 'package:test_maha_dev/presentation/provider/order_provider.dart';
import 'package:test_maha_dev/presentation/screen/home.dart';
import 'package:test_maha_dev/presentation/screen/material.dart';
import 'package:test_maha_dev/presentation/screen/order_request.dart';
import 'package:test_maha_dev/presentation/screen/pdf_preview_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName : (context) => const HomeScreen(),
  MaterialScreen.routeName : (context) => ChangeNotifierProvider<MaterialProvider>(
      create: (context) =>  MaterialProvider(),
      child: const MaterialScreen(),
  ),
  OrderRequestScreen.routeName : (context) => ChangeNotifierProvider<OrderProvider>(
    create: (context) =>  OrderProvider(),
    child: const OrderRequestScreen(),
  ),
  PdfPreviewScreen.routeName : (context) => const PdfPreviewScreen()
};