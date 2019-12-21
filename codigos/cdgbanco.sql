/* CRIAÇÃO DOS DATATYPE */
create type Imgtype as enum('PHOTO','ORTOPHOTO');
create type Type_op as enum('OI','OE','RETIF','RPC','UNKNOWN');
create type Pointtype as enum('CONTROL_POINT','PHOTO_POINT','CHECK_POINT','UNDEFINED');
create type Typephoto as enum('FRAME','PUSHBROOM','WHISKBROOM','UNKNOWN');
create type Sensor_type as enum('FILM','DIGITAL');

/*ASSUMINDO QUE O POSTGIS JÁ ESTÁ INSTALADO NA MÁQUINA*/
CREATE EXTENSION postgis; /*HABILITA O POSTGIS NO BD*/

/*ASSUMINDO QUE EXISTE O USUÁRIO VARGAS E QUE ELE TEM PERMISSÕES DE CRIAÇÂO NO SGBD*/
create schema efoto authorization vargas /*CRIAÇÃO DO SCHEMA*/
/*CRIAÇÃO DAS TABELAS DENTRO DO SCHEMA - CRIA TODAS AS TABELAS AUTOMATICAMENTE COM O SCHEMA*/

CREATE TABLE Block
(
  Id BIGINT NOT NULL ,
  Id_proj BIGINT NOT NULL ,
  PRIMARY KEY (Id)
)

CREATE TABLE Strip
(
  Id BIGINT NOT NULL ,
  Name_ VARCHAR ,
  Id_block BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_block) REFERENCES Block(Id)
)

CREATE TABLE Frame_gnss
(
  Id BIGINT NOT NULL ,
  Status boolean ,
  Geom geography (POINTZ), /*coordenadas: x,y,z - dessa forma associa automaticamente ao WGS84 srid:4326*/
  Sigma_E FLOAT,
  Sigma_N FLOAT,
  Sigma_H FLOAT,
  PRIMARY KEY (Id)
)

CREATE TABLE Frame_ins
(
  Id BIGINT NOT NULL ,
  Status boolean ,
  Omega FLOAT ,
  Phi FLOAT ,
  Kappa FLOAT ,
  Sigma_omega FLOAT ,
  Sigma_phi FLOAT ,
  Sigma_kappa FLOAT ,
  PRIMARY KEY (Id)
)

CREATE TABLE Processing_metho
(
  Id BIGINT NOT NULL,
  Data_origin VARCHAR,
  PRIMARY KEY (Id)
)

CREATE TABLE Mod_param
(
  Id BIGINT NOT NULL ,
  Type_ Type_op UNIQUE,
  Qnt_param INT ,
  Name_ VARCHAR ,
  Form_model VARCHAR ,
  PRIMARY KEY (Id)
)

CREATE TABLE Parameter
(
  Id BIGINT NOT NULL ,
  Sequential_ INT ,
  Name_ VARCHAR ,
  Symbol VARCHAR ,
  Id_mod_param BIGINT,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_mod_param) REFERENCES Mod_param(Id)
)

CREATE TABLE Srs
(
  Id BIGINT NOT NULL ,
  Epsg INT,
  PRIMARY KEY (Id),
  FOREIGN KEY (epsg) REFERENCES public.spatial_ref_sys(srid) /*COM A EXTENSÃO POSTGIS INSTALADA ESSA TABELA É CRIADA AUTOMATICAMENTE NO SCHEMA PUBLIC*/
)

CREATE TABLE Project
(
  Id BIGINT NOT NULL ,
  Name_ VARCHAR ,
  Owner VARCHAR ,
  Date_cria DATE ,
  Date_mod DATE ,
  Software VARCHAR ,
  Id_srs BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_srs) REFERENCES Srs(Id)
)

CREATE TABLE Cg_central_area
(
  Proj_center POINT ,
  Id_srs BIGINT ,
  Id_proj BIGINT ,
  FOREIGN KEY (Id_srs) REFERENCES Srs(Id),
  FOREIGN KEY (Id_proj) REFERENCES Project(Id),
  PRIMARY KEY (Id_srs, Id_proj)
)

CREATE TABLE Specification
(
  Id BIGINT NOT NULL ,
  Brand VARCHAR ,
  Model VARCHAR ,
  Manufacturer VARCHAR ,
  Focal FLOAT ,
  Detector Sensor_type ,
  Pixel_size FLOAT,
  Rows_ BIGINT,
  Cols_ BIGINT,
  PRIMARY KEY (Id)
)

CREATE TABLE Sensor
(
  Id BIGINT NOT NULL ,
  Description VARCHAR ,
  Id_spec BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_spec) REFERENCES Specification(Id)
)

CREATE TABLE Terrain
(
  Id BIGINT NOT NULL ,
  Alt_max FLOAT ,
  Alt_min FLOAT ,
  Alt_med FLOAT ,
  PRIMARY KEY (Id)
)

CREATE TABLE Decentering_distortion
(
  Id BIGINT NOT NULL ,
  P1 FLOAT ,
  P2 FLOAT ,
  Sigma_p1 FLOAT ,
  Sigma_p2 FLOAT ,
  PRIMARY KEY (Id)
)

CREATE TABLE Symmetric_distortion
(
  Id BIGINT NOT NULL ,
  K1 FLOAT ,
  K2 FLOAT ,
  K3 FLOAT ,
  K0 FLOAT ,
  Sigma_k0 FLOAT ,
  Sigma_k1 FLOAT ,
  Sigma_k2 FLOAT ,
  Sigma_k3 FLOAT ,
  PRIMARY KEY (Id)
)

CREATE TABLE Calibration
(
  Id BIGINT NOT NULL ,
  Date_cria DATE ,
  Date_end DATE ,
  Number_ VARCHAR UNIQUE,
  Focal_calib FLOAT ,
  Sigma_focal_calib FLOAT ,
  Ppx FLOAT ,
  Ppy FLOAT ,
  Sigma_ppx FLOAT ,
  Sigma_ppy FLOAT ,
  Id_sensor BIGINT ,
  Id_decentering BIGINT ,
  Id_symmetric BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_sensor) REFERENCES Sensor(Id),
  FOREIGN KEY (Id_decentering) REFERENCES Decentering_distortion(Id),
  FOREIGN KEY (Id_symmetric) REFERENCES Symmetric_distortion(Id)
)

CREATE TABLE Survey
(
  Id SERIAL NOT NULL,
  Operator VARCHAR,
  PRIMARY KEY (Id)
)

CREATE TABLE Ground_survey
(
  Id BIGINT NOT NULL ,
  Id_survey BIGINT,
  FOREIGN KEY (Id_survey) REFERENCES Survey(Id),
  PRIMARY KEY (Id)
)

CREATE TABLE Collection_point
(
  Id BIGINT NOT NULL ,
  Id_srs BIGINT ,
  Date_ DATE ,
  Receptor VARCHAR ,
  Antenna VARCHAR ,
  Antenna_height FLOAT ,
  Id_ground_survey BIGINT,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_srs) REFERENCES Srs(Id),
  FOREIGN KEY (Id_ground_survey) REFERENCES Ground_survey(Id)
)

CREATE TABLE Point
(
  Id BIGINT NOT NULL,
  Name_ VARCHAR,
  Geom Geography (POINTZ), /*coordenadas: x,y,z - dessa forma associa automaticamente ao WGS84 srid:4326*/
  Sigma float [3][3],
  Id_coll BIGINT,
  FOREIGN KEY (Id_coll) REFERENCES Collection_point(Id),
  PRIMARY KEY (Id)
)

CREATE TABLE Point_project
(
  Use_ Pointtype,
  Id_proj BIGINT,
  Id_point BIGINT,
  FOREIGN KEY (Id_proj) REFERENCES Project(Id),
  FOREIGN KEY (Id_point) REFERENCES Point(Id),
  PRIMARY KEY (Id_proj, Id_point)
)

CREATE TABLE Flight
(
  Id BIGINT NOT NULL ,
  Date_ DATE ,
  Num_series VARCHAR NULL UNIQUE,
  Num_authoriz VARCHAR UNIQUE,
  Id_sensor BIGINT ,
  Id_survey BIGINT ,
  Id_terrain BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_sensor) REFERENCES Sensor(Id),
  FOREIGN KEY (Id_survey) REFERENCES Survey(Id),
  FOREIGN KEY (Id_terrain) REFERENCES Terrain(Id)
)

CREATE TABLE Bounding_box
(
  Id BIGINT NOT NULL ,
  Xy_upper POINT,
  Xy_bottom POINT,
  Id_flight BIGINT ,
  Id_terrain BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_flight) REFERENCES Flight(Id),
  FOREIGN KEY (Id_terrain) REFERENCES Terrain(Id)
)

CREATE TABLE Param_flight
(
  Id BIGINT NOT NULL ,
  Alt_nivmar FLOAT ,
  Den_escale INT ,
  Overlap_lat FLOAT ,
  Overlap_strip FLOAT ,
  Id_flight BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_flight) REFERENCES Flight(Id)
)

CREATE TABLE Fiducials
(
  Id BIGINT NOT NULL ,
  X FLOAT ,
  Y FLOAT ,
  Sigma_x FLOAT ,
  Sigma_y FLOAT ,
  Id_calib BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_calib) REFERENCES Calibration(Id)
)

CREATE TABLE Image
(
  Id SERIAL NOT NULL ,
  Name_ VARCHAR ,
  Resolution VARCHAR ,
  Size_pxls INT [2] ,
  Img_type Imgtype ,
  Id_sensor BIGINT ,
  Id_strip BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_strip) REFERENCES Strip(Id),
  FOREIGN KEY (Id_sensor) REFERENCES sensor(Id)
)

CREATE TABLE Img_block
(
  Id_img BIGINT ,
  Id_block BIGINT ,
  FOREIGN KEY (Id_img) REFERENCES Image(Id),
  FOREIGN KEY (Id_block) REFERENCES Block(Id),
  PRIMARY KEY (Id_img, Id_block)
)

CREATE TABLE Photo
(
  Id_img BIGINT NOT NULL ,
  Geometry Typephoto ,
  FOREIGN KEY (Id_img) REFERENCES Image(Id),
  PRIMARY KEY (Id_img)
)

CREATE TABLE Coef_img
(
  Value FLOAT ,
  Id_img BIGINT ,
  Id_param BIGINT ,
  Id_proc_met BIGINT,
  Id_proj BIGINT ,
  FOREIGN KEY (Id_proc_met) REFERENCES Processing_metho(Id),
  FOREIGN KEY (Id_img) REFERENCES Image(Id),
  FOREIGN KEY (Id_param) REFERENCES Parameter(Id),
  FOREIGN KEY (Id_proj) REFERENCES Project(Id),
  PRIMARY KEY (Id_img, Id_param, Id_proj)
)

CREATE TABLE Coverage
(
  Gsd_meters FLOAT, /*gsd - ground sample distance - tamanho do terreno no pixel*/
  Geom polygon ,
  Id_img BIGINT ,
  FOREIGN KEY (Id_img) REFERENCES Image(Id),
  PRIMARY KEY (Id_img)
)

CREATE TABLE Measure
(
  Row INT ,
  Col INT ,
  Id_img BIGINT ,
  Id_point BIGINT ,
  Id_proj BIGINT,
  FOREIGN KEY (Id_proj) REFERENCES Project(Id),
  FOREIGN KEY (Id_img) REFERENCES Image(Id),
  FOREIGN KEY (Id_point) REFERENCES efoto.Point(Id),
  PRIMARY KEY (Id_proj,Id_img, Id_point)
)

CREATE TABLE Frame
(
  Id_img BIGINT NOT NULL ,
  num_neg BIGINT ,
  Geom GEOMETRY,
  Id_gnss BIGINT ,
  Id_ins BIGINT ,
  Id_block BIGINT ,
  PRIMARY KEY (Id_img),
  FOREIGN KEY (Id_gnss) REFERENCES Frame_gnss(Id),
  FOREIGN KEY (Id_ins) REFERENCES Frame_ins(Id),
  FOREIGN KEY (Id_block) REFERENCES Block(Id),
  FOREIGN KEY (Id_img) REFERENCES Photo(Id_img)
)

CREATE TABLE common_coverage
(
  Id BIGINT NOT NULL ,
  Intersection GEOMETRY, /*o ST_intersection vai sair por FRAME */
  Stereoscopy boolean,
  PRIMARY KEY (Id)
)

CREATE TABLE Transf
(
  Id BIGINT NOT NULL ,
  Id_com_cov BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_com_cov) REFERENCES common_coverage(Id)
)

CREATE TABLE Coef_transf
(
  Value FLOAT ,
  Id_param BIGINT ,
  Id_transf BIGINT ,
  Id_proj BIGINT ,
  FOREIGN KEY (Id_param) REFERENCES Parameter(Id),
  FOREIGN KEY (Id_transf) REFERENCES Transf(Id),
  FOREIGN KEY (Id_proj) REFERENCES Project(Id),
  PRIMARY KEY (Id_param, Id_transf, Id_proj)
)

CREATE TABLE N_tuplet
(
  Id BIGINT NOT NULL ,
  Size INT ,
  Id_com_cov BIGINT ,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_com_cov) REFERENCES common_coverage(Id)
)

CREATE TABLE Img_ntuplet
(
  Id_ntuplet BIGINT ,
  Id_img BIGINT ,
  FOREIGN KEY (Id_ntuplet) REFERENCES N_tuplet(Id),
  FOREIGN KEY (Id_img) REFERENCES Image(Id),
  PRIMARY KEY (Id_ntuplet, Id_img)
)

CREATE TABLE Pair
(
  Id_img1 BIGINT ,
  Id_img2 BIGINT ,
  Id_com_cov BIGINT ,
  FOREIGN KEY (Id_img1) REFERENCES Image(Id),
  FOREIGN KEY (Id_img2) REFERENCES Image(Id),
  FOREIGN KEY (Id_com_cov) REFERENCES common_coverage(Id),
  PRIMARY KEY (Id_img1, Id_img2, Id_com_cov)
); /*FECHA A CRIAÇÃO DOS SCHEMA efoto*/

--ADICIONA FK EM Id_proj PARA PROJECT DE BLOCK --
ALTER TABLE efoto.block
ADD FOREIGN KEY (Id_proj) REFERENCES efoto.project(id);

/*ACRESCENTANDO A TABELA DE FILE E PATH PARA IMG*/
CREATE TABLE efoto.file_img
(
  Id_img BIGINT NOT NULL,
  Table_ VARCHAR(25), /*CASO AS TABELAS NÃO ESTEJAM NO SCHEMA PREVISTO O ATRIBUTO DEVE SER PREENCHIDO COMO: NOME_SCHEMA.TABELA*/
  File_path varchar(1000), /*CAMINHO DO ARQUIVO NO SERVIDOR*/
  PRIMARY KEY (Id_img),
  FOREIGN KEY (Id_img) REFERENCES efoto.Image(Id)
);

/*CRIANDO SCHEMA PARA AS IMGS*/
create schema img authorization vargas;
