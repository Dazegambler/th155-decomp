function Vanish_Sword()
{
	if (this.sword)
	{
		this.sword.func();
		this.sword = null;
	}
}

function Update_Normal()
{
	if (this.occult_time > 0)
	{
		this.occult_cycle--;

		if (this.target.centerStop * this.target.centerStop >= 2 && this.target.y < this.centerY)
		{
			this.occult_cycle -= 4;
		}

		if (this.occult_cycle <= 0)
		{
			this.occult_cycle = 360;
			this.SetShot(this.target.x, this.target.y, this.direction, this.Shot_Occult_Lightning, {});
		}

		this.occult_time--;

		if (this.occult_time <= 0 || this.IsDamage() || ::battle.state != 8)
		{
			if (this.occult_back)
			{
				this.occult_back.func[0].call(this.occult_back);
			}

			this.occult_time = 0;
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

		if (this.momo_time > 0 && this.team.current == this)
		{
			this.momo_time--;

			if (this.IsDamage() && this.motion != 131 && (this.motion <= 299 || this.motion >= 312))
			{
				this.momo_time = 0;
			}

			if (this.momo_time <= 0)
			{
				if (this.momo_aura)
				{
					this.momo_aura.func[0].call(this.momo_aura);
				}

				this.armor = 0;
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

	if (this.occult_time == 0 && this.team.op >= 1000 && this.team.op_stop == 0 && this.command.rsv_k01 > 0)
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
				this.SP_Kaname_Jump(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				this.SP_Hisou_Slash(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				this.SP_Ikou_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction < 0)
			{
				this.SP_Kaname_Crash_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x == 0)
			{
				this.SP_Koma_Init(null);
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
		this.SP_Kaname_Jump(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y > 0)
	{
		this.SP_Hisou_Slash(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction > 0)
	{
		this.SP_Ikou_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction < 0)
	{
		this.SP_Kaname_Crash_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x == 0)
	{
		this.SP_Koma_Init(null);
		this.command.ResetReserve();
		return true;
	}

	return false;
}

