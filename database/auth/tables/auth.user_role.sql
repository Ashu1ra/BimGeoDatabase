CREATE TABLE auth.user_role (
    id BIGSERIAL PRIMARY KEY,
    link_user_account BIGINT NOT NULL REFERENCES auth.user_account(id) ON DELETE CASCADE,
    link_role_list BIGINT NOT NULL REFERENCES auth.role_list(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_auth_user_role_user ON auth.user_role (link_user_account);
CREATE INDEX idx_auth_user_role_role ON auth.user_role (link_role_list);

COMMENT ON TABLE auth.user_role IS 'Связь пользователя с ролью.';
COMMENT ON COLUMN auth.user_role.link_user_account IS 'FK на пользователя.';
COMMENT ON COLUMN auth.user_role.link_role_list IS 'FK на роль доступа.';