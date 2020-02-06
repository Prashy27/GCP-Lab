data "template_file" "inventory_gcp"{
    template = "${file("${path.module}/inventory_gcp")}"
    depends_on = ["google_compute_instance.kubemaster",
                  "google_compute_instance.kubenode01",
                  "google_compute_instance.kubenode02",
                  "google_compute_network.kube_vpc",
                  "google_compute_subnetwork.kube_public_subnet"
                ]
    
    vars = {
        master_if = "${google_compute_instance.kubemaster.network_interface.*.access_config}"
        master_ip = "${master_if.*.nat_ip}"
        worker_if = "${google_compute_instance.kubenode02.network_interface.*.access_config}"
        worker_ip = "${worker_if.*.nat_ip}"
    }
}

resource "null_resource" "inventory_gcp" {
    triggers {
        template_rendered = "data.template_file.inventory_gcp.rendered"
    }
    provisioner "local-exec"{
        command = "echo '${data.template_file.inventory_gcp.rendered}' > inventory_gcp"
    }
}
