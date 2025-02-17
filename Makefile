# Makefile, versao 1
# Sistemas Operativos, DEI/IST/ULisboa 2020-21

CC   = gcc
LD   = gcc
CFLAGS =-pthread -Wall -std=gnu99 -I../
LDFLAGS=-lm

# A phony target is one that is not really the name of a file
# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: all clean run

all: tecnicofs tecnicofs-client

tecnicofs: fs/state.o fs/operations.o main.o
	$(LD) $(CFLAGS) $(LDFLAGS) -o tecnicofs fs/state.o fs/operations.o main.o

fs/state.o: fs/state.c fs/state.h tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o fs/state.o -c fs/state.c

fs/operations.o: fs/operations.c fs/operations.h fs/state.h tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o fs/operations.o -c fs/operations.c

main.o: main.c fs/operations.h fs/state.h tecnicofs-api-constants.h
	$(CC) $(CFLAGS) -o main.o -c main.c

tecnicofs-client: tecnicofs-client-api.o tecnicofs-client.o
	$(LD) $(CFLAGS) $(LDFLAGS) -o tecnicofs-client tecnicofs-client-api.o tecnicofs-client.o

tecnicofs-client.o: tecnicofs-client.c tecnicofs-api-constants.h tecnicofs-client-api.h
	$(CC) $(CFLAGS) -o tecnicofs-client.o -c tecnicofs-client.c

tecnicofs-client-api.o: tecnicofs-client-api.c tecnicofs-api-constants.h tecnicofs-client-api.h
	$(CC) $(CFLAGS) -o tecnicofs-client-api.o -c tecnicofs-client-api.c

clean:
	@echo Cleaning...
	rm -f fs/*.o *.o tecnicofs
	rm -f fs/*.o *.o tecnicofs-client

