[kubemaster]
${master_nodes}

[kubeworker]
%{ for ip in worker_nodes ~}
${ip}
%{ endfor ~}