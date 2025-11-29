CREATE TABLE IF NOT EXISTS igt.borehole (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    location GEOMETRY(POINTZ, 4326),
    link_list_borehole_type BIGINT REFERENCES ref.list_borehole_type(id),
    depth_min DOUBLE PRECISION,
    depth_max DOUBLE PRECISION,
    link_list_borehole_standard BIGINT REFERENCES ref.list_borehole_standard(id),
    date_start TIMESTAMPTZ,
    date_end TIMESTAMPTZ,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_link_site ON igt.borehole (link_site);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_link_type ON igt.borehole (link_list_borehole_type);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_link_standard ON igt.borehole (link_list_borehole_standard);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_date_start ON igt.borehole (date_start);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_date_end ON igt.borehole (date_end);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_owner_user_id ON igt.borehole (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_location ON igt.borehole USING GIST(location);

COMMENT ON TABLE igt.borehole IS 'Выработка, фиксирует точки бурения.';
COMMENT ON COLUMN igt.borehole.id IS 'PK выработки.';
COMMENT ON COLUMN igt.borehole.link_site IS 'FK на участок.';
COMMENT ON COLUMN igt.borehole.location IS 'Координаты бурения (pointZ), GIST индекс.';
COMMENT ON COLUMN igt.borehole.link_list_borehole_type IS 'FK на тип скважины.';
COMMENT ON COLUMN igt.borehole.depth_min IS 'Минимальная глубина.';
COMMENT ON COLUMN igt.borehole.depth_max IS 'Максимальная глубина.';
COMMENT ON COLUMN igt.borehole.link_list_borehole_standard IS 'FK на стандарт скважины.';
COMMENT ON COLUMN igt.borehole.date_start IS 'Дата начала бурения.';
COMMENT ON COLUMN igt.borehole.date_end IS 'Дата окончания бурения.';
COMMENT ON COLUMN igt.borehole.metadata IS 'JSON с дополнительными данными.';
COMMENT ON COLUMN igt.borehole.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN igt.borehole.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN igt.borehole.owner_user_id IS 'ID пользователя создавшего выработку.';