-- Tabela Clientes
CREATE TABLE clientes (
    cli_CPF VARCHAR(11) PRIMARY KEY,
    cli_Nome VARCHAR(100) NOT NULL
);

-- Tabela Carros
CREATE TABLE carros (
    cr_modelo VARCHAR(50) PRIMARY KEY,
    cr_anoLancamento INT NOT NULL
);

-- Tabela Vendas
CREATE TABLE vendas (
    vd_idVenda INT AUTO_INCREMENT PRIMARY KEY,
    vd_cpfCliente VARCHAR(11) NOT NULL,
    vd_modeloCarro VARCHAR(50) NOT NULL,
    vd_dataVenda DATE NOT NULL,
    FOREIGN KEY (vd_cpfCliente) REFERENCES clientes(cli_CPF),
    FOREIGN KEY (vd_modeloCarro) REFERENCES carros(cr_modelo)
);
--------------------------------------------------------------------------------------

2. Quantidade de vendas do carro Marea:
SELECT COUNT(*) AS TotalVendasMarea
FROM vendas
WHERE vd_modeloCarro = 'Marea';

---------------------------------------------------------------------------------------
3. Quantidade de vendas do carro Uno por cliente
SELECT 
    v.vd_cpfCliente AS CPF,
    c.cli_Nome AS Nome,
    COUNT(*) AS TotalVendasUno
FROM vendas v
JOIN clientes c ON c.cli_CPF = v.vd_cpfCliente
WHERE v.vd_modeloCarro = 'Uno'
GROUP BY v.vd_cpfCliente, c.cli_Nome;

4. Quantidade de clientes que não efetuaram venda
SELECT COUNT(*) AS ClientesSemVenda
FROM clientes c
LEFT JOIN vendas v ON v.vd_cpfCliente = c.cli_CPF
WHERE v.vd_idVenda IS NULL;

------------------------------------------------------------------------------------------
5. Clientes sorteados (15 primeiros conforme as regras)

SELECT DISTINCT TOP 5 c.cli_CPF, c.cli_Nome
FROM clientes c
JOIN vendas v ON v.vd_cpfCliente = c.cli_CPF
JOIN carros cr ON cr.cr_modelo = v.vd_modeloCarro
WHERE 
    c.cli_CPF LIKE '0%' -- CPF começa com 0
    AND cr.cr_anoLancamento = 2021 -- Ano do carro
    AND c.cli_CPF NOT IN ( -- Exclui clientes azarados que compraram mais de um Marea
        SELECT vd_cpfCliente
        FROM vendas
        WHERE vd_modeloCarro = 'Marea'
        GROUP BY vd_cpfCliente
        HAVING COUNT(*) > 1
    )
ORDER BY v.vd_dataVenda;


6. Excluir todas as vendas que não são dos clientes sorteados, sem usar IN
WITH Sorteados AS (
    SELECT DISTINCT TOP 15 c.cli_CPF
    FROM clientes c
    JOIN vendas v ON v.vd_cpfCliente = c.cli_CPF
    JOIN carros cr ON cr.cr_modelo = v.vd_modeloCarro
    WHERE 
        c.cli_CPF LIKE '0%'
        AND cr.cr_anoLancamento = 2021
        AND c.cli_CPF NOT IN (
            SELECT vd_cpfCliente
            FROM vendas
            WHERE vd_modeloCarro = 'Marea'
            GROUP BY vd_cpfCliente
            HAVING COUNT(*) > 1
        )
    ORDER BY v.vd_dataVenda
)

DELETE v
FROM vendas v
LEFT JOIN Sorteados s ON s.cli_CPF = v.vd_cpfCliente
WHERE s.cli_CPF IS NULL;





