import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/clients/clients_repository.dart';
import '../../domain/clients/client.dart';
import '../../domain/clients/i_clients_repository.dart';
import 'clients_controller.dart';
import 'clients_state.dart';

final clientsRepositoryProvider = Provider<IClientsRepository>((_) {
  return ClientsRepository();
});

final clientsControllerProvider =
    StateNotifierProvider<ClientsController, ClientsState>((ref) {
  final clientsRepository = ref.watch(clientsRepositoryProvider);

  return ClientsController(clientsRepository: clientsRepository)..getClients();
});

final clientsFilterProvider = StateProvider<String>((_) => '');

final filteredClients = Provider<List<Client>>((ref) {
  final clientsState = ref.watch(clientsControllerProvider) as DataClientsState;
  final clientsFilter = ref.watch(clientsFilterProvider).state;

  if (clientsFilter.isEmpty) return clientsState.clients;

  return clientsState.clients.where((client) {
    final idMatch = client.id.toString().contains(clientsFilter);
    final nameMatch = '${client.firstName} ${client.lastName}'
        .toLowerCase()
        .contains(clientsFilter.toLowerCase());
    final emailMatch =
        client.email.toLowerCase().contains(clientsFilter.toLowerCase());
    return idMatch || nameMatch || emailMatch;
  }).toList();
});
