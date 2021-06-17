GCLOUD_CONFIG=solita
GCLOUD_PROJECT=antti-peltonens-lab-solita

all: none

none:
	@echo Nothing to see here. Go away!

auth:
	gcloud config configurations activate $(GCLOUD_CONFIG)

docker-build:
	docker build -t flask_hello_world:latest .

docker-tag:
	docker tag flask_hello_world:latest gcr.io/$(GCLOUD_PROJECT)/flask_hello_world:latest

docker-push: auth docker-tag
	docker push gcr.io/$(GCLOUD_PROJECT)/flask_hello_world:latest

docker-run: docker-build
	docker run --rm -p 5000:5000 flask_hello_world:latest

cloud-run-deploy: docker-push
	gcloud --configuration=$(GCLOUD_CONFIG) beta run deploy flask-hello-world \
		--allow-unauthenticated \
		--platform=managed \
		--image=gcr.io/$(GCLOUD_PROJECT)/flask_hello_world:latest \
		--region=europe-north1

call-cloud-run:
	@ENDPOINT=$(shell gcloud run services describe flask-hello-world --region=europe-north1 --format json | jq -r .status.url) && \
	curl $$ENDPOINT

load-test-cloud-run:
	@ENDPOINT=$(shell gcloud run services describe flask-hello-world --region=europe-north1 --format json | jq -r .status.url)/ && \
	ab -n 10000 -c 100 $$ENDPOINT

# eof