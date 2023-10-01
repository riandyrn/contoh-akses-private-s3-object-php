.PHONY: *

run:
	docker build -t s3-access-private-object .
	docker run -it --rm \
		-e AWS_ACCESS_KEY_ID=${POC_S3_AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${POC_S3_AWS_SECRET_ACCESS_KEY} \
		-p 9114:9114 \
		s3-access-private-object

run-svc:
	docker build -t s3-access-private-object .
	docker run -it --rm -d \
		-e AWS_ACCESS_KEY_ID=${POC_S3_AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${POC_S3_AWS_SECRET_ACCESS_KEY} \
		-p 9114:9114 \
		s3-access-private-object