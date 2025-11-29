CREATE TABLE IF NOT EXISTS import.raw_file_entity_link (
    id BIGSERIAL PRIMARY KEY,
    link_raw_file BIGINT REFERENCES import.raw_file(id),
    entity_schema TEXT NOT NULL,
    entity_name TEXT NOT NULL,
    object_id BIGINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_import_raw_file_entity_link_raw_file ON import.raw_file_entity_link (link_raw_file);
CREATE INDEX IF NOT EXISTS idx_import_raw_file_entity_link_object_id ON import.raw_file_entity_link (object_id);

COMMENT ON TABLE import.raw_file_entity_link IS 'Связь между исходными файлами и сущностями, созданными на их основе.';
COMMENT ON COLUMN import.raw_file_entity_link.id IS 'PK записи.';
COMMENT ON COLUMN import.raw_file_entity_link.link_raw_file IS 'FK на исходный файл.';
COMMENT ON COLUMN import.raw_file_entity_link.entity_schema IS 'Схема сущности.';
COMMENT ON COLUMN import.raw_file_entity_link.entity_name IS 'Название таблицы сущности.';
COMMENT ON COLUMN import.raw_file_entity_link.object_id IS 'ID объекта сущности.';
COMMENT ON COLUMN import.raw_file_entity_link.created_at IS 'Дата создания связи.';