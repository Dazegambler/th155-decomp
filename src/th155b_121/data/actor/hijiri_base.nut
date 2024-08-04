function Add_ChantCount()
{
	if (this.chant < 5)
	{
		this.chantCountBall[this.chant].func[1].call(this.chantCountBall[this.chant]);
		this.chant++;
	}
}

function Lost_ChantCount()
{
	if (this.chant > 0)
	{
		this.chant--;
		this.chantCountBall[this.chant].func[0].call(this.chantCountBall[this.chant]);
	}
}

function Set_ChantCount()
{
	for( local i = 0; i < 5; i++ )
	{
		if (i < this.chant)
		{
			this.chantCountBall[i].func[1].call(this.chantCountBall[i]);
		}
		else
		{
			this.chantCountBall[i].func[0].call(this.chantCountBall[i]);
		}
	}
}

function Move_ChantC_Orb()
{
	if (this.chantC_orb.len() > 0)
	{
		for( local i = 0; i < this.chantC_orb.len(); i++ )
		{
			if (this.chantC_orb[i] == null)
			{
				this.chantC_orb.remove(i);
				i--;
			}
			else
			{
				if (this.chantC_orb.len() == 3)
				{
					this.chantC_range += (150 - this.chantC_range) * 0,15000001.0;
				}

				local y_ = this.sin(this.chantC_rot + i * 120 * 0,01745329.0);
				this.chantC_orb[i].Warp(this.x + this.chantC_range * this.cos(this.chantC_rot + i * 120 * 0,01745329.0), this.y - 50 + this.chantC_range * 0,25000000.0 * y_);

				if (this.chantC_orb[i].drawPriority == 200 && y_ < 0)
				{
					this.chantC_orb[i].DrawActorPriority(180);
				}

				if (this.chantC_orb[i].drawPriority == 180 && y_ > 0)
				{
					this.chantC_orb[i].DrawActorPriority(200);
				}
			}
		}
	}
	else
	{
		this.chantC_range = 100;
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

	if (::battle.state == 8)
	{
		if (this.team.current != this)
		{
			this.sub_chant++;

			if (this.sub_chant >= 420)
			{
				this.sub_chant = 0;
				this.Add_ChantCount();
				this.PlaySE(1740);
			}
		}

		if (this.airByke && this.centerStop * this.centerStop <= 1)
		{
			this.airByke = false;
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
		if (this.byke == null && this.airByke == false && this.Cancel_Check(60, 200, 0, false))
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
			if (this.chant == 0)
			{
				if (this.y > this.centerY - 260)
				{
					this.SP_Chant(null);
					this.command.ResetReserve();
					return true;
				}
			}
			else
			{
				if (this.command.rsv_y < 0)
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.SP_B_Init(null);
						this.command.ResetReserve();
						return true;
					}
					else
					{
						this.SP_B_Air_Init(null);
						this.command.ResetReserve();
						return true;
					}
				}

				if (this.command.rsv_y > 0)
				{
					this.SP_C_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_y == 0)
				{
					if (this.command.rsv_x * this.direction > 0)
					{
						local t_ = {};
						t_.rush <- false;
						this.SP_D_Init(t_);
						this.command.ResetReserve();
						return true;
					}

					if (this.command.rsv_x * this.direction < 0)
					{
						if (this.centerStop * this.centerStop <= 1)
						{
							this.SP_F_Init(null);
						}
						else
						{
							this.SP_G_Init(null);
						}

						this.command.ResetReserve();
						return true;
					}

					if (this.command.rsv_x == 0)
					{
						if (this.centerStop * this.centerStop <= 1)
						{
							local t_ = {};
							t_.rush <- false;
							this.SP_A_Init(t_);
							this.command.ResetReserve();
							return true;
						}
						else
						{
							this.SP_E_Init(null);
							this.command.ResetReserve();
							return true;
						}
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

	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.motion == 40)
		{
			if (this.command.rsv_x * this.direction > 0)
			{
				if (this.command.rsv_k0 && (this.keyTake == 5 || this.keyTake == 6))
				{
					this.Atk_LowDash_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_k1 && (this.keyTake == 5 || this.keyTake == 1))
				{
					this.Atk_HighDash_Init(null);
					this.command.ResetReserve();
					return true;
				}
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
	if (this.chant == 0)
	{
		return false;
	}
	else
	{
		if (input_.command.rsv_y < 0)
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.SP_B_Init(null);
				this.command.ResetReserve();
				return true;
			}
			else
			{
				this.SP_B_Air_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}

		if (input_.command.rsv_y > 0)
		{
			this.SP_C_Init(null);
			this.command.ResetReserve();
			return true;
		}

		if (input_.command.rsv_y == 0)
		{
			if (input_.command.rsv_x * this.direction > 0)
			{
				local t_ = {};
				t_.rush <- false;
				this.SP_D_Init(t_);
				this.command.ResetReserve();
				return true;
			}

			if (input_.command.rsv_x * this.direction < 0)
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SP_F_Init(null);
				}
				else
				{
					this.SP_G_Init(null);
				}

				this.command.ResetReserve();
				return true;
			}

			if (input_.command.rsv_x == 0)
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					local t_ = {};
					t_.rush <- false;
					this.SP_A_Init(t_);
					this.command.ResetReserve();
					return true;
				}
				else
				{
					this.SP_E_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}
		}
	}

	return false;
}

