package chat

import (
	"log"

	"golang.org/x/net/context"
)

type (
	Server struct {
		UnimplementedChatServiceServer
	}
)

func (s *Server) SayHello(ctx context.Context, message *Message) (*Message, error) {
	log.Printf("Message received: %s", message.Body)
	return &Message{Body: "Send from the server"}, nil
}
