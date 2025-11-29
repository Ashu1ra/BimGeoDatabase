CREATE TABLE IF NOT EXISTS geo.city_model (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    format TEXT,
    file_data BYTEA,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_geo_city_model_link_site ON geo.city_model (link_site);
CREATE INDEX IF NOT EXISTS idx_geo_city_model_created_at ON geo.city_model (created_at);

COMMENT ON TABLE geo.city_model IS 'Городская модель, CityGML/GML данные, LOD структура, семантика.';
COMMENT ON COLUMN geo.city_model.id IS 'PK модели.';
COMMENT ON COLUMN geo.city_model.link_site IS 'FK на участок.';
COMMENT ON COLUMN geo.city_model.format IS 'Формат модели (CITYGML, GML).';
COMMENT ON COLUMN geo.city_model.file_data IS 'Бинарные данные модели (bytea).';
COMMENT ON COLUMN geo.city_model.metadata IS 'JSON с дополнительными параметрами модели.';
COMMENT ON COLUMN geo.city_model.created_at IS 'Дата добавления записи.';
COMMENT ON COLUMN geo.city_model.updated_at IS 'Дата последнего обновления.';