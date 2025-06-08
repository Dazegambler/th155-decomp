function Update_Normal()
{
	if (!this.MainLoopFirst())
	{
		if (this.IsDamage())
		{
			if (this.stateLabel)
			{
				this.stateLabel();
			}

			return true;
		}
		else
		{
			return false;
		}
	}

	this.MainLoop();
	return true;
}

function Update_Input()
{
}

function TeamSkillChain_Input( input_ )
{
	return false;
}

