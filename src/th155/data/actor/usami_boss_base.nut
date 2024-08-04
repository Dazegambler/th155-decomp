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

	this.uv_count++;
	local mat = ::manbow.Matrix();
	local x_ = this.x * this.direction % 128;
	mat.SetTranslation(256 + x_, 256 + (this.y / 2 + this.uv_count * 0,25000000.0) % 128, 0);
	this.uv.SetWorldTransform(mat);

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
				local t_ = {};
				t_.rush <- false;

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SP_E_Init(t_);
				}
				else
				{
					this.SP_E_Air_Init(t_);
				}

				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				if (this.centerStop * this.centerStop >= 4 && this.y < this.centerY)
				{
					this.SP_B_Init(null);
					this.command.ResetReserve();
					return true;
				}
				else if (this.skillC_pole == null)
				{
					this.SP_C_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y == 0)
			{
				if (this.command.rsv_x * this.direction > 0)
				{
					this.SP_A_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_x * this.direction < 0)
				{
					this.SP_F_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_x == 0)
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.SP_D_Init(null);
						this.command.ResetReserve();
						return true;
					}
					else
					{
						this.SP_D_Init(null);
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

