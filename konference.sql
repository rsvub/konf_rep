-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Pát 19. led 2018, 21:53
-- Verze serveru: 10.1.29-MariaDB
-- Verze PHP: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `konference`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `prispevek`
--

CREATE TABLE `prispevek` (
  `id_prispevek` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL,
  `id_recenzent` int(11) NOT NULL,
  `id_rodic_prispevek` int(11) NOT NULL,
  `id_administrator` int(11) NOT NULL,
  `datum` date NOT NULL,
  `nazev` varchar(45) COLLATE utf8_czech_ci NOT NULL,
  `text` varchar(250) COLLATE utf8_czech_ci NOT NULL,
  `soubor` binary(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `recenze`
--

CREATE TABLE `recenze` (
  `id_recenze` int(11) NOT NULL,
  `id_recenzent` int(11) NOT NULL,
  `id_prispevek` int(11) NOT NULL,
  `poznamka` varchar(250) COLLATE utf8_czech_ci NOT NULL,
  `ciselnik_originalita` enum('Originální','Pár originálních myšlenek','Nic nového','Opsáno') COLLATE utf8_czech_ci NOT NULL,
  `ciselnik_tema` enum('Výborně se drží tématu','Relevantní','Vcelku relevantní','Irelevantní') COLLATE utf8_czech_ci NOT NULL,
  `ciselnik_doporuceni` enum('Velice doporučuji','Doporučuji','Doporučuji s výhradou','Nedoporučuji') COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `uzivatel`
--

CREATE TABLE `uzivatel` (
  `id_uzivatel` int(11) NOT NULL,
  `jmeno` varchar(45) COLLATE utf8_czech_ci NOT NULL,
  `heslo` varchar(45) COLLATE utf8_czech_ci NOT NULL,
  `nazev` varchar(45) COLLATE utf8_czech_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_czech_ci NOT NULL,
  `typ` varchar(1) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `prispevek`
--
ALTER TABLE `prispevek`
  ADD PRIMARY KEY (`id_prispevek`),
  ADD KEY `id_recenzent` (`id_recenzent`),
  ADD KEY `id_rodic_prispevek` (`id_rodic_prispevek`),
  ADD KEY `id_autor` (`id_autor`),
  ADD KEY `id_administrator` (`id_administrator`) USING BTREE;

--
-- Klíče pro tabulku `recenze`
--
ALTER TABLE `recenze`
  ADD PRIMARY KEY (`id_recenze`),
  ADD KEY `id_recenzent - id_uizvatel` (`id_recenzent`) USING BTREE,
  ADD KEY `id_prispevek` (`id_prispevek`) USING BTREE;

--
-- Klíče pro tabulku `uzivatel`
--
ALTER TABLE `uzivatel`
  ADD PRIMARY KEY (`id_uzivatel`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `prispevek`
--
ALTER TABLE `prispevek`
  MODIFY `id_prispevek` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `recenze`
--
ALTER TABLE `recenze`
  MODIFY `id_recenze` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `uzivatel`
--
ALTER TABLE `uzivatel`
  MODIFY `id_uzivatel` int(11) NOT NULL AUTO_INCREMENT;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `prispevek`
--
ALTER TABLE `prispevek`
  ADD CONSTRAINT `prispevek_ibfk_2` FOREIGN KEY (`id_recenzent`) REFERENCES `uzivatel` (`id_uzivatel`),
  ADD CONSTRAINT `prispevek_ibfk_3` FOREIGN KEY (`id_rodic_prispevek`) REFERENCES `prispevek` (`id_prispevek`),
  ADD CONSTRAINT `prispevek_ibfk_4` FOREIGN KEY (`id_autor`) REFERENCES `uzivatel` (`id_uzivatel`),
  ADD CONSTRAINT `prispevek_ibfk_5` FOREIGN KEY (`id_administrator`) REFERENCES `uzivatel` (`id_uzivatel`);

--
-- Omezení pro tabulku `recenze`
--
ALTER TABLE `recenze`
  ADD CONSTRAINT `recenze_ibfk_1` FOREIGN KEY (`id_prispevek`) REFERENCES `prispevek` (`id_prispevek`),
  ADD CONSTRAINT `recenze_ibfk_2` FOREIGN KEY (`id_recenzent`) REFERENCES `uzivatel` (`id_uzivatel`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
