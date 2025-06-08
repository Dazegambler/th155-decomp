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

		if (this.flagState & 16384 || this.motion == 2025)
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
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6))
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
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6))
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
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6))
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
				else if ((this.input.b3 >= 1 || this.command.rsv_k3_r > 0) && this.team.op_stop <= 0 && (this.IsAttack() == 2 || this.IsAttack() == 6))
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

function Input_CommonAttack()
{
	if (this.team.mp >= 200)
	{
		if (this.input.b1 >= 12 && this.input.b1 <= 20)
		{
			if (this.Cancel_Check(40, 200, 0, true) || this.motion >= 2000 && this.motion <= 2019)
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					local t_ = {};
					t_.ky <- this.input.y;
					t_.kx <- this.input.x;
					this.Shot_Charge_Init(t_);
					this.command.ResetReserve();
					return true;
				}
				else
				{
					local t_ = {};
					t_.ky <- this.input.y;
					t_.kx <- this.input.x;
					this.Shot_Charge_Air_Init(t_);
					this.command.ResetReserve();
					return true;
				}
			}
		}
	}

	if (this.command.rsv_k1)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.motion == 40 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0)
			{
				if (this.Cancel_Check(30))
				{
					if (this.keyTake <= 2)
					{
						this.Atk_HighDash_Init(null);
						this.command.ResetReserve();
						return true;
					}
				}
			}
		}

		if (this.team.mp > 0)
		{
			if (this.flagState & 1024 || this.Cancel_Check(45, 200, 0, false))
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					if (this.cancelLV <= 45)
					{
						if (this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0)
						{
							this.Shot_Front_Init(null);
							this.command.ResetReserve();
							return true;
						}
					}

					if (this.cancelLV <= 40)
					{
						if (this.command.rsv_y > 0)
						{
							this.Shot_Normal_Under_Init(null);
							this.command.ResetReserve();
							return true;
						}

						if (this.command.rsv_y < 0)
						{
							this.Shot_Normal_Upper_Init(null);
							this.command.ResetReserve();
							return true;
						}

						this.Shot_Normal_Init(null);
						this.command.ResetReserve();
						return true;
					}
				}
				else
				{
					if (this.cancelLV <= 45)
					{
						if (this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0)
						{
							this.Shot_Front_Air_Init(null);
							this.command.ResetReserve();
							return true;
						}
					}

					if (this.cancelLV <= 40)
					{
						if (this.command.rsv_y > 0)
						{
							this.Shot_Normal_Under_Air_Init(null);
							this.command.ResetReserve();
							return true;
						}

						if (this.command.rsv_y < 0)
						{
							this.Shot_Normal_Upper_Air_Init(null);
							this.command.ResetReserve();
							return true;
						}

						this.Shot_Normal_Air_Init(null);
						this.command.ResetReserve();
						return true;
					}
				}
			}

			if (this.command.Check(this.BB))
			{
				if (this.Cancel_Check(50, 200, 0, true) && this.motion >= 2000 && this.motion <= 2019)
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						local t_ = {};
						t_.ky <- this.input.y;
						t_.kx <- this.input.x;
						this.Shot_Burrage_Init(t_);
						this.command.ResetReserve();
						return true;
					}
					else
					{
						local t_ = {};
						t_.ky <- this.input.y;
						t_.kx <- this.input.x;
						this.Shot_Burrage_Init(t_);
						this.command.ResetReserve();
						return true;
					}
				}
			}
		}
	}

	if (this.combo_func && this.flagState & 512)
	{
		if (this.command.rsv_k0)
		{
			if (this.combo_func())
			{
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k0)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.motion == 40)
			{
				if (this.Cancel_Check(30))
				{
					if (this.keyTake <= 2)
					{
						if (this.command.rsv_x * this.direction > 0)
						{
							this.Atk_LowDash_Init(null);
							this.command.ResetReserve();
							return true;
						}
						else if (this.Cancel_Check(10))
						{
							if (this.command.rsv_x * this.direction == 0 && this.command.rsv_y == 0)
							{
								this.Atk_Mid_Init(null);
								this.command.ResetReserve();
								return true;
							}
						}
					}
					else if (this.Cancel_Check(10))
					{
						if (this.command.rsv_x * this.direction == 0 && this.command.rsv_y == 0)
						{
							this.Atk_Mid_Init(null);
							this.command.ResetReserve();
							return true;
						}
					}
				}
			}

			if (this.Cancel_Check(30))
			{
				if (this.command.rsv_y > 0)
				{
					this.Atk_HighUnder_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_y < 0)
				{
					this.Atk_HighUpper_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_x * this.direction > 0)
				{
					this.Atk_HighFront_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.Cancel_Check(10))
			{
				if (this.command.rsv_x * this.direction < 0 || this.atkRange > this.abs(this.target.x - this.x))
				{
					this.Atk_Low_Init(null);
					this.command.ResetReserve();
					return true;
				}
				else
				{
					this.Atk_Mid_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}
		}
		else
		{
			if (this.Cancel_Check(30))
			{
				if (this.command.rsv_y > 0)
				{
					this.Atk_HighUnder_Air_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_y < 0)
				{
					this.Atk_HighUpper_Air_Init(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.command.rsv_x * this.direction > 0)
				{
					this.Atk_HighFront_Air_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}

			if (this.Cancel_Check(20))
			{
				this.Atk_Mid_Air_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	return false;
}

function Input_Master()
{
	if (this.team.op == 2000 && this.team.op_stop == 0 && this.team.sp >= this.team.sp_max2 && (this.team.spell_active && this.team.spell_use_count == 0 || !this.team.spell_active))
	{
		if (this.command.rsv_k23 && this.centerStop * this.centerStop <= 1 && this.Cancel_Check(9))
		{
			if (this.Spell_Climax_Init(null))
			{
				return true;
			}
		}
	}

	if (this.spellcard.id >= 0)
	{
		if (this.team.sp >= this.team.sp_max && !this.team.spell_active)
		{
			if (this.command.rsv_k12 > 0 && this.Cancel_Check(10, 0, 0))
			{
				if (this.IsFree())
				{
					this.SpellCall_Init(null);
					this.command.ResetReserve();
					return true;
				}
			}
		}

		if (this.team.spell_active && this.command.rsv_k12 > 0)
		{
			if (this.team.spell_use_count == 0 && this.spellList[this.spellcard.id].init && (this.Cancel_Check(60, 0, 0) || this.Cancel_Check(100, 0, 0) && this.hitResult & 1))
			{
				if (this.IsAttack() == 3)
				{
					this.target.team.base_scale *= 0.85000002;
				}

				this[this.spellList[this.spellcard.id].init](null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.team.op_stop == 0 && this.team.slave_ban == 0)
	{
		if (this.command.rsv_k3 > 0)
		{
			if (this.team.op >= 1000)
			{
				if (this.IsAttack() == 3 && this.hitResult & 1 && this.Cancel_Check(100, 200, 0, false))
				{
					if (this.Team_Change_Skill())
					{
						return true;
					}
				}

				if (this.command.rsv_x * this.direction > 0 && this.command.rsv_y == 0)
				{
					if (this.IsGuard())
					{
						this.Team_Change_Counter(null);
						this.command.ResetReserve();
						return true;
					}

					if (this.IsAttack() == 4 && this.team.spell_active && this.team.spell_use_count == 1 && this.team.sp >= this.team.sp_max2 && this.Cancel_Check(200, 0, 0))
					{
						if (this.Team_Change_Spell(null))
						{
							this.command.ResetReserve();
							return true;
						}
					}

					if (this.IsAttack() == 2 && (this.Cancel_Check(60) || this.motion == 2025))
					{
						this.Team_Change_Shot(null);
						this.command.ResetReserve();
						return true;
					}

					if (this.IsAttack() == 1 && (this.Cancel_Check(60) || this.Cancel_Check(100) && this.hitResult & 1))
					{
						if (this.centerStop * this.centerStop <= 1)
						{
							this.Team_Change_Attack(null);
						}
						else
						{
							this.Team_Change_Attack_Air(null);
						}

						this.command.ResetReserve();
						return true;
					}
				}

				if (this.IsGuard())
				{
					if (this.command.rsv_x * this.direction < 0 && this.command.rsv_y == 0)
					{
						this.Team_GC_DashBack_Init(null);
						return true;
					}
				}
			}

			if (this.IsFree() && this.Cancel_Check(9) && !(this.centerStop * this.centerStop >= 2 && this.disableDash > 0))
			{
				this.Team_Change_Slave(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}
}

function Input_Slave()
{
	if (this.command.rsv_k3 > 0 && this.team.op_stop == 0)
	{
		if (this.team.op >= 1000)
		{
			if (this.IsAttack() == 3 && this.hitResult & 1 && this.Cancel_Check(100, 200, 0, false))
			{
				if (this.Team_Change_Skill())
				{
					return true;
				}
			}

			if (this.input.x * this.direction > 0 && this.input.y == 0)
			{
				if (this.IsAttack() == 2 && (this.Cancel_Check(60) || this.motion == 2025))
				{
					this.Team_Change_Shot(null);
					this.command.ResetReserve();
					return true;
				}

				if (this.IsAttack() == 1 && (this.Cancel_Check(60) || this.Cancel_Check(100) && this.hitResult & 1))
				{
					if (this.centerStop * this.centerStop <= 1)
					{
						this.Team_Change_Attack(null);
					}
					else
					{
						this.Team_Change_Attack_Air(null);
					}

					this.command.ResetReserve();
					return true;
				}
			}
		}

		if (this.IsFree() && this.Cancel_Check(9) && !(this.centerStop * this.centerStop >= 2 && this.disableDash > 0))
		{
			this.Team_Change_Master(null);
			this.command.ResetReserve();
			return true;
		}
	}
}

