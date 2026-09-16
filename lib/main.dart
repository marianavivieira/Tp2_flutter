// TP2 - Interface Flutter
// Aluna: Mariana Vieira
// Tema: Tela de produto (prato de restaurante)
/// Tela principal do app - apresenta um prato do cardápio de um restaurante.

import 'package:flutter/material.dart';

/// Cores principais
const Color corPrincipal = Color(0xFF084D6E);
const Color corClara = Color(0xFFD6E9F2);

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardápio Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: corPrincipal),
        scaffoldBackgroundColor: const Color(0xFFFFF8F3),
      ),
      home: const Principal(),
    );
  }
}

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int quantidade = 1;

  final double precoUnitario = 42.90;

  void _aumentarQuantidade() {
    setState(() => quantidade++);
  }

  void _diminuirQuantidade() {
    if (quantidade > 1) {
      setState(() => quantidade--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seu Restaurante Fav',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: corPrincipal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImagemPrato(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTituloEPreco(),
                  const SizedBox(height: 8),
                  _buildAvaliacao(),
                  const SizedBox(height: 16),
                  _buildDescricao(),
                  const SizedBox(height: 20),
                  _buildTituloSecao('Ingredientes'),
                  const SizedBox(height: 8),
                  _buildListaIngredientes(),
                  const SizedBox(height: 24),
                  _buildSeletorQuantidade(),
                  const SizedBox(height: 20),
                  _buildBotaoPedido(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Área da Foto (representada por um ícone grande).
  Widget _buildImagemPrato() {
    return Container(
      height: 220,
      width: double.infinity,
      color: corClara,
      child: const Icon(Icons.lunch_dining, size: 100, color: corPrincipal),
    );
  }

  /// Nome do prato e preço, 
  Widget _buildTituloEPreco() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'Burger Supreme',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: corPrincipal,
            ),
          ),
        ),
        Text(
          'R\$ ${precoUnitario.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  /// Avaliação e número de pedidos.
  Widget _buildAvaliacao() {
    return Row(
      children: const [
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star, color: Colors.amber, size: 18),
        Icon(Icons.star_half, color: Colors.amber, size: 18),
        SizedBox(width: 6),
        Text(
          '4.5 (128 avaliações)',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }

  ///Descrição
  Widget _buildDescricao() {
    return const Text(
      'Hambúrguer artesanal de 180g, queijo cheddar derretido, bacon crocante, '
      'cebola caramelizada, alface fresca e molho especial da casa, servido em pão brioche.',
      style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildTituloSecao(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: corPrincipal,
      ),
    );
  }

  /// Lista de ingredientes do prato

  Widget _buildListaIngredientes() {
    final ingredientes = [
      'Pão brioche',
      'Hambúrguer bovino 180g',
      'Queijo cheddar',
      'Bacon crocante',
      'Cebola caramelizada',
      'Alface americana',
      'Molho especial',
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ingredientes.length,
      itemBuilder: (context, index) {
        return IngredienteItem(nome: ingredientes[index]);
      },
    );
  }

  /// Controle de quantidade com botões de + e -.
  Widget _buildSeletorQuantidade() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Quantidade:',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: _diminuirQuantidade,
          icon: const Icon(Icons.remove_circle_outline),
          color: corPrincipal,
        ),
        Text(
          '$quantidade',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: _aumentarQuantidade,
          icon: const Icon(Icons.add_circle_outline),
          color: corPrincipal,
        ),
      ],
    );
  }

  /// Botão principal (adicionar o prato ao pedido)
  Widget _buildBotaoPedido() {
    final total = precoUnitario * quantidade;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$quantidade x Burger Supreme adicionado - Total: R\$ ${total.toStringAsFixed(2)}',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            label: Text('Adicionar - R\$ ${total.toStringAsFixed(2)}'),
            style: ElevatedButton.styleFrom(
              backgroundColor: corPrincipal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget separado para exibir cada ingrediente da lista.
class IngredienteItem extends StatelessWidget {
  final String nome;

  const IngredienteItem({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 6, color: corPrincipal),
          const SizedBox(width: 10),
          Text(nome, style: const TextStyle(fontSize: 14.5)),
        ],
      ),
    );
  }
}