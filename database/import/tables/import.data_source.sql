CREATE TABLE IF NOT EXISTS import.data_source (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    link_list_source_type BIGINT REFERENCES ref.list_source_type(id),
    source_link TEXT,
    description TEXT,
    owner_user_id BIGINT, -- привязка на пользователя (устанавливается позже как FK)
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_import_data_source_link_type ON import.data_source (link_list_source_type);
CREATE INDEX IF NOT EXISTS idx_import_data_source_owner_user_id ON import.data_source (owner_user_id);

COMMENT ON TABLE import.data_source IS 'Источник данных, фиксирует происхождение и классификацию входящих файлов.';
COMMENT ON COLUMN import.data_source.id IS 'PK источника данных.';
COMMENT ON COLUMN import.data_source.name IS 'Название источника.';
COMMENT ON COLUMN import.data_source.link_list_source_type IS 'FK на тип источника, обеспечивает классификацию.';
COMMENT ON COLUMN import.data_source.source_link IS 'Ссылка на оригинальный источник.';
COMMENT ON COLUMN import.data_source.description IS 'Пояснение/заметки, может быть NULL.';
COMMENT ON COLUMN import.data_source.owner_user_id IS 'ID пользователя создавшего запись.';