package mycompany.towerdefense.components;

class Vector2 
{
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
	}

	public function getNormalized():Vector2 
	{
		var mag:Float = getMagnitude();
		if (mag == 0)
			return new Vector2(0, 0);
		else
			return new Vector2(x / mag, y / mag);
	}

	public function getMagnitude():Float
	{
		return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
	}

	public function toString():String
	{
		return "Vector2[x: " + x + ", y: " + y + "]";
	}
}