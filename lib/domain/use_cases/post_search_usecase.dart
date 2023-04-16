import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/base_usecase/base_usecase.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/domain/Entity/search_entity.dart';
import 'package:e_commerce_app/domain/repository/base_repository.dart';

class PostSearchUseCase extends BaseUseCase<SearchEntity, SearchParameters> {
  BaseRepository baseRepository;
  PostSearchUseCase({
    required this.baseRepository,
  });
  @override
  Future<Either<Failure, SearchEntity>> call(
      SearchParameters parameters) async {
    return await baseRepository.postSearch(parameters.text, parameters.token);
  }
}

class SearchParameters extends Equatable {
  final String token;
  final String text;

  const SearchParameters(this.token, this.text);

  @override
  List<Object> get props => [token, text];
}
