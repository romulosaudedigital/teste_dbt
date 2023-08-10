
{{ config(materialized='table') }}

with source_especialidade as (

    select * from (SELECT nome_do_usuario, COUNT(*) as quantidade_post
    FROM {{source('prescricao', 'df_sanofi_doencas_keywords')}}
    where tipo_de_conteudo = 'POST'
    group by nome_do_usuario
    order by quantidade_post)as subquery_alias
    where quantidade_post > 20
)

select *
from source_especialidade
