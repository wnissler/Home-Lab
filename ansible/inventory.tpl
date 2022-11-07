[master]
${master_nodes}

[worker]
%{ for ip in worker_nodes ~}
${ip}
%{ endfor ~}