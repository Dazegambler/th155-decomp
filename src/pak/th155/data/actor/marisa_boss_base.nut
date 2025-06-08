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

	if (::battle.state == 8)
	{
		if (this.boss_cpu)
		{
			this.boss_cpu();
		}
		else if (this.cpuState)
		{
			this.cpuState();

			if (this.input && this.team.current == this)
			{
				this.Update_Input();
			}
		}
	}

	this.MainLoop();
	return true;
}

function Update_Input()
{
	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y < 0)
			{
				if (this.centerStop * this.centerStop >= 4)
				{
					if (this.SP_D_Air_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}
				else if (this.SP_D_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y > 0)
			{
				if (this.SP_B_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y == 0)
			{
				if (this.command.rsv_x * this.direction > 0)
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						if (this.SP_A_Init(null))
						{
							this.command.ResetReserve();
							return true;
						}
					}
					else if (this.SP_A_Air_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}

				if (this.command.rsv_x * this.direction < 0)
				{
					if (this.SP_E_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}

				if (this.command.rsv_x == 0)
				{
					if (this.SP_F_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}
			}
		}
	}

	if (this.command.rsv_k0 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0 && this.centerStop * this.centerStop <= 1 && this.target.centerStop * this.target.centerStop <= 1 && this.abs(this.target.x - this.x) <= 60)
	{
		if (this.team.current.target.invinGrab == 0 && !(this.target.flagState & 8192) && !this.target.IsDamage())
		{
			if (this.Cancel_Check(1))
			{
				this.Atk_Grab_Init(null);
				return true;
			}
		}
	}

	if (this.Input_CommonAttack())
	{
		return true;
	}

	this.InputMove();
}

