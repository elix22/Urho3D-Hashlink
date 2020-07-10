CC=gcc
HAXE=haxe
RM=rm -r -f
SRC_DIR=src
APPLE_FLAGS=-lhl -lUrho3D  -LUrho3D/Lib  -framework SystemConfiguration -framework AudioToolbox -framework AudioUnit -framework Carbon -framework Cocoa -framework CoreAudio -framework CoreVideo -framework ForceFeedback -framework IOKit -framework OpenGL -framework CoreServices -ldl -lpthread -liconv -lc++ -stdlib=libc++ -Wno-address-of-temporary -Wno-return-type-c-linkage -Wno-c++11-extensions  -std=c++11
INCLUDES=-I hashlink -I Urho3D/include -I Urho3D/include/Urho3D/ThirdParty -I src/cpp

cleanup: urho3d-main
	$(RM) *.o

urho3d-main: Urho3DGlue.o  urho3d_core_context.o urho3d_engine_application.o urho3d_core_variant.o urho3d_math_vector2.o urho3d_math_stringhash.o hashlink_main.o 
	$(CC)  -O3 -o urho3d-main  $(INCLUDES)   hashlink_main.o  Urho3DGlue.o urho3d_core_context.o urho3d_engine_application.o urho3d_core_variant.o urho3d_math_vector2.o urho3d_math_stringhash.o   $(APPLE_FLAGS)

hashlink_main.o: hashlink-c 
	$(CC) -c -O3 -o hashlink_main.o  $(INCLUDES) hashlink/hashlink_main.c 

hashlink-c:
	$(HAXE) -cp src/haxe --main Main --hl hashlink/hashlink_main.c

Urho3DGlue.o:
	$(CC) -c -O3 -o Urho3DGlue.o  $(INCLUDES)  $(SRC_DIR)/cpp/Urho3DGlue.cpp   -std=c++11

urho3d_engine_application.o:
	$(CC) -c -O3 -o urho3d_engine_application.o  $(INCLUDES)  $(SRC_DIR)/cpp/urho3d_engine_application.cpp   -std=c++11

urho3d_core_context.o:
	$(CC) -c -O3 -o urho3d_core_context.o  $(INCLUDES)  $(SRC_DIR)/cpp/urho3d_core_context.cpp   -std=c++11

urho3d_core_variant.o:
	$(CC) -c -O3 -o urho3d_core_variant.o  $(INCLUDES)  $(SRC_DIR)/cpp/urho3d_core_variant.cpp   -std=c++11

urho3d_math_vector2.o:
	$(CC) -c -O3 -o urho3d_math_vector2.o  $(INCLUDES)  $(SRC_DIR)/cpp/urho3d_math_vector2.cpp   -std=c++11
	
urho3d_math_stringhash.o:
	$(CC) -c -O3 -o urho3d_math_stringhash.o  $(INCLUDES)  $(SRC_DIR)/cpp/urho3d_math_stringhash.cpp   -std=c++11

hdll:
	$(CC) -o Urho3D.hdll $(INCLUDES)  $(SRC_DIR)/cpp/*.cpp  -shared  -Wall -O3  -I/usr/local/include $(APPLE_FLAGS)

hl:
	$(HAXE) -cp src/haxe   --main Main --hl main.hl

all: hdll urho3d-main cleanup hl

clean:
	$(RM) *.o hashlink/ urho3d-main *.hdll *.hl *.log