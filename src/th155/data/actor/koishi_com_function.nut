function CPU_MoveBase()
{
	this.com_dash = 0.00000000;
	this.com_rand[2] = this.rand() % 100;
	local d_ = this.abs(this.targetDist);

	if (this.IsDamage() || this.IsGuard())
	{
		this.com_guard_stance = 15 + this.rand() % 10;
	}

	if (this.x < ::battle.corner_left + 100 && this.direction == 1.00000000 || this.x > ::battle.corner_right - 100 && this.direction == -1.00000000)
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (d_ <= 200)
			{
				if (this.com_rand[2] <= 65)
				{
					this.CPU_Wait(-15);
					return;
				}
				else
				{
					this.CPU_EscapeWall(-10);
					return;
				}
			}
		}
		else if (d_ <= 100)
		{
			if (this.com_rand[2] <= 40)
			{
				this.CPU_Wait(-15);
				return;
			}
			else
			{
				this.CPU_EscapeWall(-15);
				return;
			}
		}
	}

	if (this.com_difficulty == 0)
	{
		if (this.com_rand[2] <= 25)
		{
			this.CPU_Wait(-90 - this.rand() % 30);
			return;
		}

		if (this.com_rand[2] <= 50)
		{
			this.CPU_CenterWaitFar(-90 - this.rand() % 30);
			return;
		}

		this.com_rand[2] = this.rand() % 100;
	}

	if (this.com_difficulty == 1)
	{
		if (this.com_rand[2] <= 15)
		{
			this.CPU_Wait(-60 - this.rand() % 30);
			return;
		}

		if (this.com_rand[2] <= 25)
		{
			this.CPU_CenterWaitFar(-90 - this.rand() % 30);
			return;
		}

		this.com_rand[2] = this.rand() % 100;
	}

	if (this.centerStop * this.centerStop <= 1)
	{
		if (d_ <= 75)
		{
			if (this.com_rand[2] <= 15)
			{
				this.CPU_CenterWaitFar(-30 - this.rand() % 30);
				return;
			}

			if (this.com_rand[2] <= 50)
			{
				this.CPU_DashBack(-10);
				return;
			}

			if (this.com_rand[2] <= 65)
			{
				this.CPU_Walk(-30, -this.direction);
				return;
			}

			if (this.com_rand[2] <= 95)
			{
				this.CPU_Slide(-10 + this.rand() % 5, this.rand() % 10 <= 5 ? 0 : -this.direction, this.rand() % 10 <= 4 ? 1 : -1);
				return;
			}

			if (this.CPU_CenterWait(-20 - this.rand() % 20))
			{
				return;
			}
		}

		if (d_ > 75 && d_ <= 250)
		{
			if (this.com_rand[2] <= 15)
			{
				this.CPU_WalkA(-60 + this.rand() % 30);
				return;
			}

			if (this.com_rand[2] <= 55)
			{
				this.CPU_Slide(-30 + this.rand() % 20, this.rand() % 10 <= 7 ? 0 : -this.direction, this.rand() % 10 <= 4 ? 1 : -1);
				return;
			}

			if (this.target.IsFree())
			{
				if (this.CPU_DashBack(-10))
				{
					return;
				}
			}
		}

		if (d_ > 250 && d_ >= 600)
		{
			if (this.rand() % 100 == 25)
			{
				this.CPU_DashFront(-45);
				return;
			}
		}

		if (this.CPU_CheckEnemyPos([
			23,
			26,
			29
		]))
		{
			if (this.com_rand[2] <= 25)
			{
				if (this.CPU_WalkA(-60 + this.rand() % 30))
				{
					return;
				}
			}

			if (this.com_rand[2] <= 80)
			{
				if (this.rand() % 100 <= 49)
				{
					this.CPU_Slide(-30 + this.rand() % 20, this.direction, -10);
					return;
				}
				else
				{
					this.CPU_Slide(-30 + this.rand() % 20, this.direction, 10);
					return;
				}
			}
			else
			{
				this.CPU_DashFront(-30 - this.rand() % 60);
				return;
			}
		}

		if (this.CPU_CheckEnemyPos([
			16,
			19
		]))
		{
			if (this.com_rand[2] <= 33)
			{
				this.CPU_Walk(-30 - this.rand() % 30, this.direction);
				return;
			}
		}

		if (this.com_rand[2] <= 40)
		{
			if (this.rand() % 100 <= 49)
			{
				this.CPU_Slide(-30 + this.rand() % 20, this.direction, -10);
				return;
			}
			else
			{
				this.CPU_Slide(-30 + this.rand() % 20, this.direction, 10);
				return;
			}
		}
		else if (this.CPU_CenterWaitFar(-30 - this.rand() % 30))
		{
			return;
		}
	}
	else
	{
		if (this.com_rand[2] <= 33)
		{
			this.CPU_Wait(-30 - this.rand() % 45);
			return;
		}

		if (d_ <= 200)
		{
			if (this.rand() % 100 <= 25)
			{
				if (this.target.IsFree())
				{
					if (this.CPU_DashBack(-30))
					{
						return;
					}
				}
			}
			else
			{
				this.CPU_Wait(-35 - this.rand() % 15);
				return;
			}
		}

		if (d_ <= 300)
		{
			if (this.rand() % 100 <= 50)
			{
				if (this.target.IsFree())
				{
					if (this.CPU_DashFront(-30))
					{
						return;
					}
				}
			}
		}

		if (this.CPU_CheckEnemyPos([
			13,
			19
		]))
		{
			this.CPU_DashFront(-25);
			return;
		}
	}
}

function CPU_CenterWait( wait_ )
{
	this.com_rand[2] = this.rand() % 10;
	this.com_count[2] = wait_;
	this.com_subState[2] = function ()
	{
		if (this.com_count[2] > 0 || this.centerStop * this.centerStop >= 4)
		{
			return true;
		}

		if (this.com_rand[2] <= 3)
		{
			if (this.com_keyFlag.x >= 0 && this.targetDist <= (this.direction == 1.00000000 ? 50 : -400))
			{
				this.com_keyFlag.x = -1;
			}

			if (this.com_keyFlag.x <= 0 && this.targetDist >= (this.direction == 1.00000000 ? 400 : -50))
			{
				this.com_keyFlag.x = 1;
			}
		}
		else
		{
			if (this.com_keyFlag.x >= 0 && this.targetDist <= (this.direction == 1.00000000 ? 100 : -250))
			{
				this.com_keyFlag.x = -1;
			}

			if (this.com_keyFlag.x <= 0 && this.targetDist >= (this.direction == 1.00000000 ? 250 : -100))
			{
				this.com_keyFlag.x = 1;
			}
		}

		this.input.x = this.com_keyFlag.x;
		this.input.y = 0;
	};
}

function CPU_CenterWaitFar( wait_ )
{
	this.com_rand[2] = this.rand() % 10;
	this.com_count[2] = wait_;
	this.com_subState[2] = function ()
	{
		if (this.com_count[2] > 0 || this.centerStop * this.centerStop >= 4)
		{
			return true;
		}

		if (this.com_rand[2] <= 6)
		{
			if (this.com_keyFlag.x >= 0 && this.targetDist <= (this.direction == 1.00000000 ? 200 : -600))
			{
				this.com_keyFlag.x = -1;
			}

			if (this.com_keyFlag.x <= 0 && this.targetDist >= (this.direction == 1.00000000 ? 600 : -200))
			{
				this.com_keyFlag.x = 1;
			}
		}
		else
		{
			if (this.com_keyFlag.x >= 0 && this.targetDist <= (this.direction == 1.00000000 ? 325 : -450))
			{
				this.com_keyFlag.x = -1;
			}

			if (this.com_keyFlag.x <= 0 && this.targetDist >= (this.direction == 1.00000000 ? 450 : -325))
			{
				this.com_keyFlag.x = 1;
			}
		}

		this.input.x = this.com_keyFlag.x;
		this.input.y = 0;
	};
}

function CPU_WalkA( wait_ )
{
	this.com_count[2] = wait_;
	this.com_rand[2] = this.rand() % 10;
	this.com_subState[2] = function ()
	{
		if (this.com_count[2] > 0 || this.centerStop * this.centerStop >= 4 || this.com_enemyPos == 0)
		{
			return true;
		}

		switch(this.com_enemyPos)
		{
		case 5:
			if (this.abs(this.targetDist) <= 60)
			{
				this.com_subState[2] = function ()
				{
					this.input.x = -this.direction;

					if (this.com_count[2] > 0)
					{
						return true;
					}
				};
				return;
			}

			this.input.x = this.direction;
			break;

		case 8:
		case 2:
			if (this.com_rand[2] <= 6)
			{
				this.com_subState[2] = function ()
				{
					this.input.x = -this.direction;

					if (this.com_count[2] > 0)
					{
						return true;
					}
				};
			}
			else
			{
				this.com_subState[2] = function ()
				{
					this.input.x = this.direction;

					if (this.com_count[2] > 0 || this.abs(this.targetDist) <= 75)
					{
						return true;
					}
				};
			}

			break;

		case 16:
			if (this.com_rand[2] <= 7)
			{
				this.input.x = this.direction;
			}
			else
			{
				this.input.x = -this.direction;
			}

			break;

		case 13:
		case 19:
			if (this.com_rand[2] <= 6)
			{
				this.input.x = this.direction;
			}
			else
			{
				this.input.x = -this.direction;
			}

			break;

		case 12:
		case 18:
			if (this.target.x - this.x > 0.00000000)
			{
				this.input.x = -1.00000000;
			}
			else
			{
				this.input.x = 1.00000000;
			}

			break;

		default:
			this.input.x = this.direction;
			break;
		}
	};
}

function CPU_AttackBase()
{
	if (this.com_subState[2] == this.CPU_MoveStopUpdate)
	{
		this.com_count[2] = 1;
	}

	if (!this.team.spell_active)
	{
		if (this.team.sp >= this.team.sp_max && this.rand() % 100 <= 1 || this.team.sp >= this.team.sp_max * 2 && this.target.team.combo_stun >= 100)
		{
			this.CPU_SpellCall(-60);
			return;
		}
	}

	if (!this.IsFree() || this.target.team.combo_stun >= 100 || this.com_sleep > 0 || this.target.IsDamage() > 1 && this.target.recover <= 0 || this.target.IsRecover())
	{
		return;
	}
	else
	{
		if (this.rand() % 80 >= this.com_level)
		{
			return;
		}

		if (this.com_aggro_stance <= 0)
		{
			if (this.rand() % 100 >= 5)
			{
				return;
			}
		}

		if (this.team.spell_active)
		{
			if (this.CPU_CheckSpell())
			{
				return;
			}
		}

		this.com_rand[3] = this.rand() % 100;
		local d_ = this.abs(this.targetDist);

		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.com_difficulty == 0)
			{
				if (this.com_rand[3] <= 10)
				{
					this.CPU_AtkFool(-60);
					return;
				}

				if (this.com_rand[3] <= 30 && this.com_enemyPos >= 20)
				{
					this.CPU_AtkUpper(-60);
					return;
				}

				if (this.com_rand[3] <= 50 && this.com_enemyPos >= 20)
				{
					this.CPU_AtkUnder(-60);
					return;
				}

				this.com_rand[3] = this.rand() % 100;
			}

			if (d_ <= 75)
			{
				if (this.CPU_CheckEnemyPos([
					2,
					5
				]))
				{
					this.CPU_AtkLow(-15);
					return;
				}

				if (this.com_rand[3] <= 2)
				{
					if (this.CPU_CheckEnemyPos([
						5,
						8
					]) && this.target.IsAttack())
					{
						this.CPU_SkillC(-25);
						return;
					}
				}
			}

			if (d_ <= 150)
			{
				if (this.CPU_CheckEnemyPos([
					16
				]))
				{
					this.CPU_AtkDashLow(-25);
					return;
				}

				if (this.com_rand[3] <= 66)
				{
					if (this.CPU_CheckEnemyPos([
						8,
						16,
						19
					]))
					{
						this.CPU_AtkMid(-25);
						return;
					}
				}
				else if (this.CPU_CheckEnemyPos([
					8,
					16,
					18,
					19
				]))
				{
					this.CPU_AtkUpper(-25);
					return;
				}
			}

			if (d_ <= 225)
			{
				if (this.CPU_CheckEnemyPos([
					6,
					16
				]))
				{
					this.CPU_AtkDashLow(-30);
					return;
				}

				if (this.CPU_CheckEnemyPos([
					5,
					16
				]))
				{
					this.CPU_AtkMid(-25);
					return;
				}

				if (this.CPU_CheckEnemyPos([
					2,
					12,
					13
				]))
				{
					this.CPU_AtkUnder(-25);
					return;
				}

				if (this.CPU_CheckEnemyPos([
					8,
					18,
					19
				]))
				{
					this.CPU_AtkUpper(-25);
					return;
				}
			}

			if (d_ <= 400)
			{
				if (this.com_rand[3] <= 25)
				{
					if (this.CPU_CheckEnemyPos([
						5,
						9,
						16
					]))
					{
						this.CPU_Shot(-25);
						return;
					}
				}

				if (this.com_rand[3] <= 40)
				{
					if (this.CPU_CheckEnemyPos([
						16.26000023
					]))
					{
						this.CPU_ShotFront(-25);
						return;
					}
				}

				if (this.CPU_CheckEnemyPos([
					16
				]))
				{
					this.CPU_AtkFront(-25);
					return;
				}

				if (this.CPU_CheckEnemyPos([
					5,
					8,
					9,
					16,
					19
				]))
				{
					this.CPU_AtkMid(-25);
					return;
				}
			}
			else
			{
				if (this.com_rand[3] <= 0)
				{
					if (this.CPU_SkillO(-25))
					{
						return;
					}
				}

				if (this.com_rand[3] <= 3)
				{
					if (this.CPU_CheckEnemyPos([
						16,
						26,
						13,
						19,
						23,
						26,
						29
					]))
					{
						this.CPU_SkillA(-25);
						return;
					}
				}

				if (this.com_rand[3] <= 6)
				{
					if (this.CPU_CheckEnemyPos([
						16,
						26,
						13,
						19,
						23,
						26,
						29
					]))
					{
						this.CPU_SkillB(-25);
						return;
					}
				}
			}

			this.com_rand[3] = this.rand() % 100;

			if (this.com_rand[3] <= 5)
			{
				this.CPU_ShotCharge(-40);
				return;
			}

			if (this.com_rand[3] <= 35)
			{
				if (this.CPU_CheckEnemyPos([
					13,
					16,
					19,
					23,
					26,
					29
				]))
				{
					this.CPU_Shot(-25);
					return;
				}
			}

			if (this.com_rand[3] <= 45)
			{
				if (this.CPU_CheckEnemyPos([
					16,
					26
				]))
				{
					this.CPU_ShotFront(-25);
					return;
				}
			}

			if (this.CPU_CheckEnemyPos([
				6,
				9,
				16,
				19
			]))
			{
				this.CPU_AtkMid(-25);
				return;
			}

			if (this.CPU_CheckEnemyPos([
				16,
				26
			]))
			{
				this.CPU_AtkDashHigh(-50);
				return;
			}
		}
		else
		{
			if (d_ <= 400)
			{
				if (this.com_rand[3] <= 2)
				{
					if (this.com_enemyPos > 0)
					{
						this.CPU_SkillE(-25);
						return;
					}
				}

				if (this.com_rand[3] <= 3)
				{
					if (this.com_enemyPos > 9)
					{
						this.CPU_SkillD(-25);
						return;
					}
				}
			}
			else
			{
				if (this.com_rand[3] <= 1)
				{
					this.CPU_SkillE(-25);
					return;
				}

				if (this.com_rand[3] <= 4)
				{
					if (this.CPU_CheckEnemyPos([
						16,
						26,
						13,
						19,
						23,
						26,
						29
					]))
					{
						this.CPU_SkillA(-25);
						return;
					}
				}
			}

			if (this.y < this.centerY)
			{
				if (this.CPU_CheckEnemyPos([
					6,
					16,
					26
				]))
				{
					if (this.com_rand[3] <= 15)
					{
						this.CPU_Shot(-25);
						return;
					}

					if (this.com_rand[3] <= 25)
					{
						this.CPU_ShotFront(-25);
						return;
					}
				}

				if (this.CPU_CheckEnemyPos([
					2,
					12,
					13,
					22,
					23
				]))
				{
					if (this.com_rand[3] <= 25)
					{
						this.CPU_ShotUnder(-25);
						return;
					}

					this.CPU_AtkUnder(-25);
					return;
				}

				if (this.CPU_CheckEnemyPos([
					5,
					8
				]))
				{
					this.CPU_AtkMid(-50);
					return;
				}

				if (this.CPU_CheckEnemyPos([
					16,
					13,
					26,
					23
				]))
				{
					if (this.com_rand[3] <= 25)
					{
						this.CPU_ShotCharge(-50, 0, 1);
						return;
					}

					this.CPU_AtkDashLow(-30);
					return;
				}
			}
			else
			{
				if (this.CPU_CheckEnemyPos([
					2,
					5
				]))
				{
					this.CPU_AtkMid(-50);
					return;
				}

				if (this.CPU_CheckEnemyPos([
					16,
					19,
					26,
					29
				]))
				{
					this.CPU_AtkDashLow(-30);
					return;
				}
			}
		}
	}
}

function CPU_AtkFool( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_k2 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = -1;

		if (this.motion >= 3010 && this.motion <= 3019)
		{
			this.com_count[3] = -300;
			this.com_subState[3] = function ()
			{
				if (this.com_count[3] > 0)
				{
					return true;
				}

				if (this.centerStop == 0 && this.com_count[3] <= -120)
				{
					this.command.rsv_k2 = 1;
					this.command.rsv_x = 0;
					this.command.rsv_y = -1;
				}
			};
		}
	};
}

function CPU_AtkLow( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[3] = function ()
		{
			if (this.com_count[3] > 0 || this.centerStop * this.centerStop >= 4)
			{
				return true;
			}

			if (this.abs(this.targetDist) <= 75)
			{
				this.command.rsv_k0 = 3;
				this.command.rsv_y = 0;
				this.command.rsv_x = 0;
			}
			else
			{
				this.command.rsv_k0 = this.direction;
			}

			if (this.motion == 1000)
			{
				this.CPU_ChainAttack(-90);
				return true;
			}

			if (this.motion == 1100)
			{
				if (this.com_rand[3] <= 3)
				{
					this.CPU_ChainShot(-50);
					return true;
				}

				if (this.com_rand[3] <= 8)
				{
					this.CPU_ChainAttack(-40);
					return true;
				}

				return true;
			}
		};
	}
	else
	{
		this.CPU_AtkMid(wait_);
	}
}

function CPU_AtkMid( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;

	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.atkRange > this.abs(this.targetDist))
		{
			this.com_subState[3] = function ()
			{
				if (this.com_count[3] > 0 || this.centerStop * this.centerStop >= 4)
				{
					return true;
				}

				if (this.motion == 1100 || this.motion == 1000)
				{
					if (this.com_rand[3] <= 3)
					{
						this.CPU_ChainShot(-50);
						return true;
					}

					if (this.com_rand[3] <= 8)
					{
						this.CPU_ChainAttack(-40);
						return true;
					}

					return true;
				}

				this.command.rsv_k0 = 1;
				this.command.rsv_x = 0;
			};
		}
		else
		{
			this.CPU_DashFront(wait_);
			this.com_subState[3] = function ()
			{
				if (this.com_count[3] > 0 || this.centerStop * this.centerStop >= 4)
				{
					return true;
				}

				if (this.motion == 40)
				{
					if (this.keyTake <= 2 && this.abs(this.targetDist) <= 150)
					{
						this.command.rsv_k0 = 1;
						this.command.rsv_x = 0;
					}
				}
				else if (this.motion == 1100 || this.motion == 1000)
				{
					if (this.com_rand[3] <= 3)
					{
						this.CPU_ChainShot(-50);
						return true;
					}

					if (this.com_rand[3] <= 8)
					{
						this.CPU_ChainAttack(-40);
						return true;
					}

					return true;
				}
			};
		}
	}
	else
	{
		this.com_subState[3] = function ()
		{
			if (this.com_count[3] > 0 || this.centerStop * this.centerStop <= 1)
			{
				return true;
			}

			if (this.y < this.centerY && this.CPU_CheckEnemyPos([
				2,
				5,
				8
			]) || this.y > this.centerY && this.CPU_CheckEnemyPos([
				8,
				9,
				6
			]))
			{
				this.command.rsv_x = 0;
				this.command.rsv_y = 0;
				this.command.rsv_k0 = 1;
			}

			if (this.motion == 1110)
			{
				if (this.com_rand[3] <= 3)
				{
					this.CPU_ChainAttack(-25);
				}

				return true;
			}
		};
	}
}

function CPU_AtkUpper( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_y = -1;
		this.command.rsv_k0 = 1;

		if (this.motion == 1220 || this.motion == 1221 || this.motion == 1222)
		{
			if (this.com_rand[3] <= 5 && this.team.spell_active)
			{
				this.CPU_ChainSpell(-60);
				return true;
			}

			if (this.com_rand[3] <= 8)
			{
				this.CPU_ChainShot(-30);
				return true;
			}

			if (this.com_rand[3] <= 9)
			{
				this.CPU_ChainSkill(-30);
				return true;
			}

			return true;
		}
	};
}

function CPU_AtkUnder( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_y = 1;
		this.command.rsv_k0 = 1;

		if (this.motion == 1210 || this.motion == 1211 || this.motion == 1212)
		{
			if (this.com_rand[3] <= 5 && this.team.spell_active)
			{
				this.CPU_ChainSpell(-60);
				return true;
			}

			if (this.com_rand[3] <= 6)
			{
				this.CPU_ChainShot(-40);
				return true;
			}

			if (this.com_rand[3] <= 8)
			{
				this.CPU_ChainAttack(-20);
				return true;
			}

			if (this.com_rand[3] <= 9)
			{
				this.CPU_ChainSkill(-30);
				return true;
			}

			return true;
		}
	};
	return true;
}

function CPU_AtkFront( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0 || this.centerStop * this.centerStop >= 4)
		{
			return true;
		}

		this.command.rsv_x = this.direction;
		this.command.rsv_k0 = 1;

		if (this.motion == 1230 || this.motion == 1231 || this.motion == 1232)
		{
			if (this.com_rand[3] <= 7)
			{
				this.CPU_ChainShot(-30);
				return true;
			}

			if (this.com_rand[3] <= 9)
			{
				this.CPU_ChainSkill(-30);
				return true;
			}

			return true;
		}
	};
}

function CPU_AtkDashLow( wait_ )
{
	this.CPU_DashFront(wait_);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.com_subState[3] = function ()
		{
			if (this.com_count[3] > 0 || this.centerStop * this.centerStop >= 4)
			{
				return true;
			}

			if (this.motion == 40)
			{
				if (this.keyTake <= 2 && this.CPU_CheckEnemyPos([
					5,
					17
				]))
				{
					this.command.rsv_k0 = 3;
					this.command.rsv_x = this.direction;
				}
				else
				{
					return true;
				}
			}
			else if (this.motion == 1300)
			{
				if (this.com_rand[3] <= 3)
				{
					this.CPU_ChainSkill(-30);
				}

				return true;
			}
		};
	}
	else
	{
		this.com_subState[3] = function ()
		{
			if (this.com_count[3] > 0 || this.centerStop * this.centerStop <= 1)
			{
				return true;
			}

			if (this.motion == 42)
			{
				if (this.y <= this.centerY)
				{
					if (this.CPU_CheckEnemyPos([
						2,
						5,
						12,
						13,
						16
					]))
					{
						this.command.rsv_k0 = 3;
						this.command.rsv_x = 0;
					}
				}
				else if (this.CPU_CheckEnemyPos([
					2,
					8,
					18,
					19,
					16
				]))
				{
					this.command.rsv_k0 = 3;
					this.command.rsv_x = 0;
				}
			}
			else if (this.motion == 1200)
			{
				if (this.com_rand[3] <= 3)
				{
					this.CPU_ChainSkill(-30);
				}

				return true;
			}
		};
	}
}

function CPU_AtkDashHigh( wait_ )
{
	this.CPU_DashFront(wait_);
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.motion == 40)
		{
			if (this.keyTake <= 2 && this.CPU_CheckEnemyPos([
				16
			]))
			{
				this.command.rsv_k1 = 3;
				this.command.rsv_x = this.direction;
			}
		}

		if (this.motion == 1310)
		{
			this.CPU_ChainSpell(-40);
			return true;
		}
	};
}

function CPU_ChainMove( wait_ )
{
	this.com_rand[1] = this.rand() % 10;
	this.com_count[1] = wait_;
	this.com_subState[1] = function ()
	{
		if (this.rand() % 80 >= this.com_level)
		{
			return true;
		}

		if (this.com_count[1] > 0)
		{
			return true;
		}

		if (this.rand() % 1000 >= this.team.mp)
		{
			return true;
		}

		if (this.centerStop * this.centerStop <= 1)
		{
			switch(this.com_enemyPos)
			{
			case 5:
				if (this.com_rand[1] <= 3)
				{
					this.CPU_DashBack(-20);
					return true;
				}

				if (this.com_rand[1] <= 6)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : -this.direction, -10);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : -this.direction, 10);
					return true;
				}

				return true;
				break;

			case 2:
			case 8:
			case 13:
			case 16:
			case 19:
				if (this.com_rand[1] <= 1)
				{
					this.CPU_DashBack(-20);
					return true;
				}

				if (this.com_rand[1] <= 5)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : this.direction, -10);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : this.direction, 10);
					return true;
				}

				return true;
				break;

			case 14:
				if (this.com_rand[1] <= 4)
				{
					this.CPU_Slide(-10, this.direction, -10);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.direction, 10);
					return true;
				}

				return true;
				break;

			case 11:
				if (this.com_rand[1] <= 8)
				{
					this.CPU_Slide(-10, this.direction, -10);
					return true;
				}

				return true;
				break;

			case 17:
				if (this.com_rand[1] <= 8)
				{
					this.CPU_Slide(-10, this.direction, 10);
					return true;
				}

				return true;
				break;

			default:
				if (this.com_rand[1] <= 4)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : this.direction, -10);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : this.direction, 10);
					return true;
				}

				return true;
				break;
			}
		}
		else
		{
			switch(this.com_enemyPos)
			{
			case 5:
				if (this.com_rand[1] <= 4)
				{
					this.CPU_DashBack(-20);
					return true;
				}

				if (this.com_rand[1] <= 5)
				{
					this.CPU_DashFront(-20);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : -this.direction, this.y < this.centerY ? 1.00000000 : -1.00000000);
					return true;
				}

				return true;
				break;

			case 2:
			case 8:
			case 13:
			case 16:
			case 19:
				if (this.com_rand[1] <= 3)
				{
					this.CPU_DashBack(-20);
					return true;
				}

				if (this.com_rand[1] <= 7)
				{
					this.CPU_DashFront(-20);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : -this.direction, this.y < this.centerY ? 1.00000000 : -1.00000000);
					return true;
				}

				return true;
				break;

			case 14:
				if (this.com_rand[1] <= 7)
				{
					this.CPU_DashFront(-20);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : -this.direction, this.y < this.centerY ? 1.00000000 : -1.00000000);
					return true;
				}

				return true;
				break;

			case 11:
			case 17:
				if (this.com_rand[1] <= 8)
				{
					this.CPU_DashFront(-20);
					return true;
				}

				if (this.com_rand[1] <= 9)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : -this.direction, this.y < this.centerY ? 1.00000000 : -1.00000000);
					return true;
				}

				return true;
				break;

			default:
				if (this.com_rand[1] <= 6)
				{
					this.CPU_DashFront(-20);
					return true;
				}

				if (this.com_rand[1] <= 8)
				{
					this.CPU_Slide(-10, this.rand() % 10 <= 5 ? 0 : -this.direction, this.y < this.centerY ? 1.00000000 : -1.00000000);
					return true;
				}

				return true;
				break;
			}
		}
	};
}

function CPU_ChainAttack( wait_ )
{
	this.com_rand[1] = this.rand() % 10;
	this.com_count[1] = wait_;

	if (this.rand() % 80 >= this.com_level)
	{
		return true;
	}

	if (this.com_aggro_stance <= 0)
	{
		if (this.rand() % 100 >= 51)
		{
			return true;
		}
	}

	this.com_subState[1] = function ()
	{
		if (this.IsFree() || this.com_count[1] > 0)
		{
			return true;
		}

		switch(this.motion)
		{
		case 1000:
			this.command.rsv_x = 0;
			this.command.rsv_y = 0;
			this.command.rsv_k0 = 1;
			this.com_count[1] = -60;
			break;

		case 1100:
			if (this.CPU_CheckEnemyPos([
				5,
				6
			]))
			{
				if (this.com_rand[1] <= 5)
				{
					this.CPU_AtkFront(-25);
					return true;
				}
				else
				{
					this.CPU_AtkFront(-25);
					return true;
				}
			}

			if (this.com_rand[1] <= 5)
			{
				if (this.CPU_CheckEnemyPos([
					5,
					8,
					16,
					19
				]))
				{
					this.CPU_AtkUpper(-25);
					return true;
				}
			}
			else if (this.CPU_CheckEnemyPos([
				5,
				2,
				13,
				12
			]))
			{
				this.CPU_AtkUnder(-25);
				return true;
			}

			break;

		case 1500:
			this.command.rsv_x = 0;
			this.command.rsv_y = 0;
			this.command.rsv_k0 = 1;
			this.com_count[1] = -60;
			break;

		case 1600:
			this.command.rsv_x = 0;
			this.command.rsv_y = 0;
			this.command.rsv_k0 = 1;

			if (this.CPU_CheckEnemyPos([
				8,
				9
			]))
			{
				this.command.rsv_y = -2;
			}

			if (this.CPU_CheckEnemyPos([
				2,
				3
			]))
			{
				this.command.rsv_y = 2;
			}

			this.com_count[1] = -60;
			break;

		case 1700:
		case 1730:
			this.command.rsv_x = 0;
			this.command.rsv_y = 0;
			this.command.rsv_k0 = 1;
			this.com_count[1] = -60;
			break;

		case 1710:
			this.command.rsv_x = 0;
			this.command.rsv_y = 1;
			this.command.rsv_k0 = 1;
			this.com_count[1] = -60;
			break;

		case 1720:
			this.command.rsv_x = 0;
			this.command.rsv_y = -1;
			this.command.rsv_k0 = 1;
			this.com_count[1] = -60;
			break;
		}
	};
}

function CPU_ChainShot( wait_ )
{
	if (this.rand() % 80 >= this.com_level)
	{
		return true;
	}

	this.com_rand[1] = this.rand() % 10;
	this.com_count[1] = wait_;

	if (this.com_aggro_stance <= 0)
	{
		if (this.rand() % 100 >= 51)
		{
			return true;
		}
	}

	if (this.rand() % 1000 >= this.team.mp)
	{
		return true;
	}

	this.com_subState[1] = function ()
	{
		if (this.IsFree() || this.com_count[1] > 0)
		{
			return true;
		}

		if (this.motion == 1100)
		{
			if (this.CPU_CheckEnemyPos([
				5,
				16,
				26
			]))
			{
				if (this.com_rand[1] <= 2)
				{
					this.CPU_ShotFront(-60);
					return true;
				}

				this.CPU_Shot(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				8,
				19,
				29
			]))
			{
				this.CPU_ShotUpper(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				2,
				13,
				23
			]))
			{
				this.CPU_ShotUnder(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				27,
				28,
				29
			]))
			{
				if (this.com_rand[1] <= 9)
				{
					this.CPU_ShotUpper(-60);
					return true;
				}
			}

			if (this.CPU_CheckEnemyPos([
				21,
				22,
				23
			]))
			{
				if (this.com_rand[1] <= 9)
				{
					this.CPU_ShotUnder(-60);
					return true;
				}
			}
		}
		else
		{
			if (this.CPU_CheckEnemyPos([
				5,
				16,
				26
			]))
			{
				if (this.com_rand[1] <= 2)
				{
					this.CPU_ShotFront(-60);
					return true;
				}

				this.CPU_Shot(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				8,
				19,
				29
			]))
			{
				this.CPU_ShotUpper(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				2,
				13,
				23
			]))
			{
				this.CPU_ShotUnder(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				27,
				28,
				29
			]))
			{
				if (this.com_rand[1] <= 9)
				{
					this.CPU_ShotUpper(-60);
					return true;
				}
			}

			if (this.CPU_CheckEnemyPos([
				21,
				22,
				23
			]))
			{
				if (this.com_rand[1] <= 9)
				{
					this.CPU_ShotUnder(-60);
					return true;
				}
			}

			  // [203]  OP_JMP            0      0    0    0
		}
	};
}

function CPU_Shot( wait_ )
{
	if (this.rand() % 1000 >= this.team.mp)
	{
		return true;
	}

	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.motion <= 2000 && this.motion <= 2009)
		{
			if (this.com_rand[3] <= 7)
			{
				this.CPU_ChainMove(-60);
				return true;
			}

			if (this.com_rand[3] <= 9)
			{
				this.CPU_ChainSkill(-60);
				return true;
			}

			return true;
		}

		this.command.rsv_k1 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = 0;
	};
}

function CPU_ShotUpper( wait_ )
{
	if (this.rand() % 1000 >= this.team.mp)
	{
		return true;
	}

	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.motion <= 2000 && this.motion <= 2009)
		{
			if (this.com_rand[3] <= 7)
			{
				this.CPU_ChainMove(-60);
				return true;
			}

			if (this.com_rand[3] <= 9)
			{
				this.CPU_ChainSkill(-60);
				return true;
			}

			return true;
		}

		this.command.rsv_k1 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = -1;
	};
}

function CPU_ShotUnder( wait_ )
{
	if (this.rand() % 1000 >= this.team.mp)
	{
		return true;
	}

	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.motion <= 2000 && this.motion <= 2009)
		{
			if (this.com_rand[3] <= 7)
			{
				this.CPU_ChainMove(-60);
				return true;
			}

			if (this.com_rand[3] <= 9)
			{
				this.CPU_ChainSkill(-60);
				return true;
			}

			return true;
		}

		this.command.rsv_k1 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = 1;
	};
}

function CPU_ShotFront( wait_ )
{
	if (this.rand() % 1000 >= this.team.mp)
	{
		return true;
	}

	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if ((this.motion >= 2010 && this.motion <= 2019) && this.keyTake >= 3)
		{
			if (this.com_rand[3] <= 1)
			{
				if (!this.CPU_SkillO(-60))
				{
					return;
				}
			}

			if (this.com_rand[3] <= 7)
			{
				this.CPU_ChainMove(-60);
				return true;
			}

			if (this.com_rand[3] <= 9)
			{
				this.CPU_ChainSkill(-60);
				return true;
			}

			return true;
		}

		this.command.rsv_k1 = 1;
		this.command.rsv_x = this.direction;
		this.command.rsv_y = 0;
	};
}

function CPU_ShotCharge( wait_ )
{
	if (this.rand() % 1000 >= this.team.mp)
	{
		return true;
	}

	this.CPU_MoveStop(1);
	this.com_count[3] = wait_;
	this.com_rand[3] = this.rand() % 10;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.com_count[3] >= -10)
		{
			this.input.b1 = 0;
			this.input.y = 1;

			if (this.com_rand[3] <= 3)
			{
				this.input.y = 0;
			}

			if (this.com_rand[3] <= 6)
			{
				this.input.y = -1;
			}

			if (this.motion == 2020 && this.keyTake == 2)
			{
				if (this.com_rand[3] <= 9)
				{
					this.CPU_ChainMove(-60);
					return true;
				}

				return true;
			}
		}
		else
		{
			this.input.b1 = 15;
			this.command.rsv_x = 0;
			this.command.rsv_y = -this.direction;
		}
	};
}

function CPU_ChainSkill( wait_ )
{
	if (this.rand() % 80 >= this.com_level)
	{
		return true;
	}

	this.com_rand[1] = this.rand() % 10;
	this.com_count[1] = wait_;

	if (this.com_aggro_stance <= 0)
	{
		if (this.rand() % 100 >= 51)
		{
			return true;
		}
	}

	if (this.rand() % 1000 >= this.team.mp)
	{
		return true;
	}

	this.com_subState[1] = function ()
	{
		if (this.com_count[1] > 0)
		{
			return true;
		}

		if (this.motion == 1230)
		{
			if (this.CPU_CheckEnemyPos([
				6,
				16,
				26
			]))
			{
				this.CPU_SkillA(-60);
				return true;
			}
		}
		else
		{
			if (this.centerStop * this.centerStop >= 4)
			{
				if (this.com_rand[1] <= 1)
				{
					this.CPU_SkillE(-60);
					return true;
				}
			}
			else if (this.com_rand[1] <= 2 && this.com_enemyPos >= 20)
			{
				this.CPU_SkillB(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				6,
				16,
				26
			]))
			{
				if (this.com_rand[1] <= 7)
				{
					this.CPU_SkillA(-60);
					return true;
				}

				if (this.com_rand[1] == 9)
				{
					this.CPU_SkillO(-60);
					return true;
				}
			}

			if (this.CPU_CheckEnemyPos([
				8,
				5,
				18
			]) && this.target.IsDamage())
			{
				this.CPU_SkillC(-60);
				return true;
			}

			if (this.CPU_CheckEnemyPos([
				5,
				2,
				12,
				13
			]))
			{
				if (this.com_rand[1] == 9)
				{
					this.CPU_SkillO(-60);
					return true;
				}

				this.CPU_SkillD(-60);
				return true;
			}

			if (this.com_rand[1] <= 5 && this.com_enemyPos >= 10)
			{
				this.CPU_SkillO(-60);
				return true;
			}

			  // [157]  OP_JMP            0      0    0    0
		}
	};
}

function CPU_SkillA( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_k2 = 1;
		this.command.rsv_x = this.direction;
		this.command.rsv_y = 0;

		if (this.motion >= 3980 && this.motion <= 3989)
		{
			return true;
		}
	};
}

function CPU_SkillB( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_k2 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = 0;

		if (this.motion == 3060 || this.motion == 3061)
		{
			return true;
		}
	};
}

function CPU_SkillC( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_k2 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = -1;

		if (this.motion >= 3010 && this.motion <= 3019)
		{
			return true;
		}
	};
}

function CPU_SkillD( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_k2 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = 1;

		if (this.motion >= 3980 && this.motion <= 3989)
		{
			return true;
		}
	};
}

function CPU_SkillE( wait_ )
{
	this.CPU_MoveStop(1);
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_k2 = 1;
		this.command.rsv_x = -this.direction;
		this.command.rsv_y = 0;

		if (this.motion >= 3980 && this.motion <= 3989)
		{
			return true;
		}
	};
}

function CPU_SkillO( wait_ )
{
	if (this.team.op < 2000 || this.team.op_stop > 0)
	{
		return true;
	}

	this.CPU_MoveStop(1);
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		this.command.rsv_k01 = 1;
		this.command.rsv_x = 0;
		this.command.rsv_y = 0;

		if (this.motion == 2500)
		{
			if (this.com_rand[3] <= 8)
			{
				this.CPU_ChainMove(-60);
				return true;
			}

			return true;
		}
	};
}

function CPU_ChainSpell( wait_ )
{
	if (!this.team.spell_active)
	{
		return true;
	}

	if (this.rand() % 80 >= this.com_level)
	{
		return true;
	}

	this.com_rand[1] = this.rand() % 10;
	this.com_count[1] = wait_;

	if (this.com_aggro_stance <= 0)
	{
		if (this.rand() % 100 >= 51)
		{
			return true;
		}
	}

	this.com_subState[1] = function ()
	{
		if (this.com_count[1] > 0)
		{
			return true;
		}

		switch(this.spellcard.id)
		{
		case 0:
			if (this.target.IsDamage() && this.target.recover >= 30 && this.abs(this.targetDist) <= 150)
			{
				this.CPU_SpellA(-60);
				return true;
			}

			break;

		case 1:
			if (this.target.IsDamage() && this.target.recover >= 30 && this.abs(this.targetDist) <= 250)
			{
				this.CPU_SpellB(-60);
				return true;
			}

			break;

		case 2:
			if (this.target.IsDamage() && this.target.recover >= 50)
			{
				this.CPU_SkillC(-60);
				return true;
			}

			break;
		}
	};
}

function CPU_CheckSpell()
{
	if (!this.team.spell_active)
	{
		return;
	}

	switch(this.spellcard.id)
	{
	case 0:
		if (this.abs(this.targetDist) <= 175)
		{
			if (this.rand() % 100 <= 2 || this.target.IsAttack() && this.rand() % 100 <= 10 || this.motion == 37 && this.rand() % 100 <= 10)
			{
				this.CPU_SpellA(-60);
				return true;
			}
		}

		break;

	case 1:
		if (this.abs(this.targetDist) <= 250)
		{
			if (this.rand() % 100 <= 2 || this.target.IsAttack() == 2 && this.rand() % 100 <= 10)
			{
				this.CPU_SpellB(-60);
				return true;
			}
		}

		break;

	case 2:
		if (this.rand() % 100 <= 1)
		{
			this.CPU_SkillC(-60);
			return true;
		}

		break;
	}
}

function CPU_SpellA( wait_ )
{
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.motion == 4000)
		{
			return true;
		}

		this.command.rsv_k12 = 4;
	};
}

function CPU_SpellB( wait_ )
{
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.motion == 4010)
		{
			return true;
		}

		this.command.rsv_k12 = 4;
	};
}

function CPU_SpellC( wait_ )
{
	this.com_rand[3] = this.rand() % 10;
	this.com_count[3] = wait_;
	this.com_subState[3] = function ()
	{
		if (this.com_count[3] > 0)
		{
			return true;
		}

		if (this.motion == 4020)
		{
			return true;
		}

		this.command.rsv_k12 = 4;
	};
}

