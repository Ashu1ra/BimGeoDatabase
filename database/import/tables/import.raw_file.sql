CREATE TABLE IF NOT EXISTS import.raw_file (
    id BIGSERIAL PRIMARY KEY,
    link_data_source BIGINT REFERENCES import.data_source(id),
    filename TEXT NOT NULL,
    link_list_file_format BIGINT REFERENCES ref.list_file_format(id),
    file_data BYTEA,
    uploaded_by TEXT,
    upload_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    owner_user_id BIGINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_import_raw_file_link_data_source ON import.raw_file (link_data_source);
CREATE INDEX IF NOT EXISTS idx_import_raw_file_link_list_file_format ON import.raw_file (link_list_file_format);
CREATE INDEX IF NOT EXISTS idx_import_raw_file_owner_user_id ON import.raw_file (owner_user_id);

COMMENT ON TABLE import.raw_file IS 'Хранение оригинальных файлов для последующей обработки или восстановления.';
COMMENT ON COLUMN import.raw_file.id IS 'PK необработанного файла.';
COMMENT ON COLUMN import.raw_file.link_data_source IS 'FK на источник данных.';
COMMENT ON COLUMN import.raw_file.filename IS 'Имя файла.';
COMMENT ON COLUMN import.raw_file.link_list_file_format IS 'FK на формат файла.';
COMMENT ON COLUMN import.raw_file.file_data IS 'Исходный файл в бинарном формате (bytea).';
COMMENT ON COLUMN import.raw_file.uploaded_by IS 'Пользователь, загрузивший файл.';
COMMENT ON COLUMN import.raw_file.upload_at IS 'Дата загрузки файла.';
COMMENT ON COLUMN import.raw_file.owner_user_id IS 'ID пользователя создавшего запись.';