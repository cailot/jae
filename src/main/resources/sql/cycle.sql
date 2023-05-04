CREATE TABLE `Cycle` (
  `id` bigint(20) NOT NULL,
  'year' int(4) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `vacationStartDate` date NOT NULL,
  `vacationEndDate` date NOT NULL,
  `registerDate` date DEFAULT NULL
  
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Indexes for table `Cycle`
--
ALTER TABLE `Cycle`
  ADD PRIMARY KEY (`id`);


--
-- AUTO_INCREMENT for table `Cycle`
--
ALTER TABLE `Cycle`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;







INSERT INTO jae.Cycle (year, description, startDate, endDate, vacationStartDate, vacationEndDate, registerDate) VALUES (2019,'2019 Academic Calendar', '2019-06-17', '2020-06-14', '2019-12-23', '2020-01-10', CURDATE());
INSERT INTO jae.Cycle (year, description, startDate, endDate, vacationStartDate, vacationEndDate, registerDate) VALUES (2020,'2020 Academic Calendar', '2020-06-15', '2021-06-13', '2020-12-21', '2021-01-08', CURDATE());
INSERT INTO jae.Cycle (year, description, startDate, endDate, vacationStartDate, vacationEndDate, registerDate) VALUES (2021,'2021 Academic Calendar', '2021-06-14', '2022-06-12', '2021-12-20', '2022-01-07', CURDATE());
INSERT INTO jae.Cycle (year, description, startDate, endDate, vacationStartDate, vacationEndDate, registerDate) VALUES (2022,'2022 Academic Calendar', '2022-06-13', '2023-06-11', '2022-12-19', '2023-01-06', CURDATE());
INSERT INTO jae.Cycle (year, description, startDate, endDate, vacationStartDate, vacationEndDate, registerDate) VALUES (2023,'2023 Academic Calendar', '2023-06-12', '2024-06-09', '2023-12-25', '2024-01-13', CURDATE());
INSERT INTO jae.Cycle (year, description, startDate, endDate, vacationStartDate, vacationEndDate, registerDate) VALUES (2024,'2024 Academic Calendar', '2024-06-10', '2025-06-08', '2024-12-23', '2025-01-11', CURDATE());


COMMIT;


