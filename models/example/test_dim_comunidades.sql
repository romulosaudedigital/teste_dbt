{{ config(
    materialized='table',
    unique_key='id',
    tags=['dimensao', 'comunidades']
) }}

WITH comunidades_ativas AS (
    SELECT
        c.name,
        c.id,
        c.created_at,
        c.deleted_at,
        CASE WHEN c.deleted_at IS NULL THEN 'Esta ativa' ELSE 'Nao esta Ativo' END AS indica_ativa
    FROM {{ source('sdconecta', 'client') }} c
    WHERE c.published = TRUE
)

SELECT * FROM comunidades_ativas