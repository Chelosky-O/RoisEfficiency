-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2023 a las 01:03:36
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `roisefficiency`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admins`
--

CREATE TABLE `admins` (
  `primer_nombre` varchar(20) NOT NULL,
  `segundo_nombre` varchar(20) NOT NULL,
  `primer_apellido` varchar(20) NOT NULL,
  `segundo_apellido` varchar(20) NOT NULL,
  `rut` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `admins`
--

INSERT INTO `admins` (`primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `rut`, `email`, `password`) VALUES
('admin', 'admin', 'admin', 'admin', 'admin', 'admin@admin.cl', 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `id` bigint(11) NOT NULL,
  `cost` decimal(8,2) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `product_ids` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`id`, `cost`, `name`, `email`, `status`, `address`, `phone`, `date`, `product_ids`) VALUES
(6, 30000.00, 'Ivan Andres Caceres Satorres', 'ivan.caceres_s@mail.udp.cl', 'not paid', 'Mi Casita SIIIIII', '+56988388509', '2023-06-24 20:58:55', '1'),
(7, 24990.00, 'Ivan Andres Caceres Satorres', 'ivan.caceres_s@mail.udp.cl', 'not paid', 'Mi Casita SIIIIII', '1234567890', '2023-06-24 21:05:48', '3'),
(8, 30000.00, 'Ivan Andres Caceres Satorres', 'ivan.caceres_s@mail.udp.cl', 'not paid', 'Mi Casita SIIIIII', '1234567890', '2023-06-24 21:11:34', '1'),
(9, 27990.00, 'Ivan Andres Caceres Satorres', 'ivan.caceres_s@mail.udp.cl', 'not paid', 'Mi Casita SIIIIII', '1234567890', '2023-06-24 21:13:03', '2'),
(10, 24990.00, 'Ivan Andres Caceres Satorres', 'ivan.caceres_s@mail.udp.cl', 'not paid', 'Mi Casita SIIIIII', '123', '2023-06-24 21:15:47', '3'),
(11, 27990.00, 'Ivan Andres Caceres Satorres', 'ivan.caceres_s@mail.udp.cl', 'not paid', 'Mi Casita SIIIIII', '123', '2023-06-24 21:36:57', '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders_items`
--

CREATE TABLE `orders_items` (
  `id` bigint(11) NOT NULL,
  `order_id` bigint(11) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` decimal(8,2) NOT NULL,
  `product_image` varchar(255) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `order_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `id` bigint(11) NOT NULL,
  `order_id` bigint(11) NOT NULL,
  `transaction_id` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `sale_price` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `sale_price`, `quantity`, `image`) VALUES
(1, 'VistaClara', 'Lentes de alta calidad que proporcionan una visión nítida', 50000, NULL, 10, 'Lente_1.PNG'),
(2, 'Brillioptic', 'Lentes con tecnología avanzada para una visión brillante', 65000, NULL, 5, 'Lente_2.PNG'),
(3, 'CrystalView', 'Lentes cristalinos que ofrecen una claridad excepcional', 75000, NULL, 8, 'Lente_3.PNG'),
(4, 'SharpFocus', 'Lentes diseñados para una visión enfocada y precisa', 55000, NULL, 12, 'Lente_4.PNG'),
(5, 'OptiGlow', 'Lentes que realzan los colores y brindan una visión vívida', 60000, NULL, 15, 'Lente_5.PNG'),
(6, 'ClarityMax', 'Lentes de máxima claridad y definición', 70000, NULL, 6, 'Lente_6.PNG'),
(7, 'EliteVision', 'Lentes de calidad premium para una visión excepcional', 80000, NULL, 3, 'Lente_7.PNG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `primer_nombre` varchar(20) NOT NULL,
  `segundo_nombre` varchar(20) NOT NULL,
  `primer_apellido` varchar(20) NOT NULL,
  `segundo_apellido` varchar(20) NOT NULL,
  `rut` varchar(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `receta` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `rut`, `email`, `direccion`, `receta`, `password`) VALUES
('prueba', 'prueba', 'prueba', 'prueba', '15616115-5', 'asd@asd.com', 'asd', '', '123'),
('Ivan', 'Andres', 'Caceres', 'Satorres', '20707065-3', 'ivan.caceres_s@mail.udp.cl', 'Mi Casita SIIIIII', 'No tengo porque nunca he tenido lentes', '123'),
('prueba2', 'p', 'p', 'p', '20707065-4', 'pruebaaa@prueba.com', 'lol', '', '123'),
('SIMA', 'uban', 'muñoz', 'cáceres', '21199140-2', 'sima@gmail.com', 'Amalia Armstrong 7541', '', 'poto');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `orders_items`
--
ALTER TABLE `orders_items`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`rut`,`email`),
  ADD UNIQUE KEY `uc_rut` (`rut`),
  ADD UNIQUE KEY `uc_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `orders_items`
--
ALTER TABLE `orders_items`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
