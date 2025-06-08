function Shot_CommonUpdate()
{
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

function Shot_LightUpdate()
{
	if (this.hitStopTime)
	{
		this.hitStopTime--;
		return false;
	}

	this.stateLabel();
	return true;
}

