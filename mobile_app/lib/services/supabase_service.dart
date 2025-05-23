import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cliente_model.dart';

class SupabaseService {
  final SupabaseClient _supabaseClient;

  SupabaseService(this._supabaseClient);

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://irmeeknoxdzcmowsvycc.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlybWVla25veGR6Y21vd3N2eWNjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5Mzk1MjYsImV4cCI6MjA2MzUxNTUyNn0.d-xsD-tVoi2i24Q9SFkFwyrFmnKPMRG_eZCBrLdX-64',
    );
  }

  static SupabaseService get instance => 
      SupabaseService(Supabase.instance.client);

  Future<List<Cliente>> getClientesEmAberto() async {
    final response = await _supabaseClient
        .from('clientes')
        .select()
        .eq('status', 'Em aberto')
        .execute();

    if (response.error != null) {
      throw response.error!;
    }

    final data = response.data as List<dynamic>;
    return data.map((json) => Cliente.fromJson(json)).toList();
  }

  Future<Cliente> getClienteById(String id) async {
    final response = await _supabaseClient
        .from('clientes')
        .select()
        .eq('id', id)
        .single()
        .execute();

    if (response.error != null) {
      throw response.error!;
    }

    return Cliente.fromJson(response.data);
  }

  Future<void> atualizarCliente(Cliente cliente) async {
    final response = await _supabaseClient
        .from('clientes')
        .update(cliente.toJson())
        .eq('id', cliente.id)
        .execute();

    if (response.error != null) {
      throw response.error!;
    }
  }

  Future<void> atualizarStatus(String id, String status) async {
    final response = await _supabaseClient
        .from('clientes')
        .update({'status': status})
        .eq('id', id)
        .execute();

    if (response.error != null) {
      throw response.error!;
    }
  }
} 