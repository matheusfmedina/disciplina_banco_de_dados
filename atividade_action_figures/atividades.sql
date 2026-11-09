# Quais os produtos foram vendidos entre os dias 01/01/2020 e 31/07/2020

SELECT p.desc_produto, pe.dt_pedido
FROM produto p
JOIN item_pedido ip
    ON p.cd_produto = ip.cd_produto
JOIN pedido pe
	ON ip.nr_pedido = pe.nr_pedido
WHERE pe.dt_pedido BETWEEN "2020-01-01" AND "2020-07-31";

# Qual forma de pagamento mais utilizada?

SELECT fp.desc_forma_pag,
	COUNT(pe.cd_forma_pag) AS quantidade
FROM formas_pagamento fp
JOIN pedido pe
	ON fp.cd_forma_pag = pe.cd_forma_pag
GROUP BY fp.cd_forma_pag, fp.desc_forma_pag
ORDER BY quantidade DESC LIMIT 1;

# Qual forma de pagamento gerou mais receita?

SELECT fp.desc_forma_pag,
	SUM(ip.preco_item * ip.qnt_item_pedido) AS total_preco
FROM formas_pagamento fp
JOIN pedido pe
	ON fp.cd_forma_pag = pe.cd_forma_pag
JOIN item_pedido ip
	ON pe.nr_pedido = ip.nr_pedido
GROUP BY fp.desc_forma_pag
ORDER BY total_preco DESC LIMIT 1;

# Qual vendedor concretizou mais vendas em cada mês de 2019?

(SELECT v.nm_vendedor,
	COUNT(pe.cd_vendedor) AS quantidade
FROM vendedor v
JOIN pedido pe
	ON v.cd_vendedor = pe.cd_vendedor
GROUP BY v.nm_vendedor)vendedor