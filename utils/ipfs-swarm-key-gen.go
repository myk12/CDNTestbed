package main

import ("crypto/rand";
	"encoding/hex";
	"fmt";
	"log";
)

func main() {
	key := make([]byte, 32)
	_, err := rand.Read(key)
	if err != nil {
		log.Fatalln("Failed while try to read random source:", err)
	}

	fmt.Println("/key/swarm/psk/1.0.0/")
	fmt.Println("/base16/")
	fmt.Print(hex.EncodeToString(key))
}

