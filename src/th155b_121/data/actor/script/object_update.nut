function Object_CommonUpdate()
{
	if (this.damageStopTime)
	{
		this.hitStopTime = 0;
		this.damageStopTime--;
		return false;
	}

	if (this.hitStopTime)
	{
		this.hitStopTime--;
		return false;
	}

	if (this.stateLabel)
	{
		this.stateLabel();
	}

	return true;
}

function Object_LightUpdate()
{
	if (this.damageStopTime)
	{
		this.hitStopTime = 0;
		this.damageStopTime--;
		return false;
	}

	if (this.hitStopTime)
	{
		this.hitStopTime--;
		return false;
	}

	this.stateLabel();
	return true;
}

