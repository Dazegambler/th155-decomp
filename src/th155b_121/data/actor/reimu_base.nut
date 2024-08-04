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
			if (this.command.rsv_x * this.direction > 0 && this.centerStop * this.centerStop <= 1)
			{
				if (this.Okult_Side_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}
			else if (this.Okult_Init(null))
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
				if (this.SP_C_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y > 0)
			{
				if (this.SP_D_Init(null))
				{
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.command.rsv_y == 0)
			{
				if (this.command.rsv_x * this.direction > 0)
				{
					if (this.SP_A_Init(null))
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
					if (this.SP_G_Init(null))
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
		if (this.SP_C_Init(null))
		{
			this.command.ResetReserve();
			return true;
		}
	}

	if (input_.command.rsv_y > 0)
	{
		if (this.SP_D_Init(null))
		{
			this.command.ResetReserve();
			return true;
		}
	}

	if (input_.command.rsv_y == 0)
	{
		if (input_.command.rsv_x * this.direction > 0)
		{
			if (this.SP_A_Init(null))
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
			if (this.SP_G_Init(null))
			{
				this.command.ResetReserve();
				return true;
			}
		}
	}

	return false;
}

function ForceSpecialCall_Init()
{
	this.EndSpellCard();
	this.team.spell_active = true;
	this.team.spell_time = 9999;
	this.team.spell_use_count = -1;
	this.team.master.spellcard.Activate("u\x253c‹­\x253c—Ç‚\x2560ˆ\x2518•Ï‰ðŒˆ›Þ—v");
	this.PlaySE(826);
	this.SetFreeObjectStencil(this.team.index == 0 ? -1480 : 1280 + 1480, 360 + 442, this.team.index == 0 ? 1,00000000.0 : -1,00000000.0, this.SpellFace, {}, this.weakref());
	return true;
}

