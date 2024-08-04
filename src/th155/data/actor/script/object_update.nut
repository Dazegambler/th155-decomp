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

