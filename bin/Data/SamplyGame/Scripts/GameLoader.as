/**
MIT License
Copyright (c) 2020 Eli Aloni (https://github.com/elix22)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#include "Scripts/Utilities/Sample.as"

String configFileName;
String startingScene;



void LoadConfig()
{
    if (!fileSystem.FileExists(configFileName))
        return;

    XMLFile config;
    config.Load(File(configFileName, FILE_READ));

    XMLElement configElem = config.root;
    if (configElem.isNull)
        return;
		
	XMLElement generalElem = configElem.GetChild("general");
	
	if (!generalElem.isNull)
    {
        if (generalElem.HasAttribute("scene")) startingScene = generalElem.GetAttribute("scene");
	}
		
}
		
void Start()
{
    

    configFileName = cache.GetResourceFileName("Config.xml");
	
	if (!fileSystem.FileExists(configFileName))
        return;
		
	LoadConfig();
	
    // Execute the common startup for samples
    SampleStart();

	
    // Create the scene content
	if(startingScene != "")
	{
	   LoadScene_(startingScene);
	}
	else
	{
      CreateScene();
	  	
      // Setup the viewport for displaying the scene
       SetupViewport();
	}
	
	SetLogoVisible(false);
	
	if(scene_.name != "")
	{
      graphics.windowTitle = scene_.name;
	}
	else
	{
	   graphics.windowTitle = "Scene";
	}
	
    // Hook up to the frame update events
    SubscribeToEvents();
}


void CreateScene()
{
    scene_ = Scene();

    // Create the Octree component to the scene. This is required before adding any drawable components, or else nothing will
    // show up. The default octree volume will be from (-1000, -1000, -1000) to (1000, 1000, 1000) in world coordinates; it
    // is also legal to place objects outside the volume but their visibility can then not be checked in a hierarchically
    // optimizing manner
    scene_.CreateComponent("Octree");

    // Create a directional light to the world so that we can see something. The light scene node's orientation controls the
    // light direction; we will use the SetDirection() function which calculates the orientation from a forward direction vector.
    // The light will use default settings (white light, no shadows)
    Node@ lightNode = scene_.CreateChild("DirectionalLight");
    lightNode.direction = Vector3(0.6f, -1.0f, 0.8f); // The direction vector does not need to be normalized
    Light@ light = lightNode.CreateComponent("Light");
    light.lightType = LIGHT_DIRECTIONAL;


    // Create a scene node for the camera, which we will move around
    // The camera will use default settings (1000 far clip distance, 45 degrees FOV, set aspect ratio automatically)
    cameraNode = scene_.CreateChild("Camera");
    cameraNode.CreateComponent("Camera");

    // Set an initial position for the camera scene node above the plane
    cameraNode.position = Vector3(0.0f, 5.0f, 0.0f);
}



void SetupViewport()
{
    // Set up a viewport to the Renderer subsystem so that the 3D scene can be seen. We need to define the scene and the camera
    // at minimum. Additionally we could configure the viewport screen size and the rendering path (eg. forward / deferred) to
    // use, but now we just use full screen and default render path configured in the engine command line options
    Viewport@ viewport = Viewport(scene_, cameraNode.GetComponent("Camera"));
    renderer.viewports[0] = viewport;
}


void SubscribeToEvents()
{
    // Subscribe HandleUpdate() function for processing update events
    SubscribeToEvent("Update", "HandleUpdate");
}

void HandleUpdate(StringHash eventType, VariantMap& eventData)
{
    // Take the frame time step, which is stored as a float
    float timeStep = eventData["TimeStep"].GetFloat();

}

// Create XML patch instructions for screen joystick layout specific to this sample app
String patchInstructions = "";
