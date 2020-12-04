mixin VoidUseCase<Params> {
  Future<void> call(Params? params);
}

mixin FutureUseCase<Params, Response> {
  Future<Response> call(Params? params);
}

mixin StreamUseCase<Params, Response> {
  Future<Stream<Response>> call(Params? params);
}
