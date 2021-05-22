.PHONY: clean deps fmt vet lint build install run test cover image release deploy

app_name = taxibot
build_path = bin/

clean:
	rm -rf ${build_path}

deps:
	go get -u -v

fmt:
	gofmt -s -w .

vet:
	go vet ./...

lint: fmt vet

build: lint clean
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${build_path}${app_name} -v .

build-mac: lint clean
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o ${build_path}${app_name} -v .

install:
	go install -v .

run: build
	./${build_path}${app_name}

test: lint
	go test -v ./... -coverprofile=${app_name}.out

cover: test
	go tool cover -html=${app_name}.out -o=${app_name}.html

image:
	./scripts/image.sh

publish:
	./scripts/publish.sh

deploy:
	./scripts/deploy.sh
