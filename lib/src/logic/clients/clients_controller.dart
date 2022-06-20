import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/clients/client.dart';
import '../../domain/clients/i_clients_repository.dart';
import 'clients_state.dart';

class ClientsController extends StateNotifier<ClientsState> {
  final IClientsRepository clientsRepository;

  ClientsController({
    required this.clientsRepository,
  }) : super(const LoadingClientsState());

  Future<void> getClients([int? page]) async {
    try {
      final clientsResponse = await clientsRepository.getClients(page);

      final currentState = state;

      if (currentState is DataClientsState) {
        state = DataClientsState(
          [...currentState.clients, ...clientsResponse.clients],
          clientsResponse.total,
        );
      } else {
        state = DataClientsState(
          clientsResponse.clients,
          clientsResponse.total,
        );
      }
    } catch (_) {
      state = const ErrorClientsState();
    }
  }

  Future<Client> getClient(int id) async {
    try {
      return await clientsRepository.getClient(id);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> createClient({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      final createdClient = await clientsRepository.createClient(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      final currentState = state;

      if (currentState is DataClientsState) {
        state = DataClientsState(
          [createdClient, ...currentState.clients],
          currentState.total + 1,
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      final updatedClient = await clientsRepository.updateClient(client);
      final currentState = state;

      if (currentState is DataClientsState) {
        final clients = currentState.clients.map((client) {
          return client.id == updatedClient.id ? updatedClient : client;
        }).toList();
        state = DataClientsState(clients, currentState.total);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteClient(int id) async {
    try {
      await clientsRepository.deleteClient(id);
      final currentState = state;

      if (currentState is DataClientsState) {
        final clients = currentState.clients.where((client) {
          return client.id != id;
        }).toList();
        state = DataClientsState(clients, currentState.total - 1);
      }
    } catch (_) {
      rethrow;
    }
  }
}
