function Mukon_Charge( val_ )
{
	if (this.mukon_se == 0)
	{
		this.PlaySE(4067);
		this.mukon_se = 3;
	}

	this.mukon_charge += val_;

	if (this.mukon_charge >= 100)
	{
		this.mukon_charge = 100;
	}

	while (this.mukon_stock.len() < this.mukon_charge / 25)
	{
		local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.Mukon_StockBall, {});
		this.mukon_stock.append(a_.weakref());
	}
}

function Update_Normal()
{
	if (this.mukon_se > 0)
	{
		this.mukon_se--;
	}

	foreach( a in this.mukon_pos )
	{
		a.RotateByRadian(0.03490658);
	}

	foreach( val_, a in this.mukon_stock )
	{
		if (a)
		{
			a.SetSpeed_XY((this.team.current.x + this.mukon_pos[val_].x - a.x) * 0.10000000, (this.team.current.y + this.mukon_pos[val_].y - a.y) * 0.10000000);
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
				this.SP_Balloon(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				this.SP_Mine_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				this.SP_Bed_Canon_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction < 0)
			{
				this.SP_Bound_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x == 0)
			{
				local t_ = {};
				t_.rush <- false;
				this.SP_Vuccum_Init(t_);
				this.command.ResetReserve();
				return true;
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
		this.SP_Balloon(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y > 0)
	{
		this.SP_Mine_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction > 0)
	{
		this.SP_Bed_Canon_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction < 0)
	{
		this.SP_Bound_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x == 0)
	{
		local t_ = {};
		t_.rush <- false;
		this.SP_Vuccum_Init(t_);
		this.command.ResetReserve();
		return true;
	}

	return false;
}

