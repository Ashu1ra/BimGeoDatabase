CREATE TABLE auth.user_account (
    id BIGSERIAL PRIMARY KEY,
    login TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    email TEXT UNIQUE,
    full_name TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    last_login TIMESTAMPTZ,
    metadata JSON
);
CREATE INDEX idx_auth_user_account_created_at ON auth.user_account (created_at);

COMMENT ON TABLE auth.user_account IS 'Пользователи системы.';
COMMENT ON COLUMN auth.user_account.id IS 'PK пользователя.';
COMMENT ON COLUMN auth.user_account.login IS 'Логин пользователя (UNIQUE).';
COMMENT ON COLUMN auth.user_account.password_hash IS 'Хеш пароля.';
COMMENT ON COLUMN auth.user_account.email IS 'Электронная почта (UNIQUE).';
COMMENT ON COLUMN auth.user_account.full_name IS 'ФИО пользователя.';
COMMENT ON COLUMN auth.user_account.is_active IS 'Активен ли пользователь.';
COMMENT ON COLUMN auth.user_account.created_at IS 'Дата регистрации.';
COMMENT ON COLUMN auth.user_account.last_login IS 'Последнее посещение.';
COMMENT ON COLUMN auth.user_account.metadata IS 'JSON с расширенными данными (настройки).';