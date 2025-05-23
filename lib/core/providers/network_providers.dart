import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_listing_app/core/network/network_info.dart';
import 'package:event_listing_app/core/network/dio_client.dart';


final dioProvider = Provider<Dio>((ref) => Dio());

final dioClientProvider = Provider<DioClient>((ref) => 
    DioClient(dio: ref.read(dioProvider)));

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final networkInfoProvider = Provider<NetworkInfo>((ref) => 
    NetworkInfoImpl(ref.read(connectivityProvider)));