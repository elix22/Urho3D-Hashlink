#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.inc"

vdynamic *hl_dyn_abstract_call(vclosure *c, vdynamic **args, int nargs);
void *hl_dyn_getp_internal(vdynamic *d, hl_field_lookup **f, int hfield, vclosure *c = NULL);

static int hl_hash_on_tick = 0;
static int hl_hash_pre_setup = 0;

class ProxyApp : public Application
{
    // Enable type information.
    URHO3D_OBJECT(ProxyApp, Application);

    explicit ProxyApp(Context *context, vdynamic *dyn_obj) : Application(context),
                                                             touchEnabled_(false),
                                                             useMouseMode_(MM_ABSOLUTE),
                                                             screenJoystickIndex_(M_MAX_UNSIGNED),
                                                             screenJoystickSettingsIndex_(M_MAX_UNSIGNED),
                                                             paused_(false)
    {
        callback_setup = NULL;
        callback_start = NULL;
        callback_stop = NULL;
        screenJoystickpatchString_ = "";

        this_dyn_obj_app = dyn_obj;

        dyn_obj_field_on_tick = NULL;
        if (hl_hash_on_tick == 0)
            hl_hash_on_tick = hl_hash_utf8("OnTick");

        dyn_obj_field_pre_setup = NULL;
        if (hl_hash_pre_setup == 0)
            hl_hash_pre_setup = hl_hash_utf8("PreSetup");
    }

    void Setup() override
    {

        engineParameters_[EP_RESOURCE_PREFIX_PATHS] = GetSubsystem<FileSystem>()->GetProgramDir();
#if URHO3D_HAXE_HASHLINK
        engineParameters_[EP_RESOURCE_PATHS] = "Data;CoreData;";
#else
        // TBD ELI , should be dynamically modified
        engineParameters_[EP_RESOURCE_PREFIX_PATHS] = "/Users/elialoni/projects/Urho3D-Hashlink";
        engineParameters_[EP_RESOURCE_PATHS] = "bin/Data;bin/CoreData;";
#endif
        engineParameters_[EP_LOG_NAME] = GetSubsystem<FileSystem>()->GetProgramDir() + "UrhoHaxe.log";
        engineParameters_[EP_FULL_SCREEN] = false;
        engineParameters_[EP_WINDOW_WIDTH] = 1280;
        engineParameters_[EP_WINDOW_HEIGHT] = 720;
        engineParameters_[EP_WINDOW_TITLE] = "UrhoHaxe";
        engineParameters_[EP_WINDOW_ICON] = "Textures/UrhoIcon.png";

        SubscribeToEvent(E_UPDATE, URHO3D_HANDLER(ProxyApp, HandleUpdate));

        if (this_dyn_obj_app)
        {
            vclosure closure;
            hl_dyn_getp_internal(this_dyn_obj_app, &dyn_obj_field_pre_setup, hl_hash_pre_setup, &closure);
            ((void (*)(vdynamic *))closure.fun)((vdynamic *)closure.value);
        }

        if (callback_setup)
        {
            hl_dyn_call(callback_setup, NULL, 0);
        }
    }

    void Start() override
    {
        if (GetPlatform() == "Android" || GetPlatform() == "iOS")
            // On mobile platform, enable touch by adding a screen joystick
            InitTouchInput();
        else if (GetSubsystem<Input>()->GetNumJoysticks() == 0)
            // On desktop platform, do not detect touch when we already got a joystick
            SubscribeToEvent(E_TOUCHBEGIN, URHO3D_HANDLER(ProxyApp, HandleTouchBegin));

        // Subscribe key down event
        SubscribeToEvent(E_KEYDOWN, URHO3D_HANDLER(ProxyApp, HandleKeyDown));
        // Subscribe key up event
        SubscribeToEvent(E_KEYUP, URHO3D_HANDLER(ProxyApp, HandleKeyUp));

        CreateConsoleAndDebugHud();

        /*============*/
        if (callback_start)
        {
            hl_dyn_call(callback_start, NULL, 0);
        }
    }

    void Stop() override
    {
        if (callback_stop)
        {
            vdynamic *args[1];
            // hl_dyn_call(callback_stop, args, 0);

            hl_remove_root(&callback_stop);
            callback_stop = NULL;
        }

        if (callback_start)
        {
            hl_remove_root(&callback_start);
            callback_start = NULL;
        }

        if (callback_setup)
        {
            hl_remove_root(&callback_setup);
            callback_setup = NULL;
        }
    }

    void HandleUpdate(StringHash eventType, VariantMap &eventData)
    {
        using namespace Update;

        // Take the frame time step, which is stored as a float
        float timeStep = eventData[P_TIMESTEP].GetFloat();

        if (this_dyn_obj_app)
        {
            vclosure closure;
            hl_dyn_getp_internal(this_dyn_obj_app, &dyn_obj_field_on_tick, hl_hash_on_tick, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
        }
    }

    void subscribeToEvent(hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
    {
        if (stringhash)
        {
            Urho3D::StringHash *urho3d_stringhash = stringhash->ptr;
            if (urho3d_stringhash)
            {
                const char *closure_name = (char *)hl_to_utf8(str->bytes);
                hl_event_closures[*urho3d_stringhash] = new HL_Urho3DEventHandler(context_, dyn_obj, String(closure_name));
                if (*urho3d_stringhash == E_UPDATE || *urho3d_stringhash == E_TOUCHBEGIN || *urho3d_stringhash == E_KEYDOWN || *urho3d_stringhash == E_KEYUP)
                {
                    UnsubscribeFromEvent(*urho3d_stringhash);
                }
                SubscribeToEvent(*urho3d_stringhash, URHO3D_HANDLER(ProxyApp, HandlEvents));
            }
        }
    }

    void subscribeToEvent(Urho3D::Object *object, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
    {
        if (stringhash)
        {
            Urho3D::StringHash *urho3d_stringhash = stringhash->ptr;
            if (urho3d_stringhash)
            {
                const char *closure_name = (char *)hl_to_utf8(str->bytes);
                hl_event_closures[*urho3d_stringhash] = new HL_Urho3DEventHandler(context_, dyn_obj, String(closure_name));

                SubscribeToEvent(object, *urho3d_stringhash, URHO3D_HANDLER(ProxyApp, HandlEvents));
            }
        }
    }

    void HandlEvents(StringHash eventType, VariantMap &eventData)
    {
        SharedPtr<HL_Urho3DEventHandler> event_handler = hl_event_closures[eventType];
        if (event_handler == NULL)
            return;

        vclosure closure;
        vclosure *callback_fn = (vclosure *)hl_dyn_getp_internal(event_handler->dyn_obj, &event_handler->dyn_obj_field_lookup, event_handler->hl_hash_name, &closure);

        if (callback_fn && callback_fn->hasValue)
        {
            hl_urho3d_stringhash *hl_stringhsh = (hl_urho3d_stringhash *)alloca(sizeof(hl_urho3d_stringhash));
            hl_stringhsh->ptr = &eventType;
            vdynamic *dyn_urho3d_stringhash = (vdynamic *)alloca(sizeof(vdynamic));
            dyn_urho3d_stringhash->t = &hlt_abstract;
            dyn_urho3d_stringhash->v.ptr = hl_stringhsh;

            hl_urho3d_variantmap *hl_variantmap = (hl_urho3d_variantmap *)alloca(sizeof(hl_urho3d_variantmap));
            hl_variantmap->ptr = &eventData;
            vdynamic *dyn_urho3d_variantmap = (vdynamic *)alloca(sizeof(vdynamic));
            dyn_urho3d_variantmap->t = &hlt_abstract;
            dyn_urho3d_variantmap->v.ptr = hl_variantmap;
            /*
            vdynamic *args[2];
            args[0] = dyn_urho3d_stringhash;
            args[1] = dyn_urho3d_variantmap;
            hl_dyn_abstract_call(callback_fn, args, 2);
            */
            ((void (*)(vdynamic *, vdynamic *, vdynamic *))closure.fun)((vdynamic *)closure.value, (vdynamic *)(*(void **)(&dyn_urho3d_stringhash->v)), (vdynamic *)(*(void **)(&dyn_urho3d_variantmap->v)));
        }

        if (eventType == E_UPDATE)
        {
            using namespace Update;
            float timeStep = eventData[P_TIMESTEP].GetFloat();
            if (this_dyn_obj_app)
            {
                vclosure closure;
                hl_dyn_getp_internal(this_dyn_obj_app, &dyn_obj_field_on_tick, hl_hash_on_tick, &closure);
                ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            }
        }
    }

    /*=================================================================================================================*/
    /*=================================================================================================================*/
    /*=================================================================================================================*/
    /*=================================================================================================================*/

    void HandleTouchBegin(StringHash /*eventType*/, VariantMap &eventData)
    {
        // On some platforms like Windows the presence of touch input can only be detected dynamically
        InitTouchInput();
        UnsubscribeFromEvent("TouchBegin");
    }

    void HandleKeyUp(StringHash /*eventType*/, VariantMap &eventData)
    {
        using namespace KeyUp;

        int key = eventData[P_KEY].GetInt();

        // Close console (if open) or exit when ESC is pressed
        if (key == KEY_ESCAPE)
        {
            Console *console = GetSubsystem<Console>();
            if (console->IsVisible())
                console->SetVisible(false);
            else
            {
                if (GetPlatform() == "Web")
                {
                    GetSubsystem<Input>()->SetMouseVisible(true);
                    if (useMouseMode_ != MM_ABSOLUTE)
                        GetSubsystem<Input>()->SetMouseMode(MM_FREE);
                }
                else
                    engine_->Exit();
            }
        }
    }

    void HandleKeyDown(StringHash /*eventType*/, VariantMap &eventData)
    {
        using namespace KeyDown;

        int key = eventData[P_KEY].GetInt();

        // Toggle console with F1
        if (key == KEY_F1)
            GetSubsystem<Console>()->Toggle();

        // Toggle debug HUD with F2
        else if (key == KEY_F2)
            GetSubsystem<DebugHud>()->ToggleAll();

        // Common rendering quality controls, only when UI has no focused element
        else if (!GetSubsystem<UI>()->GetFocusElement())
        {
            Renderer *renderer = GetSubsystem<Renderer>();

            // Preferences / Pause
            if (key == KEY_SELECT && touchEnabled_)
            {
                paused_ = !paused_;

                Input *input = GetSubsystem<Input>();
                if (screenJoystickSettingsIndex_ == M_MAX_UNSIGNED)
                {
                    // Lazy initialization
                    ResourceCache *cache = GetSubsystem<ResourceCache>();
                    screenJoystickSettingsIndex_ = (unsigned)input->AddScreenJoystick(cache->GetResource<XMLFile>("UI/ScreenJoystickSettings_Samples.xml"), cache->GetResource<XMLFile>("UI/DefaultStyle.xml"));
                }
                else
                    input->SetScreenJoystickVisible(screenJoystickSettingsIndex_, paused_);
            }

            // Texture quality
            else if (key == '1')
            {
                auto quality = (unsigned)renderer->GetTextureQuality();
                ++quality;
                if (quality > QUALITY_HIGH)
                    quality = QUALITY_LOW;
                renderer->SetTextureQuality((MaterialQuality)quality);
            }

            // Material quality
            else if (key == '2')
            {
                auto quality = (unsigned)renderer->GetMaterialQuality();
                ++quality;
                if (quality > QUALITY_HIGH)
                    quality = QUALITY_LOW;
                renderer->SetMaterialQuality((MaterialQuality)quality);
            }

            // Specular lighting
            else if (key == '3')
                renderer->SetSpecularLighting(!renderer->GetSpecularLighting());

            // Shadow rendering
            else if (key == '4')
                renderer->SetDrawShadows(!renderer->GetDrawShadows());

            // Shadow map resolution
            else if (key == '5')
            {
                int shadowMapSize = renderer->GetShadowMapSize();
                shadowMapSize *= 2;
                if (shadowMapSize > 2048)
                    shadowMapSize = 512;
                renderer->SetShadowMapSize(shadowMapSize);
            }

            // Shadow depth and filtering quality
            else if (key == '6')
            {
                ShadowQuality quality = renderer->GetShadowQuality();
                quality = (ShadowQuality)(quality + 1);
                if (quality > SHADOWQUALITY_BLUR_VSM)
                    quality = SHADOWQUALITY_SIMPLE_16BIT;
                renderer->SetShadowQuality(quality);
            }

            // Occlusion culling
            else if (key == '7')
            {
                bool occlusion = renderer->GetMaxOccluderTriangles() > 0;
                occlusion = !occlusion;
                renderer->SetMaxOccluderTriangles(occlusion ? 5000 : 0);
            }

            // Instancing
            else if (key == '8')
                renderer->SetDynamicInstancing(!renderer->GetDynamicInstancing());

            // Take screenshot
            else if (key == '9')
            {
                Graphics *graphics = GetSubsystem<Graphics>();
                Image screenshot(context_);
                graphics->TakeScreenShot(screenshot);
                // Here we save in the Data folder with date and time appended
                screenshot.SavePNG(GetSubsystem<FileSystem>()->GetProgramDir() + "Data/Screenshot_" +
                                   Time::GetTimeStamp().Replaced(':', '_').Replaced('.', '_').Replaced(' ', '_') + ".png");
            }
        }
    }

    // If the user clicks the canvas, attempt to switch to relative mouse mode on web platform
    void HandleMouseModeRequest(StringHash /*eventType*/, VariantMap &eventData)
    {
        Console *console = GetSubsystem<Console>();
        if (console && console->IsVisible())
            return;
        Input *input = GetSubsystem<Input>();
        if (useMouseMode_ == MM_ABSOLUTE)
            input->SetMouseVisible(false);
        else if (useMouseMode_ == MM_FREE)
            input->SetMouseVisible(true);
        input->SetMouseMode(useMouseMode_);
    }

    void HandleMouseModeChange(StringHash /*eventType*/, VariantMap &eventData)
    {
        Input *input = GetSubsystem<Input>();
        bool mouseLocked = eventData[MouseModeChanged::P_MOUSELOCKED].GetBool();
        input->SetMouseVisible(!mouseLocked);
    }

    void InitTouchInput()
    {
        touchEnabled_ = true;

        ResourceCache *cache = GetSubsystem<ResourceCache>();
        Input *input = GetSubsystem<Input>();
        XMLFile *layout = cache->GetResource<XMLFile>("UI/ScreenJoystick_Samples.xml");
        const String &patchString = GetScreenJoystickPatchString();
        if (!patchString.Empty())
        {
            // Patch the screen joystick layout further on demand
            SharedPtr<XMLFile> patchFile(new XMLFile(context_));
            if (patchFile->FromString(patchString))
                layout->Patch(patchFile);
        }
        screenJoystickIndex_ = (unsigned)input->AddScreenJoystick(layout, cache->GetResource<XMLFile>("UI/DefaultStyle.xml"));
        input->SetScreenJoystickVisible(screenJoystickSettingsIndex_, true);
    }

    virtual String GetScreenJoystickPatchString() const { return screenJoystickpatchString_; }

    void SetScreenJoystickPatchString(String patch_string)
    {
        screenJoystickpatchString_ = patch_string;
    }

    void CreateConsoleAndDebugHud()
    {
        // Get default style
        ResourceCache *cache = GetSubsystem<ResourceCache>();
        XMLFile *xmlFile = cache->GetResource<XMLFile>("UI/DefaultStyle.xml");

        // Create console
        Console *console = engine_->CreateConsole();
        console->SetDefaultStyle(xmlFile);
        console->GetBackground()->SetOpacity(0.8f);

        // Create debug HUD.
        DebugHud *debugHud = engine_->CreateDebugHud();
        debugHud->SetDefaultStyle(xmlFile);
    }

    VariantMap *GetEngineParameters()
    {
        return &engineParameters_;
    }

    /*=================================================================================================================*/
    /*=================================================================================================================*/
    /*=================================================================================================================*/
    /*=================================================================================================================*/

public:
    vclosure *callback_setup;
    vclosure *callback_start;
    vclosure *callback_stop;

    //  HashMap<StringHash, vclosure *> hl_event_closures;

    HashMap<StringHash, SharedPtr<HL_Urho3DEventHandler>> hl_event_closures;

    /*=================================================================================================================*/
    /*=================================================================================================================*/
    /*=================================================================================================================*/
public:
    /// Logo sprite.
    SharedPtr<Sprite> logoSprite_;
    /// Scene.
    SharedPtr<Scene> scene_;
    /// Camera scene node.
    SharedPtr<Node> cameraNode_;
    /// Camera yaw angle.
    float yaw_;
    /// Camera pitch angle.
    float pitch_;
    /// Flag to indicate whether touch input has been enabled.
    bool touchEnabled_;
    /// Mouse mode option to use in the sample.
    MouseMode useMouseMode_;

    /// Screen joystick index for navigational controls (mobile platforms only).
    unsigned screenJoystickIndex_;
    /// Screen joystick index for settings (mobile platforms only).
    unsigned screenJoystickSettingsIndex_;
    /// Pause flag.
    bool paused_;

    String screenJoystickpatchString_;

    vdynamic *this_dyn_obj_app;
    hl_field_lookup *dyn_obj_field_on_tick;
    hl_field_lookup *dyn_obj_field_pre_setup;
    /*=================================================================================================================*/
    /*=================================================================================================================*/
};

hl_urho3d_application *hl_alloc_urho3d_application(hl_finalizer finalizer, urho3d_context *context, vdynamic *dyn_obj)
{
    //printf("hl_alloc_urho3d_application enter \n");
    hl_urho3d_application *p = (hl_urho3d_application *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_application));
    memset(p, 0, sizeof(hl_urho3d_application));

    p->finalizer = finalizer ? (void *)finalizer : 0;
    p->ptr = new ProxyApp(context, dyn_obj);
    p->dyn_obj = dyn_obj;
    return p;
}

void finalize_urho3d_application(void *v)
{
    hl_urho3d_application *appptr = (hl_urho3d_application *)v;
    if (appptr)
    {
        Urho3D::Application *app = (Urho3D::Application *)appptr->ptr;
        if (app)
        {
            /* appptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            appptr->ptr = NULL;
        }
        appptr->finalizer = NULL;
    }
}

HL_PRIM hl_urho3d_application *HL_NAME(_create_application)(urho3d_context *context, vdynamic *dyn_obj)
{
    // printf("_create_application enter \n");
    hl_urho3d_application *v = hl_alloc_urho3d_application(finalize_urho3d_application, context, dyn_obj);
    return v;
}

HL_PRIM void HL_NAME(_run_application)(hl_urho3d_application *app)
{
    // printf("_run_application enter \n");
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ptr_app->Run();
    }
}

HL_PRIM void HL_NAME(_setup_closure_application)(hl_urho3d_application *app, vclosure *callback_fn)
{
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        proxyApp->callback_setup = callback_fn;
        hl_add_root(&callback_fn);
    }
}

HL_PRIM void HL_NAME(_start_closure_application)(hl_urho3d_application *app, vclosure *callback_fn)
{
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        proxyApp->callback_start = callback_fn;
        hl_add_root(&callback_fn);
    }
}

HL_PRIM void HL_NAME(_stop_closure_application)(hl_urho3d_application *app, vclosure *callback_fn)
{
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        proxyApp->callback_stop = callback_fn;
        hl_add_root(&callback_fn);
    }
}

HL_PRIM void HL_NAME(_application_subscribe_to_event)(hl_urho3d_application *app, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
{
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        proxyApp->subscribeToEvent(stringhash, dyn_obj, str);
    }
}

HL_PRIM void HL_NAME(_application_subscribe_to_event_sender)(hl_urho3d_application *app, Urho3D::Object *object, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
{
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        proxyApp->subscribeToEvent(object, stringhash, dyn_obj, str);
    }
}

HL_PRIM bool HL_NAME(_application_is_touch_enabled)(hl_urho3d_application *app)
{
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        return proxyApp->touchEnabled_;
    }
    return false;
}

HL_PRIM void HL_NAME(_application_set_joystick_patch_string)(hl_urho3d_application *app, vstring *vpatch_string)
{
    const char *patch_string = (char *)hl_to_utf8(vpatch_string->bytes);
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        proxyApp->SetScreenJoystickPatchString(String(patch_string));
    }
}

//  VariantMap engineParameters_;
HL_PRIM VariantMap *HL_NAME(_application_get_engine_parameters)(hl_urho3d_application *app)
{
    Urho3D::Application *ptr_app = app->ptr;
    if (ptr_app)
    {
        ProxyApp *proxyApp = (ProxyApp *)ptr_app;
        return proxyApp->GetEngineParameters();
    }
    else
    {
        return NULL;
    }
}

typedef void(hashlink_initialization)();
static hashlink_initialization *urho3d_hashlink_initialize_callback = NULL;
HL_PRIM void HL_NAME(_application_initialize_hashlink)(hl_urho3d_application *app)
{
    if (urho3d_hashlink_initialize_callback != NULL)
    {
        urho3d_hashlink_initialize_callback();
    }
}

extern "C"
{
    EXPORT void urho3d_set_hashhlink_initialization_callback(hashlink_initialization *callbackfun)
    {
        urho3d_hashlink_initialize_callback = callbackfun;
    }
}

DEFINE_PRIM(HL_URHO3D_TVARIANTMAP, _application_get_engine_parameters, HL_URHO3D_APPLICATION);
DEFINE_PRIM(_VOID, _application_initialize_hashlink, HL_URHO3D_APPLICATION);

DEFINE_PRIM(_BOOL, _application_is_touch_enabled, HL_URHO3D_APPLICATION);
DEFINE_PRIM(HL_URHO3D_APPLICATION, _create_application, URHO3D_CONTEXT _DYN);
DEFINE_PRIM(_VOID, _run_application, HL_URHO3D_APPLICATION);
DEFINE_PRIM(_VOID, _setup_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));
DEFINE_PRIM(_VOID, _start_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));
DEFINE_PRIM(_VOID, _stop_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));
DEFINE_PRIM(_VOID, _application_subscribe_to_event, HL_URHO3D_APPLICATION HL_URHO3D_STRINGHASH _DYN _STRING);
DEFINE_PRIM(_VOID, _application_subscribe_to_event_sender, HL_URHO3D_APPLICATION HL_URHO3D_OBJECT HL_URHO3D_STRINGHASH _DYN _STRING);

DEFINE_PRIM(_VOID, _application_set_joystick_patch_string, HL_URHO3D_APPLICATION _STRING);
//
