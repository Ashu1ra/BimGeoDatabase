CREATE TABLE auth.access_control (
    id BIGSERIAL PRIMARY KEY,
    entity_schema TEXT NOT NULL,
    entity_name TEXT NOT NULL,
    object_id BIGINT, -- NULL => правило для всей таблицы
    link_user_account BIGINT REFERENCES auth.user_account(id),
    link_group_list BIGINT REFERENCES auth.group_list(id),
    link_role_list BIGINT REFERENCES auth.role_list(id),
    can_read BOOLEAN NOT NULL DEFAULT FALSE,
    can_write BOOLEAN NOT NULL DEFAULT FALSE,
    can_delete BOOLEAN NOT NULL DEFAULT FALSE,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_auth_access_control_schema_name ON auth.access_control (entity_schema, entity_name);
CREATE INDEX idx_auth_access_control_object ON auth.access_control (object_id);
CREATE INDEX idx_auth_access_control_user ON auth.access_control (link_user_account);
CREATE INDEX idx_auth_access_control_group ON auth.access_control (link_group_list);

COMMENT ON TABLE auth.access_control IS 'Системы прав доступа к сущностям.';
COMMENT ON COLUMN auth.access_control.id IS 'PK правила.';
COMMENT ON COLUMN auth.access_control.entity_schema IS 'Схема, к которой применяется правило.';
COMMENT ON COLUMN auth.access_control.entity_name IS 'Таблица, которой применяется правило.';
COMMENT ON COLUMN auth.access_control.object_id IS 'ID конкретного объекта; NULL означает права на всю таблицу.';
COMMENT ON COLUMN auth.access_control.link_user_account IS 'FK на пользователя; NULL допустимо.';
COMMENT ON COLUMN auth.access_control.link_group_list IS 'FK на группу; NULL допустимо.';
COMMENT ON COLUMN auth.access_control.link_role_list IS 'FK на роль; NULL допустимо.';
COMMENT ON COLUMN auth.access_control.can_read IS 'Можно читать (TRUE/FALSE).';
COMMENT ON COLUMN auth.access_control.can_write IS 'Можно редактировать (TRUE/FALSE).';
COMMENT ON COLUMN auth.access_control.can_delete IS 'Можно удалять (TRUE/FALSE).';
COMMENT ON COLUMN auth.access_control.metadata IS 'JSON с дополнительными настройками.';