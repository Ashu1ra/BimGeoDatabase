CREATE TABLE IF NOT EXISTS audit.log_borehole_interval (
    id BIGSERIAL PRIMARY KEY,
    link_borehole_interval BIGINT REFERENCES igt.borehole_interval(id) ON DELETE CASCADE,
    old_data JSON,
    operation_type TEXT NOT NULL,
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_interval_link ON audit.log_borehole_interval (link_borehole_interval);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_interval_changed_at ON audit.log_borehole_interval (changed_at);

COMMENT ON TABLE audit.log_borehole_interval IS 'Журнал изменений интервалов выработки.';
COMMENT ON COLUMN audit.log_borehole_interval.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_borehole_interval.link_borehole_interval IS 'FK на интервал.';
COMMENT ON COLUMN audit.log_borehole_interval.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_borehole_interval.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_borehole_interval.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_borehole_interval.changed_at IS 'Дата изменения.';