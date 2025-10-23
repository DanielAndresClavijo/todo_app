import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/countries/presentation/providers/country_provider.dart';

/// Pantalla de lista de países
class CountryListScreen extends ConsumerStatefulWidget {
  const CountryListScreen({super.key});

  @override
  ConsumerState<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends ConsumerState<CountryListScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar países al inicializar
    Future.microtask(() => ref.read(countryNotifierProvider.notifier).loadCountries());
  }

  @override
  Widget build(BuildContext context) {
    final countryState = ref.watch(countryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Países del Mundo'),
        elevation: 2,
      ),
      body: _buildBody(countryState),
    );
  }

  Widget _buildBody(CountryState state) {
    switch (state.status) {
      case CountryStatus.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Cargando países...'),
            ],
          ),
        );
      
      case CountryStatus.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage ?? 'Error desconocido',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(countryNotifierProvider.notifier).loadCountries();
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        );
      
      case CountryStatus.loaded:
        final countries = state.countries;
        
        if (countries.isEmpty) {
          return const Center(
            child: Text('No se encontraron países'),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(countryNotifierProvider.notifier).loadCountries();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final country = countries[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Text(
                      country.emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  title: Text(
                    country.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🌍 ${country.continent}'),
                      if (country.capital.isNotEmpty)
                        Text('🏛️ ${country.capital}'),
                      if (country.languages.isNotEmpty)
                        Text('🗣️ ${country.languages.join(", ")}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      country.code,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        );
      
      case CountryStatus.initial:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
