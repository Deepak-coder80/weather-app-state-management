import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errorMsg;
  
  const CustomError({
     this.errorMsg = '',
  });


  @override
  List<Object> get props => [errorMsg];  

  @override
  String toString() => 'CustomError : $errorMsg';
}
