# Hello World

Simple Flask application to be run in Cloud Run.

All relevant commands to get things running are in the Makefile. Note: you need to modify couple of make variables if you use this as it is pointing to my lab environment by default, or use the cloud run button below (recommended).

Example on how to get the application deployed to cloud run manually:
```
make GCLOUD_CONFIG=your_config GCLOUD_PROJECT=your-project docker-build cloud-run-deploy call-cloud-run
```

## Cloud Run

[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run)

More info about "run in cloud run button": <https://github.com/GoogleCloudPlatform/cloud-run-button#add-the-cloud-run-button-to-your-repos-readme>
