CC=gcc
HAXE=haxe
RM=rm -r -f
SRC_DIR=src
APPLE_FLAGS=-lhl -lUrho3D  -LUrho3D/Lib  -framework SystemConfiguration -framework AudioToolbox -framework AudioUnit -framework Carbon -framework Cocoa -framework CoreAudio -framework CoreVideo -framework ForceFeedback -framework IOKit -framework OpenGL -framework CoreServices -ldl -lpthread -liconv -lc++ -stdlib=libc++ -Wno-address-of-temporary -Wno-return-type-c-linkage -Wno-c++11-extensions  -std=c++11
INCLUDES=-I hashlink -I Urho3D/include -I Urho3D/include/Urho3D -I Urho3D/include/Urho3D/ThirdParty -I src/cpp

cleanup: urho3d-main
	$(RM) *.o

main-release: hashlink_main.o 
	$(CC)  -O3 -o main-release  $(INCLUDES) *.o  $(APPLE_FLAGS)

urho3d-main: all_urho3d_cpp_files hashlink_main.o 
	$(CC)  -O3 -o urho3d-main  $(INCLUDES) *.o  $(APPLE_FLAGS)

hashlink_main.o: hashlink-c 
	$(CC) -c -O3 -o hashlink_main.o  $(INCLUDES) hashlink/hashlink_main.c 

hashlink-c:
	$(HAXE) -cp src/haxe --main Main --hl hashlink/hashlink_main.c

all_urho3d_cpp_files:
	$(CC) -c -O3  $(INCLUDES)  $(SRC_DIR)/cpp/*.cpp -std=c++11

hdll:
	$(CC) -o Urho3D.hdll $(INCLUDES)  $(SRC_DIR)/cpp/*.cpp  -shared  -Wall -O3  -I/usr/local/include $(APPLE_FLAGS)

hl:
	$(HAXE) -cp src/haxe   --main Main --hl main.hl

all: hdll urho3d-main cleanup hl

clean:
	$(RM) *.o hashlink/ urho3d-main main-release *.hdll *.hl *.log