/*SEGUNDA CARGA */
INSERT INTO efoto.Frame_ins (Id, Status, Omega , Phi, Kappa)
VALUES
('1','1','359.754179','0.112191','-0.019147'),
('2','1','359.845789','0.111590','0.035325'),
('3','1','0.083991','0.112255','0.100895'),
('4','1','0.325022','0.130926','0.199567'),
('5','1','0.671948','0.110096','0.262024'),
('6','1','0.870421','0.115697','0.314441'),
('7','1','0.633081','0.105711','0.284498'),
('8','1','0.008362','0.125394','0.345486'),
('9','1','357.929358','-0.988025','0.089234'),
('10','1','357.252021','-0.076441','0.145883'),
('11','1','357.615337','0.376831','0.139602'),
('12','1','358.664555','1.839865','0.167538'),
('13','1','0.443924','-0.057255','0.130680'),
('14','1','1.330173','-0.075819','0.120941'),
('15','1','2.131010','-0.071893','0.137069');

INSERT INTO efoto.Frame_gnss (Id, Status, geom)
VALUES
('1','1',ST_Transform(ST_GeomFromText('POINTZ (680086.383535 7465619.448741 2216.850443)',32723),4326)),
('2','1',ST_Transform(ST_GeomFromText('POINTZ (680454.039480 7465620.414802 2219.684175)',32723),4326)),
('3','1',ST_Transform(ST_GeomFromText('POINTZ (680827.418783 7465619.425899 2221.085315)',32723),4326)),
('5','1',ST_Transform(ST_GeomFromText('POINTZ (681570.431077 7465613.286008 2220.461042)',32723),4326)),
('4','1',ST_Transform(ST_GeomFromText('POINTZ (681197.253830 7465617.046604 2221.364840)',32723),4326)),
('6','1',ST_Transform(ST_GeomFromText('POINTZ (681945.589050 7465606.922063 2219.668055)',32723),4326)),
('7','1',ST_Transform(ST_GeomFromText('POINTZ (682318.136566 7465601.603405 2220.154639)',32723),4326)),
('8','1',ST_Transform(ST_GeomFromText('POINTZ (682691.578519 7465600.226574 2221.122801)',32723),4326)),
('9','1',ST_Transform(ST_GeomFromText('POINTZ (680180.184963 7464738.710693 2231.770084)',32723),4326)),
('10','1',ST_Transform(ST_GeomFromText('POINTZ (680556.563945 7464758.568244 2231.497639)',32723),4326)),
('11','1',ST_Transform(ST_GeomFromText('POINTZ (680936.882062 7464776.424316 2228.786446)',32723),4326)),
('12','1',ST_Transform(ST_GeomFromText('POINTZ (681318.140337 7464789.655498 2226.579959)',32723),4326)),
('13','1',ST_Transform(ST_GeomFromText('POINTZ (681700.001965 7464785.536293 2225.838873)',32723),4326)),
('14','1',ST_Transform(ST_GeomFromText('POINTZ (682081.479210 7464778.012752 2226.474480)',32723),4326)),
('15','1',ST_Transform(ST_GeomFromText('POINTZ (682464.293344 7464765.129675 2226.813472)',32723),4326));


INSERT INTO efoto.Project (Id, Name_, Owner, Date_cria, Date_mod, Software, Id_srs)
VALUES
('4','IPP_PMRJ','Luis Henrique',null,null,'LPS','1');

INSERT INTO efoto.block (id,id_proj)
VALUES
('1','1'),
('2','2'),
('3','3'),
('4','4');

INSERT INTO efoto.strip (Id, Name_, Id_block)
VALUES
('1','faixa_21','4'),
('2','faixa_22','4');

INSERT INTO efoto.Specification (Id, Brand, Model, Manufacturer, Focal, Detector , Pixel_size, Rows_, Cols_)
VALUES
('2',null,'UltraCam X','Vexed Imaging GmbH,  A-8010 Graz, Austria', '100.0', 'DIGITAL', '7.2', '9420', '14430');

INSERT INTO efoto.Sensor (Id, Description, Id_spec)
VALUES
('2','Tipo de sensor: Conjunto de CCDs (Charged-Coupl ed Device); Dimensão: 67,824 x 103,896 mm','2');

INSERT INTO efoto.Decentering_distortion (Id,P1,P2, Sigma_p1, Sigma_p2)
VALUES
('2','0.0','0.0','0.0','0.0');

INSERT INTO efoto.Symmetric_distortion (Id,k0,k1,k2,k3,Sigma_k0,Sigma_k1,Sigma_k2,Sigma_k3)
VALUES
('2','-5.76814710E-08','0.0','0.0','0.0','2.5858527E-09',null,null,null);

INSERT INTO efoto.Calibration (Id,Date_cria,Date_end,Number_,Focal_calib,Sigma_focal_calib,Ppx,Ppy,Sigma_ppx,Sigma_ppy,Id_sensor,Id_decentering,Id_symmetric)
VALUES
('2','2011-11-06',null,null,'100.524','0.001','-0.144','0.137','0.001','0.001','2','2','2');

INSERT INTO efoto.Survey (Id,Operator)
VALUES
('4','Eng. Gilberto Pessanha Ribeiro, João Luiz Jacintho, Giliard Souza'),
('5','Empresa Topocart');

INSERT INTO efoto.Ground_survey (Id, Id_survey)
VALUES
('3','4'),
('4','5');



INSERT INTO efoto.Collection_point(Id, Id_srs, Date_, Receptor, Antenna, Antenna_height, Id_ground_survey)
VALUES
('8','1','2018-11-11',null,null,null,'3'),
('9','1','2018-11-11',null,null,null,'4');

INSERT INTO efoto.Point (Id, Name_, Geom, Sigma, Id_coll)
VALUES
('14','LH1',ST_Transform(ST_GeomFromText('POINTZ(680947.997	7464833.669 3.942)',32723),4326),null,'8'),
('15','LH2',ST_Transform(ST_GeomFromText('POINTZ(680895.378	7463828.578 9.206)',32723),4326),null,'8'),
('16','LH3',ST_Transform(ST_GeomFromText('POINTZ(682227.162	7464200.581 2.184)',32723),4326),null,'8'),
('17','LH4',ST_Transform(ST_GeomFromText('POINTZ(686550.774	7465268.293 3.627)',32723),4326),null,'8'),
('18','LH8',ST_Transform(ST_GeomFromText('POINTZ(685854.919	7458136.336 -2.495)',32723),4326),null,'8'),
('19','LH9',ST_Transform(ST_GeomFromText('POINTZ(683885.884	7457153.887 0.627)',32723),4326),null,'8'),
('20','LH10',ST_Transform(ST_GeomFromText('POINTZ(681666.199	7456476.787 9.744)',32723),4326),null,'8'),
('21','LH12',ST_Transform(ST_GeomFromText('POINTZ(685101.216	7465079.522 -2.294)',32723),4326),null,'8'),
('22','LH14',ST_Transform(ST_GeomFromText('POINTZ(682822.811	7458689.095 -3.602)',32723),4326),null,'8'),
('23','LH16',ST_Transform(ST_GeomFromText('POINTZ(681405.632	7457708.127 3.455)',32723),4326),null,'8'),
('24','LH20',ST_Transform(ST_GeomFromText('POINTZ(688521.115	7464599.734 -3.877)',32723),4326),null,'8'),
('25','LH21',ST_Transform(ST_GeomFromText('POINTZ(687344.443	7464301.226 -3.944)',32723),4326),null,'8'),
('26','LH23',ST_Transform(ST_GeomFromText('POINTZ(686179.868	7462542.982 0.487)',32723),4326),null,'8'),
('27','LH25',ST_Transform(ST_GeomFromText('POINTZ(688716.922	7461553.487 -4.833)',32723),4326),null,'8'),
('28','LH30',ST_Transform(ST_GeomFromText('POINTZ(682955.324	7464848.530 -1.938)',32723),4326),null,'8'),
('29','LH31',ST_Transform(ST_GeomFromText('POINTZ(684018.680	7464908.770 0.811)',32723),4326),null,'8'),
('30','LH32',ST_Transform(ST_GeomFromText('POINTZ(683629.086	7463714.221 7.173)',32723),4326),null,'8'),
('31','LH34',ST_Transform(ST_GeomFromText('POINTZ(682210.162	7462758.126 324.316)',32723),4326),null,'8');

INSERT INTO efoto.Point_project (Use_, Id_proj, Id_point)
VALUES
('CONTROL_POINT','4','14'),
('CONTROL_POINT','4','15'),
('CONTROL_POINT','4','16'),
('CONTROL_POINT','4','17'),
('CONTROL_POINT','4','18'),
('CONTROL_POINT','4','19'),
('CONTROL_POINT','4','20'),
('CONTROL_POINT','4','21'),
('CONTROL_POINT','4','22'),
('CONTROL_POINT','4','23'),
('CONTROL_POINT','4','24'),
('CONTROL_POINT','4','25'),
('CONTROL_POINT','4','26'),
('CONTROL_POINT','4','27'),
('CONTROL_POINT','4','28'),
('CONTROL_POINT','4','29'),
('CONTROL_POINT','4','30'),
('CONTROL_POINT','4','31');

INSERT INTO efoto.Flight (Id,Date_ ,Num_series,Num_authoriz,Id_sensor,Id_survey,Id_terrain)
VALUES
('2','2010-08-01',null , '25 7/2009 - AVOEM 360110','2','5',null);

INSERT INTO efoto.Param_flight (Id, Alt_nivmar, Den_escale, Overlap_lat, Overlap_strip,Id_flight)
VALUES
('2','2000',null,null,null,'2');

INSERT INTO efoto.Image (Id, Name_, Resolution, Size_pxls, Img_type, Id_sensor, Id_strip)
VALUES
('4','foto_4505',null,'{"9420","14430"}','PHOTO','2','1'),
('5','foto_4506',null,'{"9420","14430"}','PHOTO','2','1'),
('6','foto_4507',null,'{"9420","14430"}','PHOTO','2','1'),
('7','foto_4508',null,'{"9420","14430"}','PHOTO','2','1'),
('8','foto_4509',null,'{"9420","14430"}','PHOTO','2','1'),
('9','foto_4510',null,'{"9420","14430"}','PHOTO','2','1'),
('10','foto_4511',null,'{"9420","14430"}','PHOTO','2','1'),
('11','foto_4512',null,'{"9420","14430"}','PHOTO','2','1'),
('12','foto_4529',null,'{"9420","14430"}','PHOTO','2','2'),
('13','foto_4530',null,'{"9420","14430"}','PHOTO','2','2'),
('14','foto_4531',null,'{"9420","14430"}','PHOTO','2','2'),
('15','foto_4532',null,'{"9420","14430"}','PHOTO','2','2'),
('16','foto_4533',null,'{"9420","14430"}','PHOTO','2','2'),
('17','foto_4534',null,'{"9420","14430"}','PHOTO','2','2'),
('18','foto_4535',null,'{"9420","14430"}','PHOTO','2','2');

INSERT INTO efoto.Photo (Id_img, Geometry)
VALUES
('4','FRAME'),
('5','FRAME'),
('6','FRAME'),
('7','FRAME'),
('8','FRAME'),
('9','FRAME'),
('10','FRAME'),
('11','FRAME'),
('12','FRAME'),
('13','FRAME'),
('14','FRAME'),
('15','FRAME'),
('16','FRAME'),
('17','FRAME'),
('18','FRAME');

INSERT INTO efoto.frame(Id_img, num_neg, Geom, Id_gnss, Id_ins, Id_block)
VALUES
('4',null, null, '1', '1', '4'),
('5',null, null, '2', '2', '4'),
('6',null, null, '3', '3', '4'),
('7',null, null, '4', '4', '4'),
('8',null, null, '5', '5', '4'),
('9',null, null, '6', '6', '4'),
('10',null, null, '7', '7', '4'),
('11',null, null, '8', '8', '4'),
('12',null, null, '9', '9', '4'),
('13',null, null, '10', '10', '4'),
('14',null, null, '11', '11', '4'),
('15',null, null, '12', '12', '4'),
('16',null, null, '13', '13', '4'),
('17',null, null, '14', '14', '4'),
('18',null, null, '15', '15', '4');

INSERT INTO efoto.img_block (id_img,id_block)
VALUES
('1','1'),
('2','1'),
('3','1'),
('1','2'),
('2','2'),
('3','2'),
('1','3'),
('2','3'),
('3','3'),
('4','4'),
('5','4'),
('6','4'),
('7','4'),
('8','4'),
('9','4'),
('10','4'),
('11','4'),
('12','4'),
('13','4'),
('14','4'),
('15','4'),
('16','4'),
('17','4'),
('18','4');
