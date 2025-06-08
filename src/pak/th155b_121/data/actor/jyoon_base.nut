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

	local mat = ::manbow.Matrix();
	this.uv_count++;
	mat.SetTranslation(this.x * this.direction / 2 + this.uv_count * 0.20000000 % 1024, (this.y / 2 + this.uv_count * 1.50000000) % 1024, 0);
	this.uv.SetWorldTransform(mat);
	local mat2 = ::manbow.Matrix();
	mat2.SetTranslation(this.shion.x * this.direction / 2 + this.uv_count * 0.20000000 % 1024, (this.shion.y / 2 - this.uv_count * 0.50000000) % 1024, 0);
	this.uv2.SetWorldTransform(mat2);

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
	if (this.wait_input)
	{
		return;
	}

	if (this.stg_mode)
	{
		if (this.Cancel_Check(10))
		{
			this.VS_NamazuMove();
		}

		return;
	}

	if (this.command_change())
	{
		return true;
	}

	if (this.team.op >= 1000 && this.team.op_stop == 0 && this.command.rsv_k01 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.shion_act == false)
			{
				if (this.shion.motion == 5003)
				{
					this.Occult_ChangeShion(null);
				}
				else
				{
					this.Okult_Init(null);
				}

				this.command.ResetReserve();
				return true;
			}
			else
			{
				this.Occult_ChangeShion(null);
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
				this.SP_B_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				this.SP_E_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				this.SP_A_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction < 0)
			{
				this.SP_C_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x == 0)
			{
				this.SP_D_Init(null);
				this.command.ResetReserve();
				return true;
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
		this.SP_B_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y > 0)
	{
		this.SP_E_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction > 0)
	{
		this.SP_A_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction < 0)
	{
		this.SP_C_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x == 0)
	{
		this.SP_D_Init(null);
		this.command.ResetReserve();
		return true;
	}

	return false;
}

