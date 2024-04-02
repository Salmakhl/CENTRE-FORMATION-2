mysql> show databases ;
+--------------------+
| Database           |
+--------------------+
| bdvol              |
| centre_formation   |
| chevaux_ecurie     |
| djallabasoft       |
| hollywood          |
| information_schema |
| isgi               |
| mysql              |
| newschema          |
| performance_schema |
| sakila             |
| stu                |
| sys                |
| test1              |
| test2              |
| test3              |
+--------------------+
16 rows in set (0.00 sec)

mysql> use centre_formation;
Database changed
mysql> show tables ;
+----------------------------+
| Tables_in_centre_formation |
+----------------------------+
| catalogue                  |
| etudiant                   |
| formation                  |
| inscription                |
| session                    |
| specialite                 |
+----------------------------+
6 rows in set (0.00 sec)

mysql> select * from formation;
+----------+-------------------------+-----------+----------+
| codeForm | titreform               | dureeform | prixform |
+----------+-------------------------+-----------+----------+
|       11 | Programming Java        |        12 |     3600 |
|       12 | Web developpement       |        14 |     4200 |
|       13 | Anglais technique       |        15 |     3750 |
|       14 | Communication           |        10 |     2500 |
|       15 | Base de données Oracle  |        20 |     6000 |
|       16 | Soft skills             |        12 |     3000 |
+----------+-------------------------+-----------+----------+
6 rows in set (0.09 sec)

mysql> select * from session;
+----------+--------------+------------+------------+----------+
| codeSess | nomsess      | datedebut  | datefin    | codeform |
+----------+--------------+------------+------------+----------+
|     1101 | Session1101  | 2022-01-02 | 2022-01-14 |       11 |
|     1102 | Session 1102 | 2022-02-03 | 2022-02-15 |       11 |
|     1104 | Session 1104 | 2022-10-15 | 2022-10-27 |       11 |
|     1201 | Session 1201 | 2022-03-04 | 2022-03-18 |       12 |
|     1202 | Session 1202 | 2022-04-05 | 2022-04-19 |       12 |
|     1203 | Session 1203 | 2022-11-16 | 2022-11-30 |       12 |
|     1204 | Session 1204 | 2022-12-17 | 2022-12-31 |       12 |
|     1301 | Session 1301 | 2022-01-06 | 2022-01-21 |       13 |
|     1302 | Session 1302 | 2022-05-07 | 2022-05-22 |       13 |
|     1303 | Session 1303 | 2022-06-08 | 2022-06-23 |       13 |
|     1401 | Session 1401 | 2022-09-01 | 2022-09-11 |       14 |
|     1402 | Session 1402 | 2022-08-08 | 2022-08-18 |       14 |
|     1501 | Session 1501 | 2022-11-11 | 2022-12-01 |       15 |
|     1502 | Session 1502 | 2022-09-12 | 2022-10-02 |       15 |
|     1601 | Session 1601 | 2022-09-13 | 2022-09-25 |       16 |
|     1602 | Session 1602 | 2022-10-14 | 2022-10-26 |       16 |
+----------+--------------+------------+------------+----------+
16 rows in set (0.02 sec)

mysql> select nomsess ,datedebut, datefin from session and
    -> titreform from formation where codeform from session
    -> where now() betwen datedebut and datefin;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'and
titreform from formation where codeform from session
where now() betwen date' at line 1
mysql> SELECT session.nomsess, session.datedebut, session.datefin, formation.titreform
    -> FROM session
    -> JOIN formation ON session.codeform = formation.codeform
    -> WHERE NOW() BETWEEN session.datedebut AND session.datefin;
Empty set (0.03 sec)

mysql> desc etudiant;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| numCinEtu     | varchar(10) | NO   | PRI | NULL    |       |
| nomEtu        | varchar(45) | YES  |     | NULL    |       |
| prenomEtu     | varchar(45) | YES  |     | NULL    |       |
| dateNaissance | date        | YES  |     | NULL    |       |
| adressEtu     | varchar(45) | YES  |     | NULL    |       |
| villeEtu      | varchar(45) | YES  |     | NULL    |       |
| niveauEtu     | varchar(45) | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
7 rows in set (0.01 sec)

mysql> select formation ;
ERROR 1054 (42S22): Unknown column 'formation' in 'field list'
mysql> desc formation ;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| codeForm  | int         | NO   | PRI | NULL    |       |
| titreform | varchar(45) | YES  |     | NULL    |       |
| dureeform | int         | YES  |     | NULL    |       |
| prixform  | int         | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> desc inscription ;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| codeSess   | int         | YES  | MUL | NULL    |       |
| num_cin    | varchar(10) | YES  |     | NULL    |       |
| type_cours | varchar(10) | NO   |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> show tables ;
+----------------------------+
| Tables_in_centre_formation |
+----------------------------+
| catalogue                  |
| etudiant                   |
| formation                  |
| inscription                |
| session                    |
| specialite                 |
+----------------------------+
6 rows in set (0.00 sec)

mysql> SELECT f.titreform AS 'Titre de la formation', s.nomsess AS 'Nom de la session',
    ->        CONCAT(st.prenom, ' ', st.nom) AS 'Étudiant'
    -> FROM formation f
    -> JOIN session s ON f.codeform = s.codeform
    -> JOIN student_session ss ON s.idsession = ss.idsession
    -> JOIN student st ON ss.idstudent = st.idstudent
    -> ORDER BY f.titreform;
ERROR 1146 (42S02): Table 'centre_formation.student_session' doesn't exist
mysql> SELECT f.titreform AS 'Titre de la formation', s.nomsess AS 'Nom de la session',
    ->        CONCAT(st.prenom, ' ', st.nom) AS 'Étudiant'
    -> FROM formation f
    -> JOIN session s ON f.codeform = s.codeform
    -> JOIN student ss ON s.idsession = ss.idsession
    -> ^C
mysql> desc etudiant ;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| numCinEtu     | varchar(10) | NO   | PRI | NULL    |       |
| nomEtu        | varchar(45) | YES  |     | NULL    |       |
| prenomEtu     | varchar(45) | YES  |     | NULL    |       |
| dateNaissance | date        | YES  |     | NULL    |       |
| adressEtu     | varchar(45) | YES  |     | NULL    |       |
| villeEtu      | varchar(45) | YES  |     | NULL    |       |
| niveauEtu     | varchar(45) | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
7 rows in set (0.00 sec)

mysql> select titreform , nomEtu
    -> from formation
    -> join session on formation.codefrom=session.codeform
    -> join etudiant on