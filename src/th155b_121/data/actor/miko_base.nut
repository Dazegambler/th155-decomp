function SetMantType( type_ )
{
	switch(type_)
	{
	case 1:
		this.uv.SetMotion(9902, 0);
		this.style = 1;
		break;

	case 2:
		this.uv.SetMotion(9900, 0);
		this.style = 2;
		break;

	default:
		this.uv.SetMotion(9901, 0);
		this.style = 0;
		break;
	}
}

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
	mat.SetTranslation(this.x * this.direction / 2 + this.uv_count * 0,20000000.0 % 1024, (this.y / 2 + this.uv_count * 0,20000000.0) % 1024, 0);
	this.uv.SetWorldTransform(mat);

	if (::battle.state == 8)
	{
		if (this.warpCount > 0 && this.centerStop * this.centerStop <= 1)
		{
			this.warpCount = 0;
		}

		if (this.styleTime > 0 && this.styleTime < 1000)
		{
			this.styleTime--;

			if (this.styleTime <= 0)
			{
				foreach( a in this.styleAura )
				{
					if (a)
					{
						a.func[0].call(a);
					}
				}

				this.styleAura = [];
				this.SetMantType(-1);
			}
		}

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
			if (this.command.rsv_y < 0)
			{
				this.SP_D_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				local t_ = {};
				t_.kx <- this.command.rsv_x;
				this.SP_E_Init(t_);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y == 0)
			{
				if (this.command.rsv_x * this.direction > 0)
				{
					this.SP_B_Init(null);
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
					if (this.centerStop * this.centerStop >= 2)
					{
						this.SP_F_Init(null);
						this.command.ResetReserve();
						return true;
					}
					else if (this.warpCount == 0)
					{
						this.SP_A_Init(null);
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
		this.SP_D_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y > 0)
	{
		local t_ = {};
		t_.kx <- input_.command.rsv_x;
		this.SP_E_Init(t_);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y == 0)
	{
		if (input_.command.rsv_x * this.direction > 0)
		{
			this.SP_B_Init(null);
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
			if (this.centerStop * this.centerStop >= 2)
			{
				this.SP_F_Init(null);
				this.command.ResetReserve();
				return true;
			}
			else if (this.warpCount == 0)
			{
				this.SP_A_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	return false;
}

