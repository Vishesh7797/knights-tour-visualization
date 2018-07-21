BUILD_PATH   = docs/
EMCC         = emcc -std=gnu11 -Weverything -Werror -Wno-unused-function -Wno-language-extension-token -O2 -s ASSERTIONS=1
CC           = clang -std=gnu11 -Weverything -Werror -Wno-language-extension-token

default : $(BUILD_PATH)tour.js $(BUILD_PATH)index.htm $(BUILD_PATH)action.js

$(BUILD_PATH)tour.js : src/tour.h src/tour.c Makefile
	$(EMCC) -s EXPORTED_FUNCTIONS='["_getNextPointSerialize"]' -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -o $(BUILD_PATH)tour.js src/tour.c

$(BUILD_PATH)index.htm : src/index.htm Makefile
	cp src/index.htm $(BUILD_PATH)index.htm

$(BUILD_PATH)action.js : src/action.js Makefile
	uglifyjs src/action.js -o $(BUILD_PATH)action.js

test : src/tour.h src/tour.c src/tour_tb.c
	$(CC) -DDEBUG -o $(BUILD_PATH)tour.exe src/tour.c src/tour_tb.c
	./$(BUILD_PATH)tour

clean :
	rm -f $(BUILD_PATH)*
