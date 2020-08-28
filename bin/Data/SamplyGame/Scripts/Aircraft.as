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
#include "Scripts/Weapon.as" 
#include "Scripts/Globals.as" 	
class Aircraft: GameObject
{
	int Health;
	int MaxHealth = 30;
	int level = 0;
	CollisionLayers CollisionLayer = CollisionLayers::Enemy;
	Vector3 CollisionShapeSize =  Vector3(1.2f, 1.2f, 1.2f);
	String name;
	
	bool IsAlive
	{
		get
		{
				return Health > 0/* && node.enabled*/;
				//return  node.enabled;
		}
	}
	
	void Start()
	{

	}
	
	void DelayedStart()
	{
	//	log.Warning("Aircraft::DelayedStart ");
	}
 
 

	
	void Play()
	{
	//	log.Warning("Aircraft::Play() ");
		Health = MaxHealth;
	    RigidBody@ body = node.CreateComponent("RigidBody");
		body.mass = 1;
		body.kinematic = true;
		body.collisionMask = CollisionLayer;
		CollisionShape@ shape = node.CreateComponent("CollisionShape");
		shape.SetBox(CollisionShapeSize,Vector3(0,0,0), Quaternion());
		Init();
		SubscribeToEvent(node, "NodeCollisionStart", "HandleNodeCollision");		
	}
	
	void Init() {}
	
    void HandleNodeCollision(StringHash eventType, VariantMap& eventData)
    {	
	//	log.Warning("HandleNodeCollision");
        Node@ bulletNode = eventData["OtherNode"].GetPtr();
        RigidBody@ otherBody = eventData["OtherBody"].GetPtr();
		RigidBody@ body = eventData["Body"].GetPtr();
		 
		if (IsAlive)
		{
		    Node @ weaponNode = ((bulletNode.vars["node"].GetPtr()));
			Array<Component@>@ weapons = weaponNode.GetComponents("ScriptInstance");
			for (uint i = 0; i < weapons.length; ++i)
			{
				ScriptInstance@ instance = cast<ScriptInstance>(weapons[i]);
				if(instance.IsA("Weapon"))
				{
													
				//	log.Warning(this.name+ " got damage = " + instance.className + " : " + int(damageMap[instance.className]) + ":" + Health + ":" + MaxHealth);

					int damage  = int(damageMap[instance.className]);
					Health -= damage;
					bool killed = Health <= 0;
					
					if (killed)
					{
						Explode();
					}
					else if (damage > 0)
					{
						Hit();
					}
			
					Array<Variant> parameters;
					parameters.Push(Variant(this));
					parameters.Push(Variant(killed));
					parameters.Push(Variant(bulletNode));
					instance.Execute("void OnHit(GameObject  @ target, bool killed, Node @ bulletNode)", parameters);

					if(this.name == "Player")
					{
						SendHealthUpdateToSamplyGame();
					}

				    /*assumption is that only 1 script is of type Weapon*/
					break;
				}
			}	
			
		}
		 
    }

	void SendHealthUpdateToSamplyGame() 
	{

	}

	void Hit()
	{
		StaticModel@ staticModel = node.GetComponent("StaticModel");
		Material@  material = staticModel.materials[0];
		if (material is null)
			return;
	
		material.shaderParameters["MatSpecColor"]= Variant(Color(0, 0, 0, 0));
		ValueAnimation@ specColorAnimation = ValueAnimation();
		specColorAnimation.SetKeyFrame(0.0f, Variant( Color(1.0f, 1.0f, 1.0f, 0.5f)));
		specColorAnimation.SetKeyFrame(0.1f, Variant( Color(0, 0, 0, 0)));
		material.SetShaderParameterAnimation("MatSpecColor", specColorAnimation,WM_ONCE,1.0f);
	// TBD ELI	actionManager.addAction(DelayTime(1.0f),node,CALLBACK(this.actionHitOrExplodeDone));
	}
	
	void Explode()
	{
		Health = 0;
		Node @ explosionNode = scene.CreateChild();
		SoundSource @ soundSource = explosionNode.CreateComponent("SoundSource");
		Sound@ sound = cache.GetResource("Sound", "Sounds/BigExplosion.wav");
		if (sound !is null)
		{
			soundSource.Play(sound);
			// In case we also play music, set the sound volume below maximum so that we don't clip the output
			soundSource.gain = 0.5f;
			// Set the sound component to automatically remove its scene node from the scene when the sound is done playing
			soundSource.autoRemoveMode = REMOVE_COMPONENT;
		}
		
		explosionNode.position = node.worldPosition;
		OnExplode(explosionNode);
		actionManager.RemoveAllActions(node);
		node.SetScale(0.0f);
		
		
		ActionGroup group;
		group.Push(ScaleTo(1.0f, 0.0f),explosionNode);
		group.Push(DelayTime(1.0f),explosionNode);
		actionManager.AddActions(group,CALLBACK(this.ExplodeDone));
		
	}
	
	void OnExplode(Node @ explodeNode)
	{
		explodeNode.SetScale(2.0f);
		ParticleEmitter2D @ particleEmitter = explodeNode.CreateComponent("ParticleEmitter2D");
		ParticleEffect2D@ particleEffect = cache.GetResource("ParticleEffect2D", "Particles/Explosion.pex");
		particleEmitter.effect = particleEffect;
		
	}

	void ExplodeDone(ActionID @ actionID)
	{
	
	  //  log.Warning("ExplodeDone");
		actionID.DeleteTargets();
		
		
		Array<Component@>@ weapons = node.GetComponents("ScriptInstance");				
		for (uint i = 0; i < weapons.length; ++i)
		{
			ScriptInstance@ instance = cast<ScriptInstance>(weapons[i]);
			Weapon@ weapon = cast<Weapon>(instance.scriptObject);
			if(weapon !is null)
			{
				weapon.Stop();
			}
		}
		
		actionManager.AddAction(DelayTime(5.0f),node,CALLBACK(this.DisableNode));
		
		
	}
	
	void DisableNode(ActionID @ actionID)
	{
		//log.Warning("DisableNode");
		node.enabled = false;
		node.Remove();	
	}
	
	
	void WorldCollision(VariantMap& eventData)
    {
        VectorBuffer contacts = eventData["Contacts"].GetBuffer();
        while (!contacts.eof)
        {
            Vector3 contactPosition = contacts.ReadVector3();
            Vector3 contactNormal = contacts.ReadVector3();
            float contactDistance = contacts.ReadFloat();
            float contactImpulse = contacts.ReadFloat();
        }

    }

    void ObjectCollision(GameObject@ otherObject, VariantMap& eventData)
    {
    }
	
}
