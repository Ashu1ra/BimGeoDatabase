CREATE TABLE auth.role_list (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

COMMENT ON TABLE auth.role_list IS 'Справочник ролей доступа.';
COMMENT ON COLUMN auth.role_list.id IS 'PK роли.';
COMMENT ON COLUMN auth.role_list.name IS 'Название роли.';
COMMENT ON COLUMN auth.role_list.description IS 'Описание роли.';