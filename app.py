import os
from flask import Flask, render_template, request, redirect, url_for, jsonify
from flask_cors import CORS
from supabase import create_client
import json

app = Flask(__name__)
CORS(app)

# Configuração do Supabase
supabase_url = "https://irmeeknoxdzcmowsvycc.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlybWVla25veGR6Y21vd3N2eWNjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5Mzk1MjYsImV4cCI6MjA2MzUxNTUyNn0.d-xsD-tVoi2i24Q9SFkFwyrFmnKPMRG_eZCBrLdX-64"
supabase = create_client(supabase_url, supabase_key)

@app.route('/')
def index():
    # Buscar clientes com status "Em aberto"
    response = supabase.table('clientes').select('*').eq('status', 'Em aberto').execute()
    clientes = response.data
    return render_template('index.html', clientes=clientes)

@app.route('/cliente/<id>')
def cliente_detalhes(id):
    # Buscar dados do cliente específico
    response = supabase.table('clientes').select('*').eq('id', id).execute()
    
    if len(response.data) == 0:
        return redirect(url_for('index'))
    
    cliente = response.data[0]
    return render_template('cliente.html', cliente=cliente)

@app.route('/atualizar_cliente', methods=['POST'])
def atualizar_cliente():
    data = request.form.to_dict()
    cliente_id = data.pop('id')
    
    # Atualizar dados do cliente
    response = supabase.table('clientes').update(data).eq('id', cliente_id).execute()
    
    return redirect(url_for('index'))

@app.route('/concluir_cliente/<id>', methods=['POST'])
def concluir_cliente(id):
    # Atualizar status do cliente para "Concluido"
    response = supabase.table('clientes').update({'status': 'Concluido'}).eq('id', id).execute()
    return redirect(url_for('index'))

@app.route('/cancelar_cliente/<id>', methods=['POST'])
def cancelar_cliente(id):
    # Atualizar status do cliente para "Cancelado"
    response = supabase.table('clientes').update({'status': 'Cancelado'}).eq('id', id).execute()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True) 