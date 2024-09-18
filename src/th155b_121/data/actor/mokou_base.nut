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

	if (this.occultCount > 0)
	{
		if (this.IsDamage())
		{
			this.team.enable_regain = true;
			this.occultCount = 0;
			this.atkRate = 1.00000000;
			this.occult_level = 0;
		}
		else if (this.team.life <= 1)
		{
			this.team.enable_regain = true;
			this.occultCount = 0;
			this.atkRate = 1.00000000;
			this.occult_level = 0;
		}
		else
		{
			this.occultEffect--;
			this.occultCount++;

			if (this.occultEffect <= 0)
			{
				this.SetFreeObject(this.x, this.y - 35, this.direction, this.Occult_BurnPilar, {});
				this.occultEffect = 20 + this.rand() % 21;
			}

			if (this.occult_level < 4 && (this.occultCount == 180 || this.occultCount == 360 || this.occultCount == 540))
			{
				this.PlaySE(3241);
				this.occult_level++;
				this.atkRate = 1.04999995 + this.occult_level * 0.05000000;

				switch(this.occult_level)
				{
				case 0:
					this.occult_cycle = 40;
					break;

				case 1:
					this.occult_cycle = 20;
					break;

				case 2:
					this.occult_cycle = 10;
					break;

				default:
					this.occult_cycle = 5;
					break;
				}

				this.Occult_FireStart();
			}

			if (this.occultCount % this.occult_cycle == 1)
			{
				this.SetSelfDamage(25);
			}
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
			if (this.occultCount >= 10)
			{
				if (this.OkultB_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.occultCount == 0)
			{
				if (this.Okult_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}
		}
	}

	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y < 0)
			{
				if (this.centerStop <= -2)
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
				if (this.SP_A_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y == 0)
			{
				if (this.command.rsv_x * this.direction > 0)
				{
					local t_ = {};
					t_.rush <- false;

					if (this.SP_C_Init(t_))
					{
						this.command.ResetReserve();
						return true;
					}
				}

				if (this.command.rsv_x * this.direction < 0)
				{
					if (this.SP_B_Init(null))
					{
						this.command.ResetReserve();
						return true;
					}
				}

				if (this.command.rsv_x == 0)
				{
					if (this.SP_E_Init(null))
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

function TeamSkillChain_Input( input_ )
{
	if (input_.command.rsv_y < 0)
	{
		if (this.centerStop <= -2)
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

	if (input_.command.rsv_y > 0)
	{
		if (this.SP_A_Init(null))
		{
			this.command.ResetReserve();
			return true;
		}
	}

	if (input_.command.rsv_y == 0)
	{
		if (input_.command.rsv_x * this.direction > 0)
		{
			local t_ = {};
			t_.rush <- false;

			if (this.SP_C_Init(t_))
			{
				this.command.ResetReserve();
				return true;
			}
		}

		if (input_.command.rsv_x * this.direction < 0)
		{
			if (this.SP_B_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}

		if (input_.command.rsv_x == 0)
		{
			if (this.SP_E_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}
	}

	return false;
}

