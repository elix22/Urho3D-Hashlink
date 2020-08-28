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
#include "Scripts/Globals.as" 



class Weapon: GameObject
{
	bool isInited = false;
	uint LastLaunchDate = 0;
	uint ReloadDuration = 500;
	int Damage =1;
	int level = 0;
	bool IsReloading
	{
		get{
			return LastLaunchDate + ReloadDuration > time.systemTime;
		}	
	}
	

	void GetDamage( int &out  val)
	{
	 val = Damage;
	}
	
	void Start()
	{

	}
	
	void DelayedStart()
	{
	
	}

	
	void Stop()
	{

	}
	
	bool  FireAsync(bool byPlayer)
	{
		if (!isInited)
		{
			isInited = true;
			Init();
			
		}

		if (IsReloading)
		{
			return false;
		}

		LastLaunchDate = time.systemTime;
		OnFire(byPlayer);
		return true;
	}

	void OnHit(GameObject  @ target, bool killed, Node @ bulletNode)
	{
			//log.Warning("OnHit");
			RigidBody @ body = bulletNode.GetComponent("RigidBody");
			if (body !is null)
				body.enabled = false;
			bulletNode.SetScale(0);
	}


		
	void Init() { }
	
	Node  @ CreateRigidBullet(bool byPlayer, Vector3 collisionBox)
	{
		Node @ carrier = node;
		Node @ bullet = scene.CreateChild("bullet");
		bullet.position = carrier.position;
		RigidBody @ body = bullet.CreateComponent("RigidBody");
		CollisionShape  @ shape = bullet.CreateComponent("CollisionShape");
		shape.SetBox(collisionBox, Vector3(0,0,0), Quaternion());
		body.kinematic = true;
		body.collisionLayer = byPlayer ? CollisionLayers::Enemy : CollisionLayers::Player;
		bullet.vars["node"] = node;		
		return bullet;
	}
	
	Node @ CreateRigidBullet(bool byPlayer)
	{
		return CreateRigidBullet(byPlayer, Vector3(1.0f,1.0f,1.0f));
	}
	
	void OnFire(bool byPlayer)
	{
	
	}
	
}

