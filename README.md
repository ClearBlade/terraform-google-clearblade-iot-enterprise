# terraform-google-clearblade-iot-enterprise

This is a Terraform Module to install a fully working ClearBlade IoT Enterprise instance on Google Cloud. The following prerequisites are needed to use this module.

## Prerequisites:
- Project name and ID
- Instance ID
- Region
- Enable billing on gcloud project
- Enable `secretmanager`, `compute`, `container`, and `cloudresourcemanager` services
- Helm Chart and YAML file
- Image puller secret
- ClearBlade Platform Version
- `clearblade-terraform-ocd` service account with the `organizations/88478007873/roles/ClearBladeKubTerraformManagement` role
- `clearblade-gsm-read` service account with the `roles/secretmanager.secretAccessor`
- TLS certificate stored in a gcloud secret
- MEK stored in a gcloud secret
- Postgres primary and replica passwords stored in a secret
- Registration key stored in a secret
- Primary and MQTT IPs
- Domain name
