CREATE TABLE IF NOT EXISTS geo.bim_model (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    format TEXT,
    file_data BYTEA,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_geo_bim_model_link_site ON geo.bim_model (link_site);
CREATE INDEX IF NOT EXISTS idx_geo_bim_model_created_at ON geo.bim_model (created_at);

COMMENT ON TABLE geo.bim_model IS 'BIM/CAD модели, пространственно привязанные цифровые модели.';
COMMENT ON COLUMN geo.bim_model.id IS 'PK BIM-модели.';
COMMENT ON COLUMN geo.bim_model.link_site IS 'FK на участок.';
COMMENT ON COLUMN geo.bim_model.format IS 'Формат файла модели (IFC, 3DTILES, DWG, DXF, DGN).';
COMMENT ON COLUMN geo.bim_model.file_data IS 'Бинарные данные модели (bytea).';
COMMENT ON COLUMN geo.bim_model.metadata IS 'JSON с дополнительными параметрами модели.';
COMMENT ON COLUMN geo.bim_model.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.bim_model.updated_at IS 'Дата обновления записи.';