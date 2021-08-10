FROM public.ecr.aws/lambda/go:latest as build
WORKDIR /module
COPY . /module/
# install build tools
RUN yum install -y golang
RUN go env -w GOPROXY=direct
# cache dependencies
ADD go.mod go.sum ./
RUN go mod download
# build
ADD . .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main

# Copy artifacts to a clean image
FROM public.ecr.aws/lambda/go:latest
COPY --from=build /module/main ${LAMBDA_TASK_ROOT}
CMD ["main"]      
