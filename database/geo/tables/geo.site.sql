CREATE TABLE IF NOT EXISTS geo.site (
    id BIGSERIAL PRIMARY KEY,
    link_project BIGINT REFERENCES geo.project(id),
    name TEXT NOT NULL,
    area GEOMETRY(POLYGON, 4326),
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_geo_site_link_project ON geo.site (link_project);
CREATE INDEX IF NOT EXISTS idx_geo_site_created_at ON geo.site (created_at);
CREATE INDEX IF NOT EXISTS idx_geo_site_owner_user_id ON geo.site (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_geo_site_area ON geo.site USING GIST(area);

COMMENT ON TABLE geo.site IS 'Участок, границы и пространственная привязка.';
COMMENT ON COLUMN geo.site.id IS 'PK участка.';
COMMENT ON COLUMN geo.site.link_project IS 'FK на проект.';
COMMENT ON COLUMN geo.site.name IS 'Название участка.';
COMMENT ON COLUMN geo.site.area IS 'Область охвата участка (Polygon), GIST индекс.';
COMMENT ON COLUMN geo.site.description IS 'Описание участка, может быть NULL.';
COMMENT ON COLUMN geo.site.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.site.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN geo.site.owner_user_id IS 'ID пользователя создавшего участок.';