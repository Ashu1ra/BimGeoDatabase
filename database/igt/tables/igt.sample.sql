CREATE TABLE IF NOT EXISTS igt.sample (
    id BIGSERIAL PRIMARY KEY,
    link_borehole_interval BIGINT REFERENCES igt.borehole_interval(id),
    number TEXT UNIQUE,
    depth DOUBLE PRECISION,
    depth_from DOUBLE PRECISION,
    depth_to DOUBLE PRECISION,
    link_list_sample_standard BIGINT REFERENCES ref.list_sample_standard(id),
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_igt_sample_link_interval ON igt.sample (link_borehole_interval);
CREATE INDEX IF NOT EXISTS idx_igt_sample_depth ON igt.sample (depth);
CREATE INDEX IF NOT EXISTS idx_igt_sample_depth_from ON igt.sample (depth_from);
CREATE INDEX IF NOT EXISTS idx_igt_sample_depth_to ON igt.sample (depth_to);
CREATE INDEX IF NOT EXISTS idx_igt_sample_owner_user_id ON igt.sample (owner_user_id);

COMMENT ON TABLE igt.sample IS 'Лабораторная проба, свойства грунта и интервал отбора.';
COMMENT ON COLUMN igt.sample.id IS 'PK пробы.';
COMMENT ON COLUMN igt.sample.link_borehole_interval IS 'FK на интервал выработки.';
COMMENT ON COLUMN igt.sample.number IS 'Уникальный номер пробы (UNIQUE).';
COMMENT ON COLUMN igt.sample.depth IS 'Глубина измерения.';
COMMENT ON COLUMN igt.sample.depth_from IS 'Начальная глубина интервала.';
COMMENT ON COLUMN igt.sample.depth_to IS 'Конечная глубина интервала.';
COMMENT ON COLUMN igt.sample.link_list_sample_standard IS 'FK на стандарт отбора.';
COMMENT ON COLUMN igt.sample.description IS 'Комментарии, может быть NULL.';
COMMENT ON COLUMN igt.sample.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN igt.sample.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN igt.sample.owner_user_id IS 'ID пользователя создавшего запись.';