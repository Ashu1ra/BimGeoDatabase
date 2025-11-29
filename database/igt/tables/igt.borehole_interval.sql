CREATE TABLE IF NOT EXISTS igt.borehole_interval (
    id BIGSERIAL PRIMARY KEY,
    link_borehole BIGINT REFERENCES igt.borehole(id),
    depth_from DOUBLE PRECISION,
    depth_to DOUBLE PRECISION,
    link_list_borehole_interval_type BIGINT REFERENCES ref.list_borehole_interval_type(id),
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_interval_link_borehole ON igt.borehole_interval (link_borehole);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_interval_owner_user_id ON igt.borehole_interval (owner_user_id);

COMMENT ON TABLE igt.borehole_interval IS 'Интервалы выработки.';
COMMENT ON COLUMN igt.borehole_interval.id IS 'PK интервала.';
COMMENT ON COLUMN igt.borehole_interval.link_borehole IS 'FK на выработку.';
COMMENT ON COLUMN igt.borehole_interval.depth_from IS 'Начальная глубина интервала.';
COMMENT ON COLUMN igt.borehole_interval.depth_to IS 'Конечная глубина интервала.';
COMMENT ON COLUMN igt.borehole_interval.link_list_borehole_interval_type IS 'FK на тип интервала.';
COMMENT ON COLUMN igt.borehole_interval.metadata IS 'JSON с дополнительными данными.';
COMMENT ON COLUMN igt.borehole_interval.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN igt.borehole_interval.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN igt.borehole_interval.owner_user_id IS 'ID пользователя создавшего запись.';