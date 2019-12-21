/*CARGA DO BANCO*/

/*Processing_metho*/
  INSERT INTO efoto.Processing_metho (Id, Data_origin)
  VALUES
  ('1','Fixed Parameters'),
  ('2','Sensors Parameters'),
  ('3','Fiducials Marks'),
  ('4','Photo Triangulation'),
  ('5','Spacial Resection');

/*MOD_PARAM*/
INSERT INTO efoto.Mod_param (Id, Type_, Qnt_param, Name_) /*FALTA ACRESCENTAR A FÓRMULA MATEMÁTICA*/
  VALUES
  ('1','OI','6','Orientação Interior'),
  ('2','OE','6','Orientação Exterior'),
  ('3','RETIF','0','Retificação'),
  ('4','RPC','40','?'),
  ('5','UNKNOWN','0','UNKNOWN');

/*PARAMETRO*/
INSERT INTO efoto.Parameter (Id, Sequential_, Name_,Id_mod_param)
VALUES
  ('1','1','a0','1'),
  ('2','2','a1','1'),
  ('3','3','a2','1'),
  ('4','4','b0','1'),
  ('5','5','b1','1'),
  ('6','6','b2','1'),
  ('7','1','x0','2'),
  ('8','2','y0','2'),
  ('9','3','z0','2'),
  ('10','4','Phi','2'),
  ('11','5','Omega','2'),
  ('12','6','Kappa','2');

/*SRS*/
INSERT INTO efoto.srs (id, epsg)
VALUES
('1','32723');

/*PROJECT*/
  INSERT INTO efoto.Project (Id, Name_, Owner, Date_cria, Date_mod, Software, Id_srs)
  VALUES
  ('1','UERJ_PROJECT_NO_ORIENTATIONS','E-foto','2014-01-24','2016-06-29','E-foto','1'),
  ('2','PROJETO_UERJ_Interior_Orientation_Only','E-foto','2014-01-24','2016-06-29','E-foto','1'),
  ('3','UerjProject_InteriorAndExteriorOrientations','E-foto','2014-01-24','2016-06-29','E-foto','1');

/*Cg_central_area*/
INSERT INTO efoto.Cg_central_area (Proj_center,Id_srs, Id_proj)
VALUES
('-22.9151,-43.23435278','1','1'),
('-22.9151,-43.23435278','1','2'),
('-22.9151,-43.23435278','1','3');

/*Specification*/
INSERT INTO efoto.Specification (Id, Brand, Model, Manufacturer, Focal, Detector)
VALUES
('1',null,'RMK A 15/23','CARL ZEISS', '153.0', 'FILM');

/*Sensor*/
INSERT INTO efoto.Sensor (Id, Description, Id_spec)
VALUES
('1','LENTES PLEOGON A2 - SÉRIE 137 504 PLATAFORM AERIAL DETECTOR FILM','1');

/*Terrain*/
INSERT INTO efoto.terrain (Id, Alt_max, Alt_min, Alt_med)
VALUES
('1','21.146','4.595','10.86');

/*Decentering_distortion*/
INSERT INTO efoto.Decentering_distortion (Id,P1,P2, Sigma_p1, Sigma_p2)
VALUES
('1','-6.27800000e-07','-6.27800000e-07','1.254e-07','1.495e-07');

/*Symmetric_distortion*/
INSERT INTO efoto.Symmetric_distortion (Id,k0,k1,k2,k3,Sigma_k0,Sigma_k1,Sigma_k2,Sigma_k3)
VALUES
('1','2.66700000e-05','-1.81300000e-09','-5.87700000e-14','-5.90900000e-18',null,'1.217e-08','1.092e-12','3.009e-17');

/*Calibration*/
INSERT INTO efoto.Calibration (Id,Date_cria,Date_end,Number_,Focal_calib,Sigma_focal_calib,Ppx,Ppy,Sigma_ppx,Sigma_ppy,Id_sensor,Id_decentering,Id_symmetric)
VALUES
('1','1996-02-01','2000-02-01','001/96','153.528','0.043','-0.063','-0.037','0.016','0.017','1','1','1');

/*Survey*/
INSERT INTO efoto.Survey (Id,Operator)
VALUES
('1',null),
('2','Gabriel Lago,Guiderlan Mantovani,Vanessa Oliveira'),
('3','Fabio Cardoso,Guiderlan Mantovani,Rafaela Pereira');

/*Ground_survey*/
INSERT INTO efoto.Ground_survey (Id, Id_survey)
VALUES
('1','2'),
('2','3');

/*Collection_point*/
INSERT INTO efoto.Collection_point(Id, Id_srs, Date_, Receptor, Antenna, Antenna_height, Id_ground_survey)
VALUES
('1','1','2010-06-12','PROMARK 2','ASH110545','2.00','1'),
('2','1','2010-06-07','PROMARK 2','ASH110545','2.00','1'),
('3','1','2010-06-16','PROMARK 2','ASH110545','2.00','1'),
('4','1','2010-05-24','PROMARK 2','ASH110545','2.00','1'),
('5','1','2010-05-24','PROMARK 2','ASH110545','1.50','1'),
('6','1','2010-05-20','PROMARK 2','ASH110545','1.50','1'),
('7','1','2010-10-01','PROMARK 2','ASH110545','2.00','2');

/*POINT*/
INSERT INTO efoto.Point (Id, Name_, Geom, Sigma, Id_coll)
VALUES
('1','P01',ST_Transform(ST_GeomFromText('POINTZ(681100.209 7464305.984 12.002)',32723),4326),'{{"0.01","0","0"},{"0","2","0"},{"0","0","3"}}','1'),
('2','P02',ST_Transform(ST_GeomFromText('POINTZ(681079.091 7464791.902 10.103)',32723),4326),'{{"1","0","0"},{"0","1","0"},{"0","0","1"}}','1'),
('3','P03',ST_Transform(ST_GeomFromText('POINTZ(680114.618 7464269.661 14.941)',32723),4326),'{{"3.65896","0","0"},{"0","3.14159265","0"},{"0","0","0"}}','1'),
('4','P04',ST_Transform(ST_GeomFromText('POINTZ(680262.749 7465023.964 16.25)',32723),4326),'{{"1","0","0"},{"0","2","0"},{"0","0","3"}}','1'),
('5','P05',ST_Transform(ST_GeomFromText('POINTZ(680377.816 7465806.099 20.306)',32723),4326),'{{"1","0","0"},{"0","1","0"},{"0","0","1"}}','1'),
('6','P06',ST_Transform(ST_GeomFromText('POINTZ(680888.0110000001 7465251.245 68.268)',32723),4326),null,'1'),
('7','P08',ST_Transform(ST_GeomFromText('POINTZ(681875.866 7465066.854 5.98)',32723),4326),'{{"1","0","0"},{"0","1","0"},{"0","0","1"}}','1'),
('8','P09',ST_Transform(ST_GeomFromText('POINTZ(680626.292 7464876.497 12.075)',32723),4326),null,'1'),
('9','P10',ST_Transform(ST_GeomFromText('POINTZ(682031.497 7465841.798 21.146)',32723),4326),null,'1'),
('10','P11',ST_Transform(ST_GeomFromText('POINTZ(682134.395 7464127.842 8.656000000000001)',32723),4326),null,'1'),
('11','P12',ST_Transform(ST_GeomFromText('POINTZ(681361.203 7465299.251 7.796)',32723),4326),null,'1'),
('12','P13',ST_Transform(ST_GeomFromText('POINTZ(682208.231 7465250.939 5.913)',32723),4326),null,'1'),
('13','P14',ST_Transform(ST_GeomFromText('POINTZ(682912.044 7464795.162 4.595)',32723),4326),null,null);

/*Point_project*/
INSERT INTO efoto.Point_project (Use_, Id_proj, Id_point)
VALUES
('CONTROL_POINT','3','1'),
('CONTROL_POINT','3','2'),
('CONTROL_POINT','3','3'),
('CONTROL_POINT','3','4'),
('CONTROL_POINT','3','5'),
('CHECK_POINT','3','6'),
('CONTROL_POINT','3','7'),
('CONTROL_POINT','3','8'),
('CONTROL_POINT','3','9'),
('CONTROL_POINT','3','10'),
('CONTROL_POINT','3','11'),
('CONTROL_POINT','3','12'),
('PHOTO_POINT','3','13');

/*flight*/
INSERT INTO efoto.Flight (Id,Date_ ,Num_series,Num_authoriz,Id_sensor,Id_survey,Id_terrain)
VALUES
('1','1997-05-01','84296',null,'1','1','1');

/*Param_flight*/
INSERT INTO efoto.Param_flight (Id, Alt_nivmar, Den_escale, Overlap_lat, Overlap_strip,Id_flight)
VALUES
('1','1200','8000','0.6','0.3','1');

/*Fiducials*/
INSERT INTO efoto.Fiducials (Id,x,y,Sigma_x,Sigma_y,Id_calib)
VALUES
('1','113','0.016',null, null,'1'),
('2','-113.006','0.018',null, null,'1'),
('3','0.004','113.015',null, null,'1'),
('4','0.007','-112.975',null, null,'1');

/*Image*/
INSERT INTO efoto.Image (Id, Name_, Resolution, Size_pxls, Img_type, Id_sensor, Id_strip)
VALUES
('1','016','300dpi','{"2895","2838"}','PHOTO','1',null),
('2','017','300dpi','{"2895","2838"}','PHOTO','1',null),
('3','018','600dpi','{"2810","2810"}' ,'PHOTO','1',null);

/*Photo*/
INSERT INTO efoto.Photo (Id_img, Geometry)
VALUES
('1','FRAME'),
('2','FRAME'),
('3','FRAME');

/*Coef_img*/
INSERT INTO efoto.Coef_img (Value, Id_img, Id_param, Id_proc_met ,Id_proj)
VALUES
('-121.9002071566372','1','1','3','2'),
('0.08477311621290597','1','2','3','2'),
('-0.0001259983061025569','1','3','3','2'),
('115.8498100403994','1','4','3','2'),
('-0.0001597981063472194','1','5','3','2'),
('-0.0847671499668263','1','6','3','2'),
('-122.19858576545','2','1','3','2'),
('0.08480480665677377','2','2','3','2'),
('-0.0001579968120035763','2','3','3','2'),
('116.2164905837167','2','4','3','2'),
('-0.0001917848221210379','2','5','3','2'),
('-0.0848306982751445','2','6','3','2'),
('-118.9652123861085','3','1','3','2'),
('0.08401448822443117','3','2','3','2'),
('-0.0004671933957721276','3','3','3','2'),
('117.3727500276382','3','4','3','2'),
('-0.000469018888138602','3','5','3','2'),
('-0.08397731873742412','3','6','3','2'),
('-121.7329856092689','1','1','3','3'),
('0.08483651647337956','1','2','3','3'),
('-0.0002533540575063702','1','3','3','3'),
('115.8516683186817','1','4','3','3'),
('-0.0001915955371948097','1','5','3','3'),
('-0.08473507779333339','1','6','3','3'),
('-122.2882726002081','2','1','3','3'),
('0.0848051841715767','2','2','3','3'),
('-3.069732379098406e-005','2','3','3','3'),
('116.1942494086046','2','4','3','3'),
('-0.0001916679316794453','2','5','3','3'),
('-0.08479917206303789','2','6','3','3'),
('-118.9652123861085','3','1','3','3'),
('0.08401448822443117','3','2','3','3'),
('-0.0004671933957721276','3','3','3','3'),
('117.372750027638','3','4','3','3'),
('-0.000469018888138602','3','5','3','3'),
('-0.08397731873742412','3','6','3','3'),
('680563.040829192','1','7','4','3'),
('7465043.615670555','1','8','4','3'),
('1318.222888934673','1','9','4','3'),
('-0.01183854852964648','1','10','4','3'),
('0.03213721719438253','1','11','4','3'),
('-0.01868266445317065','1','12','4','3'),
('681276.7801411147','2','7','4','3'),
('7465033.786330241','2','8','4','3'),
('1318.66739654617','2','9','4','3'),
('-0.01335688297085822','2','10','4','3'),
('0.01199362080053563','2','11','4','3'),
('-0.03228557493268124','2','12','4','3'),
('682001.474240886','3','7','4','3'),
('7465012.373389905','3','8','4','3'),
('1319.5727958011','3','9','4','3'),
('-0.01461134532031439','3','10','4','3'),
('0.02783570875179874','3','11','4','3'),
('-0.05148575864723386','3','12','4','3');

/*Measure*/
INSERT INTO efoto.Measure (Row,Col, Id_img, Id_point, Id_proj)
VALUES
('2196','2445','1','1','3'),
('1206','2415','2','1','3'),
('167','2529','3','1','3'),
('2141','1758','1','2','3'),
('1156','1735','2','2','3'),
('113','1830','3','2','3'),
('805','2539','1','3','3'),
('1001','1460','1','4','3'),
('1142','381','1','5','3'),
('128','355','2','5','3'),
('2238','1316','2','7','3'),
('1221','1376','3','7','3'),
('1512','1654','1','8','3'),
('517','1641','2','8','3'),
('2420','244','2','9','3'),
('1376','294','3','9','3'),
('2643','2598','2','10','3'),
('1660','2686','3','10','3'),
('2499','1051','1','11','3'),
('1523','1020','2','11','3'),
('485','1094','3','11','3'),
('2678','1050','2','12','3'),
('1666','1096','3','12','3'),
('2675','1670','3','13','3');

/*CARGA DAS IMAGENS*/

INSERT INTO EFOTO.file_img (Id_img, File_path, TABLE_)
VALUES
('1','/home/tatyana/Área de Trabalho/uerj/bd_img/efoto/1997_016_300dpi.bmp','T1'),
('2','/home/tatyana/Área de Trabalho/uerj/bd_img/efoto/1997_017_300dpi.bmp','T2'),
('3','/home/tatyana/Área de Trabalho/uerj/bd_img/efoto/1997_018_300dpi.bmp','T3');
