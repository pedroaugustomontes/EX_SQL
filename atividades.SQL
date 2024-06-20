CREATE TABLE IF NOT EXISTS CLIENTES(
	ID SERIAL NOT NULL,
	nome VARCHAR(120) NOT NULL,
	email VARCHAR(120) UNIQUE NOT NULL,
	telefone VARCHAR(11) NOT NULL,
	idade INT NOT NULL,
	CONSTRAINT CLIENTE_PK PRIMARY KEY(ID)
)

CREATE TABLE IF NOT EXISTS PRODUTOS(
	id SERIAL NOT NULL,
	nome VARCHAR(255) NOT NULL,
	preco NUMERIC(10,2) NOT NULL,
	quantidade INT NOT NULL,
	CONSTRAINT PRODUTOS_PK PRIMARY KEY(ID)
)

CREATE TABLE IF NOT EXISTS VENDAS(
	ID SERIAL,
	ID_PRODUTO INT NOT NULL,
	ID_CLIENTE INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	CONSTRAINT VENDAS_PK PRIMARY KEY(ID),
	CONSTRAINT ID_PRODUTO_FK FOREIGN KEY(ID_PRODUTO) REFERENCES PRODUTOS(ID),
	CONSTRAINT ID_CLIENTE_FK FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTES(ID)
)

--### Desafios de `INSERT`
-- 1. **Adicionar um novo cliente**:
--    - Adicione um novo cliente com os seguintes dados: nome, email, telefone e idade.
--Adicionando um novo cliente: 
INSERT INTO clientes (nome, email, telefone, idade) VALUES ('Romulo Nogueira de Souza', 'nogueirainclusivedev@desenvolvedor.com', '9999-9999', 39);
INSERT INTO clientes (nome, email, telefone, idade) VALUES ('Pedro Augusto Montes Sales', 'pedro.montesales@gmail.com', '9999-8888', 29);
INSERT INTO clientes (nome, email, telefone, idade) VALUES ('Pedro Augusto Montes Sales', 'nerdindiano@gmail.com', '9999-8888', 29);
SELECT * FROM CLIENTES

-- 2. **Adicionar um novo produto**:
--    - Adicione um novo produto com os seguintes dados: nome, preço e quantidade.
--Adicionando um novo produto: 
INSERT INTO produtos (nome, preco, quantidade) VALUES ('Vassoura de Curling', 100.00, 100);
INSERT INTO produtos (nome, preco, quantidade) VALUES ('Oura Ring', 3499.99, 1);
INSERT INTO produtos (nome, preco, quantidade) VALUES ('S24 Plus', 3299.99, 2);
INSERT INTO produtos (nome, preco, quantidade) VALUES ('S23 Ultra', 3299.99, 3);
SELECT * FROM PRODUTOS
	
-- 3. **Adicionar um novo item de venda**:
--    - Adicione um novo item de venda relacionando um produto e um cliente existentes com uma quantidade específica.
--Adicionando um novo item de venda:
INSERT INTO VENDAS(ID_PRODUTO, ID_CLIENTE, QUANTIDADE) VALUES (1, 1, 2)
INSERT INTO VENDAS(ID_PRODUTO, ID_CLIENTE, QUANTIDADE) VALUES (2, 2, 5)
SELECT * FROM VENDAS

--### Desafios de `UPDATE`
--Atualizar o telefone de um cliente
UPDATE CLIENTES SET TELEFONE = '9999-7777' WHERE EMAIL = 'pedro.montesales@gmail.com'

--Atualizar o preço e a quantidade de um produto
UPDATE PRODUTOS SET PRECO = '2999.99', QUANTIDADE = '2' WHERE NOME = 'Oura Ring'

--Atualizar a quantidade de um item de venda
UPDATE VENDAS SET QUANTIDADE = 16 WHERE ID = '2'

-- ### Desafios de `DELETE ###`
-- 7. **Deletar um cliente específico**:
--    - Delete um cliente específico usando seu email como referência.
DELETE FROM CLIENTES WHERE EMAIL = 'nerdindiano@gmail.com'
	
-- 8. **Deletar um produto específico**:
--    - Delete um produto específico usando o nome do produto como referência.
DELETE FROM PRODUTOS WHERE NOME = 'S24 Plus'
	
-- 9. **Deletar um item de venda específico**:
--    - Delete um item de venda específico usando seu ID como referência.
DELETE FROM PRODUTOS WHERE ID = '5'

-- ### Desafios de Criação de `VIEWS ###`
-- 10. **Criar uma view que exibe todos os clientes com suas respectivas idades e telefones**:
--     - Crie uma view que mostra o nome, idade e telefone de todos os clientes.
CREATE OR REPLACE VIEW VIEW_CLIENTES AS
	SELECT
		C.NOME AS Nome,
		C.IDADE AS Idade,
		C.TELEFONE AS Telefone
	FROM CLIENTES C
		GROUP BY
		Nome,
		Telefone,
		Idade

SELECT * FROM VIEW_CLIENTES
	
-- 11. **Criar uma view que exibe todos os produtos com seus preços e quantidades em estoque**:
--     - Crie uma view que mostra o nome, preço e quantidade de todos os produtos.
CREATE OR REPLACE VIEW VIEW_PRODUTOS AS
	SELECT 
		P.NOME AS Produto,
		P.PRECO AS Preço,
		P.QUANTIDADE AS Estoque
	FROM PRODUTOS P
		GROUP BY
			Produto,
			Preço,
			Estoque;
	
SELECT * FROM VIEW_PRODUTOS
	
-- 12. **Criar uma view que exibe o total vendido por cada cliente**:
--     - Crie uma view que mostra o nome do cliente e o total vendido por ele.
CREATE OR REPLACE VIEW VIEW_VENDAS AS
	SELECT
		C.NOME AS Comprador,
		SUM(V.QUANTIDADE * P.PRECO) AS Total
	FROM VENDAS V
	JOIN PRODUTOS P ON P.ID = V.ID_PRODUTO
	JOIN CLIENTES C ON C.ID = V.ID_CLIENTE
	GROUP BY C.NOME

SELECT * FROM VIEW_VENDAS ORDER BY TOTAL
-- ### Desafios Adicionais

-- 13. **Adicionar um novo cliente e uma nova compra para esse cliente**:
--     - Adicione um novo cliente com dados fictícios.
INSERT INTO CLIENTES(NOME, EMAIL, TELEFONE, IDADE) VALUES ('GISELE DAMACENO', 'GISELERAPINHA@GMAIL.COM', '99585-9952', 26)
SELECT * FROM CLIENTES WHERE NOME = 'GISELE DAMACENO'
--     - Adicione um novo item de venda para esse cliente relacionando um produto existente.
INSERT INTO VENDAS(ID_CLIENTE, ID_PRODUTO, QUANTIDADE) VALUES (5, 6, 4)
SELECT * FROM VENDAS WHERE ID_CLIENTE = 5

-- 14. **Atualizar o nome e o email de um cliente específico**:
--     - Atualize o nome e o email de um cliente usando seu ID como referência.
UPDATE CLIENTES SET NOME = 'Gisele Rapinha', EMAIL = 'rapinhagi@gmail.com' WHERE ID = '5'
SELECT * FROM CLIENTES WHERE ID = 5
-- 15. **Deletar todos os itens de venda de um produto específico**:
--     - Delete todos os itens de venda de um produto específico usando o código do produto como referência.
DELETE FROM VENDAS WHERE ID_PRODUTO = 1
SELECT * FROM VENDAS

-- ***** LISTA 02 - VALENDO ************

-- 16. **Adicionar múltiplos clientes**:
--    - Adicione três novos clientes com dados fictícios em uma única instrução `INSERT`.
INSERT INTO CLIENTES(NOME, EMAIL, TELEFONE, IDADE) VALUES 
('Cliente A', 'clientea@example.com', '9999-0001', 30),
('Cliente B', 'clienteb@example.com', '9999-0002', 35),
('Cliente C', 'clientec@example.com', '9999-0003', 40);
SELECT * FROM CLIENTES

-- 17. **Adicionar múltiplos produtos**:
--    - Adicione dois novos produtos com dados fictícios em uma única instrução `INSERT
INSERT INTO PRODUTOS(NOME, PRECO, QUANTIDADE) VALUES
('Produto PANTANOSO', 200.00, 20),
('Produto BOLADO', 300.00, 30);
SELECT * FROM PRODUTOS

-- 18. **Adicionar múltiplos itens de venda**:
--    - Adicione três novos itens de venda relacionando diferentes produtos e clientes existentes em uma única instrução `INSERT`.
INSERT INTO VENDAS(ID_PRODUTO, ID_CLIENTE, QUANTIDADE) VALUES
(6, 8, 5),
(8, 5, 10),
(9, 6, 7);
SELECT * FROM VENDAS

-- ### Desafios de `UPDATE ###`

-- 19. **Atualizar a idade de todos os clientes acima de 30 anos**:
--    - Aumente a idade de todos os clientes que têm mais de 30 anos em 1 ano.
UPDATE CLIENTES SET IDADE = IDADE + 1 WHERE IDADE > 25;

-- 20. **Atualizar o preço de todos os produtos com quantidade menor que 10**:
--    - Aumente o preço de todos os produtos com quantidade menor que 10 em 10%.
UPDATE PRODUTOS SET PRECO = PRECO * 1.10 WHERE QUANTIDADE > 10;

-- 21. **Atualizar o nome de todos os produtos para incluir uma palavra-chave**:
--    - Adicione a palavra "Promoção" ao início do nome de todos os produtos.
UPDATE PRODUTOS SET NOME = 'PROMOÇÃO ' || NOME

-- ### Desafios de `DELETE`

-- 22. **Deletar todos os clientes com idade menor que 18 anos**:
--    - Delete todos os clientes que têm menos de 18 anos.
INSERT INTO CLIENTES(NOME, EMAIL, TELEFONE, IDADE) VALUES ('Cliente Z', 'clienteZ@example.com', '9999-0003', 17);
INSERT INTO CLIENTES(NOME, EMAIL, TELEFONE, IDADE) VALUES ('Cliente X', 'clienteX@example.com', '9999-0003', 16);
DELETE FROM CLIENTES WHERE IDADE < 18;

-- 23. **Deletar todos os produtos com preço maior que 50**:
--    - Delete todos os produtos cujo preço é maior que 50.
DELETE FROM PRODUTOS WHERE PRECO > 50;

-- 24. **Deletar todos os itens de venda de clientes específicos**:
--    - Delete todos os itens de venda de clientes com email específico.
DELETE FROM VENDAS WHERE ID_CLIENTE IN(SELECT * FROM CLIENTES WHERE EMAIL = 'pedro.montesales@gmail.com')

-- ### Desafios de Criação de `VIEWS`
-- 25. **Criar uma view que exibe o estoque total de produtos vendidos**:
--     - Crie uma view que mostra o nome do produto e o total vendido em relação ao estoque.
CREATE OR REPLACE VIEW ESTOQUE_TOTAL_PRODUTOS_VENDIDOS AS
	SELECT
		P.NOME AS PRODUTO,
		P.QUANTIDADE AS ESTOQUE,
		COALESCE(SUM(V.QUANTIDADE), 0) AS VENDIDO
	FROM PRODUTOS P
		LEFT JOIN VENDAS V ON P.ID = V.ID_PRODUTO
		GROUP BY P.NOME, P.QUANTIDADE

SELECT * FROM ESTOQUE_TOTAL_PRODUTOS_VENDIDOS;
-- 26. **Criar uma view que exibe os clientes que não fizeram compras**:
--     - Crie uma view que mostra o nome e email dos clientes que não têm itens de venda associados.
CREATE OR REPLACE VIEW CLIENTES_SEM_COMPRAS AS 
SELECT NOME, EMAIL FROM CLIENTES  
WHERE id NOT IN (SELECT DISTINCT ID_CLIENTE FROM VENDAS); 

SELECT * FROM CLIENTES_SEM_COMPRAS;
-- 27. **Criar uma view que exibe os produtos não vendidos**:
--     - Crie uma view que mostra o nome e preço dos produtos que não foram vendidos (quantidade de vendas igual a zero).
CREATE OR REPLACE VIEW PRODUTOS_NAO_VENDIDOS AS
SELECT NOME, PRECO FROM PRODUTOS
WHERE ID NOT IN (SELECT DISTINCT ID_PRODUTO FROM VENDAS)

SELECT * FROM PRODUTOS_NAO_VENDIDOS

-- ### Desafios Adicionais ###
-- 28. **Adicionar uma nova coluna em uma tabela e atualizar dados**:
--     - Adicione uma nova coluna `data_de_cadastro` à tabela `clientes` e preencha-a com a data atual para todos os clientes.
ALTER TABLE CLIENTES ADD COLUMN data_de_cadastro DATE; 

UPDATE CLIENTES SET data_de_cadastro = CURRENT_DATE; 
SELECT * FROM CLIENTES

-- 29. **Atualizar o preço dos produtos com base em uma condição**:
--     - Aumente o preço de todos os produtos em 5% se a quantidade em estoque for menor que 20.
UPDATE PRODUTOS SET PRECO = PRECO * 1.05 WHERE QUANTIDADE < 20;

-- 30. **Deletar registros duplicados em uma tabela**:
--     - Encontre e delete registros duplicados na tabela `clientes`, mantendo apenas um registro por cliente com base no email.
DELETE FROM CLIENTES WHERE ID NOT IN(SELECT MIN(ID) FROM CLIENTES GROUP BY EMAIL); 

-- 31. **Criar uma view que exibe a média de vendas por produto**:
--     - Crie uma view que mostra o nome do produto e a média de itens vendidos por produto.
CREATE OR REPLACE VIEW media_vendas_por_produto AS  
SELECT p.nome, AVG(V.quantidade) AS media_vendas  
FROM produtos p  
JOIN VENDAS V ON p.id = V.ID_PRODUTO  
GROUP BY p.nome; 

-- 32. **Adicionar um novo cliente e realizar múltiplas compras para esse cliente**:
--     - Adicione um novo cliente com dados fictícios.
--     - Adicione três novos itens de venda para esse cliente, relacionando diferentes produtos.
CREATE OR REPLACE VIEW media_vendas_por_produto AS  
SELECT p.nome, AVG(V.quantidade) AS media_vendas  
FROM produtos p  
JOIN VENDAS V ON p.id = V.ID_PRODUTO 
GROUP BY p.nome; 

-- 33. **Atualizar o email de todos os clientes para um novo domínio**:
--     - Atualize o email de todos os clientes para um novo domínio, por exemplo, mude `@example.com` para `@novodominio.com`.
UPDATE CLIENTES SET EMAIL = REPLACE(email, '@gmail.com', '@devfodastico.com');

-- 34. **Deletar produtos que não foram vendidos nos últimos 6 meses**:
--     - Delete todos os produtos que não têm itens de venda associados nos últimos 6 meses.
ALTER TABLE VENDAS ADD COLUMN data_venda DATE;
DELETE FROM PRODUTOS
WHERE id NOT IN (
    SELECT DISTINCT ID_PRODUTO
    FROM VENDAS
    WHERE data_venda >= CURRENT_DATE - INTERVAL '6 months'
);

-- 35. **Criar uma view que exibe a proporção de vendas por cliente**:
--     - Crie uma view que mostra o nome do cliente e a proporção do total de vendas em relação ao total de vendas de todos os clientes.
CREATE OR REPLACE VIEW proporcao_vendas_por_cliente AS
SELECT 
    c.nome AS nome_cliente,
    SUM(v.quantidade * p.preco) AS total_vendas_cliente,
    SUM(SUM(v.quantidade * p.preco)) OVER () AS total_vendas_geral,
    (SUM(v.quantidade * p.preco) / SUM(SUM(v.quantidade * p.preco)) OVER ()) * 100 AS proporcao_vendas
FROM 
    clientes c
JOIN 
    vendas v ON c.id = v.id_cliente
JOIN 
    produtos p ON v.id_produto = p.id
GROUP BY 
    c.nome;