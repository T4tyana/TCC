create or replace function efoto.getimagecoeff(param varchar, img integer, prj bigint)
returns double precision as 
$$
select ci.value 
from efoto.coef_img ci
join efoto.parameter pmt
on pmt.id = ci.id_param
where ci.id_proj = prj and ci.id_img = img and pmt.name = param;
$$ language 'sql';

create or replace view efoto.project_IOs as
select prj.id as projid, prj.name as projname, img.id, img.name_,
efoto.getimagecoeff('a0', img.id, prj.id) as a0,
efoto.getimagecoeff('a1', img.id, prj.id) as a1,
efoto.getimagecoeff('a2', img.id, prj.id) as a2,
efoto.getimagecoeff('b0', img.id, prj.id) as b0,
efoto.getimagecoeff('b1', img.id, prj.id) as b1,
efoto.getimagecoeff('b2', img.id, prj.id) as b2
from efoto.project prj
join efoto.block blk    on prj.id = blk.id_proj
join efoto.img_block ib on blk.id = ib.id_block
join efoto.image img    on img.id = ib.id_img
where efoto.getimagecoeff('a0', img.id, prj.id) is not null;