package main

import (
	"context"
	"log"

	"carbonite.fr/grpc-template/chat"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {
	var conn *grpc.ClientConn

	conn, err := grpc.NewClient(":9000", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("Erreur Dial %v", err)
	}
	defer conn.Close()

	c := chat.NewChatServiceClient(conn)
	res, err := c.SayHello(context.Background(), &chat.Message{Body: "Send from the client"})
	if err != nil {
		log.Fatalf("Erreur SayHello %v", err)
	}

	log.Printf("Message received: %s", res.Body)
}
