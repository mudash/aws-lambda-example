package main

import (
	"math/rand"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

type Request struct{}

type Response struct {
	Name string `json:"Name",required`
}

func EventHandler(r Request) (Response, error) {

	return Response{Name: GetName()}, nil

}
func GetName() string {
	rand.Seed(time.Now().Unix())
	names := []string{
		"Liza",
		"Alisha",
		"Susan",
		"Shamsia",
	}
	n := rand.Int() % len(names)
	return names[n]
}

func main() {
	lambda.Start(EventHandler)
}
