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
		if (this.cpuState)
		{
			this.cpuState();
		}

		if (this.input && this.team.current == this)
		{
			this.Update_Input();
		}
	}

	this.MainLoop();
	return true;
}

function Update_Input()
{
	if (this.command_change())
	{
		return true;
	}

	if (this.team.op >= 1000 && this.team.op_stop == 0 && this.command.rsv_k01 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			this.Okult_Init(null);
			this.command.ResetReserve();
			return true;
		}
	}

	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y > 0 && this.Cancel_Check(60, 200, 0, false))
			{
				local t_ = {};
				t_.rush <- false;
				this.SP_C_Init(t_);
				return true;
			}

			if (this.command.rsv_y < 0 && this.Cancel_Check(60, 200, 0, false))
			{
				this.SP_B_Init(null);
				return true;
			}

			if (this.command.rsv_y == 0)
			{
				if (!this.tiger && this.command.rsv_x * this.direction > 0 && this.Cancel_Check(60, 200, 0, false))
				{
					this.SP_A_Init(null);
					return true;
				}

				if (!this.dragon && this.command.rsv_x * this.direction < 0 && this.Cancel_Check(60, 200, 0, false))
				{
					this.SP_E_Init(null);
					return true;
				}

				if (!this.seals && this.command.rsv_x == 0 && this.Cancel_Check(60, 1, 0, false))
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.SP_D_Init(null);
						return true;
					}
					else
					{
						this.SP_D_Air_Init(null);
						return true;
					}
				}
			}
		}
	}

	if (this.command.rsv_k0 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0 && this.centerStop * this.centerStop <= 1 && this.target.centerStop * this.target.centerStop <= 1 && this.abs(this.target.x - this.x) <= 90)
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

function TeamSkillChain_Input( input_ )
{
	if (input_.command.rsv_y > 0)
	{
		local t_ = {};
		t_.rush <- false;
		this.SP_C_Init(t_);
		return true;
	}

	if (input_.command.rsv_y < 0)
	{
		this.SP_B_Init(null);
		return true;
	}

	if (input_.command.rsv_y == 0)
	{
		if (!this.tiger && input_.command.rsv_x * this.direction > 0)
		{
			this.SP_A_Init(null);
			return true;
		}

		if (!this.dragon && input_.command.rsv_x * this.direction < 0)
		{
			this.SP_E_Init(null);
			return true;
		}

		if (!this.seals && input_.command.rsv_x == 0)
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.SP_D_Init(null);
				return true;
			}
			else
			{
				this.SP_D_Air_Init(null);
				return true;
			}
		}
	}

	return false;
}

