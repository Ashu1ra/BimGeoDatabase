CREATE TABLE IF NOT EXISTS test.field_test (
    id BIGSERIAL PRIMARY KEY,
    link_borehole BIGINT REFERENCES igt.borehole(id),
    link_list_test_type BIGINT REFERENCES ref.list_test_type(id),
    results JSON,
    test_date TIMESTAMPTZ,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_test_field_test_link_borehole ON test.field_test (link_borehole);
CREATE INDEX IF NOT EXISTS idx_test_field_test_link_list_test_type ON test.field_test (link_list_test_type);
CREATE INDEX IF NOT EXISTS idx_test_field_test_created_at ON test.field_test (created_at);
CREATE INDEX IF NOT EXISTS idx_test_field_test_owner_user_id ON test.field_test (owner_user_id);

COMMENT ON TABLE test.field_test IS 'Полевое испытание, результаты исследований скважин.';
COMMENT ON COLUMN test.field_test.id IS 'PK испытания.';
COMMENT ON COLUMN test.field_test.link_borehole IS 'FK на выработку.';
COMMENT ON COLUMN test.field_test.link_list_test_type IS 'FK на тип испытания.';
COMMENT ON COLUMN test.field_test.results IS 'JSON с результатами испытания.';
COMMENT ON COLUMN test.field_test.test_date IS 'Дата проведения.';
COMMENT ON COLUMN test.field_test.metadata IS 'JSON с дополнительными сведениями.';
COMMENT ON COLUMN test.field_test.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN test.field_test.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN test.field_test.owner_user_id IS 'ID пользователя создавшего запись.';