output "kubemaster_public_ip" {
  value = "${google_compute_instance.kubemaster.network_interface[0].access_config[0].nat_ip}"
}

output "kubemaster_private_ip" {
  value = "${google_compute_instance.kubemaster.network_interface[0].network_ip}"
}

output "kubenode01_public_ip" {
  value = "${google_compute_instance.kubenode01.network_interface[0].access_config[0].nat_ip}"
}

output "kubenode01_private_ip" {
  value = "${google_compute_instance.kubenode01.network_interface[0].network_ip}"
}

output "kubenode02_public_ip" {
  value = "${google_compute_instance.kubenode02.network_interface[0].access_config[0].nat_ip}"
}

output "kubenode02_private_ip" {
  value = "${google_compute_instance.kubenode02.network_interface[0].network_ip}"
}
