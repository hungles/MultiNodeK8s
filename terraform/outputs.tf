output "k8_master_1_public_ip" {
  value = module.k8_master_1.k8_masters_public_ip
}

output "k8_master_2_public_ip" {
  value = module.k8_master_2.k8_masters_public_ip
}

output "k8_master_1_public_dns" {
  value = module.k8_master_1.k8_masters_public_dns
}

output "k8_master_2_public_dns" {
  value = module.k8_master_2.k8_masters_public_dns
}

output "k8_worker_1_public_ip" {
  value = module.k8_worker_1.k8_workers_public_ip
}

output "k8_worker_2_public_ip" {
  value = module.k8_worker_2.k8_workers_public_ip
} 

output "k8_worker_1_public_dns" {
  value = module.k8_worker_1.k8_workers_public_dns
} 

output "k8_worker_2_public_dns" {
  value = module.k8_worker_2.k8_workers_public_dns
}

output "lb" {
  value = module.control_plane_lb.alb_dns_name
}