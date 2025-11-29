CREATE TABLE IF NOT EXISTS ref.list_borehole_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

COMMENT ON TABLE ref.list_borehole_type IS 'Справочник типов выработок.';
COMMENT ON COLUMN ref.list_borehole_type.id IS 'PK типа выработки.';
COMMENT ON COLUMN ref.list_borehole_type.mnemonic IS 'Уникальный код типа выработки.';
COMMENT ON COLUMN ref.list_borehole_type.name IS 'Название типа выработки.';
COMMENT ON COLUMN ref.list_borehole_type.description IS 'Пояснение, может быть NULL.';