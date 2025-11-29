CREATE TABLE IF NOT EXISTS ref.list_file_format (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    metadata JSON,
    description TEXT
);

COMMENT ON TABLE ref.list_file_format IS 'Справочник форматов исходных данных.';
COMMENT ON COLUMN ref.list_file_format.id IS 'PK формата, уникальный идентификатор.';
COMMENT ON COLUMN ref.list_file_format.mnemonic IS 'Уникальный код формата для бизнес-логики.';
COMMENT ON COLUMN ref.list_file_format.name IS 'Название формата.';
COMMENT ON COLUMN ref.list_file_format.metadata IS 'JSON с правилами и настройками разбора файлов.';
COMMENT ON COLUMN ref.list_file_format.description IS 'Дополнительное пояснение; может быть NULL.';