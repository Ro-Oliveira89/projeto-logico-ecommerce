# Projeto Lógico de Banco de Dados para E-commerce

## Descrição

Projeto desenvolvido como parte do desafio de modelagem lógica de banco de dados utilizando MySQL.

O sistema simula um cenário de E-commerce contemplando clientes, produtos, pedidos, fornecedores, vendedores, pagamentos, estoque e entregas.

## Estrutura do Banco

O projeto contém as seguintes entidades principais:

- clients
- clientPF
- clientPJ
- product
- orders
- payment
- delivery
- supplier
- seller
- productStorage

As entidades foram modeladas para representar um cenário completo de comércio eletrônico.

## Modelo Lógico

O modelo lógico utilizado como base para o desenvolvimento do banco de dados encontra-se disponível no arquivo:

- DER.pdf

O arquivo pode ser aberto diretamente pelo GitHub para visualização do diagrama do banco de dados.

## Refinamentos Implementados

### Cliente PF e PJ

Foi realizada a especialização dos clientes em:

- Pessoa Física (PF)
- Pessoa Jurídica (PJ)

### Múltiplas Formas de Pagamento

O modelo permite que um cliente possua mais de uma forma de pagamento cadastrada.

### Controle de Entregas

Implementação de:

- Código de rastreio
- Status da entrega

## Tecnologias Utilizadas

- MySQL
- SQL
- MySQL Workbench

## Estrutura do Projeto

### ecommerce.sql

Contém:

- Criação do banco
- Criação das tabelas
- Inserção dos dados
- Consultas SQL

### ECOMMERCE.mwb

Arquivo de modelagem desenvolvido no MySQL Workbench.

## Consultas Desenvolvidas

- Quantidade de pedidos por cliente
- Clientes com mais de um pedido
- Relação entre produtos e fornecedores
- Produtos, fornecedores e estoque
- Acompanhamento das entregas
- Classificação de frete
- Frete com taxa adicional
- Identificação de clientes PF e PJ
- Verificação de fornecedores que também atuam como vendedores

## Autor

Rodrigo Oliveira
