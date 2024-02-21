package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"
)

func main() {
	// define command line parameters
	sizePtr := flag.String("size", "", "File size (e.g., 100KB, 100MB, 1GB")
	flag.Parse()

	// check parameters
	if *sizePtr == "" {
		fmt.Println("Usage: go run exec.go -size=<size>")
		return
	}

	// parse file size
	size, err := parseSize(*sizePtr)
	if err != nil {
		fmt.Println("Invalid file size format")
		return
	}

	// generate file
	fileName := fmt.Sprintf("%s.dat", *sizePtr)
	err = generateFile(fileName, size)
	if err != nil {
		fmt.Printf("Failed to generate file %s\n", fileName)
		return
	}

	fmt.Printf("Generate file %s successfully!\n", fileName)
}

func parseSize(sizePtr string) (int64, error) {
	// get digital part
	size, err := strconv.ParseInt(sizePtr[:len(sizePtr)-2], 10, 64)
	if err != nil {
		return 0, err
	}

	// get unit
	unit := sizePtr[len(sizePtr)-2:]
	var multiplier int64
	switch unit {
	case "KB":
		multiplier = 1024
	case "MB":
		multiplier = 1024 * 1024
	case "GB":
		multiplier = 1024 * 1024 * 1024
	default:
		return 0, fmt.Errorf("unsupported unit '%s'", unit)
	}

	return size * multiplier, nil
}

// generate file
func generateFile(fileName string, fileSize int64) error {
	// create file
	file, err := os.Create(fileName)
	if err != nil {
		return err
	}

	defer file.Close()

	// padding file content
	data := make([]byte, fileSize)
	_, err = file.Write(data)
	if err != nil {
		return err
	}

	return nil
}
