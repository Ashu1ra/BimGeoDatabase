CREATE TABLE IF NOT EXISTS ref.list_test_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    code TEXT,
    name TEXT NOT NULL,
    category TEXT,
    description TEXT
);
CREATE INDEX IF NOT EXISTS idx_ref_list_test_type_code ON ref.list_test_type (code);

COMMENT ON TABLE ref.list_test_type IS 'Справочник типов испытаний.';
COMMENT ON COLUMN ref.list_test_type.id IS 'PK типа испытания.';
COMMENT ON COLUMN ref.list_test_type.mnemonic IS 'Уникальный код типа испытания.';
COMMENT ON COLUMN ref.list_test_type.code IS 'Короткое название типа.';
COMMENT ON COLUMN ref.list_test_type.name IS 'Название типа испытания.';
COMMENT ON COLUMN ref.list_test_type.category IS 'Категория испытания (field/lab).';
COMMENT ON COLUMN ref.list_test_type.description IS 'Пояснение, может быть NULL.';