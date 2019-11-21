
select
sqlserver_start_time,
virtual_machine_type_desc
from sys.dm_os_sys_info;


select count(*) as active_tasks from sys.dm_os_tasks where task_state<>'DONE';


select 
total_physical_memory_kb as total_kb, 
available_physical_memory_kb as available_kb
from sys.dm_os_sys_memory;


select count(*) as total_threads from sys.dm_os_threads;


select 
host_platform as platform,
host_distribution as distro
from sys.dm_os_host_info;


select count(*) as allocated_objects from sys.dm_os_memory_objects;

