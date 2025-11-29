CREATE TABLE IF NOT EXISTS ref.list_source_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

COMMENT ON TABLE ref.list_source_type IS 'Справочник типов источников данных, стандартизирует источники.';
COMMENT ON COLUMN ref.list_source_type.id IS 'PK источника, уникальный идентификатор.';
COMMENT ON COLUMN ref.list_source_type.mnemonic IS 'Уникальный код источника для бизнес-логики.';
COMMENT ON COLUMN ref.list_source_type.name IS 'Название типа источника.';
COMMENT ON COLUMN ref.list_source_type.description IS 'Дополнительное пояснение; может быть NULL.';