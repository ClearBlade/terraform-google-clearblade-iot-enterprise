# terraform-google-clearblade-iot-enterprise

This is a Terraform Module to install a fully working ClearBlade IoT Enterprise instance on Google Cloud. The following prerequisites are needed to use this module.

## Prerequisites:
- Project name and ID
- Instance ID
- Region
- Enable billing on gcloud project
- Enable `secretmanager`, `compute`, `container`, and `cloudresourcemanager` services
- Image puller secret
- ClearBlade Platform Version
- `clearblade-gsm-read` service account with the `roles/secretmanager.secretAccessor`

## Usage:

Here's an example usage of the module.

```
module "clearblade-iot-enterprise" {
    source                       = "ClearBlade/clearblade-iot-enterprise/google"
    version                      = "<version>"
    project_id                   = "<project_id>"
    namespace_name               = "<namespace>"
    region                       = "<region>"
    zones                        = ["<zone1>", "<zone2>"]
    initial_node_count           = 3
    min_node_count               = 0
    max_node_count               = 3
    node_machine_type            = "n2-standard-16"
    pg_disk_count                = 1
    pg_disk_size                 = "100"
    iotcore_disk_count           = 1
    iotcore_disk_size            = "10"
    console_disk_count           = 1
    console_disk_size            = "10"
    days_in_cycle                = 1
    start_time                   = "04:00"
    blue_version                 = "<version>"
    cloudflare_api_token         = "<api_token>"
    cloudflare_zone_id           = "<zone_id>"
    instance_id                  = "<instance_id>"
    base_url_suffix              = "<url_suffix>"
    image_puller_secret          = "<image_puller_secret>"
    helm_chart                   = "https://github.com/ClearBlade/helm-charts/releases/download/clearblade-iot-enterprise-3.1.1/clearblade-iot-enterprise-3.1.1.tgz"
}
```

## Release New Version

To release a new version, go to the releases page and click `Draft a new release` and enter the desired version, fill in the other details and then click `Publish release`.



