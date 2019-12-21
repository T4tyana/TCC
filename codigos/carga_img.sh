#Gerar o arquivo para carga
raster2pgsql -t "auto" -c -M /home/tatyana/bd/efoto/1997_016_300dpi.bmp img.t1 > /home/tatyana/bd/imgsbd/t1.sql
raster2pgsql -t "auto" -c -M /home/tatyana/bd/efoto/1997_017_300dpi.bmp img.t2 > /home/tatyana/bd/imgsbd/t2.sql
raster2pgsql -t "auto" -c -M /home/tatyana/bd/efoto/1997_018_300dpi.bmp img.t3 > /home/tatyana/bd/imgsbd/t3.sql

#Logar como postgres
sudo su postgres

#Fazer a carga no banco
postgres@T4tyz-197:/home/tatyana/bd/imgsbd$ psql -d teste -f t1.sql
postgres@T4tyz-197:/home/tatyana/bd/imgsbd$ psql -d teste -f t2.sql
postgres@T4tyz-197:/home/tatyana/bd/imgsbd$ psql -d teste -f t3.sql

#Alterar o dono da tabela (no caso do usuário não for o dono)
postgres@T4tyz-197:/home/tatyana/bd/imgsbd$ psql -d teste
psql (10.10 (Ubuntu 10.10-0ubuntu0.18.04.1))

teste=# alter table img.t1 owner to vargas;
ALTER TABLE
teste=# alter table img.t2 owner to vargas;
ALTER TABLE
teste=# alter table img.t3 owner to vargas;
ALTER TABLE
teste=# \q