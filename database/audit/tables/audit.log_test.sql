CREATE TABLE IF NOT EXISTS audit.log_test (
    id BIGSERIAL PRIMARY KEY,
    test_type TEXT NOT NULL, -- 'lab' or 'field'
    link_test BIGINT, -- ID записи в соответствующей таблице
    old_data JSON,
    operation_type TEXT NOT NULL,
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_test_type_link ON audit.log_test (test_type, link_test);
CREATE INDEX IF NOT EXISTS idx_audit_log_test_changed_at ON audit.log_test (changed_at);

COMMENT ON TABLE audit.log_test IS 'Журнал изменений испытаний.';
COMMENT ON COLUMN audit.log_test.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_test.test_type IS 'Тип испытания (lab/field).';
COMMENT ON COLUMN audit.log_test.link_test IS 'FK на испытание.';
COMMENT ON COLUMN audit.log_test.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_test.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_test.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_test.changed_at IS 'Дата изменения.';