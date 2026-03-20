-- O dataset só tinha o cep, mas não região e estado, criamos dados ficticios para treino

-- Criando coluna ESTADO:

alter table vendas_dio
add column Estado varchar(20) after CEP_Entrega; 

-- Preenchendo Estado com base no CEP

update vendas_dio
set Estado = case
    when left(CEP_Entrega,2) between '01' AND '19' THEN 'SP'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '20' AND '28' THEN 'RJ'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '29' AND '29' THEN 'ES'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '30' AND '39' THEN 'MG'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '40' AND '48' THEN 'BA'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '49' AND '49' THEN 'SE'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '50' AND '56' THEN 'PE'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '57' AND '57' THEN 'AL'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '58' AND '59' THEN 'PB'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '60' AND '63' THEN 'CE'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '64' AND '64' THEN 'PI'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '65' AND '69' THEN 'MA'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '70' AND '73' THEN 'DF'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '74' AND '76' THEN 'GO'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '77' AND '79' THEN 'TO'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '80' AND '87' THEN 'PR'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '88' AND '89' THEN 'SC'
    WHEN LEFT(CEP_Entrega, 2) BETWEEN '90' AND '99' THEN 'RS'
    ELSE 'NA'
END;

-- Criar coluna REGIÃO (Norte, Nordeste, Sul, Sudeste, Centro-Oeste)

alter table vendas_dio
add column Regiao varchar (20) after estado;

-- Preenchendo por regiao

update vendas_dio
set Regiao = case
WHEN Estado IN ('SP','RJ','MG','ES') THEN 'Sudeste'
    WHEN Estado IN ('PR','SC','RS') THEN 'Sul'
    WHEN Estado IN ('DF','GO','MT','MS','TO') THEN 'Centro-Oeste'
    WHEN Estado IN ('BA','SE','AL','PE','PB','RN','CE','PI','MA') THEN 'Nordeste'
    WHEN Estado IN ('AM','PA','AP','RO','RR','AC') THEN 'Norte'
    ELSE 'NA'
END;

-- Agora podemos saber as vendas por Estado

select Estado, sum(Preco * Quantidade) as Total
from vendas_dio
group by Estado
order by Total desc;

-- Vendas por Regiao

select Regiao, sum(Preco * Quantidade) as Total
from vendas_dio
group by Regiao
order by Total desc;


-- Consulta por Estado e Regiao para grafico simples no excel:

SELECT 
    Estado,
    Regiao,
    SUM(Preco * Quantidade) AS Total
FROM vendas_dio
GROUP BY Estado, Regiao
ORDER BY Total DESC;





