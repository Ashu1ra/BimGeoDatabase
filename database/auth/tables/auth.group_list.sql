CREATE TABLE auth.group_list (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

COMMENT ON TABLE auth.group_list IS 'Справочник групп пользователей.';
COMMENT ON COLUMN auth.group_list.id IS 'PK группы.';
COMMENT ON COLUMN auth.group_list.name IS 'Название группы (UNIQUE).';
COMMENT ON COLUMN auth.group_list.description IS 'Описание группы.';