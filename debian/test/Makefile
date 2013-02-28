# test functionality

BIN	= fcrackzip
OPT	= -c a -u -v -v
LEN	= -l 1-2
PASS	= -p aa
OPTIONS = $(OPT) $(LEN)

FILE	= test.zip

all: test1 test2 test3

input.pass:
	echo "aa" > $@

$(FILE):
	#  create encrypted file, give 2 character password, like "ab"
	#  when asked
	touch a b c
	zip -e $(FILE) a b c

	rm -f a b c

\'$(FILE): $(FILE)
	cp $(FILE) \'$(FILE)

test1: $(FILE)
	# test simple crack
	$(BIN) $(OPTIONS) $(PASS) $(FILE)

test2: \'$(FILE)
	# test special filename
	$(BIN) $(OPTIONS) $(PASS) \'$(FILE)

test3: input.pass
	# test stdin
	$(BIN) $(OPTIONS) -p - $(FILE) < input.pass

# End of file
