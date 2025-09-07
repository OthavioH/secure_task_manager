
sealed class DeleteTaskState {}

class DeleteTaskInitialState implements DeleteTaskState {
  const DeleteTaskInitialState();
}

class DeleteTaskLoadingState implements DeleteTaskState {
  const DeleteTaskLoadingState();
}

class DeleteTaskSuccessState implements DeleteTaskState {
  const DeleteTaskSuccessState();
}

class DeleteTaskErrorState implements DeleteTaskState {
  final String errorMessage;

  const DeleteTaskErrorState(this.errorMessage);
}