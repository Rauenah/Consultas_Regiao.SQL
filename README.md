# 📄 **README — Análise de Vendas por Estado e Região (SQL + Excel)**

## 📌 Visão Geral
Este projeto tem como objetivo praticar consultas SQL e análise de dados utilizando um dataset fictício de vendas de marketplace.  
O dataset original continha informações como produto, preço, quantidade, marketplace, forma de pagamento, CEP de entrega e avaliação do cliente.  
Porém, **não incluía as colunas de Estado e Região**, que foram criadas e preenchidas manualmente via SQL para enriquecer a análise.

Após o tratamento no banco, os resultados foram exportados e visualizados em gráficos simples no Excel.

---

# 🗂️ 1. Dataset Utilizado

O arquivo utilizado neste projeto é:

```
dataset_marketplace.csv
```

### ✔ O dataset foi limpo antes de subir:
- Importado no Excel usando **UTF‑8 (65001)**  
- Delimitado corretamente por **ponto e vírgula**  
- Colunas separadas e organizadas  
- Acentuação corrigida  
- Nenhuma linha quebrada ou desformatada  

O arquivo está pronto para uso e reprodutibilidade.

---

# 🛠️ 2. Criação da Coluna **Estado**

```sql
ALTER TABLE vendas_dio
ADD COLUMN Estado VARCHAR(20) AFTER CEP_Entrega;
```

### Preenchimento baseado nas faixas de CEP:

```sql
UPDATE vendas_dio
SET Estado = CASE
    WHEN LEFT(CEP_Entrega,2) BETWEEN '01' AND '19' THEN 'SP'
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
```

---

# 🗺️ 3. Criação da Coluna **Região**

```sql
ALTER TABLE vendas_dio
ADD COLUMN Regiao VARCHAR(20) AFTER Estado;
```

### Preenchimento baseado no Estado:

```sql
UPDATE vendas_dio
SET Regiao = CASE
    WHEN Estado IN ('SP','RJ','MG','ES') THEN 'Sudeste'
    WHEN Estado IN ('PR','SC','RS') THEN 'Sul'
    WHEN Estado IN ('DF','GO','MT','MS','TO') THEN 'Centro-Oeste'
    WHEN Estado IN ('BA','SE','AL','PE','PB','RN','CE','PI','MA') THEN 'Nordeste'
    WHEN Estado IN ('AM','PA','AP','RO','RR','AC') THEN 'Norte'
    ELSE 'NA'
END;
```

---

# 📊 4. Consultas de Análise

## ✔ Vendas por Estado

```sql
SELECT Estado, SUM(Preco * Quantidade) AS Total
FROM vendas_dio
GROUP BY Estado
ORDER BY Total DESC;
```

## ✔ Vendas por Região

```sql
SELECT Regiao, SUM(Preco * Quantidade) AS Total
FROM vendas_dio
GROUP BY Regiao
ORDER BY Total DESC;
```

---

# 📈 5. Visualizações no Excel

Após exportar os resultados das consultas em CSV, foram criados gráficos simples no Excel.

### 📌 Gráfico 1 — Vendas por Estado
- Tipo: Colunas  
- Dados: Estado × Total  
- Objetivo: identificar os estados com maior volume de vendas  

### 📌 Gráfico 2 — Vendas por Região
- Tipo: Colunas  
- Dados: Região × Total  
- Objetivo: comparar o desempenho das regiões brasileiras  

Ambos foram organizados em abas separadas dentro da mesma planilha.

---

# 🎯 6. Objetivo do Projeto
Este repositório demonstra:

- Manipulação e enriquecimento de dados via SQL  
- Criação de colunas derivadas (Estado e Região)  
- Uso de regras reais de CEP  
- Consultas agregadas  
- Exportação e visualização no Excel  
- Construção de gráficos simples para análise  

É um exercício completo para quem está desenvolvendo portfólio em SQL e análise de dados.

---

# 🚀 7. Próximos Passos
- Criar gráficos dinâmicos com segmentação  
- Analisar ticket médio, LTV e marketplace  
- Criar dashboard completo no Excel ou Power BI  
- Documentar insights no README  


