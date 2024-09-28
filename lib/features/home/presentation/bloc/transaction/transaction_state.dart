

abstract class TransactionState<T> {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading<T> extends TransactionState<T> {
  const TransactionLoading();
}

class TransactionException extends TransactionState {
  final String errorMessage;

  const TransactionException(this.errorMessage);
}

class TransactionSuccess<T> extends TransactionState {
  const TransactionSuccess();
}
