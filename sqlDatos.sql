USE infotel_dev;

-- 1. CATEGORÍAS
INSERT INTO categoria (id_categoria, nombre, descripcion, icono_url) VALUES
(1, 'Ponchos', '', ''),
(2, 'Chalecos', '', ''),
(3, 'Cardigans', '', ''),
(4, 'Capas', '', ''),
(5, 'Polivestidos', '', ''),
(6, 'Sweaters', '', ''),
(7, 'Ruanas', '', ''),
(8, 'Chales', '', ''),
(9, 'Camisetas', '', ''),
(10, 'Casacas', '', ''),
(11, 'Accesorios', '', ''),
(12, 'Hogar', '', ''),
(13, 'Servicios', '', '');

-- 2. PRODUCTOS
INSERT INTO producto (id_producto, nombre, descripcion, tallas, material, precio, stock, imagen_url, categoria_id) VALUES
(1, 'Poncho Tortuga', 'Poncho en Alpacril con cuello tortuga y botones decorativos.', '14, 16, S, M, L', 'Alpacril', 140.00, 10, '', 1),
(2, 'Chaleco Estrella', 'Chaleco en Alpacril con cierre clásico.', 'S, M, L', 'Alpacril', 95.00, 8, '', 2),
(3, 'Cardigan Camila', 'Cardigan elegante con cuello capucha y botones.', 'S, M, L', 'Alpacril', 100.00, 7, '', 3),
(4, 'Capa Misa', 'Capa larga con botones y cuello camisa.', 'Estandar', 'Alpacril', 110.00, 6, '', 4),
(5, 'Polivestido Tortuga', 'Polivestido con cuello tortuga, ideal para clima frío.', 'Estandar', 'Alpacril', 120.00, 9, '', 5),
(6, 'Sweater Capucha', 'Sweater unisex con capucha y tejido suave.', 'S, M, L, XL', 'Algodón', 105.00, 12, '', 6),
(7, 'Ruana Perla', 'Ruana de lino: frescura, elegancia y estilo.', 'Estandar', 'Lino', 85.00, 10, '', 7),
(8, 'Chal de Lino', 'Chal ligero y elegante de lino.', 'Estandar', 'Lino', 70.00, 15, '', 8),
(9, 'Camiseta RO', 'Camiseta de algodón personalizada.', '06-08-10-12-14-16-S-M-L-XL', 'Algodón', 45.00, 20, '', 9),
(10, 'Casaca Niño', 'Casaca abrigadora para niños.', '06-08-10-12-14-16', 'Mixto', 65.00, 10, '', 10),
(11, 'Mochila Camila', 'Mochila con diseño tradicional y moderno.', 'Única', 'Tela tejida andina', 85.00, 15, '', 11),
(12, 'Cojín Alpacril', 'Cojín suave para el hogar en varios colores.', 'Estandar', 'Alpacril', 60.00, 18, '', 12);

-- 3. COLORES GENERALES
INSERT INTO color (id_color, nombre) VALUES
(1, 'AZUL'), (2, 'BEIGE'), (3, 'CAFE'), (4, 'JASPEADO'), (5, 'LLAMITA'),
(6, 'GRIS'), (7, 'MARENGO'), (8, 'NEGRO'), (9, 'PLOMO PLATA'),
(10, 'AMARILLO'), (11, 'BOLIVAR'), (12, 'CELESTE'), (13, 'MORADO'),
(14, 'PLOMO'), (15, 'ROJO'), (16, 'ROSADO'), (17, 'VERDE'), (18, 'MARFIL');

-- 4. ASOCIACIONES PRODUCTO - COLOR
INSERT INTO producto_color (producto_id, color_id) VALUES
-- Poncho Tortuga (producto_id = 1)
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(1, 6), (1, 7), (1, 8), (1, 9),

-- Chaleco Estrella (producto_id = 2)
(2, 1), (2, 2), (2, 3), (2, 6),

-- Mochila Camila (producto_id = 11)
(11, 10), (11, 11), (11, 12), (11, 13),
(11, 14), (11, 15), (11, 16), (11, 17),

-- Ruana Perla (producto_id = 7)
(7, 18);