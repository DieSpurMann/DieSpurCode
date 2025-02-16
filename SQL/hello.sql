DROP SCHEMA IF EXISTS bieres CASCADE;

CREATE SCHEMA bieres;
SET SCHEMA 'bieres';

create table bieres.buveur
(
        idbuveur integer,
        nomb varchar(50)     NOT NULL,
        prenomb varchar(50)    NOT NULL,
        login varchar(50) NOT NULL,
        constraint buveur_pk primary key(idbuveur)
);

create table bieres.biere
(
        idbiere integer,
        nombiere varchar(50)     NOT NULL,
        degre integer            NOT NULL,
        typebiere varchar(50)    NOT NULL,
        constraint biere_pk    primary key(idbiere)
);

create table bieres.bar
(
        idbar integer,
        nombar varchar(50)        NOT NULL,
        villebar varchar(50)    NOT NULL,
        constraint bar_pk primary key(idbar)
);

create table bieres.frequenter
(
        idbuveur integer,
        idbar integer,
        constraint freq_pk primary key(idbuveur, idbar),
        constraint freq_buveur_key foreign key(idbuveur) references bieres.buveur(idbuveur),
        constraint  freq_bar_key foreign key(idbar) references bieres.bar(idbar)
);

create table bieres.aimer
(
        idbuveur integer,
        idbiere integer,
        constraint aim_pk primary key(idbuveur, idbiere),
        constraint aim_buveur_key foreign key(idbuveur) references bieres.buveur(idbuveur),
        constraint aim_biere_key foreign key(idbiere) references bieres.biere(idbiere)
);

create table bieres.servir
(
        idbar integer,
        idbiere integer,
        constraint serv_ok primary key(idbiere, idbar),
        constraint ser_bar_key foreign key(idbar)  references bieres.bar(idbar),
        constraint ser_biere_key foreign key(idbiere) references bieres.biere(idbiere)
);

-- EX4 table création 

CREATE TABLE bieres.buveurs_amateurs (
   idbuveur numeric(3) primary key,
   login varchar(20) not null,
   nomb varchar(30) not null,
   prenomb varchar(30) not null
);

CREATE TABLE bieres.buveurs_pros (
   idbuveur numeric(3) primary key,
   login varchar(20) not null,
   nomb varchar(30) not null,
   prenomb varchar(30) not null,
   idbar_prefere numeric(3) not null
);

-- Ex5 table création

CREATE TABLE bieres.audit_biere (
   idbiere varchar(10),
   action varchar(3),
   utilisateur varchar(30),
   date_modif timestamp
);


/* Remplissage des tables */
insert into buveur(idbuveur, nomb, prenomb,login) values(1,'Eastwood', 'Clint','moukhouyaali');
insert into buveur(idbuveur, nomb, prenomb,login) values(2, 'Abitbol', 'Georges','gab');
insert into buveur(idbuveur, nomb, prenomb,login) values(3, 'DeNice', 'Brice','bde');
insert into buveur(idbuveur, nomb, prenomb,login) values(4, 'Bricot', 'Juda','jbri');
insert into buveur(idbuveur, nomb, prenomb,login) values(5, 'Conseil', 'Benjamin','bconseil');
insert into buveur(idbuveur, nomb, prenomb,login) values(6, 'Kollyck', 'Al','ako');


insert into biere(idbiere,nombiere,degre,typebiere) values(1, 'kronembourg', 4, 'pils');
insert into biere(idbiere,nombiere,degre,typebiere) values(2, 'pilsener', 5, 'pils');
insert into biere(idbiere,nombiere,degre,typebiere) values(3, 'heinecken', 5, 'pils');
insert into biere(idbiere,nombiere,degre,typebiere) values(4, 'leffe', 6, 'triple');
insert into biere(idbiere,nombiere,degre,typebiere) values(5, 'smirnoff', 4, 'arromatisee');
insert into biere(idbiere,nombiere,degre,typebiere) values(6, 'dremmwel', 6,' al');


insert into bar(idbar,nombar,villebar) values(2, 'Bar des sports', 'Lannion');
insert into bar(idbar,nombar,villebar) values(3, 'Chez momo', 'Morlaix');
insert into bar(idbar,nombar,villebar) values(4, 'Bar du bon coin', 'Morlaix');
insert into bar(idbar,nombar,villebar) values(1, 'Anti soif', 'Lannion');
insert into bar(idbar,nombar,villebar) values(6, 'Chti canon', 'Tregastel');
insert into bar(idbar,nombar,villebar) values(5, 'Bar Aine', 'Lannion');

insert into frequenter(idbuveur, idbar) values(1, 1);
insert into frequenter(idbuveur, idbar) values(1, 2);
insert into frequenter(idbuveur, idbar) values(1, 3);
insert into frequenter(idbuveur, idbar) values(1, 4);
insert into frequenter(idbuveur, idbar) values(1, 5);
insert into frequenter(idbuveur, idbar) values(1, 6);
insert into frequenter(idbuveur, idbar) values(2, 2);
insert into frequenter(idbuveur, idbar) values(4, 1);
insert into frequenter(idbuveur, idbar) values(4, 4);
insert into frequenter(idbuveur, idbar) values(5, 1);
insert into frequenter(idbuveur, idbar) values(5, 2);
insert into frequenter(idbuveur, idbar) values(5, 3);
insert into frequenter(idbuveur, idbar) values(5, 4);
insert into frequenter(idbuveur, idbar) values(5, 5);
insert into frequenter(idbuveur, idbar) values(6, 2);

insert into servir(idbar, idbiere) values(1, 1);
insert into servir(idbar, idbiere) values(1, 3);
insert into servir(idbar, idbiere) values(1, 4);
insert into servir(idbar, idbiere) values(2, 1);
insert into servir(idbar, idbiere) values(4, 3);
insert into servir(idbar, idbiere) values(5, 4);
insert into servir(idbar, idbiere) values(3, 1);
insert into servir(idbar, idbiere) values(3, 3);
insert into servir(idbar, idbiere) values(3, 5);
insert into servir(idbar, idbiere) values(5, 5);
insert into servir(idbar, idbiere) values(4, 5);
insert into servir(idbar, idbiere) values(6, 5);
insert into servir(idbar, idbiere) values(4, 1);
insert into servir(idbar, idbiere) values(4, 4);
insert into servir(idbar, idbiere) values(4, 6);


insert into aimer(idbuveur, idbiere) values(1, 2);
insert into aimer(idbuveur, idbiere) values(1, 3);
insert into aimer(idbuveur, idbiere) values(2, 3);
insert into aimer(idbuveur, idbiere) values(3, 1);
insert into aimer(idbuveur, idbiere) values(3, 2);
insert into aimer(idbuveur, idbiere) values(3, 3);
insert into aimer(idbuveur, idbiere) values(3, 4);
insert into aimer(idbuveur, idbiere) values(3, 5);
insert into aimer(idbuveur, idbiere) values(3, 6);
insert into aimer(idbuveur, idbiere) values(4, 1);
insert into aimer(idbuveur, idbiere) values(6, 1);
insert into aimer(idbuveur, idbiere) values(6, 3);
insert into aimer(idbuveur, idbiere) values(6, 5);


--ex 1
CREATE OR REPLACE VIEW bieres.mes_infos AS
SELECT idbuveur, nomb, prenomb, login
FROM bieres.buveur
WHERE login = CURRENT_USER;

CREATE OR REPLACE VIEW bieres.mes_bieres AS
SELECT b.idbiere, b.nombiere, b.degre, b.typebiere
FROM bieres.biere b
JOIN bieres.aimer a ON b.idbiere = a.idbiere
JOIN bieres.buveur u ON a.idbuveur = u.idbuveur
WHERE u.login = CURRENT_USER;

select * from bieres.mes_infos;
select * from bieres.mes_bieres;


-- GRANT CONNECT on database moukhouyaali to PUBLIC;
Grant USAGE on schema bieres to PUBLIC;

GRANT SELECT ON bieres.mes_infos TO PUBLIC;
GRANT SELECT ON bieres.mes_bieres TO PUBLIC;


--ex 2
CREATE OR REPLACE VIEW bieres.n_frequenter AS
SELECT distinct a.idbuveur, s.idbar
FROM bieres.aimer a
JOIN bieres.servir s ON a.idbiere = s.idbiere;

select * from bieres.n_frequenter;

--ex 3 

-- Fonction pour vérifier les changements de degré d'alcool
CREATE OR REPLACE FUNCTION bieres.check_degre_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier que la modification ne dépasse pas 1 degré
    IF ABS(NEW.degre - OLD.degre) > 1 THEN
        RAISE EXCEPTION 'La modification du degré ne peut pas dépasser 1 degré';
    END IF;

    -- Vérifier que l'utilisateur est un amateur de la bière
    IF NOT EXISTS (
        SELECT 1 
        FROM bieres.aimer a
        JOIN bieres.buveur b ON a.idbuveur = b.idbuveur
        WHERE b.login = CURRENT_USER 
        AND a.idbiere = NEW.idbiere
    ) THEN
        RAISE EXCEPTION 'Seuls les amateurs de cette bière peuvent modifier son degré d''alcool';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger
CREATE TRIGGER check_degre_biere
BEFORE UPDATE OF degre ON bieres.biere
FOR EACH ROW
EXECUTE FUNCTION bieres.check_degre_update();

-- TEST ex 3

-- Test avec une modification de plus d'un degré (doit échouer)
--UPDATE bieres.biere SET degre = degre + 2 WHERE idbiere = 1;

-- Test par un utilisateur qui n'aime pas la bière (doit échouer)
--UPDATE bieres.biere SET degre = degre + 1 WHERE idbiere = 1;

-- Test valide par un amateur de la bière
--UPDATE bieres.biere SET degre = degre + 1 WHERE idbiere IN (
--    SELECT idbiere FROM bieres.aimer WHERE idbuveur = 1
--);


-- EX4


-- Vue toutbuveur
CREATE OR REPLACE VIEW bieres.toutbuveur AS
SELECT idbuveur, login, nomb, prenomb, idbar_prefere, 'P' as nature
FROM bieres.buveurs_pros 
UNION
SELECT idbuveur, login, nomb, prenomb, NULL as idbar_prefere, 'A' as nature
FROM bieres.buveurs_amateurs;

-- Fonction trigger pour l'insertion
CREATE OR REPLACE FUNCTION bieres.insert_toutbuveur()
RETURNS TRIGGER AS $$
BEGIN
   IF NEW.nature NOT IN ('P', 'A') THEN
       RAISE EXCEPTION 'Nature invalide : doit être P ou A';
   END IF;

   IF NEW.nature = 'P' THEN
       IF NEW.idbar_prefere IS NULL THEN
           RAISE EXCEPTION 'Un buveur professionnel doit avoir un bar préféré';
       END IF;
       INSERT INTO bieres.buveurs_pros VALUES (
           NEW.idbuveur, NEW.login, NEW.nomb, NEW.prenomb, NEW.idbar_prefere
       );
   ELSE
       IF NEW.idbar_prefere IS NOT NULL THEN
           RAISE EXCEPTION 'Un amateur ne peut pas avoir de bar préféré';
       END IF;
       INSERT INTO bieres.buveurs_amateurs VALUES (
           NEW.idbuveur, NEW.login, NEW.nomb, NEW.prenomb
       );
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Création du trigger
CREATE TRIGGER insert_toutbuveur_trigger
INSTEAD OF INSERT ON bieres.toutbuveur
FOR EACH ROW
EXECUTE FUNCTION bieres.insert_toutbuveur();


-- Test insertion buveur pro
INSERT INTO bieres.toutbuveur VALUES(100, 'pro1', 'Dupont', 'Jean', 1, 'P');

-- Test insertion amateur
INSERT INTO bieres.toutbuveur VALUES(101, 'ama1', 'Martin', 'Paul', null, 'A');

-- EX5


-- Fonction trigger
CREATE OR REPLACE FUNCTION bieres.audit_biere_changes() 
RETURNS TRIGGER AS $$
BEGIN
   CASE TG_OP
       WHEN 'DELETE' THEN
           INSERT INTO bieres.audit_biere VALUES(
               OLD.idbiere::text, 
               'DES',
               CURRENT_USER,
               CURRENT_TIMESTAMP
           );
           RETURN OLD;
           
       WHEN 'INSERT' THEN
           INSERT INTO bieres.audit_biere VALUES(
               COALESCE(NEW.idbiere::text, 'ABS'),
               'INS',
               CURRENT_USER,
               CURRENT_TIMESTAMP
           );
           RETURN NEW;
           
       WHEN 'UPDATE' THEN
           IF NEW.degre != OLD.degre THEN
               INSERT INTO bieres.audit_biere VALUES(
                   NEW.idbiere::text,
                   CASE 
                       WHEN NEW.degre > OLD.degre THEN 'AUG'
                       ELSE 'DIM'
                   END,
                   CURRENT_USER,
                   CURRENT_TIMESTAMP
               );
           END IF;
           RETURN NEW;
   END CASE;
   RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger
CREATE TRIGGER audit_biere_trigger
AFTER INSERT OR UPDATE OR DELETE ON bieres.biere
FOR EACH ROW EXECUTE FUNCTION bieres.audit_biere_changes();

-- Tests
INSERT INTO bieres.biere VALUES (100, 'Test Beer', 5, 'test');
UPDATE bieres.biere SET degre = 6 WHERE idbiere = 100;
DELETE FROM bieres.biere WHERE idbiere = 100;

-- Vérification
SELECT * FROM bieres.audit_biere ORDER BY date_modif DESC;