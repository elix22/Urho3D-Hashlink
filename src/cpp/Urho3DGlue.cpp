#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}
/*
gcc -c -O3 -o Urho3DGlue.o  -I out   Urho3DGlue.cpp   -I../Urho3D/include -I../Urho3D/include/Urho3D/ThirdParty   -std=c++11 
gcc -c -O3 -o main.o  -I out out/main.c 

gcc  -O3 -o urho3d-main  -I out   main.o  Urho3DGlue.o  -lhl -lUrho3D  -L../Urho3D/Lib -I../Urho3D/include -I../Urho3D/include/Urho3D/ThirdParty   -std=c++11 -framework SystemConfiguration -framework AudioToolbox -framework AudioUnit -framework Carbon -framework Cocoa -framework CoreAudio -framework CoreVideo -framework ForceFeedback -framework IOKit -framework OpenGL -framework CoreServices -ldl -lpthread -liconv -lc++ -stdlib=libc++ -std=c++0x -Wno-address-of-temporary -Wno-return-type-c-linkage -Wno-c++11-extensions -DDEBUG -D_DEBUG

*/

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

class Sample : public Application
{
    // Enable type information.
    URHO3D_OBJECT(Sample, Application);

    explicit Sample(Context *context) : Application(context)
    {
    }

    void Setup() override
    {
        //
        engineParameters_[EP_RESOURCE_PREFIX_PATHS] = GetSubsystem<FileSystem>()->GetProgramDir();
#if URHO3D_HAXE_HASHLINK
         engineParameters_[EP_RESOURCE_PATHS] = "Data;CoreData;";
#else
        engineParameters_[EP_RESOURCE_PATHS] = "bin/Data;bin/CoreData;";
#endif
        engineParameters_[EP_LOG_NAME] = GetSubsystem<FileSystem>()->GetProgramDir() + "UrhoHaxe.log";
        engineParameters_[EP_FULL_SCREEN] = false;
        engineParameters_[EP_WINDOW_WIDTH] = 1280;
        engineParameters_[EP_WINDOW_HEIGHT] = 720;
        engineParameters_[EP_WINDOW_TITLE] = "UrhoHaxe";
        engineParameters_[EP_WINDOW_ICON] = "Textures/UrhoIcon.png";
    }

    void Start() override
    {
        CreateText();
    }

    void CreateText()
    {
        auto *cache = GetSubsystem<ResourceCache>();

        // Construct new Text object
        SharedPtr<Text> helloText(new Text(context_));

        // Set String to display
        helloText->SetText("Hello World from Urho3D!");

        // Set font and text color
        helloText->SetFont(cache->GetResource<Font>("Fonts/Anonymous Pro.ttf"), 30);
        helloText->SetColor(Color(0.0f, 1.0f, 0.0f));

        // Align Text center-screen
        helloText->SetHorizontalAlignment(HA_CENTER);
        helloText->SetVerticalAlignment(VA_CENTER);

        // Add Text instance to the UI root element
        GetSubsystem<UI>()->GetRoot()->AddChild(helloText);
    }
};

HL_PRIM void HL_NAME(_start_urho3_dapplication)()
{
    Urho3D::Context *context = new Urho3D::Context();
    Sample *application = new Sample(context);
    application->Run();
}



 HL_PRIM void HL_NAME(_create_app)(urho3d_context * context)
 {
    Sample *application = new Sample(context);
    application->Run();
 }


DEFINE_PRIM(_VOID, _start_urho3_dapplication, _NO_ARG);
DEFINE_PRIM(_VOID, _create_app, URHO3D_CONTEXT);