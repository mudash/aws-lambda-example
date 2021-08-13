package main

import (
	"math/rand"
	"strings"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

type Request struct {
	Gender string `json:"Gender"`
}

type Response struct {
	Name string `json:"Name",required`
}

// Lambda Event Handler
func EventHandler(r Request) (Response, error) {

	g := strings.ToLower(r.Gender)
	any := rand.Int()
	if g == "m" {
		return Response{Name: GetBabyBoyName()}, nil
	} else if g == "f" {
		return Response{Name: GetBabyGirlName()}, nil
	} else if any%2 == 0 {
		return Response{Name: GetBabyBoyName()}, nil
	}

	return Response{Name: GetBabyGirlName()}, nil
}

// Randomly suggest baby boy names
func GetBabyBoyName() string {
	rand.Seed(time.Now().Unix())
	names := []string{
		"Ali",
		"Alvin",
		"Casey",
		"Dylan",
		"John",
	}
	n := rand.Int() % len(names)
	return names[n]
}

// Randomly suggest baby girl names
func GetBabyGirlName() string {
	rand.Seed(time.Now().Unix())
	names := []string{
		"Aima",
		"Alisha",
		"Faria",
		"Patricia",
		"Shamsia",
	}
	n := rand.Int() % len(names)
	return names[n]
}

func main() {
	lambda.Start(EventHandler)
}
