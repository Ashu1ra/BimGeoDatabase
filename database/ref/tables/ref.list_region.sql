CREATE TABLE IF NOT EXISTS ref.list_region (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    code TEXT NOT NULL,
    name TEXT NOT NULL
);

COMMENT ON TABLE ref.list_region IS 'Справочник регионов России.';
COMMENT ON COLUMN ref.list_region.id IS 'PK региона.';
COMMENT ON COLUMN ref.list_region.mnemonic IS 'Уникальный код региона для бизнес-логики.';
COMMENT ON COLUMN ref.list_region.code IS 'Код региона.';
COMMENT ON COLUMN ref.list_region.name IS 'Название региона.';