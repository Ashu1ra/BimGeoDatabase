CREATE TABLE IF NOT EXISTS geo.project (
    id BIGSERIAL PRIMARY KEY,
    link_list_region BIGINT REFERENCES ref.list_region(id),
    name TEXT NOT NULL,
    link_data_source BIGINT REFERENCES import.data_source(id),
    center_location GEOMETRY(POINTZ, 4326),
    area GEOMETRY(MULTIPOLYGON, 4326),
    date_start TIMESTAMPTZ,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_geo_project_link_list_region ON geo.project (link_list_region);
CREATE INDEX IF NOT EXISTS idx_geo_project_created_at ON geo.project (created_at);
CREATE INDEX IF NOT EXISTS idx_geo_project_owner_user_id ON geo.project (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_geo_project_center_location ON geo.project USING GIST(center_location);
CREATE INDEX IF NOT EXISTS idx_geo_project_area ON geo.project USING GIST(area);

COMMENT ON TABLE geo.project IS 'Проект, объединяет данные по территории и источникам.';
COMMENT ON COLUMN geo.project.id IS 'PK проекта.';
COMMENT ON COLUMN geo.project.link_list_region IS 'FK на регион проекта.';
COMMENT ON COLUMN geo.project.name IS 'Название проекта.';
COMMENT ON COLUMN geo.project.link_data_source IS 'FK на источник проекта.';
COMMENT ON COLUMN geo.project.center_location IS 'Координата центра проекта (pointZ), GIST индекс.';
COMMENT ON COLUMN geo.project.area IS 'Область охвата проекта (MultiPolygon), GIST индекс.';
COMMENT ON COLUMN geo.project.date_start IS 'Дата начала проекта.';
COMMENT ON COLUMN geo.project.description IS 'Описание проекта, может быть NULL.';
COMMENT ON COLUMN geo.project.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.project.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN geo.project.owner_user_id IS 'ID пользователя создавшего проект.';