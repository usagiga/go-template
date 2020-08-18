xxx:
	@echo "Please select optimal option."

build:
	@go build -o go-template .

clean:
	@rm -f ./go-template
	@rm -f ./docker/__debug_bin

run:
	@go run .

debug:
	@air

test:
	@go test -v "./..."
