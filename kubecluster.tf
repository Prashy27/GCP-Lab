provider "google" {
    credentials = "${file("./creds/serviceaccount.json")}"
    project = "mykubecluster-265413"
    region = "us-east1"
}

resource "google_compute_subnetwork" "kube_public_subnet"{
    name = "kube-public-subnet"
    ip_cidr_range = "10.0.1.0/24"
    region = "us-east1"
    network = "${google_compute_network.kube_vpc.self_link}"
}

resource "google_compute_network" "kube_vpc"{
    name = "kube-vpc-network"
    auto_create_subnetworks = false
}


resource "google_compute_instance" "kubemaster"{
    name = "gcp-kubemaster"
    machine_type = "custom-2-7168-ext"
    zone = "us-east1-b"
    allow_stopping_for_update = true
    tags = ["kubemaster"]

    boot_disk {
        initialize_params {
            image = "centos-cloud/centos-7"
            size = 10
            type = "pd-ssd"
        }
    }

    network_interface {
        network = "${google_compute_network.kube_vpc.self_link}"
        subnetwork = "${google_compute_subnetwork.kube_public_subnet.self_link}"
        network_ip = "10.0.1.5"

        access_config {

        }
    }
}

resource "google_compute_instance" "kubenode01"{
    name = "gcp-kubenode01"
    machine_type = "custom-2-5120-ext"
    zone = "us-east1-b"
    allow_stopping_for_update = true
    tags = ["kubenode01"]

    boot_disk {
        initialize_params {
            image = "centos-cloud/centos-7"
            size = 10
            type = "pd-ssd"
        }
    }

    network_interface {
        network = "${google_compute_network.kube_vpc.self_link}"
        subnetwork = "${google_compute_subnetwork.kube_public_subnet.self_link}"
        network_ip = "10.0.1.6"

        access_config {

        }
    }
}

resource "google_compute_instance" "kubenode02"{
    name = "gcp-kubenode02"
    machine_type = "custom-2-5120-ext"
    zone = "us-east1-b"
    allow_stopping_for_update = true
    tags = ["kubenode02"]

    boot_disk {
        initialize_params {
            image = "centos-cloud/centos-7"
            size = 10
            type = "pd-ssd"
        }
    }

    network_interface {
        network = "${google_compute_network.kube_vpc.self_link}"
        subnetwork = "${google_compute_subnetwork.kube_public_subnet.self_link}"
        network_ip = "10.0.1.7"

        access_config {

        }
    }
}
