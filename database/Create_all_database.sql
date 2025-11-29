-- СХЕМЫ
CREATE SCHEMA IF NOT EXISTS ref;
CREATE SCHEMA IF NOT EXISTS import;
CREATE SCHEMA IF NOT EXISTS geo;
CREATE SCHEMA IF NOT EXISTS igt;
CREATE SCHEMA IF NOT EXISTS test;
CREATE SCHEMA IF NOT EXISTS audit;
CREATE SCHEMA IF NOT EXISTS auth;

-- ref.*
CREATE TABLE IF NOT EXISTS ref.list_test_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    code TEXT,
    name TEXT NOT NULL,
    category TEXT,
    description TEXT
);
CREATE INDEX IF NOT EXISTS idx_ref_list_test_type_code ON ref.list_test_type (code);

COMMENT ON TABLE ref.list_test_type IS 'Справочник типов испытаний.';
COMMENT ON COLUMN ref.list_test_type.id IS 'PK типа испытания.';
COMMENT ON COLUMN ref.list_test_type.mnemonic IS 'Уникальный код типа испытания.';
COMMENT ON COLUMN ref.list_test_type.code IS 'Короткое название типа.';
COMMENT ON COLUMN ref.list_test_type.name IS 'Название типа испытания.';
COMMENT ON COLUMN ref.list_test_type.category IS 'Категория испытания (field/lab).';
COMMENT ON COLUMN ref.list_test_type.description IS 'Пояснение, может быть NULL.';

CREATE TABLE IF NOT EXISTS ref.list_source_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

COMMENT ON TABLE ref.list_source_type IS 'Справочник типов источников данных, стандартизирует источники.';
COMMENT ON COLUMN ref.list_source_type.id IS 'PK источника, уникальный идентификатор.';
COMMENT ON COLUMN ref.list_source_type.mnemonic IS 'Уникальный код источника для бизнес-логики.';
COMMENT ON COLUMN ref.list_source_type.name IS 'Название типа источника.';
COMMENT ON COLUMN ref.list_source_type.description IS 'Дополнительное пояснение; может быть NULL.';

CREATE TABLE IF NOT EXISTS ref.list_sample_standard (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

COMMENT ON TABLE ref.list_sample_standard IS 'Справочник стандартов отбора проб.';
COMMENT ON COLUMN ref.list_sample_standard.id IS 'PK стандарта.';
COMMENT ON COLUMN ref.list_sample_standard.mnemonic IS 'Уникальный код стандарта.';
COMMENT ON COLUMN ref.list_sample_standard.name IS 'Название стандарта.';
COMMENT ON COLUMN ref.list_sample_standard.description IS 'Пояснение, может быть NULL.';

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

CREATE TABLE IF NOT EXISTS ref.list_file_format (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    metadata JSON,
    description TEXT
);

COMMENT ON TABLE ref.list_file_format IS 'Справочник форматов исходных данных.';
COMMENT ON COLUMN ref.list_file_format.id IS 'PK формата, уникальный идентификатор.';
COMMENT ON COLUMN ref.list_file_format.mnemonic IS 'Уникальный код формата для бизнес-логики.';
COMMENT ON COLUMN ref.list_file_format.name IS 'Название формата.';
COMMENT ON COLUMN ref.list_file_format.metadata IS 'JSON с правилами и настройками разбора файлов.';
COMMENT ON COLUMN ref.list_file_format.description IS 'Дополнительное пояснение; может быть NULL.';

CREATE TABLE IF NOT EXISTS ref.list_borehole_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

COMMENT ON TABLE ref.list_borehole_type IS 'Справочник типов выработок.';
COMMENT ON COLUMN ref.list_borehole_type.id IS 'PK типа выработки.';
COMMENT ON COLUMN ref.list_borehole_type.mnemonic IS 'Уникальный код типа выработки.';
COMMENT ON COLUMN ref.list_borehole_type.name IS 'Название типа выработки.';
COMMENT ON COLUMN ref.list_borehole_type.description IS 'Пояснение, может быть NULL.';

CREATE TABLE IF NOT EXISTS ref.list_borehole_standard (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

COMMENT ON TABLE ref.list_borehole_standard IS 'Справочник стандартов выполнения бурения.';
COMMENT ON COLUMN ref.list_borehole_standard.id IS 'PK стандарта.';
COMMENT ON COLUMN ref.list_borehole_standard.mnemonic IS 'Уникальный код стандарта.';
COMMENT ON COLUMN ref.list_borehole_standard.name IS 'Название стандарта.';
COMMENT ON COLUMN ref.list_borehole_standard.description IS 'Пояснение, может быть NULL.';

CREATE TABLE IF NOT EXISTS ref.list_borehole_interval_type (
    id BIGSERIAL PRIMARY KEY,
    mnemonic TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    metadata JSON,
    description TEXT
);

COMMENT ON TABLE ref.list_borehole_interval_type IS 'Справочник типов интервалов бурения.';
COMMENT ON COLUMN ref.list_borehole_interval_type.id IS 'PK типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.mnemonic IS 'Уникальный код типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.name IS 'Название типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.metadata IS 'JSON с дополнительными параметрами типа интервала.';
COMMENT ON COLUMN ref.list_borehole_interval_type.description IS 'Пояснение, может быть NULL.';

-- import.*
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
-- geo.*
CREATE TABLE IF NOT EXISTS geo.project (
    id BIGSERIAL PRIMARY KEY,
    link_list_region BIGINT REFERENCES ref.list_region(id),
    name TEXT NOT NULL,
    link_data_source BIGINT REFERENCES import.data_source(id),
    center_location GEOMETRY(POINTZ, 4326),
    area GEOMETRY(MULTIPOLYGON, 4326),
    date_start TIMESTAMPTZ,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_geo_project_link_list_region ON geo.project (link_list_region);
CREATE INDEX IF NOT EXISTS idx_geo_project_created_at ON geo.project (created_at);
CREATE INDEX IF NOT EXISTS idx_geo_project_owner_user_id ON geo.project (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_geo_project_center_location ON geo.project USING GIST(center_location);
CREATE INDEX IF NOT EXISTS idx_geo_project_area ON geo.project USING GIST(area);

COMMENT ON TABLE geo.project IS 'Проект, объединяет данные по территории и источникам.';
COMMENT ON COLUMN geo.project.id IS 'PK проекта.';
COMMENT ON COLUMN geo.project.link_list_region IS 'FK на регион проекта.';
COMMENT ON COLUMN geo.project.name IS 'Название проекта.';
COMMENT ON COLUMN geo.project.link_data_source IS 'FK на источник проекта.';
COMMENT ON COLUMN geo.project.center_location IS 'Координата центра проекта (pointZ), GIST индекс.';
COMMENT ON COLUMN geo.project.area IS 'Область охвата проекта (MultiPolygon), GIST индекс.';
COMMENT ON COLUMN geo.project.date_start IS 'Дата начала проекта.';
COMMENT ON COLUMN geo.project.description IS 'Описание проекта, может быть NULL.';
COMMENT ON COLUMN geo.project.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.project.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN geo.project.owner_user_id IS 'ID пользователя создавшего проект.';

CREATE TABLE IF NOT EXISTS geo.site (
    id BIGSERIAL PRIMARY KEY,
    link_project BIGINT REFERENCES geo.project(id),
    name TEXT NOT NULL,
    area GEOMETRY(POLYGON, 4326),
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_geo_site_link_project ON geo.site (link_project);
CREATE INDEX IF NOT EXISTS idx_geo_site_created_at ON geo.site (created_at);
CREATE INDEX IF NOT EXISTS idx_geo_site_owner_user_id ON geo.site (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_geo_site_area ON geo.site USING GIST(area);

COMMENT ON TABLE geo.site IS 'Участок, границы и пространственная привязка.';
COMMENT ON COLUMN geo.site.id IS 'PK участка.';
COMMENT ON COLUMN geo.site.link_project IS 'FK на проект.';
COMMENT ON COLUMN geo.site.name IS 'Название участка.';
COMMENT ON COLUMN geo.site.area IS 'Область охвата участка (Polygon), GIST индекс.';
COMMENT ON COLUMN geo.site.description IS 'Описание участка, может быть NULL.';
COMMENT ON COLUMN geo.site.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.site.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN geo.site.owner_user_id IS 'ID пользователя создавшего участок.';

CREATE TABLE IF NOT EXISTS geo.topography (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    link_data_source BIGINT REFERENCES import.data_source(id),
    area GEOMETRY(MULTIPOLYGON, 4326),
    raster_file BYTEA,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_geo_topography_link_site ON geo.topography (link_site);
CREATE INDEX IF NOT EXISTS idx_geo_topography_link_data_source ON geo.topography (link_data_source);
CREATE INDEX IF NOT EXISTS idx_geo_topography_created_at ON geo.topography (created_at);
CREATE INDEX IF NOT EXISTS idx_geo_topography_owner_user_id ON geo.topography (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_geo_topography_area ON geo.topography USING GIST(area);

COMMENT ON TABLE geo.topography IS 'Топографические данные, рельеф и цифровые модели местности.';
COMMENT ON COLUMN geo.topography.id IS 'PK топографии.';
COMMENT ON COLUMN geo.topography.link_site IS 'FK на участок.';
COMMENT ON COLUMN geo.topography.link_data_source IS 'FK на источник данных.';
COMMENT ON COLUMN geo.topography.area IS 'Область охвата (MultiPolygon), GIST индекс.';
COMMENT ON COLUMN geo.topography.raster_file IS 'Растровый файл с данными рельефа (bytea).';
COMMENT ON COLUMN geo.topography.metadata IS 'JSON с дополнительной информацией.';
COMMENT ON COLUMN geo.topography.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.topography.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN geo.topography.owner_user_id IS 'ID пользователя создавшего запись.';

CREATE TABLE IF NOT EXISTS geo.bim_model (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    format TEXT,
    file_data BYTEA,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_geo_bim_model_link_site ON geo.bim_model (link_site);
CREATE INDEX IF NOT EXISTS idx_geo_bim_model_created_at ON geo.bim_model (created_at);

COMMENT ON TABLE geo.bim_model IS 'BIM/CAD модели, пространственно привязанные цифровые модели.';
COMMENT ON COLUMN geo.bim_model.id IS 'PK BIM-модели.';
COMMENT ON COLUMN geo.bim_model.link_site IS 'FK на участок.';
COMMENT ON COLUMN geo.bim_model.format IS 'Формат файла модели (IFC, 3DTILES, DWG, DXF, DGN).';
COMMENT ON COLUMN geo.bim_model.file_data IS 'Бинарные данные модели (bytea).';
COMMENT ON COLUMN geo.bim_model.metadata IS 'JSON с дополнительными параметрами модели.';
COMMENT ON COLUMN geo.bim_model.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN geo.bim_model.updated_at IS 'Дата обновления записи.';

CREATE TABLE IF NOT EXISTS geo.city_model (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    format TEXT,
    file_data BYTEA,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_geo_city_model_link_site ON geo.city_model (link_site);
CREATE INDEX IF NOT EXISTS idx_geo_city_model_created_at ON geo.city_model (created_at);

COMMENT ON TABLE geo.city_model IS 'Городская модель, CityGML/GML данные, LOD структура, семантика.';
COMMENT ON COLUMN geo.city_model.id IS 'PK модели.';
COMMENT ON COLUMN geo.city_model.link_site IS 'FK на участок.';
COMMENT ON COLUMN geo.city_model.format IS 'Формат модели (CITYGML, GML).';
COMMENT ON COLUMN geo.city_model.file_data IS 'Бинарные данные модели (bytea).';
COMMENT ON COLUMN geo.city_model.metadata IS 'JSON с дополнительными параметрами модели.';
COMMENT ON COLUMN geo.city_model.created_at IS 'Дата добавления записи.';
COMMENT ON COLUMN geo.city_model.updated_at IS 'Дата последнего обновления.';

-- igt.*
CREATE TABLE IF NOT EXISTS igt.borehole (
    id BIGSERIAL PRIMARY KEY,
    link_site BIGINT REFERENCES geo.site(id),
    location GEOMETRY(POINTZ, 4326),
    link_list_borehole_type BIGINT REFERENCES ref.list_borehole_type(id),
    depth_min DOUBLE PRECISION,
    depth_max DOUBLE PRECISION,
    link_list_borehole_standard BIGINT REFERENCES ref.list_borehole_standard(id),
    date_start TIMESTAMPTZ,
    date_end TIMESTAMPTZ,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_link_site ON igt.borehole (link_site);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_link_type ON igt.borehole (link_list_borehole_type);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_link_standard ON igt.borehole (link_list_borehole_standard);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_date_start ON igt.borehole (date_start);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_date_end ON igt.borehole (date_end);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_owner_user_id ON igt.borehole (owner_user_id);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_location ON igt.borehole USING GIST(location);

COMMENT ON TABLE igt.borehole IS 'Выработка, фиксирует точки бурения.';
COMMENT ON COLUMN igt.borehole.id IS 'PK выработки.';
COMMENT ON COLUMN igt.borehole.link_site IS 'FK на участок.';
COMMENT ON COLUMN igt.borehole.location IS 'Координаты бурения (pointZ), GIST индекс.';
COMMENT ON COLUMN igt.borehole.link_list_borehole_type IS 'FK на тип скважины.';
COMMENT ON COLUMN igt.borehole.depth_min IS 'Минимальная глубина.';
COMMENT ON COLUMN igt.borehole.depth_max IS 'Максимальная глубина.';
COMMENT ON COLUMN igt.borehole.link_list_borehole_standard IS 'FK на стандарт скважины.';
COMMENT ON COLUMN igt.borehole.date_start IS 'Дата начала бурения.';
COMMENT ON COLUMN igt.borehole.date_end IS 'Дата окончания бурения.';
COMMENT ON COLUMN igt.borehole.metadata IS 'JSON с дополнительными данными.';
COMMENT ON COLUMN igt.borehole.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN igt.borehole.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN igt.borehole.owner_user_id IS 'ID пользователя создавшего выработку.';

CREATE TABLE IF NOT EXISTS igt.borehole_interval (
    id BIGSERIAL PRIMARY KEY,
    link_borehole BIGINT REFERENCES igt.borehole(id),
    depth_from DOUBLE PRECISION,
    depth_to DOUBLE PRECISION,
    link_list_borehole_interval_type BIGINT REFERENCES ref.list_borehole_interval_type(id),
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_interval_link_borehole ON igt.borehole_interval (link_borehole);
CREATE INDEX IF NOT EXISTS idx_igt_borehole_interval_owner_user_id ON igt.borehole_interval (owner_user_id);

COMMENT ON TABLE igt.borehole_interval IS 'Интервалы выработки.';
COMMENT ON COLUMN igt.borehole_interval.id IS 'PK интервала.';
COMMENT ON COLUMN igt.borehole_interval.link_borehole IS 'FK на выработку.';
COMMENT ON COLUMN igt.borehole_interval.depth_from IS 'Начальная глубина интервала.';
COMMENT ON COLUMN igt.borehole_interval.depth_to IS 'Конечная глубина интервала.';
COMMENT ON COLUMN igt.borehole_interval.link_list_borehole_interval_type IS 'FK на тип интервала.';
COMMENT ON COLUMN igt.borehole_interval.metadata IS 'JSON с дополнительными данными.';
COMMENT ON COLUMN igt.borehole_interval.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN igt.borehole_interval.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN igt.borehole_interval.owner_user_id IS 'ID пользователя создавшего запись.';

CREATE TABLE IF NOT EXISTS igt.sample (
    id BIGSERIAL PRIMARY KEY,
    link_borehole_interval BIGINT REFERENCES igt.borehole_interval(id),
    number TEXT UNIQUE,
    depth DOUBLE PRECISION,
    depth_from DOUBLE PRECISION,
    depth_to DOUBLE PRECISION,
    link_list_sample_standard BIGINT REFERENCES ref.list_sample_standard(id),
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_igt_sample_link_interval ON igt.sample (link_borehole_interval);
CREATE INDEX IF NOT EXISTS idx_igt_sample_depth ON igt.sample (depth);
CREATE INDEX IF NOT EXISTS idx_igt_sample_depth_from ON igt.sample (depth_from);
CREATE INDEX IF NOT EXISTS idx_igt_sample_depth_to ON igt.sample (depth_to);
CREATE INDEX IF NOT EXISTS idx_igt_sample_owner_user_id ON igt.sample (owner_user_id);

COMMENT ON TABLE igt.sample IS 'Лабораторная проба, свойства грунта и интервал отбора.';
COMMENT ON COLUMN igt.sample.id IS 'PK пробы.';
COMMENT ON COLUMN igt.sample.link_borehole_interval IS 'FK на интервал выработки.';
COMMENT ON COLUMN igt.sample.number IS 'Уникальный номер пробы (UNIQUE).';
COMMENT ON COLUMN igt.sample.depth IS 'Глубина измерения.';
COMMENT ON COLUMN igt.sample.depth_from IS 'Начальная глубина интервала.';
COMMENT ON COLUMN igt.sample.depth_to IS 'Конечная глубина интервала.';
COMMENT ON COLUMN igt.sample.link_list_sample_standard IS 'FK на стандарт отбора.';
COMMENT ON COLUMN igt.sample.description IS 'Комментарии, может быть NULL.';
COMMENT ON COLUMN igt.sample.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN igt.sample.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN igt.sample.owner_user_id IS 'ID пользователя создавшего запись.';

-- test.*
CREATE TABLE IF NOT EXISTS test.field_test (
    id BIGSERIAL PRIMARY KEY,
    link_borehole BIGINT REFERENCES igt.borehole(id),
    link_list_test_type BIGINT REFERENCES ref.list_test_type(id),
    results JSON,
    test_date TIMESTAMPTZ,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_test_field_test_link_borehole ON test.field_test (link_borehole);
CREATE INDEX IF NOT EXISTS idx_test_field_test_link_list_test_type ON test.field_test (link_list_test_type);
CREATE INDEX IF NOT EXISTS idx_test_field_test_created_at ON test.field_test (created_at);
CREATE INDEX IF NOT EXISTS idx_test_field_test_owner_user_id ON test.field_test (owner_user_id);

COMMENT ON TABLE test.field_test IS 'Полевое испытание, результаты исследований скважин.';
COMMENT ON COLUMN test.field_test.id IS 'PK испытания.';
COMMENT ON COLUMN test.field_test.link_borehole IS 'FK на выработку.';
COMMENT ON COLUMN test.field_test.link_list_test_type IS 'FK на тип испытания.';
COMMENT ON COLUMN test.field_test.results IS 'JSON с результатами испытания.';
COMMENT ON COLUMN test.field_test.test_date IS 'Дата проведения.';
COMMENT ON COLUMN test.field_test.metadata IS 'JSON с дополнительными сведениями.';
COMMENT ON COLUMN test.field_test.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN test.field_test.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN test.field_test.owner_user_id IS 'ID пользователя создавшего запись.';

CREATE TABLE IF NOT EXISTS test.lab_test (
    id BIGSERIAL PRIMARY KEY,
    link_sample BIGINT REFERENCES igt.sample(id),
    link_list_test_type BIGINT REFERENCES ref.list_test_type(id),
    results JSON,
    test_date TIMESTAMPTZ,
    metadata JSON,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    owner_user_id BIGINT
);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_link_sample ON test.lab_test (link_sample);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_link_list_test_type ON test.lab_test (link_list_test_type);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_created_at ON test.lab_test (created_at);
CREATE INDEX IF NOT EXISTS idx_test_lab_test_owner_user_id ON test.lab_test (owner_user_id);

COMMENT ON TABLE test.lab_test IS 'Лабораторное испытание, контроль качества проб.';
COMMENT ON COLUMN test.lab_test.id IS 'PK испытания.';
COMMENT ON COLUMN test.lab_test.link_sample IS 'FK на пробу.';
COMMENT ON COLUMN test.lab_test.link_list_test_type IS 'FK на тип испытания.';
COMMENT ON COLUMN test.lab_test.results IS 'JSON с результатами испытания.';
COMMENT ON COLUMN test.lab_test.test_date IS 'Дата проведения.';
COMMENT ON COLUMN test.lab_test.metadata IS 'JSON с дополнительными сведениями.';
COMMENT ON COLUMN test.lab_test.created_at IS 'Дата создания записи.';
COMMENT ON COLUMN test.lab_test.updated_at IS 'Дата обновления записи.';
COMMENT ON COLUMN test.lab_test.owner_user_id IS 'ID пользователя создавшего запись.';

-- audit.*
CREATE TABLE IF NOT EXISTS audit.log_borehole_interval (
    id BIGSERIAL PRIMARY KEY,
    link_borehole_interval BIGINT REFERENCES igt.borehole_interval(id) ON DELETE CASCADE,
    old_data JSON,
    operation_type TEXT NOT NULL,
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_interval_link ON audit.log_borehole_interval (link_borehole_interval);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_interval_changed_at ON audit.log_borehole_interval (changed_at);

COMMENT ON TABLE audit.log_borehole_interval IS 'Журнал изменений интервалов выработки.';
COMMENT ON COLUMN audit.log_borehole_interval.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_borehole_interval.link_borehole_interval IS 'FK на интервал.';
COMMENT ON COLUMN audit.log_borehole_interval.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_borehole_interval.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_borehole_interval.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_borehole_interval.changed_at IS 'Дата изменения.';

CREATE TABLE IF NOT EXISTS audit.log_borehole (
    id BIGSERIAL PRIMARY KEY,
    link_borehole BIGINT REFERENCES igt.borehole(id) ON DELETE CASCADE,
    old_data JSON,
    operation_type TEXT NOT NULL, 
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_link ON audit.log_borehole (link_borehole);
CREATE INDEX IF NOT EXISTS idx_audit_log_borehole_changed_at ON audit.log_borehole (changed_at);

COMMENT ON TABLE audit.log_borehole IS 'Журнал изменений выработок.';
COMMENT ON COLUMN audit.log_borehole.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_borehole.link_borehole IS 'FK на выработку.';
COMMENT ON COLUMN audit.log_borehole.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_borehole.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_borehole.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_borehole.changed_at IS 'Дата изменения.';

CREATE TABLE IF NOT EXISTS audit.log_sample (
    id BIGSERIAL PRIMARY KEY,
    link_sample BIGINT REFERENCES igt.sample(id) ON DELETE CASCADE,
    old_data JSON,
    operation_type TEXT NOT NULL,
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_sample_link ON audit.log_sample (link_sample);
CREATE INDEX IF NOT EXISTS idx_audit_log_sample_changed_at ON audit.log_sample (changed_at);

COMMENT ON TABLE audit.log_sample IS 'Журнал изменений проб.';
COMMENT ON COLUMN audit.log_sample.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_sample.link_sample IS 'FK на пробу.';
COMMENT ON COLUMN audit.log_sample.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_sample.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_sample.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_sample.changed_at IS 'Дата изменения.';

CREATE TABLE IF NOT EXISTS audit.log_test (
    id BIGSERIAL PRIMARY KEY,
    test_type TEXT NOT NULL, -- 'lab' or 'field'
    link_test BIGINT, -- ID записи в соответствующей таблице
    old_data JSON,
    operation_type TEXT NOT NULL,
    changed_by BIGINT REFERENCES "user".user_account(id),
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_log_test_type_link ON audit.log_test (test_type, link_test);
CREATE INDEX IF NOT EXISTS idx_audit_log_test_changed_at ON audit.log_test (changed_at);

COMMENT ON TABLE audit.log_test IS 'Журнал изменений испытаний.';
COMMENT ON COLUMN audit.log_test.id IS 'PK записи.';
COMMENT ON COLUMN audit.log_test.test_type IS 'Тип испытания (lab/field).';
COMMENT ON COLUMN audit.log_test.link_test IS 'FK на испытание.';
COMMENT ON COLUMN audit.log_test.old_data IS 'JSON с предыдущими значениями.';
COMMENT ON COLUMN audit.log_test.operation_type IS 'Тип операции (INSERT/UPDATE/DELETE).';
COMMENT ON COLUMN audit.log_test.changed_by IS 'Пользователь, внесший изменение.';
COMMENT ON COLUMN audit.log_test.changed_at IS 'Дата изменения.';

-- auth.*
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

CREATE TABLE auth.group_list (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

COMMENT ON TABLE auth.group_list IS 'Справочник групп пользователей.';
COMMENT ON COLUMN auth.group_list.id IS 'PK группы.';
COMMENT ON COLUMN auth.group_list.name IS 'Название группы (UNIQUE).';
COMMENT ON COLUMN auth.group_list.description IS 'Описание группы.';

CREATE TABLE auth.role_list (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

COMMENT ON TABLE auth.role_list IS 'Справочник ролей доступа.';
COMMENT ON COLUMN auth.role_list.id IS 'PK роли.';
COMMENT ON COLUMN auth.role_list.name IS 'Название роли.';
COMMENT ON COLUMN auth.role_list.description IS 'Описание роли.';

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