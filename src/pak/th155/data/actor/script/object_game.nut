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

function SetDamage( damage_ )
{
	this.life -= damage_.tointeger();
}

function SetComboDamage( atk, damage, min_scale = 0.10000000, disable_kill = false )
{
	local scale = this.team.damage_scale;
	scale = scale * this.team.base_scale;

	if (scale < min_scale)
	{
		scale = min_scale;
	}

	scale = scale * atk.owner.atkRate;
	scale = scale * atk.atkRate_Pat;
	local d = (damage * scale).tointeger();
	this.SetDamage(d);
	return d;
}

