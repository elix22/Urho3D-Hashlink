/**
MIT License

Copyright (c) 2020 Xamarin
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


class Background: GameObject
{
 
    Node @ frontTile = null, rearTile = null;
	
	float BackgroundRotationX = 45.0f;
	float BackgroundRotationY = 15.0f;
	float BackgroundScale = 300.0f;
	float BackgroundSpeed = 0.05f;
	float FlightHeight = 10.0f;

	Vector3 frontTilePos;
	Vector3 rearTilePos;	
	
	void DelayedStart()
	{
			// Background consists of two huge tiles (each BackgroundScale x BackgroundScale)
			frontTile = CreateTile(0);
			rearTile = CreateTile(1);
			frontTilePos = frontTile.position;
			rearTilePos = rearTile.position;

			CreateBackGroundMovingAction();						
	}
 
	void OnActionDone(ActionID @ actionID)
	{
		// Moving Tiles action completed so switching the tiles and creating a new one , 
		SwitchTiles();
		CreateBackGroundMovingAction();
	}

	void CreateBackGroundMovingAction()
	{
	
		float x = BackgroundScale * Sin(90 - BackgroundRotationX);
	   	float y = BackgroundScale * Sin(BackgroundRotationX) + FlightHeight;

		float moveTo = x + 1.0f; //a small adjusment to hide that gap between two tiles
	   	float h = (Tan(BackgroundRotationX)) * moveTo;

		// log.Warning("actionManager.isRunning() == false");
		ActionGroup actDef;
		actDef.Push(MoveBy(1 / BackgroundSpeed,  Vector3(0, -moveTo, -h)),frontTile);
		actDef.Push(MoveBy(1 / BackgroundSpeed,  Vector3(0, -moveTo, -h)),rearTile);
		actionManager.AddActions(actDef,CALLBACK(this.OnActionDone));			
		
	}

	void SwitchTiles()
	{
		float x = BackgroundScale * Sin(90 - BackgroundRotationX);
	   	float y = BackgroundScale * Sin(BackgroundRotationX) + FlightHeight;
		Node @ tmp = frontTile;
		frontTile = rearTile;
		rearTile = tmp;
		rearTile.position = Vector3(0, x, y);
	}
	
	Node @ CreateTile(int index)
	{
		Node @ tile = node.CreateChild();
		Node @ planeNode = tile.CreateChild();
	    planeNode.scale =  Vector3(BackgroundScale, 0.0001f, BackgroundScale);
		
		StaticModel@ planeObject = planeNode.CreateComponent("StaticModel");
		planeObject.model = cache.GetResource("Model", "Models/Plane.mdl");
		planeObject.material = cache.GetResource("Material", "Materials/Grass.xml");
		
		// area for trees:
		float sizeZ = BackgroundScale / 2.1f;
		float sizeX = BackgroundScale / 3.8f;

		Node@ treeNode = tile.CreateChild();
		treeNode.Rotate(Quaternion(0, Random(5) * 90, 0), TS_LOCAL);	
		treeNode.SetScale(0.35f);//RandomHelper.NextRandom(0.33f, 0.38f));
		StaticModel@ treeGroup = treeNode.CreateComponent("StaticModel");
		treeGroup.model = cache.GetResource("Model", "Models/Tree.mdl");
		treeGroup.material  = cache.GetResource("Material", "Materials/TreeMaterial.xml");
		
		for (float i = -sizeX; i < sizeX; i += 2.6f)
		{
			for (float j = -sizeZ; j < sizeZ; j += 3.0f)
			{
				Node@ clonedTreeNode = treeNode.Clone();
				clonedTreeNode.position =  Vector3(i + Random(-0.5f, 0.5f), 0, j);
			}
		}
		
		treeNode.Remove();
		
		tile.Rotate( Quaternion(270 + BackgroundRotationX, 0, 0), TS_LOCAL);
		tile.RotateAround(Vector3(0, 0, 0),  Quaternion(0, BackgroundRotationY, 0), TS_LOCAL);
		float tilePosX = BackgroundScale * Sin((90 - BackgroundRotationX));
		float tilePosY = BackgroundScale * Sin((BackgroundRotationX));		
		tile.position =  Vector3(0, (tilePosX + 0.01f) * index, tilePosY * index + FlightHeight);
		
		return tile;
	}
}
