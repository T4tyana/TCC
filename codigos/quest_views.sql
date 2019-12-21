/*CONSULTAS*/
/*VISÕES*/
-- Quais pontos não estão sendo utilizados em nenhum projeto---OK---
create or replace view efoto.Point_no_proj
as
select p.Id, p.name_, ST_AsText(ST_Transform(CAST(P.geom As geometry),32723)), sigma , id_coll
from efoto.point p
left join efoto.point_project pp
on p.id = pp.id_point
where pp.id_point IS NULL;
--QUAIS AS IMAGENS QUE NÃO ESTÃO EM NENHUM PROJETO ---OK---
create or replace view efoto.Img_no_proj
as
SELECT I.ID, I.NAME_, I.RESOLUTION, I.SIZE_PXLS, I.IMG_TYPE, I.ID_SENSOR, I.ID_STRIP
FROM EFOTO.IMAGE I
LEFT JOIN EFOTO.IMG_BLOCK IB
ON I.ID=IB.ID_IMG
LEFT JOIN EFOTO.BLOCK B
ON IB.ID_BLOCK =B.ID
LEFT JOIN EFOTO.PROJECT P
ON B.ID_PROJ=P.ID
WHERE P.ID IS NULL;
--QUAL PROJETO TEM MAIS IMAGENS?  ---OK---
CREATE OR REPLACE VIEW EFOTO.COUNT_IMG_PROJ_DESC
AS
SELECT P.ID, P.NAME_,COUNT(P.ID)
FROM EFOTO.PROJECT P
LEFT JOIN EFOTO.BLOCK B
ON  P.ID = B.ID_PROJ
LEFT JOIN EFOTO.IMG_BLOCK IB
ON B.ID=IB.ID_BLOCK
LEFT JOIN EFOTO.IMAGE I
ON IB.ID_IMG=I.ID
GROUP BY P.ID ORDER BY COUNT(P.ID) DESC LIMIT 1;
--QUANTAS IMAGENS TEM POR PROJETO? ---OK---
CREATE OR REPLACE VIEW EFOTO.COUNT_IMG_PROJ
AS
SELECT P.ID, P.NAME_,COUNT(P.ID)
FROM EFOTO.PROJECT P
LEFT JOIN EFOTO.BLOCK B
ON  P.ID = B.ID_PROJ
LEFT JOIN EFOTO.IMG_BLOCK IB
ON B.ID=IB.ID_BLOCK
LEFT JOIN EFOTO.IMAGE I
ON IB.ID_IMG=I.ID
GROUP BY P.ID ORDER BY COUNT(P.ID);
--QUAIS SÃO AS IMAGENS DISPONÍVEIS? (ARMAZENADAS) ---OK---
CREATE OR REPLACE VIEW EFOTO.IMG_FILE_FOUND
AS
SELECT I.ID, I.NAME_
FROM EFOTO.IMAGE I
LEFT JOIN EFOTO.FILE_IMG FI
ON I.ID = FI.ID_IMG
WHERE FI.TABLE_ IS NOT NULL OR FI.FILE_PATH IS NOT NULL;

--QUAIS SÃO AS IMAGENS NÃO DISPONÍVEIS? (NÃO-ARMAZENADAS) ---OK---
CREATE OR REPLACE VIEW EFOTO.IMG_FILE_NOT_FOUND
AS
SELECT I.ID, I.NAME_
FROM EFOTO.IMAGE I
LEFT JOIN EFOTO.FILE_IMG FI
ON I.ID = FI.ID_IMG
WHERE FI.TABLE_ IS NULL AND FI.FILE_PATH IS NULL;

--QUAIS PROJETOS ESTÃO ATIVOS? (NESSE CASO LISTA OS PROJETOS COM NOME PELA DATA DE MODIFICAÇÃO)  ----OK----
--LISTAR PROJETOS EM ORDEM DE MODIFICAÇÃO
CREATE OR REPLACE VIEW EFOTO.PROJ_LAST_MODIFICATION
AS
SELECT P.NAME_, P.Date_mod
FROM EFOTO.PROJECT P
ORDER BY P.Date_mod DESC;

--QUANTOS PONTOS EXISTEM POR LEV.TOPOGRÁFICO? ---OK---
CREATE OR REPLACE VIEW EFOTO.COUNt_POINTS_OF_GROUND_SURVEY
AS
SELECT GS.ID, COUNT(P.ID)
FROM EFOTO.POINT P
LEFT JOIN EFOTO.COLLECTION_POINT CP
ON P.ID_COLL = CP.ID
LEFT JOIN EFOTO.GROUND_SURVEY GS
ON CP.ID_GROUND_SURVEY = GS.ID
GROUP BY GS.ID ORDER BY COUNT (P.ID);

--QUAL É A FUNÇÃO DE CADA PONTO DE UM PROJETO? ---OK---
CREATE OR REPLACE VIEW EFOTO.POINT_BY_USE_IN_PROJ
AS
SELECT P.ID, PP.USE_, PR.NAME_
FROM EFOTO.PROJECT PR
JOIN EFOTO.POINT_PROJECT PP
ON PR.ID=PP.ID_PROJ
JOIN EFOTO.POINT P
ON PP.ID_POINT=P.ID;

--O PROJETO TEM QUAIS IMAGENS? ---OK---
CREATE OR REPLACE VIEW EFOTO.PROJ_IMG
AS
SELECT P.ID AS ID_PROJ, P.NAME_ AS PROJ_NAME, I.NAME_ AS IMG_NAME
FROM EFOTO.PROJECT P
LEFT JOIN EFOTO.BLOCK B
ON  P.ID = B.ID_PROJ
LEFT JOIN EFOTO.IMG_BLOCK IB
ON B.ID=IB.ID_BLOCK
LEFT JOIN EFOTO.IMAGE I
ON IB.ID_IMG=I.ID;


--QUAIS SÃO OS VALORES DE OI E OE EXISTENTES? ----ok----
CREATE VIEW EFOTO.OI_AVAILABLE
AS
SELECT A0.ID_PROJ, A0.ID_IMG, A0.VALUE AS A0_, A1.VALUE AS A1_, A2.VALUE AS A2_, B0.VALUE AS B0_, B1.VALUE AS B1_, B2.VALUE AS B2_ FROM
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'a0') as a0,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'a1') as a1,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'a2') as a2,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'b0') as b0,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'b1') as b1,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'b2') as b2
WHERE A0.ID_PROJ = A1.ID_PROJ AND
 A2.ID_PROJ = A1.ID_PROJ AND
 A2.ID_PROJ = B0.ID_PROJ AND
 B0.ID_PROJ = B1.ID_PROJ AND
 B2.ID_PROJ = B1.ID_PROJ AND
 A0.ID_IMG = A1.ID_IMG AND
 A2.ID_IMG = A1.ID_IMG AND
 A2.ID_IMG = B0.ID_IMG AND
 B0.ID_IMG = B1.ID_IMG AND
 B2.ID_IMG = B1.ID_IMG;

 CREATE VIEW EFOTO.OE_AVAILABLE
AS
SELECT x0.ID_PROJ, x0.ID_IMG, x0.VALUE AS x0_, y0.VALUE AS y0_, z0.VALUE AS z0_, Omega.VALUE AS Omega_, Kappa.VALUE AS Kappa_, Phi.VALUE AS Phi_ FROM
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'x0') as x0,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'y0') as y0,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'z0') as z0,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'Kappa') as Kappa,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'Omega') as Omega,
(SELECT ci.id_proj, ci.id_img, ci.value FROM EFOTO.COEF_IMG CI JOIN EFOTO.PARAMETER P ON P.ID=CI.ID_PARAM WHERE P.Name_ = 'Phi') as Phi
WHERE x0.ID_PROJ = y0.ID_PROJ AND
 y0.ID_PROJ = z0.ID_PROJ AND
 z0.ID_PROJ = Kappa.ID_PROJ AND
 Kappa.ID_PROJ = Omega.ID_PROJ AND
 Omega.ID_PROJ = Phi.ID_PROJ AND
 x0.ID_IMG = y0.ID_IMG AND
 y0.ID_IMG = z0.ID_IMG AND
 z0.ID_IMG = Kappa.ID_IMG AND
 Kappa.ID_IMG = Omega.ID_IMG AND
 Omega.ID_IMG = Phi.ID_IMG;
-- QUAIS SÃO OS PONTOS E SUAS COORDENADAS DE CADA PROJETO? ----ok---
CREATE OR REPLACE VIEW EFOTO.POINT_COORD_PROJ
AS
SELECT P.ID, ST_AsText(ST_Transform(CAST(P.geom As geometry),32723)), PR.Name_
FROM EFOTO.PROJECT PR
JOIN EFOTO.POINT_PROJECT PP
ON PR.ID=PP.ID_PROJ
JOIN EFOTO.POINT P
ON PP.ID_POINT=P.ID;