CREATE TABLE IF NOT EXISTS audit.log_sample (
    id BIGSERIAL PRIMARY KEY,
    link_sample BIGINT REFERENCES igt.sample(id) ON DELETE CASCADE,
    old_data JSON,
    operation_type TEXT NOT NULL,
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_sample_link ON audit.log_sample (link_sample);
CREATE INDEX IF NOT EXISTS idx_audit_log_sample_changed_at ON audit.log_sample (changed_at);

COMMENT ON TABLE audit.log_sample IS 'Журнал изменений проб.';
COMMENT ON COLUMN audit.log_sample.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_sample.link_sample IS 'FK на пробу.';
COMMENT ON COLUMN audit.log_sample.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_sample.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_sample.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_sample.changed_at IS 'Дата изменения.';