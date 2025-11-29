CREATE TABLE IF NOT EXISTS geo.topography (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    link_data_source BIGINT REFERENCES import.data_source(id),
    area GEOMETRY(MULTIPOLYGON, 4326),
    raster_file BYTEA,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_geo_topography_link_site ON geo.topography (link_site);
CREATE INDEX IF NOT EXISTS idx_geo_topography_link_data_source ON geo.topography (link_data_source);
CREATE INDEX IF NOT EXISTS idx_geo_topography_created_at ON geo.topography (created_at);
CREATE INDEX IF NOT EXISTS idx_geo_topography_owner_user_id ON geo.topography (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_geo_topography_area ON geo.topography USING GIST(area);

COMMENT ON TABLE geo.topography IS 'Топографические данные, рельеф и цифровые модели местности.';
COMMENT ON COLUMN geo.topography.id IS 'PK топографии.';
COMMENT ON COLUMN geo.topography.link_site IS 'FK на участок.';
COMMENT ON COLUMN geo.topography.link_data_source IS 'FK на источник данных.';
COMMENT ON COLUMN geo.topography.area IS 'Область охвата (MultiPolygon), GIST индекс.';
COMMENT ON COLUMN geo.topography.raster_file IS 'Растровый файл с данными рельефа (bytea).';
COMMENT ON COLUMN geo.topography.metadata IS 'JSON с дополнительной информацией.';
COMMENT ON COLUMN geo.topography.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.topography.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN geo.topography.owner_user_id IS 'ID пользователя создавшего запись.';