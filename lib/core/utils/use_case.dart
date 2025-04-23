import 'dart:async';

import 'package:async/async.dart' as async;
import 'package:flutter/foundation.dart';

import 'logger.dart';
import '../network/api_manager_helpers.dart';
import 'result.dart';

abstract class UseCase<TInput, TOutput extends Object, TEvent>
    extends _UseCaseBase<TEvent> {
  UseCase(super.logger);

  final cancelToken = ApiCancelToken();
  late async.CancelableOperation<Result<TOutput, Failure>>
      _cancellableOperation;

  bool _isRunning = false;

  @override
  Future<void> stop() async {
    if (_isRunning) {
      cancelToken.cancel();
      await _cancellableOperation.cancel();
    }
    super.stop();
  }

  @nonVirtual
  Future<Result<TOutput, Failure>> call({TInput? params}) async {
    _cancellableOperation =
        async.CancelableOperation<Result<TOutput, Failure>>.fromFuture(
      execute(params: params),
    );
    _isRunning = true;
    final result = await _cancellableOperation.valueOrCancellation(
      Result<TOutput, Failure>.failure(
        Failure(message: 'Use case is cancelled.'),
      ),
    );
    cancelToken.refresh();
    _isRunning = false;
    return result!;
  }

  Future<Result<TOutput, Failure>> execute({TInput? params});
}

abstract class StreamUseCase<TInput, TOutput extends Object, TEvent>
    extends _UseCaseBase<TEvent> {
  StreamUseCase(super.logger);

  Stream<Result<TOutput, Failure>> call({TInput? params});
}

abstract class _UseCaseBase<TEvent> {
  _UseCaseBase(this.logger);

  final Logger logger;

  final _eventController = StreamController<TEvent>();

  Stream<TEvent> get onEvent => _eventController.stream;

  @protected
  void publish(TEvent event) {
    if (_eventController.hasListener) _eventController.add(event);
  }

  @mustCallSuper
  Future<void> stop() async {
    if (_eventController.hasListener) {
      await _eventController.close();
    }
  }
}
