package samplygame;

enum abstract CollisionLayers(Int) from Int to Int
{
	var Player = 2;
	var Enemy = 4;
}

class Globals
{
    public static var damageMap:Map<String,Int> = ["samplygame.BigWhiteCube" => 20,"samplygame.MachineGun" => 3,"samplygame.Missile"=> 8,"samplygame.SmallPlates"=> 10,"samplygame.Joysticks"=> 10,"samplygame.Coin"=> 0];
}