CREATE TABLE IF NOT EXISTS audit.log_borehole (
    id BIGSERIAL PRIMARY KEY,
    link_borehole BIGINT REFERENCES igt.borehole(id) ON DELETE CASCADE,
    old_data JSON,
    operation_type TEXT NOT NULL, 
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_link ON audit.log_borehole (link_borehole);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_changed_at ON audit.log_borehole (changed_at);

COMMENT ON TABLE audit.log_borehole IS 'Журнал изменений выработок.';
COMMENT ON COLUMN audit.log_borehole.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_borehole.link_borehole IS 'FK на выработку.';
COMMENT ON COLUMN audit.log_borehole.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_borehole.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_borehole.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_borehole.changed_at IS 'Дата изменения.';