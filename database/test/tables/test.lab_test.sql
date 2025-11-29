CREATE TABLE IF NOT EXISTS test.lab_test (
    id BIGSERIAL PRIMARY KEY,
    link_sample BIGINT REFERENCES igt.sample(id),
    link_list_test_type BIGINT REFERENCES ref.list_test_type(id),
    results JSON,
    test_date TIMESTAMPTZ,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_link_sample ON test.lab_test (link_sample);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_link_list_test_type ON test.lab_test (link_list_test_type);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_created_at ON test.lab_test (created_at);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_owner_user_id ON test.lab_test (owner_user_id);

COMMENT ON TABLE test.lab_test IS 'Лабораторное испытание, контроль качества проб.';
COMMENT ON COLUMN test.lab_test.id IS 'PK испытания.';
COMMENT ON COLUMN test.lab_test.link_sample IS 'FK на пробу.';
COMMENT ON COLUMN test.lab_test.link_list_test_type IS 'FK на тип испытания.';
COMMENT ON COLUMN test.lab_test.results IS 'JSON с результатами испытания.';
COMMENT ON COLUMN test.lab_test.test_date IS 'Дата проведения.';
COMMENT ON COLUMN test.lab_test.metadata IS 'JSON с дополнительными сведениями.';
COMMENT ON COLUMN test.lab_test.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN test.lab_test.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN test.lab_test.owner_user_id IS 'ID пользователя создавшего запись.';