package samplygame;

import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import urho3d.UIElement.HorizontalAlignment;
import urho3d.Application;
import urho3d.actions.*;

class SamplyGame extends Application {
	private var scene:Scene = null;
	private var gameNode:Node = null;

	private var cameraNode:Node = null;

	public static var mainGame:SamplyGame = null;

	var playing:Bool = false;
	var enemies_:Enemies = null;
	var player_:Player;
	var startMenu_:StartMenu = null;
	var startMenuNode_:Node = null;
	private var coins = 0;

	private var CoinsString:String = " Coins";
	private var HealthString:String = "Health : ";
	var coinsText:Text = null;
	var healthText:Text = null;

	var drawDebug:Bool = false;

	public override function Setup() {
		trace("Setup");

		mainGame = this;
		engineParameters[EP_RESOURCE_PATHS] = "Data/SamplyGame;Data;CoreData;";
		engineParameters[EP_FULL_SCREEN] = false;
		engineParameters[EP_WINDOW_WIDTH] = 450;
		engineParameters[EP_WINDOW_HEIGHT] = 800;
		engineParameters[EP_WINDOW_TITLE] = "SamplyGame";
		engineParameters[EP_WINDOW_ICON] = "icon.png";
		engineParameters[EP_ORIENTATIONS] = "Portrait";
	}

	public override function Start() {
		Input.SetMouseVisible(true);

		CreateScene();
		SubscribeToEvents();

		CreateStartMenu();

		coinsText = new Text();
		coinsText.text = coins + CoinsString;
		coinsText.horizontalAlignment = HA_RIGHT;
		coinsText.SetFont(new Font("Fonts/Font.ttf"), Graphics.width / 30);
		UI.root.AddChild(coinsText);

		healthText = new Text();
		healthText.text = HealthString + 100 + "%";
		healthText.horizontalAlignment = HA_LEFT;
		healthText.SetFont(new Font("Fonts/Font.ttf"), Graphics.width / 30);
		UI.root.AddChild(healthText);
	}

	public function CreateScene() {
		scene = new Scene();

		scene.CreateComponent("Octree");
		scene.CreateComponent("DebugRenderer");

		var physics:PhysicsWorld = scene.CreateComponent("PhysicsWorld");
		physics.gravity = new Vector3(0.0, 0.0, 0.0);

		cameraNode = scene.CreateChild("Camera");
		var camera:Camera = cameraNode.CreateComponent("Camera");
		cameraNode.position = new Vector3(0.0, 0.0, -10.0);

		var viewport = new Viewport(scene, cameraNode.GetComponent("Camera"));
		Renderer.SetViewport(0, viewport);

		var zoneNode = scene.CreateChild("Zone");
		var zone:Zone = zoneNode.CreateComponent("Zone");
		zone.boundingBox = new BoundingBox(-300.0, 300.0);
		zone.ambientColor = new Color(1.0, 1.0, 1.0);

		scene.AddLogicComponent(new Background());

		var lightNode = scene.CreateChild("DirectionalLight");
		lightNode.position = new Vector3(0, -5, -40);
		var light:Light = lightNode.CreateComponent("Light");
		light.lightType = LIGHT_POINT;
		light.range = 120;
		light.brightness = 0.8;
	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", "HandleUpdate");
		SubscribeToEvent("PostRenderUpdate", "HandlePostRenderUpdate");
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Float = eventData["TimeStep"];
		

		if (startMenu_ != null && startMenu_.startPlay == true && playing == false) {
			playing = true;

			healthText.text = HealthString + 100 + "%";

			var playerNode:Node = scene.CreateChild("PlayerNode");
			player_ = new Player();
			playerNode.AddLogicComponent(player_);

			if (player_ != null) {
				DeleteStartMenu();
				player_.Play();

				enemies_ = new Enemies();
				scene.AddLogicComponent(enemies_);
				enemies_.SetPlayer(player_);
				enemies_.StartSpawning();

				SpawnCoins();
			}
		} else if (player_ != null && player_.IsAlive() == false) {
			// log.Warning("you died");
			playing = false;
			enemies_.KillAll();
			enemies_.RemovePlayer();
			player_ = null;
			enemies_ = null;

			InvokeDelayed(1.0, "CreateStartMenu", []);
			coins = 0;
			coinsText.text = coins + CoinsString;
		}

		// Toggle debug geometry with space
		if (Input.GetKeyPress(KEY_SPACE))
			drawDebug = !drawDebug;
	}

	public function HandlePostRenderUpdate(eventType:StringHash, eventData:VariantMap) {
		if (drawDebug)
			Renderer.DrawDebugGeometry(true);
	}

	function CreateStartMenu() {
		// log.Warning("CreateStartMenu");
		startMenuNode_ = scene.CreateChild("StartMenuNode");
		if (startMenuNode_ != null) {
			startMenu_ = new StartMenu();
			//	trace(startMenu_.className);
			startMenuNode_.AddLogicComponent(startMenu_);
		}
	}

	function DeleteStartMenu() {
		if (startMenuNode_ != null) {
			// log.Warning("DeleteStartMenu");
			startMenuNode_.Remove();
			startMenu_ = null;
		}
	}

	// spwans a coin every 4 seconds
	public function SpawnCoins() {
		if (player_ != null && player_.IsAlive()) {
			var coinNode = scene.CreateChild("coinNode");
			coinNode.position = new TVector3(Random(-2.0, 2.0), 5.0, 0);
			var coin = new Coin();
			coinNode.AddLogicComponent(coin);
			coin.FireAsync(false);
			ActionManager.AddAction(new DelayTime(4.0), coinNode, this.SpawnCoinsLoop);
		}
	}

	public function SpawnCoinsLoop(actionID:ActionID) {
		// delete coin
		actionID.DeleteTargets();

		SpawnCoins();
	}

	public function OnCoinCollected() {
		coins++;
		coinsText.text = coins + CoinsString;
	}

	public function OnPlayerHealthUpdate(health:Float) {
		// trace("OnPlayerHealthUpdate " + health);

		healthText.text = HealthString + cast(health, Int) + "%";
	}
}
