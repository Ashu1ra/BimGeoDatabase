CREATE TABLE IF NOT EXISTS ref.list_borehole_standard (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

COMMENT ON TABLE ref.list_borehole_standard IS 'Справочник стандартов выполнения бурения.';
COMMENT ON COLUMN ref.list_borehole_standard.id IS 'PK стандарта.';
COMMENT ON COLUMN ref.list_borehole_standard.mnemonic IS 'Уникальный код стандарта.';
COMMENT ON COLUMN ref.list_borehole_standard.name IS 'Название стандарта.';
COMMENT ON COLUMN ref.list_borehole_standard.description IS 'Пояснение, может быть NULL.';