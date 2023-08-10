
{{ config(materialized='table') }}

with source_especialidade as (

    select * from (SELECT nome_do_usuario, tipo_de_conteudo, COUNT(*) as Quantidade
    FROM {{source('prescricao', 'df_sanofi_doencas_keywords')}}
    where tipo_de_conteudo = 'POST'
    group by nome_do_usuario, tipo_de_conteudo
    order by quantidade)as subquery_alias
    where quantidade > 20
)

select *
from source_especialidade
