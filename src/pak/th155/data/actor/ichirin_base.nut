function Update_Normal()
{
	if (this.unzanReload > 0)
	{
		this.unzanReload--;

		if (this.unzanReload <= 0)
		{
			this.unzan = true;
		}
	}

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

	if (this.team.op >= 1000 && this.team.op_stop == 0 && this.team.master == this && this.command.rsv_k01 > 0)
	{
		if (!this.hassyaku && this.Cancel_Check(60, 200, 0, false))
		{
			local t_ = {};
			t_.k <- 0;

			if (this.command.rsv_x * this.direction > 0)
			{
				t_.k = 1.00000000;
			}

			if (this.command.rsv_x * this.direction < 0)
			{
				t_.k = -1.00000000;
			}

			if (this.Okult_Init(t_))
			{
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y < 0)
			{
				if (this.centerStop * this.centerStop >= 4 && this.y < this.centerY)
				{
					if (this.SP_RingFlight_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}
				else if (this.SP_B_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y > 0)
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					if (this.SP_A_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}
				else if (this.SP_A_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y == 0)
			{
				if (this.command.rsv_x * this.direction > 0)
				{
					if (this.SP_G_Init(null))
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
					if (this.SP_D_Init(null))
					{
						this.command.ResetReserve();
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
	if (input_.command.rsv_y < 0)
	{
		if (this.centerStop * this.centerStop >= 4 && this.y < this.centerY)
		{
			if (this.SP_RingFlight_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}
		else if (this.SP_B_Init(null))
		{
			this.command.ResetReserve();
			return true;
		}
	}

	if (input_.command.rsv_y > 0)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.SP_A_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}
		else if (this.SP_A_Init(null))
		{
			this.command.ResetReserve();
			return true;
		}
	}

	if (input_.command.rsv_y == 0)
	{
		if (input_.command.rsv_x * this.direction > 0)
		{
			if (this.SP_G_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}

		if (input_.command.rsv_x * this.direction < 0)
		{
			if (this.SP_E_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}

		if (input_.command.rsv_x == 0)
		{
			if (this.SP_D_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}
	}

	return false;
}

