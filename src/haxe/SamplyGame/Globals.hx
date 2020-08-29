package samplygame;

enum abstract CollisionLayers(Int) 
{
	var Player = 2;
	var Enemy = 4;
}

class Globals
{
    public static var damageMap:Map<String,Int> = ["BigWhiteCube" => 20,"MachineGun" => 3,"Missile"=> 8,"SmallPlates"=> 10,"Joysticks"=> 10,"Coin"=> 0];
}