import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/clients/client.dart';
import '../../logic/clients/clients_provider.dart';
import '../../logic/clients/clients_state.dart';
import '../../logic/user/user_provider.dart';
import '../core/widgets/coda_logo.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool isFetching = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CodaLogo(
          height: 24,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: _signOut,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Filter by ID, name or email',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final clientsState = watch(clientsControllerProvider);

          if (clientsState is DataClientsState) {
            final clients = watch(filteredClients);

            if (clients.isEmpty) {
              return const Center(
                child: Text('No clients found.'),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients.elementAt(index);
                final clientListTile = Dismissible(
                  key: Key(client.id.toString()),
                  background: Container(
                    color: theme.errorColor,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: theme.errorColor,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (_) => _deleteClient(context, client.id),
                  child: ListTile(
                    onTap: () => _navigateToClientDetail(context, client),
                    leading: client.profilePictureUrl != null
                        ? CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              client.profilePictureUrl!,
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: theme.primaryIconTheme.color,
                            child: Text(client.firstName[0].toUpperCase()),
                          ),
                    title: Text('${client.firstName} ${client.lastName}'),
                    subtitle: Text(client.email),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  ),
                );

                if (index == clients.length - 1) {
                  return Column(
                    children: [
                      clientListTile,
                      const SizedBox(height: 16),
                      if (isFetching) ...[
                        const ListTile(
                          title: CircularProgressIndicator.adaptive(),
                        )
                      ],
                    ],
                  );
                }

                return clientListTile;
              },
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/client'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onScroll() async {
    if (isFetching) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final clientsController = context.read(clientsControllerProvider.notifier);
    final clientsState =
        context.read(clientsControllerProvider) as DataClientsState;

    if (clientsState.clients.length < clientsState.total) {
      if (maxScroll - currentScroll <= 200) {
        setState(() {
          isFetching = true;
          page++;
        });
        await clientsController.getClients(page);
        setState(() {
          isFetching = false;
        });
      }
    }
  }

  void _navigateToClientDetail(BuildContext context, Client client) {
    Navigator.of(context).pushNamed('/client', arguments: client);
  }

  void _deleteClient(BuildContext context, int clientId) {
    final clientsController = context.read(clientsControllerProvider.notifier);
    clientsController.deleteClient(clientId);
  }

  void _onSearch() {
    context.read(clientsFilterProvider).state = _searchController.text;
  }

  void _signOut() {
    context.read(userControllerProvider.notifier).signOut();
  }
}
