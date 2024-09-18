function IsFree()
{
	if (this.motion <= 89)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function IsRecover()
{
	if (this.motion >= 30 && this.motion <= 39)
	{
		return 1;
	}

	return 0;
}

function IsDamage()
{
	if (this.motion >= 200 && this.motion <= 202 || this.motion == 130 || this.motion == 131)
	{
		return 1;
	}
	else if (this.motion >= 203 && this.motion <= 399)
	{
		return 2;
	}

	return 0;
}

function IsDown()
{
	if (this.motion >= 211 && this.motion <= 214 && this.keyTake == 6)
	{
		return true;
	}

	if (this.motion == 225 && this.keyTake == 4)
	{
		return true;
	}

	if (this.motion == 290 && this.keyTake == 1)
	{
		return true;
	}

	if (this.motion == 308 && this.keyTake == 0)
	{
		return true;
	}

	return false;
}

function IsGuard()
{
	if (this.motion >= 120 && this.motion <= 129)
	{
		return 3;
	}

	if (this.motion >= 110 && this.motion <= 119)
	{
		return 2;
	}

	if (this.motion >= 100 && this.motion <= 109)
	{
		return 1;
	}

	return 0;
}

function IsAttack()
{
	if (this.motion >= 4000 && this.motion <= 4999)
	{
		if (this.motion >= 4900)
		{
			return 5;
		}
		else
		{
			return 4;
		}
	}
	else if (this.motion >= 3910 && this.motion <= 3980)
	{
		return 6;
	}
	else if (this.motion >= 3000 && this.motion <= 3909)
	{
		return 3;
	}
	else if (this.motion >= 2000 && this.motion <= 2999)
	{
		return 2;
	}
	else if (this.motion >= 1000)
	{
		return 1;
	}

	return 0;
}

function IsCenter( y_ )
{
	local a = this.y - this.centerY;

	if (this.abs(a) <= y_)
	{
		return 0.00000000;
	}
	else if (a > 0)
	{
		return 1.00000000;
	}
	else
	{
		return -1.00000000;
	}
}

function Cancel_Check( cl_, mp_ = 0, sp_ = 0, free_ = false )
{
	if (mp_ > 0 && this.team.mp < mp_ || sp_ > 0 && this.team.sp < sp_)
	{
		return false;
	}

	if (this.cancelLV <= 0)
	{
		return true;
	}
	else if (this.cancelLV <= cl_ && this.flagState & 32)
	{
		if (this.cancelLV <= 9 || (this.cancelLV >= 10 && this.hitResult || free_) && !(this.hitResult & 16))
		{
			return true;
		}
	}

	return false;
}

