package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"net"
)

type ClientMessage struct {
	Command string `json:"command"`
	Content string `json:"content"`
}

func squalk(conn net.Conn, content string) {
	response := fmt.Sprintf("Polly squalks: %s\n", content)
	fmt.Print(response)
	conn.Write([]byte(response))
}

func handleConnection(conn net.Conn) {
	defer conn.Close()
	reader := bufio.NewReader(conn)
	for {
		jsonMessage, err := reader.ReadBytes('\n')
		if err != nil {
			break
		}
		var message ClientMessage
		if err := json.Unmarshal(jsonMessage, &message); err != nil {
			conn.Write([]byte("Bad json"))
			continue
		}
		switch message.Command {
		case "say":
			squalk(conn, message.Content)
		case "bye":
			squalk(conn, "ByeBye!")
			return
		default:
			squalk(conn, fmt.Sprintf("I can't %s", message.Command))
		}
	}
}

func main() {
	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		panic("parrot failed to wake up")
	}
	defer listener.Close()
	fmt.Println("Parrot listening on port 8080")
	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}
		go handleConnection(conn)
	}
}

// {"command": "say", "content": "hi im polly"}
// {"command": "say", "content": "I wana cracker"}
// {"command": "bye"}
// {"command": "dance"}
