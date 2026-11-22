/*
====================================================
PROJETO LÓGICO DE BANCO DE DADOS - E-COMMERCE
Autor: Rodrigo Oliveira
====================================================
*/

/*
====================================================
1. CRIAÇÃO DO BANCO
====================================================
*/

DROP DATABASE IF EXISTS ecommerce;

CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(100),
    Minit CHAR(3),
    Lname VARCHAR(200),
    Address VARCHAR(100),
    clientType ENUM('PF','PJ') NOT NULL
);

CREATE TABLE clientPF(
	idClient INT PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    CONSTRAINT fk_client_pf
    FOREIGN KEY(idClient)
    REFERENCES clients(idClient)
);

CREATE TABLE clientPJ(
	idClient INT PRIMARY KEY,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    SocialName VARCHAR(255) NOT NULL,
	CONSTRAINT fk_client_pj
    FOREIGN KEY(idClient)
    REFERENCES clients(idClient)
);
    
CREATE TABLE product(
	idProduct int auto_increment primary key,
	Pname varchar(100),
	classification_kids bool default false,
	category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
	rating FLOAT DEFAULT 0,
	size varchar(10)
);
	
CREATE TABLE payment(
	idClient int,
	idPayment int,
	typePayment ENUM(
		'Boleto',
		'Cartão Crédito',
		'Cartão Débito',
		'PIX'
	),
	limitAvailable float,
	PRIMARY KEY(idClient, idPayment),
	CONSTRAINT fk_payment_client
	FOREIGN KEY(idClient)
	REFERENCES clients(idClient)
);

CREATE TABLE orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum ('Cancelado','Confirmado', 'Em processamento') default 'Em processamento',
	orderDescription varchar(255),
	sendValue float default 10,
	paymentCash bool default false,
	constraint fk_order_client foreign key (idOrderClient) references clients (idClient)
    on update cascade
);
   
CREATE TABLE productStorage(
	idProdStorage int auto_increment primary key,
	storageLocation varchar(255),
	quantity int default 0
);
    
CREATE TABLE supplier(
	idSupplier int auto_increment primary key,
	SocialName varchar(255) not null,
	CNPJ char(14) not null,
	contact char(11) not null,
	constraint unique_supplier unique (CNPJ)
);
    
CREATE TABLE seller(
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
	AbstName varchar (255),
	location varchar (255),
	CNPJ char(14),
	CPF char(11),
	contact char(11) not null,
	constraint unique_cnpj_seller unique (CNPJ),
	constraint unique_cpf_seller unique (CPF)
);

CREATE TABLE productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller,idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

CREATE TABLE productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum ('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct,idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

CREATE TABLE storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar (255) not null,
    primary key (idLproduct,idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

CREATE TABLE productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier (idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);

CREATE TABLE delivery(
	idDelivery INT AUTO_INCREMENT PRIMARY KEY,
	idOrder INT NOT NULL,
	trackingCode VARCHAR(50),
	deliveryStatus ENUM(
		'Preparando Envio',
		'Em Transporte',
		'Entregue',
		'Atrasado'
	) DEFAULT 'Preparando Envio',

	CONSTRAINT fk_delivery_order
	FOREIGN KEY(idOrder)
	REFERENCES orders(idOrder)
);

/*
====================================================
3. INSERÇÃO DOS DADOS
====================================================
*/

INSERT INTO clients
(Fname,Minit,Lname,Address,clientType)
VALUES
('Rodrigo','D','Oliveira','Rua Rosa de Morais 13 - São Paulo','PF'),
('Karina','M','Oliveira','Rua Simão Lopes 33 - São Paulo','PF'),
('Caio','M','Oliveira','Avenida Miguel Stefano 1973 - São Paulo','PF'),
('Hugo','P','De Paula','Avenida Lion 02 - Santo André','PF'),
('Maria','P','Scartigno','Rua das Figueiras 98 - Santo André','PF'),
('Victoria','B','Anderson','Rua Francisco Horta 43 - Praia Grande','PF');

INSERT INTO clientPF
(idClient, CPF)
VALUES
(1,'98352005100'),
(2,'98433560100'),
(3,'50739113000'),
(4,'55098432000'),
(5,'73872924600'),
(6,'95584653100');

INSERT INTO clients
(Fname,Minit,Lname,Address,clientType)
VALUES
('Empresa','X','LTDA','São Paulo','PJ');

INSERT INTO clientPJ
(idClient,CNPJ,SocialName)
VALUES
(7,'12345678000199','XPTO Comercio LTDA');
            
insert into product
(Pname, classification_kids, category, rating, size) values
			('Fone de ouvido',false,'Eletrônico',4,null),
            ('Barbie Elsa',true,'Brinquedos',3,null),
            ('Body Carters',true,'Vestimenta',5,null),
            ('Microfone Vedo - Youtuber',false,'Eletrônico',4,null),
            ('Sofa retrátil',false,'Móveis',3,'3x57x80'),
            ('Farinha de arroz',false,'Alimentos',2,null),
            ('Fire Stick Amazon',false,'Eletrônico',1,null);
            
INSERT INTO payment
(idClient,idPayment,typePayment,limitAvailable)
VALUES
(1,1,'Cartão Crédito',5000),
(2,1,'PIX',0),
(3,1,'Boleto',0),
(4,1,'Cartão Débito',1000);

INSERT INTO payment
(idClient,idPayment,typePayment,limitAvailable)
VALUES
(1,2,'PIX',0);

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
		(1,default,'compra via aplicativo',null,1),
        (2,default,'compra via aplicativo',50,0),
        (3,'Confirmado',null,null,1),
        (4,default,'compra via web site',150,0);
        
INSERT INTO delivery
(idOrder, trackingCode, deliveryStatus)
VALUES
(1,'BR123456789','Entregue'),
(2,'BR987654321','Em Transporte'),
(3,'BR456123789','Preparando Envio');
              
INSERT INTO productOrder
(idPOproduct, idPOorder, poQuantity, poStatus)
VALUES
(1,1,2,NULL),
(2,1,1,NULL),
(3,2,1,NULL);        

insert into productStorage (storageLocation, quantity) values
		('Rio de Janeiro',1000),
        ('Rio de Janeiro',500),
        ('São Paulo',10),
        ('São Paulo',100),
        ('São Paulo',10),
        ('Brasilia',60);
        
insert into storageLocation (idLproduct, idLstorage, location) values
		(1,1,'RJ'),
(2,2,'RJ'),
(3,3,'SP'),
(4,4,'SP'),
(5,5,'SP'),
(6,6,'GO');
        
insert into supplier
(SocialName, CNPJ, contact)
values
('Almeida e filhos','12345678912345','21985474'),
('Eletrônicos Silva','85451964914345','21985484'),
('Eletrônicos Valma','93456789393469','21975474');

insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
		(1,1,500),
(1,2,400),
(2,3,633),
(3,4,5),
(2,5,10);
        
insert into seller
(SocialName, AbstName, CNPJ, CPF, location, contact)
values
('Tech eletronics',null,'12345678945632',null,'Rio de Janeiro','219946287'),
('Botique Durgas',null,null,'12345678311','Rio de Janeiro','219567895'),
('Kids World',null,'45678912365448',null,'São Paulo','1198657484');

insert into productSeller (idPseller, idPproduct, prodQuantity) values
		(1,1,80),
(2,2,10);

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
		(2,default,'compra via aplicativo',null,1);

/*
====================================================
4. CONSULTAS SQL
====================================================
*/

/*
As consultas abaixo foram desenvolvidas para atender
aos requisitos do desafio e responder perguntas de
negócio relacionadas ao cenário de e-commerce.
*/
        
/*
Pergunta:
Quantos pedidos cada cliente realizou?
*/

SELECT
    c.Fname,
    c.Lname,
    COUNT(o.idOrder) AS TotalPedidos
FROM clients c
INNER JOIN orders o
ON c.idClient = o.idOrderClient
GROUP BY c.idClient;

/*
Pergunta:
Clientes com mais de um pedido.
*/

SELECT
    c.Fname,
    COUNT(o.idOrder) AS TotalPedidos
FROM clients c
INNER JOIN orders o
ON c.idClient = o.idOrderClient
GROUP BY c.idClient
HAVING COUNT(o.idOrder) > 1;

/*
Pergunta:
Relação entre produtos e fornecedores.
*/

SELECT
    p.Pname,
    s.SocialName
FROM product p
INNER JOIN productSupplier ps
ON p.idProduct = ps.idPsProduct
INNER JOIN supplier s
ON ps.idPsSupplier = s.idSupplier;

/*
Pergunta:
Classificação de frete.
*/

SELECT
    idOrder,
    sendValue,
    CASE
        WHEN sendValue > 100 THEN 'Frete Alto'
        ELSE 'Frete Normal'
    END AS CategoriaFrete
FROM orders;

/*
Pergunta:
Frete com taxa adicional.
*/

SELECT
    idOrder,
    sendValue,
    sendValue * 1.1 AS FreteComTaxa
FROM orders;

/*
Pergunta:
Clientes ordenados alfabeticamente.
*/

SELECT
    Fname,
    Lname
FROM clients
ORDER BY Fname;

/*
Pergunta:
Acompanhamento das entregas.
*/

SELECT
    o.idOrder,
    d.trackingCode,
    d.deliveryStatus
FROM orders o
INNER JOIN delivery d
    ON o.idOrder = d.idOrder
ORDER BY o.idOrder;

/*
Pergunta:
Produtos, fornecedores e estoque.
*/

SELECT
    p.Pname AS Produto,
    s.SocialName AS Fornecedor,
    ps.quantity AS QuantidadeFornecedor,
    st.quantity AS QuantidadeEstoque
FROM product p
INNER JOIN productSupplier ps
    ON p.idProduct = ps.idPsProduct
INNER JOIN supplier s
    ON ps.idPsSupplier = s.idSupplier
INNER JOIN storageLocation sl
    ON p.idProduct = sl.idLproduct
INNER JOIN productStorage st
    ON sl.idLstorage = st.idProdStorage;

/*
Pergunta:
Identificar clientes PF e PJ.
*/

SELECT
    c.idClient,
    c.Fname,
    c.Lname,
    c.clientType
FROM clients c
ORDER BY c.clientType;

/*
Pergunta:
Algum vendedor também é fornecedor?
*/

SELECT
    s.SocialName AS Fornecedor,
    se.SocialName AS Vendedor
FROM supplier s
INNER JOIN seller se
    ON s.CNPJ = se.CNPJ;
    
/*
====================================================
FIM DO PROJETO
====================================================
*/