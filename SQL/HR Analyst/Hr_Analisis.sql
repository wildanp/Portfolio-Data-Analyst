select * from hrdataset_v14 hv 

--jumlah karyawan aktif
select count(*) as total_aktif
from hrdataset_v14 hv 
where hv."DateofTermination" is null or hv."DateofTermination" = '';

--distribusi gender karyawan aktif
select hv."Sex",count(*) as karyawan_aktif
from hrdataset_v14 hv 
where hv."DateofTermination" is null or hv."DateofTermination" = ''
group by "Sex" ;

--jumlah karyawan per departemen
select hv."Department", count(*) as total_karyawan
from hrdataset_v14 hv
where hv."DateofTermination" is null or hv."DateofTermination" = ''
group by hv."Department" 
order by total_karyawan desc;

--Tren karyawan keluar per tahun 
select extract(year from to_date("DateofTermination", 'MM/DD/YYYY')) as tahun_keluar,
	count(*) as jumlah_keluar
from hrdataset_v14
where "DateofTermination" <> ''
group by tahun_keluar
order by tahun_keluar

--Rata-rata gaji per departemen
select hv."Department", 
	Round(avg(hv."Salary" ),2) as rata_rata_gaji
from hrdataset_v14 hv 
where hv."DateofTermination" is null or hv."DateofTermination" = ''
group by hv."Department";

--rata-rata absen per departemen
select hv."Department",
	round(avg(hv."Absences" ),2) as rata_rata_absen
from hrdataset_v14 hv 
group by "Department" 
order by rata_rata_absen 

--distribusi jabatan (position) karyawan aktif
select hv."Position", 
	count(*) as Jumlah
from hrdataset_v14 hv
where hv."DateofTermination" is null or hv."DateofTermination" = ''
group by "Position" 
order by jumlah 

--Top 5 gaji tertinggi
select hv."Employee_Name",
	hv."Position" , 
	hv."Salary" 
from hrdataset_v14 hv 
where hv."DateofTermination" is null or hv."DateofTermination" = ''
order by "Salary" 
limit 5;

--jumlah karyawan keluar per departemen
select hv."Department" ,
	count(*) as jumlah_keluar
from hrdataset_v14 hv 
group by "Department" 
order by jumlah_keluar 


