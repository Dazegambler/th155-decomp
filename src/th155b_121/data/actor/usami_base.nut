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
	mat.SetTranslation(256 + x_, 256 + (this.y / 2 + this.uv_count * 0.25000000) % 128, 0);
	this.uv.SetWorldTransform(mat);

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
		if (this.doppel == null && this.Cancel_Check(60, 200, 0, false))
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.Okult_Init(null);
			}
			else
			{
				this.Okult_Air_Init(null);
			}

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

function TeamSkillChain_Input( input_ )
{
	if (input_.command.rsv_y < 0)
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

	if (input_.command.rsv_y > 0)
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

	if (input_.command.rsv_y == 0)
	{
		if (input_.command.rsv_x * this.direction > 0)
		{
			this.SP_A_Init(null);
			this.command.ResetReserve();
			return true;
		}

		if (input_.command.rsv_x * this.direction < 0)
		{
			this.SP_F_Init(null);
			this.command.ResetReserve();
			return true;
		}

		if (input_.command.rsv_x == 0)
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

	return false;
}

function InputMove()
{
	if (this.input.b4 > 0 && this.input.x == 0 && this.input.y == 0 && this.centerStop * this.centerStop <= 1 && !this.IsGuard())
	{
		if (this.cancelLV <= 1)
		{
			this.Guard_Stance(null);
			return true;
		}
	}

	if (this.disableDash == 0)
	{
		if (this.cancelLV <= 1)
		{
			if (this.input.b4 > 0 && this.input.x * this.direction > 0 && this.input.y == 0 || this.command.Check(this.N6N6))
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					if (this.motion != 40)
					{
						if (this.change_reserve)
						{
							this.Team_ChangeReserve_Common();
							this.team.current.DashFront_Init(null);
						}
						else
						{
							this.DashFront_Init(null);
						}

						return true;
					}
				}
				else if (this.dashCount <= 1 && this.motion != 42)
				{
					if (this.change_reserve)
					{
						this.Team_ChangeReserve_Common();
						this.team.current.DashFront_Air_Init(null);
					}
					else
					{
						this.DashFront_Air_Init(null);
					}

					return true;
				}
			}

			if (this.input.b4 > 0 && this.input.x * this.direction < 0 && this.input.y == 0 || this.command.Check(this.N4N4))
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					if (this.motion != 41)
					{
						if (this.change_reserve)
						{
							this.Team_ChangeReserve_Common();
							this.team.current.DashBack_Init(null);
						}
						else
						{
							this.DashBack_Init(null);
						}

						return true;
					}
				}
				else if (this.dashCount <= 1 && this.motion != 43)
				{
					if (this.change_reserve)
					{
						this.Team_ChangeReserve_Common();
						this.team.current.DashBack_Air_Init(null);
					}
					else
					{
						this.DashBack_Air_Init(null);
					}

					return true;
				}
			}
		}

		if (this.flagState & 16384 || this.motion == 2020 && this.keyTake <= 1)
		{
			if (this.input.b4 > 0 && this.input.x * this.direction < 0 && this.input.y == 0 || this.command.Check(this.N4N4))
			{
				if (this.motion != 41 && this.centerStop * this.centerStop <= 1)
				{
					if (this.change_reserve)
					{
						this.Team_ChangeReserve_Common();
						this.team.current.DashBack_Init(null);
					}
					else
					{
						this.DashBack_Init(null);
					}

					return true;
				}

				if (this.centerStop * this.centerStop >= 4)
				{
					if (this.dashCount <= 1 && this.motion != 43)
					{
						if (this.change_reserve)
						{
							this.Team_ChangeReserve_Common();
							this.team.current.DashBack_Air_Init(null);
						}
						else
						{
							this.DashBack_Air_Init(null);
						}

						return true;
					}
				}
			}

			if (this.input.b4 > 0 && this.input.x * this.direction > 0 && this.input.y == 0 || this.command.Check(this.N6N6))
			{
				if (this.flagState & 16384 && this.centerStop * this.centerStop >= 4)
				{
					if (this.dashCount <= 1 && this.motion != 42)
					{
						if (this.change_reserve)
						{
							this.Team_ChangeReserve_Common();
							this.team.current.DashFront_Air_Init(null);
						}
						else
						{
							this.DashFront_Air_Init(null);
						}

						return true;
					}
				}
			}
		}
	}

	if (this.cancelLV <= 1)
	{
		if (this.input.b4 > 0 && this.slideCount == 0)
		{
			if (this.input.y <= -1 && this.command.ban_slide >= 0)
			{
				this.command.ban_slide = -1;
				this.SlideUp_Init(null);
				return true;
			}

			if (this.input.y >= 1 && this.command.ban_slide <= 0)
			{
				this.command.ban_slide = 1;
				this.SlideFall_Init(null);
				return true;
			}
		}
	}

	if (this.cancelLV <= 0)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.input.y <= -3)
			{
				this.SlideUp_Init(null);
				return true;
			}

			if (this.input.y >= 3)
			{
				this.SlideFall_Init(null);
				return true;
			}
		}

		if (this.input.x == 0)
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				if (this.debuff_hate.time > 0)
				{
					if (this.stateLabel != this.MoveFront)
					{
						this.MoveFront_Init(null);
					}
				}

				if (this.debuff_fear.time > 0)
				{
					if (this.stateLabel != this.MoveBack)
					{
						this.MoveBack_Init(null);
					}
				}
			}
		}
		else if (this.centerStop * this.centerStop <= 1)
		{
			if (this.input.x * this.direction > 0.00000000)
			{
				if (this.motion != 40 && this.debuff_hyper.time > 0)
				{
					this.DashFront_Init(null);
					return true;
				}
				else if (this.stateLabel != this.MoveFront)
				{
					this.MoveFront_Init(null);
				}
			}
			else if (this.stateLabel != this.MoveBack)
			{
				this.MoveBack_Init(null);
			}
		}
	}

	if (this.hitResult & 1 && this.flagState & 16384 && this.cancelLV >= 10)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.input.y <= -1)
			{
				this.hitBackFlag = 0.00000000;

				if (this.motion <= 49)
				{
					this.SlideUp_Init(null);
				}
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6) && this.team.slave_ban == 0 && this.team.slave.type != 19)
				{
					this.Team_ChangeReserve_Common();
					this.team.current.C_SlideUp_Init(null);
				}
				else
				{
					this.C_SlideUp_Init(null);
				}

				return true;
			}

			if (this.input.y >= 1)
			{
				this.hitBackFlag = 0.00000000;

				if (this.motion <= 49)
				{
					this.SlideFall_Init(null);
				}
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6) && this.team.slave_ban == 0 && this.team.slave.type != 19)
				{
					this.Team_ChangeReserve_Common();
					this.team.current.C_SlideFall_Init(null);
				}
				else
				{
					this.C_SlideFall_Init(null);
				}

				return true;
			}
		}
		else if (this.slideCount == 0)
		{
			if (this.input.y <= -1)
			{
				this.hitBackFlag = 0.00000000;

				if (this.motion <= 49)
				{
					this.SlideUp_Init(null);
				}
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6) && this.team.slave_ban == 0 && this.team.slave.type != 19)
				{
					this.Team_ChangeReserve_Common();
					this.team.current.C_SlideUp_Init(null);
				}
				else
				{
					this.C_SlideUp_Init(null);
				}

				return true;
			}

			if (this.input.y >= 1)
			{
				this.hitBackFlag = 0.00000000;

				if (this.motion <= 49)
				{
					this.SlideFall_Init(null);
				}
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6) && this.team.slave_ban == 0 && this.team.slave.type != 19)
				{
					this.Team_ChangeReserve_Common();
					this.team.current.C_SlideFall_Init(null);
				}
				else
				{
					this.C_SlideFall_Init(null);
				}

				return true;
			}
		}
	}
}

