CREATE TABLE auth.user_group (
    id BIGSERIAL PRIMARY KEY,
    link_user_account BIGINT NOT NULL REFERENCES auth.user_account(id) ON DELETE CASCADE,
    link_group_list BIGINT NOT NULL REFERENCES auth.group_list(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_auth_user_group_user ON auth.user_group (link_user_account);
CREATE INDEX idx_auth_user_group_group ON auth.user_group (link_group_list);

COMMENT ON TABLE auth.user_group IS 'Связь пользователей с группами.';
COMMENT ON COLUMN auth.user_group.link_user_account IS 'FK на пользователя.';
COMMENT ON COLUMN auth.user_group.link_group_list IS 'FK на группу.';