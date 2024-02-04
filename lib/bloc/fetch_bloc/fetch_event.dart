part of 'fetch_bloc.dart';

@immutable
sealed class FetchEvent {}

class ProductFetchEvent extends FetchEvent {}
