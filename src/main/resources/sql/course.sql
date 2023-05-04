CREATE TABLE `Course` (
  `id` bigint(20) NOT NULL,
  `day` varchar(10) COLLATE latin1_general_ci NOT NULL,
  `description` varchar(400) COLLATE latin1_general_ci NOT NULL,
  `grade` varchar(10) COLLATE latin1_general_ci NOT NULL,
  `name` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `registerDate` date DEFAULT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Indexes for table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Course`
--
ALTER TABLE `Course`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;
COMMIT;







INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','p2', 'Friday', 'Year 2 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('MON','p2', 'Monday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','p2', 'Saturday', 'Year 2 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','p2', 'Saturday', 'Year 2 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','p2', 'Thursday', 'Year 2 Thursday', CURDATE());

INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','p3', 'Friday', 'Year 3 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('MON','p3', 'Monday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','p3', 'Saturday', 'Year 3 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','p3', 'Saturday', 'Year 3 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','p3', 'Thursday', 'Year 3 Thursday', CURDATE());

INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','p4', 'Friday', 'Year 4 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('MON','p4', 'Monday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','p4', 'Saturday', 'Year 4 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','p4', 'Saturday', 'Year 4 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','p4', 'Thursday', 'Year 4 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','p4', 'Thursday', 'Year 4 Power Writing', CURDATE());

INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','p5', 'Friday', 'Year 5 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('TUE','p5', 'Tuesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','p5', 'Saturday', 'Year 5 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','p5', 'Saturday', 'Year 5 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','p5', 'Thursday', 'Year 5 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('TUE','p5', 'Tuesday', 'Year 5 Power Writing', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','p6', 'Friday', 'Year 6 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('TUE','p6', 'Tuesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','p6', 'Saturday', 'Year 6 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','p6', 'Saturday', 'Year 6 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','p6', 'Friday', 'Year 6 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','s7', 'Friday', 'Year 7 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','s7', 'Saturday', 'Year 7 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','s7', 'Saturday', 'Year 7 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','s7', 'Thursday', 'Year 7 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('TUE','s7', 'Tuesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','s8', 'Friday', 'Year 8 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','s8', 'Saturday', 'Year 8 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','s8', 'Saturday', 'Year 8 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','s8', 'Thursday', 'Year 8 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','s8', 'Wednesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','s9', 'Friday', 'Year 9 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','s9', 'Saturday', 'Year 9 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','s9', 'Saturday', 'Year 9 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','s9', 'Thursday', 'Year 9 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','s9', 'Wednesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','s10', 'Friday', 'Year 10 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','s10', 'Saturday', 'Year 10 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','s10', 'Saturday', 'Year 10 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','s10', 'Thursday', 'Year 10 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','s10', 'Wednesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','tt6', 'Friday', 'TT6 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','tt6', 'Saturday', 'TT6 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','tt6', 'Saturday', 'TT6 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','tt6', 'Thursday', 'TT6 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('TUE','tt6', 'Tuesday', 'Online Free Tutorial Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','tt6', 'Wednesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','tt6', 'Wednesday', 'PW6 Wednesday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI','tt8', 'Friday', 'TT8 Friday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM','tt8', 'Saturday', 'TT8 Saturday morning', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM','tt8', 'Saturday', 'TT8 Saturday afternoon', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('THU','tt8', 'Thursday', 'TT8 Thursday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('TUE','tt8', 'Tuesday', 'Online Free Tutorial Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','tt8', 'Wednesday', 'Online Class', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED','tt8', 'Wednesday', 'PW8 Wednesday', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED W4','srw4', 'Wednesday', '[P4] SRW', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('TUE W5','srw5', 'Tuesday', '[P5] SRW', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED W6','srw6', 'Wednesday', '[TT6] SRW', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('WED W8','srw8', 'Wednesday', '[TT8] SRW', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI ENG 3&4','vce', 'Friday', 'VCE ENGLISH 3&4', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('FRI MM 3&4','vce', 'Friday', 'VCE ENGLISH 3&4', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM CHEM 1&2','vce', 'Saturday', 'VCE CHEMISTRY 1&2', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SAM CHEM 3&4','vce', 'Saturday', 'VCE CHEMISTRY 3&4', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM BIO 1&2','vce', 'Saturday', 'VCE BIOLOGY 1&2', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM BIO 3&4','vce', 'Saturday', 'VCE BIOLOGY 3&4', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM ENG 1&2','vce', 'Saturday', 'VCE ENGLISH 1&2', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM ENG 3&4','vce', 'Saturday', 'VCE ENGLISH 3&4', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM FM 3&4','vce', 'Saturday', 'VCE FURTHER MATHS 3&4', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM MM 1&2','vce', 'Saturday', 'VCE MATHS METHODS 1&2', CURDATE());
INSERT INTO jae.Course (name, grade, day, description, registerDate) VALUES ('SPM MM 3&4','vce', 'Saturday', 'VCE MATHS METHODS 3&4', CURDATE());

COMMIT;
