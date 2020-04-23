xxx:
	@echo "Please select optimal option."

build:
	@go build -o go-template .

clean:
	@rm -f ./go-template

run:
	@go run .

test:
	@go test -v "./..."
