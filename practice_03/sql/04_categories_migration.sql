BEGIN;
CREATE TABLE categories (
    category_id 	bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name       		text NOT NULL UNIQUE
);

INSERT INTO categories (name) 
VALUES ('Смартфони'),
       ('Навушники'),
       ('Розумні годинники'),
       ('Ноутбуки'),
       ('Планшети');


ALTER TABLE products
ADD COLUMN category_id bigint
    REFERENCES categories (category_id) ON DELETE RESTRICT;

UPDATE products p
SET category_id = c.category_id
FROM categories c
WHERE c.name = p.category;

ALTER TABLE products ALTER COLUMN category_id SET NOT NULL;

ALTER TABLE products DROP COLUMN category;

COMMIT;