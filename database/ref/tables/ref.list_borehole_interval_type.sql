CREATE TABLE IF NOT EXISTS ref.list_borehole_interval_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    metadata JSON,
    description TEXT
);

COMMENT ON TABLE ref.list_borehole_interval_type IS 'Справочник типов интервалов бурения.';
COMMENT ON COLUMN ref.list_borehole_interval_type.id IS 'PK типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.mnemonic IS 'Уникальный код типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.name IS 'Название типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.metadata IS 'JSON с дополнительными параметрами типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.description IS 'Пояснение, может быть NULL.';