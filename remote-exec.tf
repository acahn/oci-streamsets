resource "null_resource" "StreamSets" {
    depends_on = ["oci_core_instance.DataCollector"]

provisioner "remote-exec" {
      connection {
        type = "ssh"
        port = "22"
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.datacollector_vnic.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
      }
       inline = [
  "wget https://s3-us-west-2.amazonaws.com/archives.streamsets.com/datacollector/3.5.0/rpm/el7/streamsets-datacollector-3.5.0-el7-all-rpms.tar--2018-10-04 15:45:46--  https://s3-us-west-2.amazonaws.com/archives.streamsets.com/datacollector/3.5.0/rpm/el7/streamsets-datacollector-3.5.0-el7-all-rpms.tar",
  "tar -xf streamsets-datacollector-3.5.0-el7-all-rpms.tar",
  "cd streamsets-datacollector-3.5.0-el7-all-rpms/",
  "sudo yum localinstall streamsets-datacollector-3.5.0-1.noarch.rpm -y",
  "sudo systemctl start sdc",
  "echo The default username and password are admin and admin",
  "echo Browse to http://<system-ip>:18630/"
  ]
    }
    }
