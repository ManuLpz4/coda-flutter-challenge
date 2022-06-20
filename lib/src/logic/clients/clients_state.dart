import '../../domain/clients/client.dart';
import '../core/state.dart';

abstract class ClientsState {
  const ClientsState();
}

class LoadingClientsState extends ClientsState implements Loading {
  const LoadingClientsState();
}

class DataClientsState extends ClientsState implements Data {
  final List<Client> clients;
  final int total;

  const DataClientsState(this.clients, this.total);
}

class ErrorClientsState extends ClientsState {
  const ErrorClientsState();
}
