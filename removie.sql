-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-09-2025 a las 00:05:33
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `removie`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `id_calificacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_contenido` int(11) NOT NULL,
  `puntuacion` float NOT NULL,
  `comentario` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id_contenido` int(11) NOT NULL,
  `tmdb_id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `tipo` enum('pelicula','serie') NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_lanzamiento` date DEFAULT NULL,
  `poster_url` varchar(255) DEFAULT NULL,
  `trailer_url` varchar(255) DEFAULT NULL,
  `idioma_original` varchar(10) DEFAULT NULL,
  `calificacion_promedio` float DEFAULT NULL,
  `fecha_ultima_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contenido`
--

INSERT INTO `contenido` (`id_contenido`, `tmdb_id`, `titulo`, `tipo`, `descripcion`, `fecha_lanzamiento`, `poster_url`, `trailer_url`, `idioma_original`, `calificacion_promedio`, `fecha_ultima_actualizacion`) VALUES
(1, 755898, 'La guerra de los mundos', 'pelicula', 'Will Radford, un destacado analista de ciberseguridad, pasa sus días rastreando posibles amenazas a la seguridad nacional a través de un programa de vigilancia masiva. Un ataque de una entidad desconocida le lleva a cuestionarse si el gobierno le está ocultando algo a él... y al resto del mundo.', '2025-07-29', 'https://image.tmdb.org/t/p/w500/fjgSlNGECNgVeMJaOdDAXmGh7ZM.jpg', NULL, 'en', 4.176, '2025-08-18 18:05:18'),
(2, 1061474, 'Superman', 'pelicula', 'En un mundo que ha perdido la fe en la bondad, Superman lucha por reconciliar su herencia kryptoniana con los valores humanos que moldearon su carácter. Criado en la Tierra, representa la verdad, la justicia y el estilo americano, pero debe enfrentarse a un mundo cínico que cuestiona sus ideales. Entre el deber de proteger a la humanidad y la búsqueda de su identidad, Superman demuestra que la esperanza y la bondad nunca pasan de moda, incluso en los tiempos más oscuros, inspirando a otros a creer en un futuro mejor.', '2025-07-09', 'https://image.tmdb.org/t/p/w500/fvUJb08yatV2b3NUSwuYdQKYoFd.jpg', NULL, 'en', 7.616, '2025-08-18 18:05:19'),
(3, 1234821, 'Jurassic World: El renacer', 'pelicula', 'Cinco años después de los eventos de \"Dominion\", la ecología del planeta ha demostrado ser insoportable para los dinosaurios, donde los pocos que quedan viven aislados en las regiones ecuatoriales. Zora Bennett es contratada para dirigir a un equipo de especialistas cuyo objetivo es conseguir el material genético de las tres criaturas más grandes, las cuales tienen en su ADN la clave para fabricar un medicamento que aportará grandes beneficios a la humanidad. Pero la operación se cruzará con una familia cuyo barco volcó y todos acabarán en una isla prohibida ocupada por dinosaurios de numerosas especies, donde tendrán que hacer lo imposible para sobrevivir.', '2025-07-01', 'https://image.tmdb.org/t/p/w500/v49ceVcpW4Vj0tveTWlzrRdsFf4.jpg', NULL, 'en', 6.378, '2025-08-18 18:05:20'),
(4, 1382406, 'Venganza implacable', 'pelicula', 'Después de que su esposa e hija sean brutalmente asesinadas a manos de unos misteriosos sicarios vinculados a un sanguinario sindicato del crimen organizado, An Bai (Tony Jaa), un veterano experto en Muay Thai, se propone desentrañar la verdad e inicia una implacable misión de venganza.', '2024-12-05', 'https://image.tmdb.org/t/p/w500/h8DNi9XJKUS2nOzU5qEFEg7R0N6.jpg', NULL, 'zh', 7.515, '2025-08-18 18:05:21'),
(5, 1241470, 'Osiris', 'pelicula', 'Un equipo de comandos de las Fuerzas Especiales despierta en una nave sin recordar cómo llegaron. Allí descubren que están siendo perseguidos por una implacable raza alienígena.', '2025-07-25', 'https://image.tmdb.org/t/p/w500/3YtZHtXPNG5AleisgEatEfZOT2w.jpg', NULL, 'en', 6.515, '2025-08-18 18:05:22'),
(6, 575265, 'Misión: Imposible - Sentencia final', 'pelicula', 'El agente Ethan Hunt continúa su misión de impedir que Gabriel controle el tecnológicamente omnipotente programa de IA conocido como \"the Entity\".', '2025-05-17', 'https://image.tmdb.org/t/p/w500/haOjJGUV00dKlZaJWgjM1UD1cJV.jpg', NULL, 'en', 7.207, '2025-08-18 18:05:23'),
(7, 1311031, 'Guardianes de la noche: Kimetsu no Yaiba La fortaleza infinita', 'pelicula', 'El Cuerpo de Cazadores de Demonios se enfrenta a los Doce Kizuki restantes antes de enfrentarse a Muzan en el Castillo del Infinito para derrotarlo de una vez por todas.', '2025-07-18', 'https://image.tmdb.org/t/p/w500/6N21gcFbhT4ocdTU4MGREAaM5Vz.jpg', NULL, 'ja', 7.2, '2025-08-18 18:05:24'),
(8, 1319895, 'Hostile Takeover', 'pelicula', '', '2025-08-08', 'https://image.tmdb.org/t/p/w500/vntwlS3CAKfoLTs90GaoK6lymBC.jpg', NULL, 'en', 7.364, '2025-08-18 18:05:25'),
(9, 1087192, 'Cómo entrenar a tu dragón', 'pelicula', 'En la escarpada isla de Mema, donde vikingos y dragones han sido enemigos acérrimos durante generaciones, Hipo se desmarca desafiando siglos de tradición cuando entabla amistad con Desdentao, un temido dragón Furia Nocturna. Su insólito vínculo revela la verdadera naturaleza de los dragones y desafía los cimientos de la sociedad vikinga.', '2025-06-06', 'https://image.tmdb.org/t/p/w500/kjQXYc2Abhy3TBgAZGzJRhN1JaV.jpg', NULL, 'en', 8, '2025-08-18 18:05:26'),
(10, 1195631, 'Guillermo Tell', 'pelicula', 'En el siglo XIV, las potencias europeas luchan por el dominio del Sacro Imperio Romano. El ambicioso Imperio Austríaco invade la pacífica Suiza, arrasando con todo a su paso. Guillermo Tell, un humilde cazador, se ve obligado a empuñar las armas cuando su familia y su tierra sufren la tiranía del rey austríaco y sus despiadados señores de la guerra.', '2025-01-17', 'https://image.tmdb.org/t/p/w500/f9JBhW0bjkfPufuyNyhcA5s7NVB.jpg', NULL, 'en', 6.376, '2025-08-18 18:05:27'),
(11, 1185528, '射雕英雄传：侠之大者', 'pelicula', '', '2025-01-29', 'https://image.tmdb.org/t/p/w500/xDYngVPSl6zdepSsSxAZRvScUOM.jpg', NULL, 'zh', 6.617, '2025-08-18 18:05:28'),
(12, 1106289, 'El último encargo', 'pelicula', 'Una rutinaria recogida de dinero da un giro salvaje cuando dos incompatibles conductores de camión, Russell y Travis, son asaltados por despiadados criminales a las órdenes de la hábil mente maestra Zoe, cuyos planes van mucho más allá del cargamento de dinero en efectivo. Mientras el caos se desata a su alrededor, este improbable dúo tiene que enfrentarse en situaciones de alto riesgo, con personalidades que chocan continuamente y un muy mal día que no deja de empeorar.', '2025-07-27', 'https://image.tmdb.org/t/p/w500/lbpyI9nwzSVDjS7OnE0uC41UciP.jpg', NULL, 'en', 6.5, '2025-08-18 18:05:30'),
(13, 1078605, 'Weapons', 'pelicula', 'Cuando todos los alumnos de una misma clase, salvo uno, desaparecen misteriosamente la misma noche y exactamente a la misma hora, la pequeña ciudad donde viven se pregunta quién o qué está detrás de su desaparición.', '2025-08-04', 'https://image.tmdb.org/t/p/w500/aYEFAf5t3tQDztvlhrNiuMVijNp.jpg', NULL, 'en', 7.585, '2025-08-18 18:05:30'),
(14, 936108, 'Pitufos', 'pelicula', 'Película musical de animación centrada en las icónicas creaciones de Peyo. Cuando Papá Pitufo es secuestrado de forma misteriosa por los malvados brujos Razamel y Gargamel, Pitufina lleva a los Pitufos a una misión al mundo real para salvarle. Con la ayuda de nuevos amigos, los Pitufos deberán descubrir qué define su destino para salvar el universo.', '2025-07-05', 'https://image.tmdb.org/t/p/w500/zBdQclxQnEDOhDOjkKgKPW6jEHh.jpg', NULL, 'en', 6.036, '2025-08-18 18:05:31'),
(15, 986206, 'Night Carnage', 'pelicula', '', '2025-07-29', 'https://image.tmdb.org/t/p/w500/w0wjPQKhlqisSbylf1sWZiNyc2h.jpg', NULL, 'en', 5.925, '2025-08-18 18:05:31'),
(16, 1285247, 'El escuadrón del crimen', 'pelicula', 'En medio de la invasión del Día D, un grupo de soldados estadounidenses recibe órdenes de introducir clandestinamente a un miembro de la Resistencia francesa tras las líneas enemigas para asesinar a un objetivo nazi de alto valor.', '2024-07-05', 'https://image.tmdb.org/t/p/w500/rbRdDf2RpE33XOEY9yhdlzrlsUy.jpg', NULL, 'en', 5.667, '2025-08-18 18:05:32'),
(17, 1155281, 'La creación de los dioses 2: Fuerza demoníaca', 'pelicula', 'Taishi Wen Zhong condujo a Xiqi al ejército de la dinastía Shang, incluidos Deng Chanyu y cuatro generales de la familia Mo. Con la ayuda de inmortales de Kunlun como Jiang Ziya, Ji Fa dirigió al ejército y a los civiles de Xiqi para defender su patria.', '2025-01-29', 'https://image.tmdb.org/t/p/w500/vM42VhcagVqVhl099en5pvMy4sq.jpg', NULL, 'zh', 6.28, '2025-08-18 18:05:32'),
(18, 980477, 'Ne Zha 2', 'pelicula', 'Cuando los cuerpos de los dos amigos, Aobing y Nezha, están a punto de ser destruidos, se les permite que sus almas sigan existiendo. Su maestro, Taiyi Zhenren, restaura sus cuerpos con la ayuda de una flor de loto. Después de esto, Nezha parte en busca de enfrentar al Rey Dragón del Mar del Este, Ao Guang.', '2025-01-29', 'https://image.tmdb.org/t/p/w500/kJiTA2CBGEr3He3kSt2lLTvTuEB.jpg', NULL, 'zh', 7.98, '2025-08-18 18:05:33'),
(19, 617126, 'Los Cuatro Fantásticos: Primeros pasos', 'pelicula', 'Con un mundo retrofuturista inspirado en los años 60 como telón de fondo, la Primera Familia de Marvel deberá hacer frente a su mayor desafío hasta la fecha. Obligados a buscar el equilibrio entre su papel de héroes y sus fuertes vínculos familiares, tendrán que defender la Tierra de un hambriento dios espacial llamado Galactus y su intrigante heraldo, Estela Plateada.', '2025-07-23', 'https://image.tmdb.org/t/p/w500/ckfiXWGEMWrUP53cc6QyHijLlhl.jpg', NULL, 'en', 7.2, '2025-08-18 18:05:33'),
(20, 803796, 'Las guerreras k-pop', 'pelicula', 'Cuando no están llenando estadios, las superestrellas del K-pop Rumi, Mira y Zoey usan sus poderes secretos para proteger a sus fans de una amenaza sobrenatural.', '2025-06-20', 'https://image.tmdb.org/t/p/w500/swQRKmW7RLhncPYHvM0RHz8b7bT.jpg', NULL, 'en', 8.4, '2025-08-18 18:05:34'),
(21, 119051, 'Miércoles', 'serie', 'Miércoles Addams, lista, sarcástica y un poco muerta por dentro, investiga una oleada de asesinatos mientras hace amigos —y enemigos— en la Academia Nunca Más.', '2022-11-23', 'https://image.tmdb.org/t/p/w500/bNKwoYqkCXfIhhr5Jz8slrsw32r.jpg', NULL, 'en', 8.404, '2025-08-18 18:05:37'),
(22, 244808, 'ぬきたし THE ANIMATION', 'serie', '', '2025-07-19', 'https://image.tmdb.org/t/p/w500/zlybZJXfu4IpPnWXhnRtobl9BgZ.jpg', NULL, 'ja', 7.281, '2025-08-18 18:05:38'),
(23, 157239, 'Alien: Planeta Tierra', 'serie', 'Cuando una misteriosa nave se estrella contra la Tierra, una joven y un variopinto grupo de soldados tácticos hacen un fatídico hallazgo que los pone cara a cara con la mayor amenaza del planeta. El equipo de rescate busca supervivientes entre los restos de la colisión y se topa con una forma de vida depredadora que levanta más misterios y miedos de los que cabría imaginarse. Debido a esta nueva amenaza, el equipo deberá luchar por sobrevivir. Lo que decidan hacer con este descubrimiento podría cambiar el planeta Tierra tal y como lo conocen.', '2025-08-12', 'https://image.tmdb.org/t/p/w500/8IIPZe4V2xNYFWY7lBY6GpN2L8O.jpg', NULL, 'en', 7.9, '2025-08-18 18:05:50'),
(24, 79744, 'The Rookie', 'serie', 'Comenzar de nuevo no es fácil, especialmente para el chico de una ciudad pequeña John Nolan que, después de un incidente que cambia su vida, está persiguiendo su sueño de ser un oficial de policía de Los Ángeles. Como el novato más viejo de la fuerza, se ha encontrado con el escepticismo de algunos de los superiores que lo ven como una crisis ambulante.', '2018-10-16', 'https://image.tmdb.org/t/p/w500/xGJ98jmU88PNhxSxcsX8WWmJJCa.jpg', NULL, 'en', 8.524, '2025-08-18 18:05:51'),
(25, 121876, '花儿与少年', 'serie', '', '2014-04-25', 'https://image.tmdb.org/t/p/w500/xj8EEPB0ipfja5ZbcJLGucZtoUA.jpg', NULL, 'zh', 6.778, '2025-08-18 18:06:03'),
(26, 194766, 'El verano en que me enamoré', 'serie', 'Una serie basada en el superventas del New York Times. En verano, Belly y su familia van a la casa de la playa de los Fisher en Cousins. Todos los veranos son iguales... hasta que Belly cumple 16 años. Las relaciones se cuestionarán, se revelarán dolorosas verdades, y Belly cambiará para siempre. Es el verano del primer amor, del primer desamor y del crecimiento: es el verano en que se pone guapa.', '2022-06-16', 'https://image.tmdb.org/t/p/w500/wDeFJIE5chr2P8iKW6HjyHKNm8x.jpg', NULL, 'en', 8.2, '2025-08-18 18:06:42'),
(27, 227114, 'Butterfly', 'serie', 'David Jung, un misterioso agente de inteligencia de Estados Unidos que se esconde en Corea del Sur, ve como su vida se desmorona cuando una terrible decisión de su pasado resurge para atormentarlo y se convierte en el objetivo de Rebecca, una joven asesina, y de Caddis, la siniestra organización para la que esta trabaja.', '2025-08-13', 'https://image.tmdb.org/t/p/w500/iyNaZhjN5ExXDqB80kqazoRYd1D.jpg', NULL, 'en', 7.5, '2025-08-18 18:06:42'),
(28, 93405, 'El juego del calamar', 'serie', 'Cientos de personas con problemas de dinero aceptan una invitación rarísima para competir en juegos infantiles. Dentro los esperan un tentador premio y desafíos letales.', '2021-09-17', 'https://image.tmdb.org/t/p/w500/g72YfmqUU0AlbDXRiYmDZWs28f7.jpg', NULL, 'ko', 7.863, '2025-08-18 18:06:48'),
(29, 2734, 'Ley y orden: Unidad de Víctimas Especiales', 'serie', '‘Ley y Orden: Unidad de Víctimas Especiales’ es una serie de televisión estadounidense grabada en Nueva York donde es también principalmente producida. Con el estilo de la original ‘Ley y Orden’ los episodios son usualmente \"sacados de los titulares\" o basados libremente en verdaderos asesinatos que han recibido la atención de los medios.', '1999-09-20', 'https://image.tmdb.org/t/p/w500/2Rk9me3Jlho02Y9RRTodfuiWULy.jpg', NULL, 'en', 7.937, '2025-08-18 18:06:55'),
(30, 1405, 'Dexter', 'serie', 'Serie de suspense que narra la historia de un hombre extraño llamado Dexter Morgan. Cuando era niño, Dexter fue maltratado y abandonado por sus padres, ahora es un exitoso e importante forense patológico... pero bajo su carismática personalidad, se esconde una terrible verdad. Dexter ha canalizado sus innatas necesidades homicidas en una segunda profesión que guarda celosamente en secreto: buscar, dar caza y asesinar brutalmente a despiadados criminales.', '2006-10-01', 'https://image.tmdb.org/t/p/w500/q8dWfc4JwQuv3HayIZeO84jAXED.jpg', NULL, 'en', 8.214, '2025-08-18 18:07:03'),
(31, 0, 'Matrix', 'pelicula', 'Cuando un extranjero, Tadeo, es encontrado gravemente herido cerca de la aldea, el minero Li Kung y su esposa Ah Ni le ofrecen refugio. Según se va  curando se va involucrando en un conflicto que enfrenta a la gente del pueblo contra el malvado Maestro Ho, su malvado clan del Escarabajo y el aterrador Señor Pi.', NULL, 'https://image.tmdb.org/t/p/w500/cAY1L0BOzehTHc8W4J5ElEKdCr6.jpg', 'https://www.youtube.com/watch?v=NfvI_wpDpwQ', NULL, 5.5, '2025-09-22 18:52:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_generos`
--

CREATE TABLE `contenido_generos` (
  `id_contenido` int(11) NOT NULL,
  `id_genero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contenido_generos`
--

INSERT INTO `contenido_generos` (`id_contenido`, `id_genero`) VALUES
(1, 15),
(1, 17),
(2, 1),
(2, 2),
(2, 15),
(3, 1),
(3, 2),
(3, 15),
(4, 1),
(4, 5),
(4, 17),
(5, 1),
(5, 11),
(5, 15),
(6, 1),
(6, 2),
(6, 17),
(7, 1),
(7, 3),
(7, 9),
(7, 17),
(8, 1),
(8, 4),
(8, 17),
(9, 1),
(9, 2),
(9, 8),
(9, 9),
(10, 1),
(10, 7),
(10, 10),
(11, 1),
(11, 7),
(11, 10),
(12, 1),
(12, 4),
(12, 5),
(13, 11),
(13, 13),
(14, 3),
(14, 8),
(14, 9),
(15, 1),
(15, 11),
(15, 14),
(16, 1),
(16, 18),
(17, 1),
(17, 9),
(17, 18),
(18, 1),
(18, 2),
(18, 3),
(18, 9),
(19, 2),
(19, 15),
(20, 1),
(20, 3),
(20, 4),
(20, 9),
(20, 12),
(21, 4),
(21, 13),
(21, 31),
(22, 3),
(22, 4),
(22, 7),
(22, 31),
(23, 7),
(23, 31),
(24, 4),
(24, 5),
(24, 7),
(25, 30),
(26, 7),
(27, 7),
(27, 20),
(28, 7),
(28, 13),
(28, 20),
(29, 5),
(29, 7),
(29, 13),
(30, 5),
(30, 7),
(30, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `episodios`
--

CREATE TABLE `episodios` (
  `id_episodio` int(11) NOT NULL,
  `id_temporada` int(11) NOT NULL,
  `numero_episodio` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `fecha_lanzamiento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `episodios`
--

INSERT INTO `episodios` (`id_episodio`, `id_temporada`, `numero_episodio`, `titulo`, `descripcion`, `duracion`, `fecha_lanzamiento`) VALUES
(1, 1, 1, 'Los miércoles son tristes', 'Cuando expulsan a Miércoles por orquestar una broma deliciosamente perversa, sus padres deciden enviarla a la Academia Nunca Más: el internado donde se enamoraron.', 60, '2022-11-23'),
(2, 1, 2, 'La tristeza es solitaria', 'El sheriff interroga a Miércoles sobre los extraños sucesos de la noche anterior. Después, Miércoles se enfrenta a una oponente de armas tomar en la competitiva Copa Poe.', 49, '2022-11-23'),
(3, 1, 3, 'Tristemente amiga o enemiga', 'Miércoles descubre una sociedad secreta. En el Día del Acercamiento, los marginados de Nunca Más se codean con los normis de Jericó en Mundo Peregrino.', 49, '2022-11-23'),
(4, 1, 4, 'Qué noche la de ese día', 'Miércoles le pide a Xavier que la acompañe al baile Rave\'N, lo que desata los celos de Tyler... pero Cosa se guarda un as en la manga. Entretanto, Eugene vigila la cueva.', 50, '2022-11-23'),
(5, 1, 5, 'Quien siembra vientos recoge tristeza', 'Miércoles indaga en el pasado de su familia durante el fin de semana de padres. Enid se siente obligada a transformarse.', 53, '2022-11-23'),
(6, 1, 6, 'Hoy por mí, mañana por mí', 'Los amigos de Miércoles le montan una fiesta de cumpleaños sorpresa. Lo hacen con buena intención... pero ella preferiría pasarlo resolviendo los asesinatos.', 51, '2022-11-23'),
(7, 1, 7, 'Qué triste que todavía no me conozcas', 'El excéntrico tío Fétido llega de visita y cuenta su teoría sobre el monstruo. A regañadientes, Miércoles accede a quedar con Tyler en la cripta de Crackstone.', 48, '2022-11-23'),
(8, 1, 8, 'Una bandada de tristeza', 'Miércoles se mete en un lío con la directora Weems, pero eso es solo el comienzo de sus problemas. Para luchar contra un mal ancestral, necesitará la ayuda de sus amigos.', 53, '2022-11-23'),
(9, 3, 1, 'La vuelta a la tristeza', 'Tras unas productivas vacaciones de verano, Miércoles regresa a Nunca Más convertida en una celebridad... y en el objetivo de un peligroso acosador.', 60, '2025-08-06'),
(10, 3, 2, 'Más vale diablo triste que conocido', 'El caos campa a sus anchas mientras Nunca Más celebra su Día de las Bromas anual. Miércoles se ve las caras con un viejo enemigo y encuentra un aliado en alguien inesperado.', 61, '2025-08-06'),
(11, 3, 3, 'La llamada de la tristeza', 'Miércoles, despojada de sus poderes y del libro de Goody, se ve obligada a hacer de detective a la vieja usanza en una acampada escolar.', 59, '2025-08-06'),
(12, 3, 4, 'Si las tristezas hablaran', 'Fétido y Cosa se suman a la investigación de Miércoles. Bianca intenta ocultar un secreto... y acaba descubriendo otro.', 60, '2025-08-06'),
(13, 3, 5, 'Episodio 5', '', NULL, '2025-09-03'),
(14, 3, 6, 'Episodio 6', '', NULL, '2025-09-03'),
(15, 3, 7, 'Episodio 7', '', NULL, '2025-09-03'),
(16, 3, 8, 'Episodio 8', '', NULL, '2025-09-03'),
(17, 2, 1, 'Episodio 1', '', 23, '2025-07-19'),
(18, 2, 2, 'Episodio 2', '', 23, '2025-07-26'),
(19, 2, 3, 'Episodio 3', '', 23, '2025-08-02'),
(20, 2, 4, 'Episodio 4', '', 23, '2025-08-09'),
(21, 2, 5, 'Episodio 5', '', 23, '2025-08-16'),
(22, 2, 6, 'Episodio 6', '', NULL, '2025-08-23'),
(23, 2, 7, 'Episodio 7', '', NULL, '2025-08-30'),
(24, 2, 8, 'Episodio 8', '', NULL, '2025-09-06'),
(25, 2, 9, 'Episodio 9', '', NULL, '2025-09-13'),
(26, 2, 10, 'Episodio 10', '', NULL, '2025-09-20'),
(27, 2, 11, 'Episodio 11', '', NULL, '2025-09-27'),
(28, 4, 1, 'Nunca Jamás', 'Tras estrellarse una nave espacial en la Tierra, una joven busca a su hermano.', 65, '2025-08-12'),
(29, 4, 2, 'Míster Octubre', 'Mientras crece la tensión entre corporaciones, tiene lugar una reunión y un secreto sale a la luz.', 56, '2025-08-12'),
(30, 4, 3, 'Episodio 3', '', 54, '2025-08-19'),
(31, 4, 4, 'Episodio 4', '', 59, '2025-08-26'),
(32, 4, 5, 'Episodio 5', '', NULL, '2025-09-02'),
(33, 4, 6, 'Episodio 6', '', NULL, '2025-09-09'),
(34, 4, 7, 'Episodio 7', '', NULL, '2025-09-16'),
(35, 4, 8, 'Episodio 8', '', NULL, '2025-09-23'),
(36, 5, 1, 'Piloto', 'Comenzar de nuevo no es fácil, especialmente para el chico de una ciudad pequeña John Nolan que, después de un incidente que cambia su vida, está persiguiendo su sueño de ser un oficial de policía.', 43, '2018-10-16'),
(37, 5, 2, 'Curso intensivo', 'Talia obliga a Nolan a confrontar sus instintos morales personales para ser un buen policía después de encontrarse con una víctima de secuestro. Mientras tanto, Lucy está temporalmente con un nuevo oficial de entrenamiento que pone a prueba su paciencia, y Jackson debe enfrentar sus fracasos de frente si quiere ser un oficial.', 43, '2018-10-23'),
(38, 5, 3, 'El bueno, el feo y el malo', 'Después de perder el control de una escena de un crimen, Nolan y Talia debaten si los seres humanos son buenos o malos por naturaleza. Entretanto, a Lucy le preocupa que Tim permita el comportamiento destructivo de su mujer y que no se cuide.', 43, '2018-10-30'),
(39, 5, 4, 'El intercambio', 'Los novatos son emparejados con nuevos compañeros, Nolan tendrá que buscar a un criminal fugado. Jackson tendrá que enfrentarse a sus miedos.', 43, '2018-11-13'),
(40, 5, 5, 'La cacería', 'Nolan y sus compañeros se enfrentan en una competición. Lucy se da cuenta de que Bradford quiere ganar a todo coste', 41, '2018-11-20'),
(41, 5, 6, 'Hawke', 'Nolan y el equipo deben ayudar a capturar a un policía y su antiguo mentor de la academia después de que se convierte en un fugitivo después de un asalto. Mientras tanto, el oficial Tim Bradford necesita que la oficial Lucy Chen aprenda a predecir los movimientos de los delincuentes para capturarlos.', 43, '2018-11-27'),
(42, 5, 7, 'El acompañante', 'Nolan y Bishop deben acompañar a un director de cine en su patrulla. La mujer de Bradford es arrestada por posesión de drogas', 42, '2018-12-04'),
(43, 5, 8, 'Hora de la muerte', 'El oficial Nolan y el oficial Bishop responden a una llamada de alarma silenciosa en una tienda local donde dos hombres intentan robar el lugar. El oficial Nolan persigue a uno de los sospechosos a pie y se ve obligado a tomar una decisión en una fracción de segundo que afectará a sus vidas. Mientras tanto, el oficial Bishop ayuda a coordinar una redada de drogas que está demasiado cerca de casa para el oficial Bradford.', 42, '2018-12-11'),
(44, 5, 9, 'Enfrentamiento', 'Encuentran a la esposa del oficial Bradford herida y él jura encontrar el responsable. Mientras tanto, el oficial Nolan protege su hogar.', 43, '2019-01-08'),
(45, 5, 10, 'De carne y hueso', 'La Oficial Chen trabajará con la Capitán Andersen, y Bradford pide a Chen que la proteja a toda costa. Mientras, Nolan trabajará con el sargento Gray.', 42, '2019-01-15'),
(46, 5, 11, 'Secuoya', 'Una visita no programada del vicepresidente de los Estados Unidos pone a la estación en alerta máxima por una posible amenaza.', 43, '2019-01-22'),
(47, 5, 12, 'Desamor', 'El día más peligroso del año, el Día de San Valentín, tiene al equipo en alerta máxima. Y como ahora Nolan está soltero, invita a todos a una fiesta.', 43, '2019-02-12'),
(48, 5, 13, 'Pillados con las manos en la masa', 'Los primeros meses de trabajo de campo dan a un novato las lecciones más importantes y cruciales. Pero también se convierten en los primeros sospechosos tras el robo de una gran suma de dinero de una redada de drogas.', 43, '2019-02-19'),
(49, 5, 14, 'El día del paisano', 'Nolan intenta demostrar que ha estado progresando más rápido que los otros novatos para convertirse en detective dentro de cinco años. Además, Lucy Chen, Jackson West y él tendrán que tomar todas las decisiones por sí mismos mientras patrullan sin uniforme.', 43, '2019-02-26'),
(50, 5, 15, 'La persecución', 'Cuando un autobús de la prisión se estrella, Nolan intenta impresionar a un negociador de rehenes del FBI que rastrea a un preso que ha escapado.', 43, '2019-03-05'),
(51, 5, 16, 'Luz verde', 'El oficial Nolan recibe una lección de respeto después de que su arresto a un miembro de una pandilla lo lleve a una vida libre para todos. El oficial Chen y el oficial Bradford detienen a Mario López, quien cree que puede hablar para salir de una infracción de tránsito.', 43, '2019-03-19'),
(52, 5, 17, 'La alteración', 'Un terremoto masivo sacude la ciudad y arroja a las patrullas de todos y sus ciudadanos al caos. El Agente Russo recomienda al Oficial Nolan para un detalle protector de Brad Hayes, un hombre cuyos tratos le han puesto un blanco en la cabeza.', 42, '2019-03-26'),
(53, 5, 18, 'Frente interno', 'Cuando uno de sus colegas es arrestado por Asuntos Internos por mentir en el estrado de los testigos, lleva a la liberación de tres delincuentes cuyos casos trabajó y al equipo que se le pide que los revise ahora que están libres. Mientras tanto, el agente Nolan descubre que está siendo demandado por un hombre que afirma haber utilizado una fuerza excesiva que provocó una lesión.', 43, '2019-04-02'),
(54, 5, 19, 'La lista', 'Los novatos tienen que seguir la pista de una serie de crímenes en un período de 48 horas para su examen final.', 43, '2019-04-09'),
(55, 5, 20, 'Caída libre', 'Mientras los novatos se preparan para un gran examen para ver quién pasa a la siguiente etapa de entrenamiento, el Oficial Nolan y el Oficial Bishop son llamados a la escena de un asesinato y se enteran de que la víctima puede estar vinculada a un potencial ataque terrorista en la ciudad de Los Angeles.', 43, '2019-04-16'),
(56, 7, 1, 'Episodio 1', '', 40, '2022-06-10'),
(57, 7, 2, 'Episodio 2', '', 22, '2022-06-17'),
(58, 7, 3, 'Episodio 3', '', 39, '2022-06-18'),
(59, 7, 4, 'Episodio 4', '', 19, '2022-06-23'),
(60, 6, 1, 'Impacto', 'Los oficiales se enfrentan a un ataque a la ciudad de Los Ángeles, que ha dejado a Bradford luchando por su vida.', 43, '2019-09-29'),
(61, 7, 5, 'Episodio 5', '', 30, '2022-06-25'),
(62, 6, 2, 'El detective nocturno', 'Nolan se une al nuevo detective, Pablo Armstrong, para investigar un asesinato provocado por el encuentro de un antiguo interés amoroso.', 43, '2019-10-06'),
(63, 7, 6, 'Episodio 6', '', 66, '2022-06-30'),
(64, 6, 3, 'La apuesta', 'El oficial Nolan trabaja en un caso criminal de alto riesgo que involucra a un agente encubierto de seguridad nacional.', 43, '2019-10-13'),
(65, 7, 7, 'Episodio 7', '', 57, '2022-07-02'),
(66, 7, 8, 'Episodio 8', '', 31, '2022-07-07'),
(67, 6, 4, 'Guerreros y guardianes', 'Nolan tiene un comienzo difícil con su nueva oficial de entrenamiento. Mientras, Bradford se esfuerza por encontrar un regalo apropiado para Rachel.', 43, '2019-10-20'),
(68, 6, 5, 'Amor con mano dura', 'Como parte de su segunda fase de entrenamiento, se les pide a los novatos que desarrollen sus primeros informantes confidenciales. Nolan pronto descubre que no hay dos informantes iguales y lucha con su nueva tarea. La madre de Chen complica su vida hogareña cuando viene a quedarse con ella.', 43, '2019-10-27'),
(69, 7, 9, 'Episodio 9', '', 37, '2022-07-09'),
(70, 6, 6, 'Efectos colaterales', 'Una alerta de emergencia de un inminente ataque con misiles envía a Los Ángeles al caos y a la incertidumbre, mientras que los oficiales intentan mantener la paz y lidiar con sus propios desastres.', 43, '2019-11-03'),
(71, 7, 10, 'Episodio 10', '', 20, '2022-07-14'),
(72, 6, 7, 'Seguridad', 'La relación de John y Jessica se complica mucho más después de dar algunas noticias sorprendentes. A Bradford y West se les asigna un proyecto de policía comunitaria que ayuda a los Watts Rams como entrenadores voluntarios en su clínica de otoño.', 42, '2019-11-10'),
(73, 7, 11, 'Episodio 11', '', 32, '2022-07-16'),
(74, 6, 8, 'Un corte limpio', 'Nolan pasa su cumpleaños custodiando una escena de un crimen en una oficina de abogados. Mientras que Bradford y West reciben una mención honorífica.', 43, '2019-11-17'),
(75, 7, 12, 'Episodio 12', '', 22, '2022-07-21'),
(76, 6, 9, 'Punto álgido', 'Ponen a prueba la confianza del oficial Nolan. Harper ha conseguido una visita con su hija que pone en peligro su vida por problemas del pasado.', 43, '2019-12-01'),
(77, 7, 13, 'Episodio 13', '', 36, '2022-07-23'),
(78, 6, 10, 'El lado oscuro', 'El equipo tiene que escoltar a una famosa asesina en serie. La Oficial Chen conoce a un hombre aparentemente perfecto que despierta su interés.', 43, '2019-12-08'),
(79, 7, 14, 'Episodio 14', '', 25, '2022-07-28'),
(80, 6, 11, 'El día de la muerte', 'La oficial Chen ha sido secuestrada y todo el equipo la busca desesperadamente.', 43, '2020-02-23'),
(81, 7, 15, 'Episodio 15', '', 61, '2022-07-29'),
(82, 6, 12, 'De vez en cuando', 'Nolan lleva a la prometida de su hijo, a un día de patrulla como bervervadora, después de que ella muestra interés por convertirse en policía. La relación de Jackson le produce complicasciones en el trabajo.', 43, '2020-03-01'),
(83, 7, 16, 'Episodio 16', '', 32, '2022-07-30'),
(84, 6, 13, 'Día de seguimiento', 'Nolan recibe noticias que le cambian la vida e invita a Grace a una comida casera en su cocina recién remodelada. Cada unidad tiene la tarea de hacer un seguimiento de los casos inactivos con la esperanza de poder descubrir nuevos pruebas que les ayuden a cerrar la investigación.', 43, '2020-03-08'),
(85, 7, 17, 'Episodio 17', '', 21, '2022-08-04'),
(86, 6, 14, 'Casualidades', 'Nolan y Harper investigan un asesinato que puede tener implicaciones para la seguridad nacional. Bradford debe enfrentar su pasado cuando se cruza con un veterano sin hogar.', 42, '2020-03-15'),
(87, 7, 18, 'Episodio 18', '', 34, '2022-08-06'),
(88, 6, 15, 'Rechazo', 'Nolan descubre que le han suplantado la identidad y que esto podría poner en peligro su posición. El sargento Grey debe enfrentarse a su pasado.', 43, '2020-03-22'),
(89, 7, 19, 'Episodio 19', '', 19, '2022-08-11'),
(90, 6, 16, 'De noche a la mañana', 'Chen y Bradford deben acudir a las audiciones de un programa de televisión, donde Chen se enfrentará a Ryan Seacrest y el jurado.', 43, '2020-04-05'),
(91, 7, 20, 'Episodio 20', '', 32, '2022-08-13'),
(92, 6, 17, 'Control', 'La relación del oficial Nolan y su confidente se pone a prueba cuando descubre que ha estado en la calle vendiendo droga.', 43, '2020-04-12'),
(93, 7, 21, 'Episodio 21', '', 28, '2022-08-18'),
(94, 6, 18, 'Bajo presión', 'Nolan y Harper tienen la tarea de escoltar a 4 delincuentes juveniles a un programa de Scared Straight en una instalación correccional que rápidamente se convierte en una situación desenfrenada. Nolan no está seguro de su relación con Grace después de que ella no le presenta a su ex marido.', 43, '2020-04-26'),
(95, 7, 22, 'Episodio 22', '', 34, '2022-08-20'),
(96, 6, 19, 'La palabra \"C\"', 'Su año de novato está llegando a su fin y Nolan, Chen y West están a punto de ser presionados con más fuerza que nunca antes, ya que sus oficiales de capacitación evalúan si están realmente listos para el trabajo. Después de que uno de sus compañeros novatos está involucrado en un tiroteo, el equipo descubre algunas pruebas inquietantes.', 43, '2020-05-03'),
(97, 7, 23, 'Episodio 23', '', 24, '2022-08-25'),
(98, 6, 20, 'La caza', 'El descubrimiento de Nolan va mucho más allá de lo que esperaba y podría poner en peligro su vida y su carrera.', 43, '2020-05-10'),
(99, 7, 24, 'Episodio 24', '', 29, '2022-08-27'),
(100, 7, 25, 'Episodio 25', '', 22, '2022-09-01'),
(101, 7, 26, 'Episodio 26', '', 27, '2022-08-30'),
(102, 7, 27, 'Episodio 27', '', 39, '2022-09-03'),
(103, 7, 28, 'Episodio 28', '', 77, '2023-10-24'),
(104, 7, 29, 'Episodio 29', '', 40, '2023-10-26'),
(105, 7, 30, 'Episodio 30', '', 36, '2023-10-27'),
(106, 7, 31, 'Episodio 31', '', 65, '2023-10-28'),
(107, 7, 32, 'Episodio 32', '', 93, '2023-10-30'),
(108, 7, 33, 'Episodio 33', '', 45, '2023-10-31'),
(109, 7, 34, 'Episodio 34', '', 38, '2023-11-03'),
(110, 7, 35, 'Episodio 35', '', 72, '2023-11-06'),
(111, 7, 36, 'Episodio 36', '', 32, '2023-11-09'),
(112, 7, 37, 'Episodio 37', '', 34, '2023-11-14'),
(113, 7, 38, 'Episodio 38', '', 49, '2023-11-16'),
(114, 7, 39, 'Episodio 39', '', 66, '2023-11-20'),
(115, 7, 40, 'Episodio 40', '', 49, '2023-11-21'),
(116, 7, 41, 'Episodio 41', '', 51, '2023-11-24'),
(117, 7, 42, 'Episodio 42', '', 39, '2023-11-25'),
(118, 7, 43, 'Episodio 43', '', 48, '2023-11-27'),
(119, 7, 44, 'Episodio 44', '', 46, '2023-11-28'),
(120, 7, 45, 'Episodio 45', '', 35, '2023-11-30'),
(121, 7, 46, 'Episodio 46', '', 68, '2023-12-04'),
(122, 7, 47, 'Episodio 47', '', 32, '2023-12-05'),
(123, 7, 48, 'Episodio 48', '', 48, '2023-12-07'),
(124, 7, 49, 'Episodio 49', '', 47, '2023-12-08'),
(125, 7, 50, 'Episodio 50', '', 30, '2023-12-10'),
(126, 7, 51, 'Episodio 51', '', 52, '2023-12-11'),
(127, 7, 52, 'Episodio 52', '', 35, '2023-12-12'),
(128, 7, 53, 'Episodio 53', '', 46, '2023-12-14'),
(129, 7, 54, 'Episodio 54', '', 34, '2023-12-19'),
(130, 7, 55, 'Episodio 55', '', 60, '2023-12-21'),
(131, 7, 56, 'Episodio 56', '', 36, '2023-12-26'),
(132, 7, 57, 'Episodio 57', '', 59, '2023-12-28'),
(133, 7, 58, 'Episodio 58', '', 37, '2024-01-02'),
(134, 7, 59, 'Episodio 59', '', 42, '2024-01-04'),
(135, 7, 60, 'Episodio 60', '', 44, '2024-01-09'),
(136, 7, 61, 'Episodio 61', '', 39, '2024-01-11'),
(137, 7, 62, 'Episodio 62', '', 35, '2024-01-16'),
(138, 7, 63, 'Episodio 63', '', 36, '2024-01-19'),
(139, 7, 64, 'Episodio 64', '', 47, '2024-01-22'),
(140, 7, 65, 'Episodio 65', '', 29, '2024-01-26'),
(141, 7, 66, 'Episodio 66', '', 43, '2024-01-30'),
(142, 7, 67, 'Episodio 67', '', 79, '2024-01-31'),
(143, 7, 68, 'Episodio 68', '', 47, '2024-02-07'),
(144, 7, 69, 'Episodio 69', '', 75, '2024-07-21'),
(145, 7, 70, 'Episodio 70', '', 38, '2024-07-25'),
(146, 7, 71, 'Episodio 71', '', 97, '2024-08-02'),
(147, 7, 72, 'Episodio 72', '', 66, '2024-08-09'),
(148, 7, 73, 'Episodio 73', '', 48, '2024-08-28'),
(149, 7, 74, 'Episodio 74', '', 36, '2024-08-28'),
(150, 7, 75, 'Episodio 75', '', 30, '2024-08-29'),
(151, 7, 76, 'Episodio 76', '', 33, '2024-08-30'),
(152, 7, 77, 'Episodio 77', '', 33, '2024-08-31'),
(153, 7, 78, 'Episodio 78', '', 34, '2024-09-01'),
(154, 7, 79, 'Episodio 79', '', 31, '2024-09-02'),
(155, 7, 80, 'Episodio 80', '', 35, '2024-09-03'),
(156, 7, 81, 'Episodio 81', '', 61, '2024-09-06'),
(157, 7, 82, 'Episodio 82', '', 41, '2024-09-07'),
(158, 7, 83, 'Episodio 83', '', 41, '2024-09-10'),
(159, 7, 84, 'Episodio 84', '', 42, '2024-09-13'),
(160, 7, 85, 'Episodio 85', '', 44, '2024-09-14'),
(161, 7, 86, 'Episodio 86', '', 31, '2024-09-17'),
(162, 7, 87, 'Episodio 87', '', 50, '2024-09-20'),
(163, 7, 88, 'Episodio 88', '', 34, '2024-09-24'),
(164, 7, 89, 'Episodio 89', '', 44, '2024-09-27'),
(165, 7, 90, 'Episodio 90', '', 29, '2024-09-30'),
(166, 7, 91, 'Episodio 91', '', 36, '2024-10-01'),
(167, 7, 92, 'Episodio 92', '', 40, '2024-10-04'),
(168, 7, 93, 'Episodio 93', '', 32, '2024-10-08'),
(169, 7, 94, 'Episodio 94', '', 43, '2024-10-11'),
(170, 7, 95, 'Episodio 95', '', 32, '2024-10-15'),
(171, 7, 96, 'Episodio 96', '', 39, '2024-10-18'),
(172, 7, 97, 'Episodio 97', '', 29, '2024-10-21'),
(173, 7, 98, 'Episodio 98', '', 30, '2024-10-22'),
(174, 7, 99, 'Episodio 99', '', 30, '2024-10-24'),
(175, 7, 100, 'Episodio 100', '', 34, '2024-10-25'),
(176, 7, 101, 'Episodio 101', '', 41, '2024-10-29'),
(177, 7, 102, 'Episodio 102', '', 52, '2024-10-31'),
(178, 7, 103, 'Episodio 103', '', 41, '2024-11-01'),
(179, 7, 104, 'Episodio 104', '', 32, '2024-11-05'),
(180, 7, 105, 'Episodio 105', '', 44, '2024-11-07'),
(181, 7, 106, 'Episodio 106', '', 30, '2024-11-11'),
(182, 7, 107, 'Episodio 107', '', 32, '2024-11-12'),
(183, 7, 108, 'Episodio 108', '', 41, '2024-11-14'),
(184, 7, 109, 'Episodio 109', '', 30, '2024-11-19'),
(185, 7, 110, 'Episodio 110', '', 43, '2024-11-22'),
(186, 7, 111, 'Episodio 111', '', 30, '2024-11-26'),
(187, 7, 112, 'Episodio 112', '', 42, '2024-11-28'),
(188, 7, 113, 'Episodio 113', '', 40, '2024-12-02'),
(189, 7, 114, 'Episodio 114', '', 32, '2024-12-05'),
(190, 7, 115, 'Episodio 115', '', 70, '2025-08-09'),
(191, 7, 116, 'Episodio 116', '', 17, '2025-08-10'),
(192, 7, 117, 'Episodio 117', '', 17, '2025-08-11'),
(193, 7, 118, 'Episodio 118', '', 17, '2025-08-12'),
(194, 7, 119, 'Episodio 119', '', NULL, '2025-08-13'),
(195, 7, 120, 'Episodio 120', '', 59, '2025-08-14'),
(196, 7, 121, 'Episodio 121', '', 40, '2025-08-15'),
(197, 7, 122, 'Episodio 122', '', 37, '2025-08-17'),
(198, 7, 123, 'Episodio 123', '', 16, '2025-08-18'),
(199, 7, 124, 'Episodio 124', '', NULL, '2025-08-19'),
(200, 7, 125, 'Episodio 125', '', NULL, '2025-08-20'),
(201, 7, 126, 'Episodio 126', '', NULL, '2025-08-21'),
(202, 7, 127, 'Episodio 127', '', NULL, '2025-08-22'),
(203, 7, 128, 'Episodio 128', '', NULL, '2025-08-24'),
(204, 7, 129, 'Episodio 129', '', NULL, '2025-08-25'),
(205, 7, 130, 'Episodio 130', '', NULL, '2025-08-29'),
(206, 7, 131, 'Episodio 131', '', NULL, NULL),
(207, 7, 132, 'Episodio 132', '', NULL, NULL),
(208, 7, 133, 'Episodio 133', '', NULL, NULL),
(209, 7, 134, 'Episodio 134', '', NULL, NULL),
(210, 7, 135, 'Episodio 135', '', NULL, NULL),
(211, 9, 1, 'Episodio 1', '', 81, '2014-04-25'),
(212, 9, 2, 'Episodio 2', '', 90, '2014-05-02'),
(213, 9, 3, 'Episodio 3', '', 90, '2014-05-09'),
(214, 9, 4, 'Episodio 4', '', 103, '2014-05-16'),
(215, 9, 5, 'Episodio 5', '', 91, '2014-05-23'),
(216, 9, 6, 'Episodio 6', '', 105, '2014-05-30'),
(217, 9, 7, 'Episodio 7', '', 102, '2014-06-06'),
(218, 9, 8, 'Episodio 8', '', 107, '2014-06-13'),
(219, 8, 1, 'Consecuencias', 'Casi al final de su entrenamiento, Nolan ahora enfrenta su mayor desafío como oficial de policía cuando debe aceptar las decisiones que ha tomado en pos de la verdad.', 43, '2021-01-03'),
(220, 8, 2, 'En el ámbito de la justicia', 'El oficial John Nolan y la oficial Nyla Harper están asignados a un centro de policía comunitaria para ayudar a reconstruir la reputación de su estación en la comunidad. Nolan está decidido a tener un impacto positivo, pero Nyla tiene sus dudas.', 43, '2021-01-10'),
(221, 8, 3, 'La Fiera', 'La madre del oficial John Nolan hace una visita sin previo aviso que complica su vida, y el sargento Grey considera retirarse.', 43, '2021-01-17'),
(222, 8, 4, 'Sabotaje', 'La relación del oficial Jackson West con su nuevo oficial de entrenamiento, Stanton, se ha intensificado y comienza a trabajar con el sargento Gray para encontrar una solución.', 43, '2021-01-24'),
(223, 8, 5, 'Cierre de emergencia', 'El oficial Nolan es tomado como rehén por un hombre sin nada que perder mientras la estación se cierra y corre para identificar al sospechoso antes de que acabe el tiempo. Mientras tanto, el oficial Jackson y su oficial de entrenamiento, el oficial Doug Stanton, llegan a un punto de inflexión en su relación que podría terminar con la carrera de Jackson.', 43, '2021-02-14'),
(224, 8, 6, 'Revelaciones', 'La decisión del oficial Nolan de regresar a la escuela para convertirse en oficial de entrenamiento está resultando mucho más difícil de lo que esperaba. Mientras tanto, el oficial Chen considera ir a un trabajo encubierto después de probar el trabajo cuando el ex colega de Harper necesita ayuda.', 43, '2021-02-21'),
(225, 8, 7, 'Crímenes reales', 'El equipo recibe el tratamiento de la verdadera serie de documentos del crimen cuando analizan un caso reciente que presenta a un ex actor infantil cuya vida adulta le ha granjeado un seguimiento de culto.', 43, '2021-02-28'),
(226, 8, 8, 'Resentimiento', 'Nolan, Harper y López son asignados al secuestro del hijo de un juez de la corte que tiene una larga lista de enemigos que posiblemente podrían estar involucrados.', 43, '2021-03-28'),
(227, 8, 9, 'Amber', 'Una Alerta Amber envía al equipo a una carrera contrarreloj para encontrar a un recién nacido que fue robado de un hospital local. Los oficiales Jackson y Chen trabajan en su último turno como novatos mientras Nolan continúa por 30 días más.', 43, '2021-04-04'),
(228, 8, 10, 'Hombre de honor', 'Los agentes Harper y Nolan se dan cuenta de que detrás de un robo a un banco puede haber motivos ocultos mas allá de necesitar dinero.', 43, '2021-04-11'),
(229, 8, 11, 'Savia nueva', 'Cuando alguien destroza la ventanilla del coche de Fiona Ryan, el agente Nolan se ofrece para vigilar su casa. Lucy esta molesta con Tim.', 43, '2021-04-18'),
(230, 8, 12, 'Corazón valiente', 'Después de llevar a su hijo, Henry, al hospital después de su colapso, Nolan se reúne con su ex esposa, Sarah, y deben unirse para ayudar a su hijo. Mientras tanto, el detective López descubre que \'La Fiera\' está en el mismo hospital y quiere averiguar exactamente por qué.', 43, '2021-05-02'),
(231, 8, 13, 'Triple deber', 'Los agentes Nolan y Bradford quieren evitar un enfrentamiento por drogas antes de que se pierdan vidas inocentes. Harper y Chen van de incógnito.', 43, '2021-05-09'),
(232, 8, 14, 'Límite', 'El oficial Nolan se lesiona levemente mientras persigue a un ladrón y el fiscal local quiere acusar al sospechoso de asalto a pesar de los deseos de Nolan. Mientras tanto, Lucy se infiltra, el lugar de la boda de López es incautado por el FBI y Nolan conoce a su nuevo vecino.', 43, '2021-05-16'),
(233, 10, 1, 'Episodio 1', '', 94, '2015-04-25'),
(234, 10, 2, 'Episodio 2', '', 89, '2015-05-02'),
(235, 10, 3, 'Episodio 3', '', 98, '2015-05-09'),
(236, 10, 4, 'Episodio 4', '', 100, '2015-05-16'),
(237, 10, 5, 'Episodio 5', '', 95, '2015-05-23'),
(238, 10, 6, 'Episodio 6', '', 94, '2015-05-30'),
(239, 10, 7, 'Episodio 7', '', 97, '2015-06-06'),
(240, 10, 8, 'Episodio 8', '', 106, '2015-06-13'),
(241, 10, 9, 'Episodio 9', '', 91, '2015-06-20'),
(242, 10, 10, 'Episodio 10', '', 99, '2015-06-27'),
(243, 10, 11, 'Episodio 11', '', 116, '2015-07-04'),
(244, 11, 1, 'Vida y muerte', 'Nolan y el equipo corren para localizar a López después de que fuera secuestrada el día de su boda, para salvar su vida y también la de su hijo.', 43, '2021-09-26'),
(245, 11, 2, 'Cinco minutos', 'Nolan y Chen se topan con una ladrona que les da pistas sobre un posible robo durante la gala del Getty. Nolan se atreve a pedirle una cita a Bailey.', 43, '2021-10-03'),
(246, 11, 3, 'En la línea de fuego', 'Nolan y Chen acuden a un incendio y sospechan que hay algo más detrás. Tras un tiroteo, buscan al tirador y descubren su vínculo con uno de ellos.', 43, '2021-10-10'),
(247, 11, 4, 'Al rojo vivo', 'Nolan y Chen buscan a una desaparecida. Harper busca a un pirómano tras el aviso de un ciclista herido. Wesley tiene que superar algo imposible.', 43, '2021-10-17'),
(248, 11, 5, 'T.E.P.', 'Una nueva droga convierte a la gente en zombis y Nolan y el equipo tendrán un Halloween que no olvidarán. Lucy cuestiona si su piso está embrujado.', 43, '2021-10-31'),
(249, 11, 6, 'Justicia poética', 'Nolan y el equipo buscan un tesoro escondido antes de que haya heridos. Bradford debe animar al poli más veterano a jubilarse y patrullan juntos.', 43, '2021-11-07'),
(250, 11, 7, 'Apagafuegos', 'Se descubre más sobre la muerte de Fred. Chen y Bradford quieren la revancha, Grey los ayuda y detienen a unas ricas. Elijah presiona más a Wesley.', 43, '2021-11-14'),
(251, 11, 8, 'Ataque y retirada', 'El equipo persigue a un terrorista. Genny, la hermana de Tim, se presenta por sorpresa con una noticia. López piensa en un plan para ayudar a Wesley.', 43, '2021-12-05'),
(252, 11, 9, 'Colapso', 'Wesley intenta colocar un micro en la oficina de Elijah para incriminarlo. Bradford y su hermana descubren una verdad perturbadora sobre su padre.', 43, '2021-12-12'),
(253, 11, 10, 'Latido', 'Nolan conoce el pasado de Bailey y debe decidir si aún tienen futuro. Una avioneta se estrella en la ciudad y el equipo tiene que averiguar por qué.', 43, '2022-01-02'),
(254, 11, 11, 'Desenlace', 'El equipo debe confiar en un delincuente para eliminar una amenaza mayor. Chen y Bradford investigan el asesinato de una sintecho, amiga de Tamara.', 43, '2022-01-09'),
(255, 11, 12, 'El contratiempo', 'Aparece una mano en la playa y el equipo busca a su dueño. Tim quiere demostrar a Lucy que no es un maníaco del control y la invita a una cita doble.', 43, '2022-01-23'),
(256, 11, 13, 'Lucha o huida', '', 43, '2022-01-30'),
(257, 11, 14, 'Posibilidad remota', 'Nolan y Harper ayudan al investigador Randy con su primera recompensa. Chen y Bradford buscan al autor de muchos delitos por toda la ciudad.', 43, '2022-02-27'),
(258, 11, 15, 'Lista negra', 'Harper asigna el \"Día del paisano\" a Thorsen, pero reciben una visita. Asesinan a dos testigos de un gran jurado y el equipo busca a los asesinos.', 43, '2022-03-06'),
(259, 11, 16, 'Crímenes reales', 'Para cambiar su imagen, Thorsen participa en un reality y vive otra mala situación. Con el productor asesinado, lo investigan antes de ser sospechoso.', 43, '2022-03-13'),
(260, 11, 17, 'Parada', 'Nolan y el equipo tienen que negociar con un hombre consternado que tiene al hospital retenido para asegurarse de que operen a su mujer de urgencia.', 43, '2022-04-03'),
(261, 11, 18, 'Traidores', 'Tras el robo en un tren, el equipo investiga. A Chen le molesta que Bradford no reconozca su trabajo. Harper toma una decisión en su vida personal.', 43, '2022-04-10'),
(262, 11, 19, 'Simone', 'Nolan y el FBI piden ayuda a la novata del FBI, Simone Clark, cuando un antiguo estudiante suyo es sospechoso de terrorismo tras una explosión.', 43, '2022-04-24'),
(263, 11, 20, 'Enervo', 'El equipo y el FBI corren para detener las bombas repartidas por toda la ciudad. La fuerza especial conjunta sospecha de la involucración de la CIA.', 43, '2022-05-01'),
(264, 11, 21, 'El Día de la Madre', 'Grey patrulla con Nolan para prepararlo como instructor. Tim y Lucy gestionan los planes del Día de la Madre y de unas vacaciones con sus parejas.', 43, '2022-05-08'),
(265, 11, 22, 'Un día en el hoyo', 'Nolan pasa una semana en un pueblo fronterizo con una agente inexperta. Bradford y Chen se infiltran en un posible caso de tráfico de drogas.', 42, '2022-05-15'),
(266, 12, 1, 'Episodio 1', '', 81, '2017-04-23'),
(267, 12, 2, 'Episodio 2', '', 77, '2017-04-30'),
(268, 12, 3, 'Episodio 3', '', 76, '2017-05-07'),
(269, 12, 4, 'Episodio 4', '', 86, '2017-05-14'),
(270, 12, 5, 'Episodio 5', '', 82, '2017-05-21'),
(271, 12, 6, 'Episodio 6', '', 82, '2017-05-28'),
(272, 12, 7, 'Episodio 7', '', 81, '2017-06-04'),
(273, 12, 8, 'Episodio 8', '', 80, '2017-06-11'),
(274, 12, 9, 'Episodio 9', '', 80, '2017-06-18'),
(275, 12, 10, 'Episodio 10', '', 86, '2017-06-25'),
(276, 12, 11, 'Episodio 11', '', 82, '2017-07-02'),
(277, 12, 12, 'Episodio 12', '', 84, '2017-07-09'),
(278, 13, 1, 'Redoblarse', 'El agente John Nolan vuelve a verse las caras con la asesina en serie Rosalind, y Bradford y Chen inician una operación encubierta.', 42, '2022-09-25'),
(279, 13, 2, 'El día del parto', 'John Nolan está cada vez más cerca de su nuevo puesto y Lucy se gana una invitación para asistir a una formación especializada en Sacramento.', 44, '2022-10-02'),
(280, 13, 3, 'Los Dyefanáticos', 'Nolan se enfrenta a un gran desafío cuando le asignan a su primera novata, Celina Juarez, una agente con una manera muy peculiar de hacer su trabajo.', 43, '2022-10-09'),
(281, 13, 4, 'La elección', 'La policía de LA y el FBI trabajan juntos contra reloj y Nolan se ve obligado a tomar una decisión de vida o muerte tras un ultimátum desgarrador.', 43, '2022-10-16'),
(282, 13, 5, 'El fugitivo', 'Nolan y Juarez buscan a un conductor que se ha dado a la fuga tras un accidente. Tras reabrir una herida del pasado, Tim recibe ayuda de Lucy.', 43, '2022-10-23'),
(283, 13, 6, 'La estimación', 'Nolan y Juarez investigan un depósito en efectivo relacionado con un antiguo caso de la DEA. Wesley se sorprende al ver quién es el abogado de Elijah.', 44, '2022-10-30'),
(284, 13, 7, 'Fuego cruzado', 'Nolan y Juarez son testigos de un tiroteo, y Lopez y Harper solicitan la ayuda de Lucy para investigar un asesinato relacionado con una banda.', 43, '2022-11-06'),
(285, 13, 8, 'El collar', 'Los agentes John Nolan y Celina Juarez trabajan contra reloj para intentar detener una inminente explosión.', 43, '2022-12-04'),
(286, 13, 9, 'Retractarse', 'Mientras la brigada investiga la muerte de un sospechoso en custodia policial, aparece un cabo suelto que pone en peligro el trabajo de Juarez.', 43, '2022-12-04'),
(287, 13, 10, 'La lista', 'Cuando Nyla y James se ven envueltos en el atraco a un banco, el equipo inicia una persecución por toda la ciudad. Tim y Lucy tienen su primera cita.', 43, '2023-01-03'),
(288, 13, 11, 'Los desnudos y los muertos', 'Durante la búsqueda de un chico desaparecido, la brigada termina en medio de una guerra muy peligrosa entre dos bandas rivales de narcotraficantes.', 43, '2023-01-10'),
(289, 13, 12, 'Noticias de muerte', 'Nolan y Celina deben hacer guardia en un hospital después de que un peligroso prisionero necesite cirugía; Aaron, López y Harper investigan una serie de robos; Tim y Lucy consideran cómo su relación secreta afectará su trabajo.', 43, '2023-01-17'),
(290, 13, 13, 'Papi policía', 'Mientras una ola de calor y un apagón azotan la ciudad, Nolan y Aaron desenmascaran a unos criminales y Chen descubre algo perturbador.', 43, '2023-01-24'),
(291, 13, 14, 'Sentencia de muerte', 'Nolan y Bailey buscan al culpable de un tiroteo, Aaron ayuda a Lucy con un caso de desaparición y Wesley sospecha que un juez está aceptando sobornos.', 43, '2023-01-31'),
(292, 13, 15, 'La estafa', 'Con el apoyo del FBI, Lopez lo arriesga todo para ayudar a Elijah Stone a derribar al líder de una banda a cambio de su propia seguridad.', 43, '2023-02-14'),
(293, 13, 16, 'Expuesto', 'El equipo intenta detener la explosión de un camión y Nolan y compañía buscan a tres hombres que han estado en contacto con el virus del ébola.', 43, '2023-02-21'),
(294, 13, 17, 'El enemigo está en el interior', 'El equipo tendrá que ingeniárselas para intentar descubrir lo que traman Elijah y Abril. Nolan y Juarez reabren el caso de la hermana de Juarez.', 43, '2023-02-28'),
(295, 13, 18, 'Problema', 'Cuando Dim desaparece, la agente Chen y el sargento Bradford, junto con la CIA, se preparan para buscarlo, y para ello contratan la ayuda de Juicy.', 43, '2023-03-21'),
(296, 13, 19, 'Un agujero en el mundo', 'El equipo investiga un patrón de secuestros que los lleva a un descubrimiento que los golpea cerca de casa con uno de los suyos.  Mientras tanto, la relación de Lucy y Tim se pone a prueba cuando comienzan a sentir las horas difíciles de sus trabajos.', 43, '2023-03-28'),
(297, 13, 20, 'Repeticiones cortas en tándem', 'El regreso de la exmujer de Bradford, que viene en busca de ayuda para salvar a alguien de su pasado, hace que la relación de Lucy y Tim se tambalee.', 43, '2023-04-18'),
(298, 13, 21, 'Irse a pique', 'Lucy inicia una operación encubierta y Harper y Nolan intentan averiguar por qué están apareciendo miembros amputados por toda la ciudad.', 43, '2023-04-25'),
(299, 13, 22, 'Bajo asedio', 'Tras una serie de incidentes, el equipo se da cuenta de que su unidad podría ser el objetivo de un grupo de asaltantes enmascarados.', 43, '2023-05-02'),
(300, 14, 1, 'Episodio 1', '', 94, '2022-06-17'),
(301, 14, 2, 'Episodio 2', '', 87, '2022-06-24'),
(302, 14, 3, 'Episodio 3', '', 91, '2022-07-01'),
(303, 14, 4, 'Episodio 4', '', 91, '2022-07-08'),
(304, 14, 5, 'Episodio 5', '', 87, '2022-07-15'),
(305, 14, 6, 'Episodio 6', '', 92, '2022-07-22'),
(306, 14, 7, 'Episodio 7', '', 93, '2022-07-29'),
(307, 14, 8, 'Episodio 8', '', 91, '2022-08-05'),
(308, 14, 9, 'Episodio 9', '', 93, '2022-08-12'),
(309, 14, 10, 'Episodio 10', '', 87, '2022-08-19'),
(310, 14, 11, 'Episodio 11', '', 92, '2022-08-26'),
(311, 14, 12, 'Episodio 12', '', 87, '2022-09-02'),
(312, 15, 1, 'Contraatacar', 'Los agentes investigan los ataques de la temporada anterior y Nolan intenta sobrevivir al último día de trabajo antes de su enlace con Bailey.', 44, '2024-02-20'),
(313, 15, 2, 'El martillo', 'El equipo se reúne para celebrar la boda de John y Bailey; Mientras tanto, Celina descubre una discrepancia en su caso, lo que lleva a un nuevo descubrimiento. En otra parte, la relación de Lucy y Tim se pone a prueba.', 44, '2024-02-27'),
(314, 15, 3, 'Problemas en el paraíso', 'La luna de miel de Nolan y Bailey es más una pesadilla que un sueño cuando se convierte en una escena de crimen activa. Mientras tanto, Tim y Celina se asocian y deben descubrir la identidad de John Doe.', 42, '2024-03-05'),
(315, 15, 4, 'Jornada de formación', 'Thorsen deberá demostrar que está listo para reincorporarse al trabajo y los demás investigan un homicidio que podría estar ligado a un antiguo caso.', 43, '2024-03-26'),
(316, 15, 5, 'El juramento', 'John y Bailey se encuentran a una niña en la escena de un crimen y deben decidir si enviarla a un centro a pasar la noche o cuidarla ellos mismos.', 42, '2024-04-02'),
(317, 15, 6, 'Secretos y mentiras', 'John y Celina buscan a una fugitiva con sed de venganza y Bailey le pide a John que se replantee la decisión que ambos tomaron de no tener hijos.', 43, '2024-04-09'),
(318, 15, 7, 'Aplastado', 'El equipo se une para investigar la desaparición de dos chicas adolescentes. Mientras tanto, Lopez y Harper inician una misión muy diferente.', 43, '2024-04-30'),
(319, 15, 8, 'Tarjeta de asistencia', 'Lucy y Celina investigan a los sospechosos de un ataque relacionado con la mafia que deja numerosas víctimas, y Tim y Aaron inician otra operación.', 43, '2024-05-07'),
(320, 15, 9, 'La restricción', 'Nolan y Celina trabajan en un caso especial; Monica pide ayuda para identificar a sus agresores y Lopez y Harper descubren algo importante.', 43, '2024-05-14'),
(321, 15, 10, 'Plan de evacuación', 'El Sargento Gray ayuda al equipo a prepararse para su misión más importante hasta el momento.  Mientras tanto, Aaron, López, Celina, Tim y Smitty descubren una conexión sorprendente en su caso.', 43, '2024-05-21'),
(322, 16, 1, 'Episodio 1', '', 91, '2023-10-25'),
(323, 16, 2, 'Episodio 2', '', 92, '2023-11-01'),
(324, 16, 3, 'Episodio 3', '', 96, '2023-11-08'),
(325, 16, 4, 'Episodio 4', '', 92, '2023-11-15'),
(326, 16, 5, 'Episodio 5', '', 90, '2023-11-22'),
(327, 16, 6, 'Episodio 6', '', 87, '2023-11-23'),
(328, 16, 7, 'Episodio 7', '', 98, '2023-11-29'),
(329, 16, 8, 'Episodio 8', '', 88, '2023-12-06'),
(330, 16, 9, 'Episodio 9', '', 95, '2023-12-13'),
(331, 16, 10, 'Episodio 10', '', 93, '2023-12-20'),
(332, 16, 11, 'Episodio 11', '', 102, '2023-12-27'),
(333, 16, 12, 'Episodio 12', '', 96, '2024-01-03'),
(334, 16, 13, 'Episodio 13', '', 100, '2024-01-10'),
(335, 16, 14, 'Episodio 14', '', 99, '2024-01-17'),
(336, 16, 15, 'Episodio 15', '', 62, '2024-01-18'),
(337, 16, 16, 'Episodio 16', '', 76, '2024-01-23'),
(338, 16, 17, 'Episodio 17', '', 77, '2024-01-24'),
(339, 16, 18, 'Episodio 18', '', 110, '2024-01-25'),
(340, 17, 1, 'El disparo', 'John se recupera de una herida de bala y el equipo, con dos miembros nuevos, busca a dos reclusos con sed de venganza que se han dado a la fuga.', 44, '2025-01-07'),
(341, 17, 2, 'El observador', 'El equipo debe realizar tareas de vigilancia comunitaria mientras busca a un justiciero local. Mientras tanto, los instintos de Celina se ponen a prueba y Tim y Lucy descubren secretos sobre los dos nuevos novatos.', 44, '2025-01-14'),
(342, 17, 3, 'Salir perdiendo', 'Antes de que Bailey regrese a casa, John busca pistas para localizar a Jason Wyler. Luego, Tim y Lucy intercambian a los novatos; una cara amigable reaparece en la estación y Wesley se siente inquieto por Angela.', 43, '2025-01-21'),
(343, 17, 4, 'Cae la oscuridad', 'Después de su paso por el Departamento de Policía de Los Ángeles, Wesley regresa a la oficina del fiscal de distrito, donde su pasado lo conecta con la investigación del equipo. Mientras tanto, Bailey y John tienen sentimientos encontrados sobre la seguridad, mientras que Lucy comienza a sospechar de Seth.', 43, '2025-01-28'),
(344, 17, 5, 'Hasta la muerte', 'El equipo busca a un asesino en serie mientras Nyla lucha con las consecuencias del ataque. La relación de Lucy con Seth da un giro, mientras que Bailey lucha contra su miedo a Jason Wyler.', 43, '2025-02-04'),
(345, 17, 6, 'La gala', 'Es el día de San Valentín y el teniente Grey les da a Tim y Lucy una misión nada romántica, mientras que John y Celina buscan a una chica desaparecida. Más tarde, el equipo se prepara para una gala benéfica donde múltiples relaciones llegan a un punto crítico.', 44, '2025-02-11'),
(346, 17, 7, 'Mickey', 'En el último día de Celina como novata, John le hace una última prueba. Mientras tanto, Bailey hace un nuevo amigo y Lucy confía en Seth para una misión encubierta.', 44, '2025-02-18'),
(347, 17, 8, 'Incendio forestal', 'Nyla sigue sospechando de Liam Glasser mientras se desata un incendio forestal que provoca el caos en la ciudad. Mientras tanto, James intenta ayudar a un amigo y Seth comete un costoso error, poniendo a dos de los suyos en peligro.', 43, '2025-02-25'),
(348, 17, 9, 'El beso', 'El equipo se moviliza para localizar a un sospechoso después de que una serie de eventos mortales afecten a uno de los suyos. Mientras tanto, Celina asume su primer caso con la ayuda de Bailey.', 44, '2025-03-11'),
(349, 17, 10, 'El agente del caos', 'John, Lucy y Angela investigan los extraños apuñalamientos de tres adolescentes y el equipo tiene problemas para lidiar con un grupo de presos.', 43, '2025-03-18'),
(350, 17, 11, 'Velocidad', 'John y Celina se ven involucrados en una toma de rehenes mientras trabajan en una operación encubierta para una iniciativa de seguridad pública.', 42, '2025-03-25'),
(351, 17, 12, 'El día de los inocentes', 'Una broma del día de los inocentes en la red social de la policía de Los Ángeles siembra el caos en toda la ciudad.', 43, '2025-04-01'),
(352, 17, 13, 'Tres carteles', 'Tras la aparición de unas vallas publicitarias que van en contra de la policía de Los Ángeles, el equipo se dispone a buscar a los responsables.', 43, '2025-04-08'),
(353, 17, 14, 'Locos por los asesinatos', 'Tim recibe un mensaje muy extraño, lo cual desencadena una investigación en la dark web. Mientras, Celina intenta sabotear un podcast muy conocido.', 43, '2025-04-15'),
(354, 17, 15, 'Un secreto mortal', 'Los productores de un documental entrevistan a la policía de Los Ángeles sobre un caso de desaparición muy complejo relacionado con John.', 43, '2025-04-22'),
(355, 17, 16, 'El regreso', 'El regreso de alguien conocido provoca sentimientos encontrados en el equipo. Mientras tanto, un influencer pone a sus seguidores en contra de Wesley.', 43, '2025-04-29'),
(356, 17, 17, 'Motín y recompensa', 'Tras el secuestro del nuevo crush de Randy, el equipo decide echarle una mano, y Angela y Nyla recurren a sus madres para atrapar a un estafador.', 43, '2025-05-06'),
(357, 17, 18, 'El bueno, el malo y Oscar', 'John y Harper aúnan fuerzas para atrapar a Oscar; Angela investiga el robo de un banco y Lucy y Tim tienen que adaptarse a su nuevo horario.', 43, '2025-05-13'),
(358, 18, 1, 'Episodio 1', '', 122, '2024-09-04'),
(359, 18, 2, 'Episodio 2', '', 71, '2024-09-05'),
(360, 18, 3, 'Episodio 3', '', 96, '2024-09-11'),
(361, 18, 4, 'Episodio 4', '', 79, '2024-09-12'),
(362, 18, 5, 'Episodio 5', '', 88, '2024-09-18'),
(363, 18, 6, 'Episodio 6', '', 64, '2024-09-19'),
(364, 18, 7, 'Episodio 7', '', 101, '2024-09-25'),
(365, 18, 8, 'Episodio 8', '', 81, '2024-09-26'),
(366, 18, 9, 'Episodio 9', '', 134, '2024-10-02'),
(367, 18, 10, 'Episodio 10', '', 72, '2024-10-02'),
(368, 18, 11, 'Episodio 11', '', 97, '2024-10-09'),
(369, 18, 12, 'Episodio 12', '', 54, '2024-10-09'),
(370, 18, 13, 'Episodio 13', '', 124, '2024-10-16'),
(371, 18, 14, 'Episodio 14', '', 87, '2024-10-16'),
(372, 18, 15, 'Episodio 15', '', 113, '2024-10-23'),
(373, 18, 16, 'Episodio 16', '', 129, '2024-10-30'),
(374, 18, 17, 'Episodio 17', '', 105, '2024-11-06'),
(375, 18, 18, 'Episodio 18', '', 100, '2024-11-13'),
(376, 18, 19, 'Episodio 19', '', 113, '2024-11-20'),
(377, 18, 20, 'Episodio 20', '', 53, '2024-11-21'),
(378, 18, 21, 'Episodio 21', '', 124, '2024-11-27'),
(379, 18, 22, 'Episodio 22', '', 99, '2024-12-03'),
(380, 18, 23, 'Episodio 23', '', 54, '2024-12-03'),
(381, 20, 1, 'Episodio 1', '', 106, '2025-08-16'),
(382, 20, 2, 'Episodio 2', '', NULL, '2025-08-23'),
(383, 20, 3, 'Episodio 3', '', NULL, '2025-08-30'),
(384, 20, 4, 'Episodio 4', '', NULL, '2025-09-06'),
(385, 21, 1, 'Piloto', 'David Jung, un hombre coreano-americano que fingió su muerte hace nueve años, hace frente a su pasado cuando su hija Rebecca, que ahora trabaja como sicaria para la agencia privada de inteligencia Caddis, recibe el encargo de matarlo.', 51, '2025-08-13'),
(386, 21, 2, 'Daegu', 'David y Rebecca huyen de Caddis después de un tenso encuentro en un control policial. Pero su reencuentro inesperado se complica a causa del resentimiento que Rebecca alberga por el abandono de su padre.', 49, '2025-08-13'),
(387, 21, 3, 'Busan', 'Rebecca, David y la familia de él se refugian en un piso franco en la ciudad costera de Busan. Las tensiones familiares aumentan porque a Rebecca le cuesta aceptar la nueva familia de su padre. Además, se produce una revelación sobrecogedora sobre el pasado de David con Juno durante un enfrentamiento violento en un puerto deportivo.', 52, '2025-08-13'),
(388, 21, 4, 'Pohang', 'Después de secuestrar a Oliver, David y Rebecca emplean la información que le sonsacan para elaborar un plan contra Juno. Dicho plan los lleva de vuelta a Seúl, donde los aguardan Gun y Caddis.', 45, '2025-08-13'),
(389, 21, 5, 'Seúl', 'Juno interroga a Oliver y descubre que la traicionó cuando fue prisionero de David. Mientras tanto, David y Rebecca llevan a cabo una operación psicológica contra Juno para separarla de Oliver y destruir Caddis de una vez por todas.', 49, '2025-08-13'),
(390, 21, 6, 'Annyeong', 'David va tras Rebecca después de que Juno y agentes de Caddis la secuestren, lo cual desencadena una vertiginosa persecución y una brutal emboscada en una fábrica abandonada.', 49, '2025-08-13'),
(391, 22, 1, 'Casa de verano', 'Es el auténtico primer día del verano: el día en que Belly, su hermano Steven y su madre Laurel se dirigen a la playa de Cousins para quedarse con Susannah Fisher -que es como una segunda madre para Belly- y sus hijos, Conrad y Jeremiah. Belly lleva yendo a Cousins desde antes de nacer, pero algo de este verano le parece diferente a Belly. Y si la primera noche es una referencia, tiene razón.', 45, '2022-06-16'),
(392, 22, 2, 'Vestido de verano', 'Es el primer día de Belly como debutante, y tras pasar un día de compras y tomando el té, se pregunta si tomó la decisión correcta cuando aceptó la invitación de Susannah. Pero cuando aparece Cam, las cosas cambian para Belly. Su verano de novedades apenas comienza. Mientras tanto, Steven tiene su particular romance de verano, y Laurel se siente intrigada por un escritor, como ella.', 39, '2022-06-16'),
(393, 22, 3, 'Noches de verano', 'Es el decimosexto cumpleaños de Belly y su mejor amiga, Taylor, llega a Cousins para participar en la celebración. Para Belly su cumpleaños es siempre su día favorito del año, pero este año se ve sorprendida por un secreto que Taylor le ha estado ocultando. Las debutantes le preguntan a Belly a quién llevará al baile de debutantes. El secreto de Laurel y Susannah finalmente sale a la luz.', 45, '2022-06-16'),
(394, 22, 4, 'Calor de verano', 'Llega el 4 de julio y los padres aparecen en la playa de Cousins para la fiesta anual de Susannah en la casa de la playa. Las tensiones estallan entre Conrad y su padre. Belly y los hermanos Fisher preparan margaritas y la situación acaba en caos. Más tarde, Belly tiene un momento romántico que se interrumpe.', 44, '2022-06-16'),
(395, 22, 5, 'Ligue de verano', 'Creyendo que Conrad podría revelarle sus sentimientos por ella, Belly toma una decisión. Pero cuando Belly y Conrad finalmente tienen la oportunidad de hablar, las cosas no van como ella esperaba, y ella se pregunta si tal vez se ha fijado en el hermano equivocado de los Fisher. A Steven le encargan trabajar en la sala de póquer del club de campo, y Laurel y Susannah tienen una noche de fiesta.', 52, '2022-06-16'),
(396, 22, 6, 'Marea de verano', 'Taylor vuelve para jugar en el torneo benéfico de voleibol de la playa de Cousins y para ayudar a Belly, que está atrapada entre Conrad y Jeremiah. Una fiesta de las debutantes en un yate termina en desastre y Belly toma una decisión clara entre los hermanos. Steven se siente abrumado ante los adinerados amigos de Shayla, y Cleveland ayuda a Conrad a superar un momento difícil.', 48, '2022-06-16'),
(397, 22, 7, 'Amor de verano', 'Llega el baile de debutantes, pero la gran noche de Belly podría arruinarse cuando Jeremiah descubre el secreto que su madre ha ocultado todo el verano. Belly se ve sola en la pista de baile, pero alguien salva la situación. Tras revelarse el secreto de Susannah y Laurel, la temporada termina con una promesa de Susannah y la confesión de Conrad que Belly ha estado esperando todo el verano.', 45, '2022-06-16'),
(398, 23, 1, 'Amor perdido', 'Belly siempre estaba impaciente por regresar a la playa de Cousins, pero con Conrad y Jeremiah peleando por su corazón y la reaparición del cáncer de Susannah, no está segura de que el verano vaya a ser igual. Un visitante inesperado amenaza el futuro de la adorada casa de Susannah y Belly debe reunir a la pandilla para unir fuerzas y decidir de una vez por todas dónde está su corazón.', 57, '2023-07-13'),
(399, 23, 2, 'Escena de amor', 'Belly se une a Jeremiah en una búsqueda importante, pero la tensión de su pasado amenaza con interponerse en el camino, y tienen que encontrar una manera de curar su herida, para poder ayudar a Conrad.', 42, '2023-07-13'),
(400, 23, 3, 'Mal de amores', 'La casa de verano está a la venta, pero Belly, Jeremiah y Conrad no dejarán que se pierda tan fácilmente. Mientras Conrad trabaja en un plan secreto, Belly y Jeremiah intentan una vía más directa. Pero estar de regreso en Cousins con los hermanos Fisher comporta que Belly no pueda escapar de los dolorosos recuerdos del año anterior.', 48, '2023-07-13'),
(401, 23, 4, 'Juego de amor', 'Todo vale en el amor y en la feria del paseo marítimo. Un día de competición con viejos y nuevos amigos despierta grandes sentimientos en Belly, Conrad y Jeremiah, y conduce a una sorpresa aún mayor que los afectará a todos.', 50, '2023-07-20'),
(402, 23, 5, 'Loco de amor', 'No tienes que ir a casa, pero no puedes quedarte aquí. Belly y la pandilla irrumpen en un lugar familiar para pasar la noche después de que la tía Julia los obligara a salir de la casa de verano. Pero el cambio de escenario obligará a todos a afrontar sus sentimientos.', 50, '2023-07-27');
INSERT INTO `episodios` (`id_episodio`, `id_temporada`, `numero_episodio`, `titulo`, `descripcion`, `duracion`, `fecha_lanzamiento`) VALUES
(403, 23, 6, 'Fiesta de amor', 'Mientras su tiempo en Cousins se agota, Belly se ve a sí misma preguntándose: ¿Qué haría Susannah? Montar una fiesta a lo grande, seguro. Pero ¿la fiesta implicará cerrar los asuntos que necesitan cerrar, o sencillamente generará nuevos problemas para todos?', 55, '2023-08-03'),
(404, 23, 7, 'Historia de amor', 'Algunas resacas son peores que otras. Belly se despierta recordando los errores cometidos la noche anterior. Pero ¿es demasiado tarde para arreglar las cosas?', 57, '2023-08-10'),
(405, 23, 8, 'Triángulo amoroso', 'Después de una dolorosa revelación, Belly, Jeremiah y Conrad quedan atrapados en un lugar cerrado durante la noche. Las emociones aumentan cuando Belly debe afrontar el pasado y el presente para decidir su futuro.', 59, '2023-08-17'),
(406, 24, 1, 'Luz roja, luz verde', 'El arruinado y desesperado Gi-hun acepta participar en un enigmático juego con la intención de ganar dinero fácil. Ya en la primera ronda se desata el horror.', 61, '2021-09-17'),
(407, 24, 2, 'Infierno', 'El grupo, en desacuerdo sobre si continuar o no, decide someterlo a votación. Pero la cruda realidad de sus vidas podría ser tan despiadada como el propio juego.', 63, '2021-09-17'),
(408, 24, 3, 'El hombre del paraguas', 'Llegan nuevos participantes a la ronda siguiente (que promete ser tan dulce como mortal) con algunos ases en la manga. Entretanto, Jun-ho se cuela dentro.', 55, '2021-09-17'),
(409, 24, 4, 'El equipo es lo primero', 'A pesar de las alianzas entre jugadores, nadie está a salvo cuando apagan la luz. El equipo de Gi-hun necesita una estrategia para el tercer juego.', 55, '2021-09-17'),
(410, 24, 5, 'Un mundo justo', 'Gi-hun y su equipo hacen turnos para vigilar de noche. Los enmascarados tienen problemas con uno de sus aliados en la conspiración.', 52, '2021-09-17'),
(411, 24, 6, 'Gganbu', 'Los participantes se emparejan para el cuarto juego. Gi-hun tiene un dilema moral, Sang-woo elige salvarse a sí mismo y Sae-byeok cuenta la historia de su vida.', 62, '2021-09-17'),
(412, 24, 7, 'Personas importantes', 'El líder enmascarado recibe a invitados importantes que vienen a disfrutar del espectáculo en primera fila. Algunos participantes caen ante la presión del quinto juego.', 58, '2021-09-17'),
(413, 24, 8, 'El líder', 'La desconfianza y la repulsión aumentan entre los finalistas antes del último juego. Jun-ho consigue huir y se propone destapar lo que ocurre dentro de las instalaciones.', 33, '2021-09-17'),
(414, 24, 9, 'Un día con suerte', 'El juego final presenta otra prueba cruel... pero, esta vez, su conclusión dependerá de un solo participante. El creador del juego diabólico sale a la luz.', 56, '2021-09-17'),
(415, 25, 1, 'La última temporada', 'El curso está acabando y Belly quiere volver a Cousins para disfrutar de un verano idílico con su novio Jeremiah, pero todo se tuerce cuando descubre una horrible verdad.', 61, '2025-07-16'),
(416, 25, 2, 'Las últimas Navidades', 'Belly intenta recomponer su vida tras la horrible traición. Taylor, atrapada en el fuego cruzado, discute con Steven y provoca un desastre.', 59, '2025-07-16'),
(417, 25, 3, 'La última cena', 'Belly y Jeremiah quieren mantener en secreto la gran noticia hasta que todos estén en Cousins para la ceremonia del jardín honorífico de Susannah, pero Conrad no quiere ir.', 56, '2025-07-23'),
(418, 25, 4, 'Última resistencia', 'Belly cumple 21 años sola en Filadelfia, y su día especial aún acaba peor cuando las desavenencias familiares sobre su futuro acaparan todo el protagonismo.', 58, '2025-07-30'),
(419, 25, 5, 'El último baile', 'Jeremiah no puede dejar su trabajo y Conrad debe ayudar a Belly a planear la boda. De camino a Nueva York para una oportunidad laboral, Steven encuentra una inesperada compañera de viaje.', 67, '2025-08-06'),
(420, 25, 6, 'Apellido', 'Ahora que Adam da el visto bueno, la boda es cada vez más grande y Belly se siente superada, pero las cosas parecen arreglarse tras una fiesta sorpresa para la novia.', 58, '2025-08-13'),
(421, 25, 7, 'Episodio 7', '', NULL, '2025-08-20'),
(422, 25, 8, 'Episodio 8', '', NULL, '2025-08-27'),
(423, 25, 9, 'Episodio 9', '', NULL, '2025-09-03'),
(424, 25, 10, 'Episodio 10', '', NULL, '2025-09-10'),
(425, 25, 11, 'Episodio 11', '', NULL, '2025-09-17'),
(426, 26, 1, 'Pan y lotería', 'Sediento de venganza, Gi-hun se da media vuelta en el aeropuerto. Más tarde, desde su escondite, intenta dar con el escurridizo reclutador, que está a la caza de nuevos jugadores.', 66, '2024-12-26'),
(427, 26, 2, 'Fiesta de Halloween', 'Gi-hun finalmente consigue una invitación, con fecha para el día de Halloween. En un tenso cara a cara con Jun-ho, ambos ponen sus cartas sobre la mesa.', 52, '2024-12-26'),
(428, 26, 3, '001', 'Llegan los nuevos jugadores, con la esperanza de ganar 45,6 mil millones de wones. Tras una intensa primera ronda, el destino de los supervivientes se decide en una votación final.', 62, '2024-12-26'),
(429, 26, 4, 'Seis piernas', 'Los jugadores se preparan para un pentatlón a seis piernas, en el que cada miembro del equipo debe completar un minijuego para sobrevivir... o enfrentarse a la eliminación colectiva.', 63, '2024-12-26'),
(430, 26, 5, 'Otro juego', 'La actitud de Kang No-eul hace que se gane unos cuantos enemigos. Los nervios están a flor de piel cuando los jugadores restantes deben votar si pasar a la siguiente ronda o no.', 77, '2024-12-26'),
(431, 26, 6, 'O ﻿ X', 'Jun-ho y su equipo se preparan para infiltrarse en una isla que levanta ciertas sospechas. A medida que aumenta la tensión, los jugadores se dividen en dos facciones opuestas.', 53, '2024-12-26'),
(432, 26, 7, 'Amigos o enemigos', 'Los jugadores restantes idean una estrategia para sobrevivir a la noche. Gi-hun propone un plan arriesgado, pero necesitará aliados de confianza para llevarlo a cabo.', 61, '2024-12-26'),
(433, 27, 1, 'Llaves y puñales', 'No-eul se infiltra en una peligrosa operación con un plan arriesgado. Se anuncia un nuevo juego: el escondite, en el que un equipo tiene llaves y el otro, puñales.', 58, '2025-06-27'),
(434, 27, 2, 'Noche estrellada', 'El juego continúa y Gi-hun está decidido a enfrentarse con Kang Dae-ho. Mientras tanto, Kim Jun-hee sufre una emergencia repentina que la pone al límite.', 60, '2025-06-27'),
(435, 27, 3, 'No es culpa tuya', 'El equipo de Jun-ho está a punto de encontrar la isla. Jang Geum-ja suplica desesperadamente a Gi-hun para poder salvar a Jun-hee. Los VIPS debaten una propuesta cruel.', 66, '2025-06-27'),
(436, 27, 4, '222', 'Mientras Gi-hun ayuda a Jun-hee en medio de la creciente presión, ella debe tomar una decisión crucial. Antes del último juego, el Líder le da un ultimátum a Gi-hun.', 66, '2025-06-27'),
(437, 27, 5, '○△□', 'No-eul intenta liderar las negociaciones, pero su plan fracasa. Gi-hun se encuentra en una encrucijada que pone a prueba sus límites: ¿hasta dónde será capaz de llegar?', 63, '2025-06-27'),
(438, 27, 6, 'Humanos', 'Mientras Jun-ho intenta llegar a la isla, la tensión es máxima en la ronda final. Los jugadores se enfrentan a una situación imposible en los últimos minutos del juego.', 56, '2025-06-27'),
(439, 28, 1, 'Episodio 1', '', 43, NULL),
(440, 28, 2, 'Episodio 2', '', 43, NULL),
(441, 28, 3, 'Episodio 3', '', 43, NULL),
(442, 28, 4, 'Episodio 4', '', 43, NULL),
(443, 28, 5, 'Episodio 5', '', 43, NULL),
(444, 28, 6, 'Episodio 6', '', 43, NULL),
(445, 29, 1, 'La recompensa', 'El sangriento asesinato y descuartizamiento de un taxista en Nueva York hace que los detectives Stabler y Benson investiguen y descubran que este hombre se estaba haciendo pasar por otro.', 44, '1999-09-20'),
(446, 29, 2, 'Una vida de soltera', 'Benson y Stabler se encargan del caso de una mujer que cae al vacío desde lo alto de un edificio. Los principales sospechosos son su psiquiatra, su amante y parte de su intrigante familia.', 43, '1999-09-27'),
(447, 29, 3, '...O parecer uno mismo', 'Una joven modelo es encontrada muerta y violada. La Unidad descubre alrededor de ella toda una siniestra maquinación en torno al culto al cuerpo que había llevado a la joven a la anorexia.', 43, '1999-10-04'),
(448, 29, 4, 'Histeria', 'Tras comprobar que la última víctima era una chica de alta extracción social, Benson y Stabler creen detectar en unos asesinatos de prostitutas unos patrones que conducen hasta otro policía.', 43, '1999-10-11'),
(449, 29, 5, 'Ansias de viajar', 'Un escritor es hallado muerto con los pantys de una mujer introducidos en la boca. La investigación lleva a los detectives hasta una adolescente que a Stabler le recuerda a su propia hija ', 45, '1999-10-18'),
(450, 29, 6, 'La maldición de la chica de segundo', 'Una prometedora estudiante en un colegio privado es violada y asesinada, pero la investigación se ve continuamente obstaculizada por la dirección del centro, que quiere evitar la mala prensa', 44, '1999-10-25'),
(451, 29, 7, 'Incivilizado', 'Los detectives Benson y Stabler tienen que investigar el caso del asesinato y violación de un joven. El único sospechoso parece ser un antiguo violador que ahora se dedica a coleccionar sellos.', 45, '1999-11-15'),
(452, 29, 8, 'Acechadas', 'El ayudante del fiscal del distrito es encontrado muerto y asaltado sexualmente. Los detectives Stabler y Benson inician la investigación, y esta última descubre que ella puede ser futura víctima.', 44, '1999-11-22'),
(453, 29, 9, 'Acciones y ataduras', 'Una analista financiera con una atracción fetichista por el sadomasoquismo es encontrada muerta. Benson y Stabler discuten sobre si ha sido un asesinato, y cuál habría sido el móvil, o un suicidio', 45, '1999-11-29'),
(454, 29, 10, 'Superación', 'Una mujer joven denuncia haber sido violada y golpeada. Las sospechas se dirigen hacia un hombre adinerado y con educación. Pero, con el tiempo, el caso se archiva. Sin embargo, el violador vuelve a actuar.', 45, '2000-01-07'),
(455, 29, 11, 'Mala sangre', 'El hijo del líder de la \"Coalición Moral\" aparece asesinado en la azotea de un edificio donde había asistido a una fiesta. Las pruebas de ADN llevan a los agentes a relacionar el caso con el portero del edificio y su hermano, con antecedentes penales por asesinato.', 45, '2000-01-14'),
(456, 29, 12, 'Poema de amor ruso', 'Un multimillonario es encontrado muerto, y la investigación de su vida privada conduce a unas sórdidas costumbres íntimas y a un círculo de inmigrantes rusos ilegales que negocian con el sexo.', 44, '2000-01-21'),
(457, 29, 13, 'Bajo la toga', 'Los detectives Benson y Stabler no entienden por qué ha podido ser asesinado un juez caracterizado por su lucha contra los abusos sexuales. Pronto descubren que el juez estaba corrupto.', 44, '2000-02-04'),
(458, 29, 14, 'Prescripciones', 'Un caso de abuso sexual que tiene cinco años de antigüedad es reabierto. Los detectives quedan impactados cuando una de las abusadas dice saber quién fue su asaltante, pero no quiere denunciarlo.', 44, '2000-02-11'),
(459, 29, 15, 'Deificados', 'La muerte de un hombre en extrañas circunstancias en un frustrado intento de asalto sexual poco a poco implica a una chica que forma parte de una familia con importante presencia femenina.', 44, '2000-02-18'),
(460, 29, 16, 'El tercer hombre', 'Las investigaciones de Benson y Stabler tras la muerte y agresión sexual de una anciana les llevan hasta un par de delincuentes que reconocen haber entrado a robar en casa de la fallecida.', 45, '2000-02-25'),
(461, 29, 17, 'Equivocado', 'La nuera de un importante educador religioso es encontrada muerta en la habitación de su hotel. Benson y Stabler sospechan de un ladrón que ha desvalijado varios hoteles de la ciudad.', 44, '2000-03-31'),
(462, 29, 18, 'Sala de chat', 'Benson y Stabler inician un rastreo de redes de pornografía infantil por Internet cuando investigan el caso de una muchacha de dieciséis años que asegura haber sido asaltada por un pederasta.', 44, '2000-04-14'),
(463, 29, 19, 'Contacto', 'Cuando Benson y Stabler detienen a un sospechoso de haber asaltado sexualmente a varias mujeres a bordo de sus coches en un subterráneo de la ciudad, ninguna víctima puede identificarlo.', 42, '2000-04-28'),
(464, 29, 20, 'Remordimiento', 'El detective Munch comienza un intimar con una reportera de un programa de noticias que fue asaltada sexualmente dos meses antes. Sin embargo, el estallido de una bomba interrumpe la investigación.', 44, '2000-05-05'),
(465, 29, 21, 'Nocturno', 'El juicio a un hombre acusado de abusar de menores de edad sufre un giro cuando un profesor de piano es acusado de pedofilia, y uno de los principales testigos tiene problemas para identificarlo.', 43, '2000-05-12'),
(466, 29, 22, 'Esclavas', 'Un abogado sospechoso de utilizar a una inmigrante rumana como esclava sexual es relacionado con un asesinato. Mientras, un psicólogo recomienda a Cragen que expulse a uno de sus hombres.', 44, '2000-05-21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id_favorito` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_contenido` int(11) NOT NULL,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `generos`
--

CREATE TABLE `generos` (
  `id_genero` int(11) NOT NULL,
  `tmdb_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `generos`
--

INSERT INTO `generos` (`id_genero`, `tmdb_id`, `nombre`) VALUES
(1, 28, 'Acción'),
(2, 12, 'Aventura'),
(3, 16, 'Animación'),
(4, 35, 'Comedia'),
(5, 80, 'Crimen'),
(6, 99, 'Documental'),
(7, 18, 'Drama'),
(8, 10751, 'Familia'),
(9, 14, 'Fantasía'),
(10, 36, 'Historia'),
(11, 27, 'Terror'),
(12, 10402, 'Música'),
(13, 9648, 'Misterio'),
(14, 10749, 'Romance'),
(15, 878, 'Ciencia ficción'),
(16, 10770, 'Película de TV'),
(17, 53, 'Suspense'),
(18, 10752, 'Bélica'),
(19, 37, 'Western'),
(20, 10759, 'Action & Adventure'),
(27, 10762, 'Kids'),
(29, 10763, 'News'),
(30, 10764, 'Reality'),
(31, 10765, 'Sci-Fi & Fantasy'),
(32, 10766, 'Soap'),
(33, 10767, 'Talk'),
(34, 10768, 'War & Politics');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pendientes`
--

CREATE TABLE `pendientes` (
  `id_pendiente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_contenido` int(11) NOT NULL,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temporadas`
--

CREATE TABLE `temporadas` (
  `id_temporada` int(11) NOT NULL,
  `id_contenido` int(11) NOT NULL,
  `numero_temporada` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `fecha_lanzamiento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `temporadas`
--

INSERT INTO `temporadas` (`id_temporada`, `id_contenido`, `numero_temporada`, `titulo`, `fecha_lanzamiento`) VALUES
(1, 21, 1, 'Temporada 1', '2022-11-23'),
(2, 22, 1, 'Temporada 1', '2025-07-19'),
(3, 21, 2, 'Temporada 2', '2025-08-06'),
(4, 23, 1, 'Temporada 1', '2025-08-12'),
(5, 24, 1, 'Temporada 1', '2018-10-16'),
(6, 24, 2, 'Temporada 2', '2019-09-29'),
(7, 25, 0, 'Especiales', '2022-06-10'),
(8, 24, 3, 'Temporada 3', '2021-01-02'),
(9, 25, 1, 'Temporada 1', '2014-04-25'),
(10, 25, 2, 'Temporada 2', '2015-04-25'),
(11, 24, 4, 'Temporada 4', '2021-09-26'),
(12, 25, 3, 'Temporada 3', '2017-04-23'),
(13, 24, 5, 'Temporada 5', '2022-09-25'),
(14, 25, 4, 'Temporada 4', '2022-06-17'),
(15, 24, 6, 'Temporada 6', '2024-02-20'),
(16, 25, 5, 'Temporada 5', '2023-10-25'),
(17, 24, 7, 'Temporada 7', '2025-01-07'),
(18, 25, 6, 'Temporada 6', '2024-09-04'),
(19, 24, 8, 'Temporada 8', NULL),
(20, 25, 7, 'Temporada 7', '2025-08-16'),
(21, 27, 1, 'Temporada 1', '2025-08-13'),
(22, 26, 1, 'Temporada 1', '2022-06-16'),
(23, 26, 2, 'Temporada 2', '2023-07-13'),
(24, 28, 1, 'Temporada 1', '2021-09-17'),
(25, 26, 3, 'Temporada 3', '2025-07-16'),
(26, 28, 2, 'Temporada 2', '2024-12-26'),
(27, 28, 3, 'Temporada 3', '2025-06-27'),
(28, 29, 0, 'Especiales', NULL),
(29, 29, 1, 'Temporada 1', '1999-09-20'),
(30, 30, 0, 'Especiales', '2009-10-25'),
(31, 29, 2, 'Temporada 2', '2000-10-19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `avatar_url` varchar(255) DEFAULT NULL,
  `rol` enum('usuario','admin') DEFAULT 'usuario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `email`, `password_hash`, `fecha_registro`, `avatar_url`, `rol`) VALUES
(2, '', 'hola@gmail.com', '$2y$10$MPY6jDoyS479dZHJadEhP.oIfkIRwTgcwAiIe3sMKPSlIiZVH5Iwu', '2025-09-22 21:46:32', NULL, 'usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vistas`
--

CREATE TABLE `vistas` (
  `id_visto` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_contenido` int(11) NOT NULL,
  `fecha_visto` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`id_calificacion`),
  ADD UNIQUE KEY `uq_calif_user_content` (`id_usuario`,`id_contenido`),
  ADD KEY `id_contenido` (`id_contenido`);

--
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id_contenido`),
  ADD UNIQUE KEY `tmdb_id` (`tmdb_id`);

--
-- Indices de la tabla `contenido_generos`
--
ALTER TABLE `contenido_generos`
  ADD PRIMARY KEY (`id_contenido`,`id_genero`),
  ADD KEY `id_genero` (`id_genero`);

--
-- Indices de la tabla `episodios`
--
ALTER TABLE `episodios`
  ADD PRIMARY KEY (`id_episodio`),
  ADD KEY `id_temporada` (`id_temporada`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id_favorito`),
  ADD UNIQUE KEY `uq_fav_user_content` (`id_usuario`,`id_contenido`),
  ADD KEY `id_contenido` (`id_contenido`);

--
-- Indices de la tabla `generos`
--
ALTER TABLE `generos`
  ADD PRIMARY KEY (`id_genero`),
  ADD UNIQUE KEY `tmdb_id` (`tmdb_id`);

--
-- Indices de la tabla `pendientes`
--
ALTER TABLE `pendientes`
  ADD PRIMARY KEY (`id_pendiente`),
  ADD UNIQUE KEY `uq_pend_user_content` (`id_usuario`,`id_contenido`),
  ADD KEY `id_contenido` (`id_contenido`);

--
-- Indices de la tabla `temporadas`
--
ALTER TABLE `temporadas`
  ADD PRIMARY KEY (`id_temporada`),
  ADD KEY `id_contenido` (`id_contenido`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `vistas`
--
ALTER TABLE `vistas`
  ADD PRIMARY KEY (`id_visto`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_contenido` (`id_contenido`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `id_calificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `id_contenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT de la tabla `episodios`
--
ALTER TABLE `episodios`
  MODIFY `id_episodio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=467;

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id_favorito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `generos`
--
ALTER TABLE `generos`
  MODIFY `id_genero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `pendientes`
--
ALTER TABLE `pendientes`
  MODIFY `id_pendiente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `temporadas`
--
ALTER TABLE `temporadas`
  MODIFY `id_temporada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vistas`
--
ALTER TABLE `vistas`
  MODIFY `id_visto` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`) ON DELETE CASCADE;

--
-- Filtros para la tabla `contenido_generos`
--
ALTER TABLE `contenido_generos`
  ADD CONSTRAINT `contenido_generos_ibfk_1` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`) ON DELETE CASCADE,
  ADD CONSTRAINT `contenido_generos_ibfk_2` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`id_genero`) ON DELETE CASCADE;

--
-- Filtros para la tabla `episodios`
--
ALTER TABLE `episodios`
  ADD CONSTRAINT `episodios_ibfk_1` FOREIGN KEY (`id_temporada`) REFERENCES `temporadas` (`id_temporada`) ON DELETE CASCADE;

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pendientes`
--
ALTER TABLE `pendientes`
  ADD CONSTRAINT `pendientes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `pendientes_ibfk_2` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`) ON DELETE CASCADE;

--
-- Filtros para la tabla `temporadas`
--
ALTER TABLE `temporadas`
  ADD CONSTRAINT `temporadas_ibfk_1` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`) ON DELETE CASCADE;

--
-- Filtros para la tabla `vistas`
--
ALTER TABLE `vistas`
  ADD CONSTRAINT `vistas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `vistas_ibfk_2` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
