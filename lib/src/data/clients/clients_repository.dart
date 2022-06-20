import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../src/core/utils/constants.dart';
import '../../domain/clients/client.dart';
import '../../domain/clients/clients_response.dart';
import '../../domain/clients/i_clients_repository.dart';

class ClientsRepository implements IClientsRepository {
  @override
  Future<ClientsResponse> getClients([int? page]) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/client/list?page=${page ?? 1}'),
      );
      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || json['success'] == false) {
        throw Exception('Failed to load clients');
      }

      final clientsResponse = ClientsResponse.fromJson(json['response']);

      return clientsResponse;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Client> getClient(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/client/fetch/$id'),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || json['success'] == false) {
        throw Exception('Failed to load client');
      }

      final client = Client.fromJson(json['response']);

      return client;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Client> createClient({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/client/save'),
        body: {
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
        },
      );
      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || json['success'] == false) {
        throw Exception('Failed to create client');
      }

      final createdClient = Client.fromJson(json['response']);

      return createdClient;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Client> updateClient(Client client) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/client/save'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(client.toJson()),
      );
      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || json['success'] == false) {
        throw Exception('Failed to update client');
      }

      final updatedClient = Client.fromJson(json['response']);

      return updatedClient;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteClient(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/client/remove/$id'),
      );
      final json = jsonDecode(response.body);

      if (response.statusCode != 200 || json['success'] == false) {
        throw Exception('Failed to delete client');
      }
    } catch (_) {
      rethrow;
    }
  }
}
