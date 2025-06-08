function Lost_Raccoon( t )
{
	this.raccoon -= t;

	if (this.raccoon <= 0)
	{
		this.raccoon = 0;
		this.revive = 900;
	}

	if (this.tanuki_gauge)
	{
		this.tanuki_gauge.func[1].call(this.tanuki_gauge, this.raccoon);
	}
}

function DamageLostRaccoon()
{
	this.Lost_Raccoon(1);
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.CommonSmoke_Core, {});
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.FallRaccoon, {});
	return true;
}

function Shapeshift( t )
{
	if (t)
	{
		if (!this.shapeshift)
		{
			this.shapeshift = true;
			this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
		}
	}
	else if (this.shapeshift)
	{
		this.shapeshift = false;
		this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
	}
}

function ShapeshiftSmoke()
{
	this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
}

function Update_Normal()
{
	if (this.spellC_Hit)
	{
		if (this.target.debuff_animal.time <= 0)
		{
			this.team.spell_time = 1;

			if (!this.team.spell_enable_end)
			{
				this.team.spell_enable_end = true;
			}

			this.spellC_Hit = false;
		}
	}

	if (this.revive > 0)
	{
		this.revive--;

		if (this.revive <= 0)
		{
			this.revive = 0;
			this.raccoon = 4;

			if (this.tanuki_gauge)
			{
				this.tanuki_gauge.func[1].call(this.tanuki_gauge, this.raccoon);
			}
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
	if (this.target.debuff_animal.time <= 0)
	{
		if (this.command_change())
		{
			return true;
		}

		if (this.team.op >= 1000 && this.team.op_stop == 0 && this.command.rsv_k01 > 0)
		{
			if (this.Cancel_Check(60, 200, 0, false))
			{
				if (this.alien.len() > 0 && this.command.rsv_x * this.direction > 0 && this.command.rsv_y == 0)
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.OkultB_Init(null);
					}
					else
					{
						this.OkultB_Air_Init(null);
					}

					this.command.ResetReserve();
					return true;
				}
				else if (this.raccoon > 0)
				{
					this.Okult_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}
		}

		if (this.command.rsv_k2 > 0 && this.raccoon > 0)
		{
			if (this.Cancel_Check(60, 200, 0, false))
			{
				if (this.command.rsv_y < 0)
				{
					this.SP_D_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_y > 0 && !this.karasaka)
				{
					this.SP_E_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_y == 0)
				{
					if (this.command.rsv_x * this.direction > 0)
					{
						this.SP_F_Init(null);
						this.command.ResetReserve();
						return true;
					}

					if (this.command.rsv_x * this.direction < 0)
					{
						if (this.centerStop * this.centerStop <= 1)
						{
							this.SP_A_Init(null);
							this.command.ResetReserve();
							return true;
						}
						else
						{
							this.SP_Taiko_Init(null);
							this.command.ResetReserve();
							return true;
						}
					}

					if (!this.command.rsv_x)
					{
						this.SP_B_Init(null);
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
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	if (input_.command.rsv_y < 0)
	{
		this.SP_D_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y > 0 && !this.karasaka)
	{
		this.SP_E_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y == 0)
	{
		if (input_.command.rsv_x * this.direction > 0)
		{
			this.SP_F_Init(null);
			this.command.ResetReserve();
			return true;
		}

		if (input_.command.rsv_x * this.direction < 0)
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.SP_A_Init(null);
				this.command.ResetReserve();
				return true;
			}
			else
			{
				this.SP_Taiko_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}

		if (!input_.command.rsv_x)
		{
			this.SP_B_Init(null);
			this.command.ResetReserve();
			return true;
		}
	}

	return false;
}

