package samplygame;


import urho3d.LogicComponent;
import urho3d.*;
import samplygame.actions.*;
import samplygame.actions.ActionManager.ActionID;
import samplygame.actions.ActionManager.ActionGroup;

class Background extends LogicComponent {
	var frontTile:Node = null;
	var rearTile:Node = null;

	final BackgroundRotationX = 45.0;
	final BackgroundRotationY = 15.0;
	final BackgroundScale = 300.0;
	final BackgroundSpeed = 0.05;
	final FlightHeight = 10.0;

	var frontTilePos = new Vector3();
	var rearTilePos = new Vector3();

	public function new(?dyn:Dynamic) {
		super(dyn);
	}

    public inline function  ToRadians(v:Float):Float
        {
            return v * 3.1415926535897932384626433832795028 / 180.0;
        }

	public override function DelayedStart() {
		trace("DelayedStart");
		frontTile = CreateTile(0);
		rearTile = CreateTile(1);
		frontTilePos = frontTile.position;
        rearTilePos = rearTile.position;
        
        CreateBackGroundMovingAction();	
    }
    
    function  OnActionDone( actionID:ActionID)
	{
        //trace("OnActionDone");
		// Moving Tiles action completed so switching the tiles and creating a new one , 
		SwitchTiles();
		CreateBackGroundMovingAction();
	}

	function CreateBackGroundMovingAction()
	{
	
		var x = BackgroundScale * Math.Sin(90 - BackgroundRotationX);
	   	var y = BackgroundScale * Math.Sin(BackgroundRotationX) + FlightHeight;

		var moveTo = x + 1.0; //a small adjusment to hide that gap between two tiles
	   	var h = (Math.Tan(BackgroundRotationX)) * moveTo;

		// log.Warning("actionManager.isRunning() == false");
		var actDef = new ActionGroup();
		actDef.Push(new MoveBy(1 / BackgroundSpeed,  new Vector3(0, -moveTo, -h)),frontTile);
		actDef.Push(new MoveBy(1 / BackgroundSpeed,  new Vector3(0, -moveTo, -h)),rearTile);
		ActionManager.actionManager.AddActions(actDef,this.OnActionDone);			
		
	}

	function SwitchTiles()
	{
		var x = BackgroundScale * Math.Sin(90 - BackgroundRotationX);
	   	var y = BackgroundScale * Math.Sin(BackgroundRotationX) + FlightHeight;
           
		var tmp = frontTile;
		frontTile = rearTile;
		rearTile = tmp;
		rearTile.position = new Vector3(0, x, y);
	}

	function CreateTile(index:Int):Node {
		var tile = node.CreateChild();
		var planeNode = tile.CreateChild();
		planeNode.scale = new Vector3(BackgroundScale, 0.0001, BackgroundScale);

		var planeObject:StaticModel = planeNode.CreateComponent("StaticModel");
		planeObject.model = new Model("Models/Plane.mdl");
		planeObject.material = new Material("Materials/Grass.xml");

		// area for trees:
		final sizeZ = BackgroundScale / 2.1;
		final sizeX = BackgroundScale / 3.8;

		var treeNode = tile.CreateChild();
		treeNode.Rotate(new Quaternion(0, Random(5) * 90, 0), TS_LOCAL);
		treeNode.scale = 0.35; // RandomHelper.NextRandom(0.33f, 0.38f));
		var treeGroup:StaticModel = treeNode.CreateComponent("StaticModel");
		treeGroup.model = new Model("Models/Tree.mdl");
		treeGroup.material = new Material("Materials/TreeMaterial.xml");

		var i = -sizeX;
		while (i < sizeX) {
			var j = -sizeZ;
			while (j < sizeZ) {
                var clonedTreeNode = treeNode.Clone();
                clonedTreeNode.position = new  Vector3(i + Random(-0.5, 0.5), 0, j);
				j += 3.0;
			}
			i += 2.6;
		}

		treeNode.Remove();

        tile.Rotate( new Quaternion(270 + BackgroundRotationX, 0, 0), TS_LOCAL);
		tile.RotateAround(new Vector3(0, 0, 0),  new Quaternion(0, BackgroundRotationY, 0), TS_LOCAL);
		var tilePosX = BackgroundScale * Math.Sin((90 - BackgroundRotationX));
		var tilePosY = BackgroundScale * Math.Sin((BackgroundRotationX));		
        tile.position =  new Vector3(0, (tilePosX + 0.01) * index, tilePosY * index + FlightHeight);
        
		return tile;
	}
}
