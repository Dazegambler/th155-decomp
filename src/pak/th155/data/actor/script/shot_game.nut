function ConvertTotalSpeed()
{
	this.vx = this.va.x;
	this.vy = this.va.y;
}

function ResetSpeed()
{
	this.vx = 0.00000000;
	this.vy = 0.00000000;
	this.va.x = 0.00000000;
	this.va.y = 0.00000000;
	this.ConvertTotalSpeed();
}

