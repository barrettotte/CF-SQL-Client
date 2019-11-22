

-- Tables in library --
select table_schema, table_name, table_partition, source_type
from qsys2.syspartitionstat
where table_schema = 'BOLIB'
order by table_partition;


-- Basic system stats --
select
host_name as host,
active_jobs_in_system as jobs,  
active_threads_in_system as threads, 
average_cpu_utilization as cpu_usage
from qsys2.system_status_info;


-- Get all objects --
select objname, objcreated, objattribute, objdefiner
from table(qsys2.object_statistics('*ALL', 'LIB'));


select count(*) as libraries from table (qsys2.object_statistics('*ALL', 'LIB'));
