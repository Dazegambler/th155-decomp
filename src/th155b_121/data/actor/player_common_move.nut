function Test_Motion( force_, rotate_ )
{
	if (this.IsFree() || force_)
	{
		if (rotate_)
		{
			local t_ = this.motion_test[0];
			this.motion_test.append(t_);
			this.motion_test.remove(0);
			this.motion_test[0].call(this);
		}
		else
		{
			this.motion_test[0].call(this);
		}
	}
}

function CommonWin()
{
	::battle.endWinDemo[this.team.index] = true;
}

function CommonBegin()
{
	::battle.endWinDemo[this.team.index] = true;
	this.demoObject = null;
}

function CommonLose()
{
	::battle.endLoseDemo[this.team.index] = true;
}

function TalkActionA1( t )
{
}

function TalkActionA2( t )
{
}

function CommonBeginBattleSkip()
{
	if (this.team.current == this)
	{
		if (this.team.index == 0)
		{
			this.direction = 1.00000000;
			this.Warp(::battle.start_x[0], ::battle.start_y[0]);
		}
		else
		{
			this.direction = -1.00000000;
			this.Warp(::battle.start_x[1], ::battle.start_y[1]);
		}

		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.Stand_Init(null);
		this.ReleaseTargetActor(this.demoObject);
		this.demoObject = null;
		this.masterAlpha = 1.00000000;
	}
	else
	{
		this.Team_Bench_In();
	}
}

function AjustCenterStop()
{
	if (this.centerStop * this.centerStop >= 4)
	{
		if (this.y < this.centerY)
		{
			this.centerStop = -2;
			this.centerStopCheck = -1.00000000;
			return;
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 2;
			this.centerStopCheck = 1.00000000;
			return;
		}
	}
}

function FreeReset()
{
	this.rx = 0.00000000;
	this.ry = 0.00000000;
	this.rz = 0.00000000;
	this.sx = this.sy = 1.00000000;
	this.FitBoxfromSprite();
	this.hitBackFlag = 0;
	this.enableKO = true;
	this.freeMap = false;
	this.collisionFree = false;
	this.GetFront();

	if (this.invin < 0)
	{
		this.invin = 0;
	}

	if (this.invinObject < 0)
	{
		this.invinObject = 0;
	}

	if (this.team.life <= 0 && this.enableKO)
	{
		this.DamageKO_Init(null);
		return true;
	}

	if (this.stanBossCount > 0)
	{
		this.DamageBossStan_Init(null);
		return true;
	}

	if (this.team.combo_stun >= 100 && this.stanCount > 0)
	{
		this.DamageStan_Init(null);
		return true;
	}

	this.team.ResetCombo();

	if (this.event_motionEnd)
	{
		if (this.event_motionEnd.call(this))
		{
			this.event_motionEnd = null;
		}
	}

	return false;
}

function EndtoFreeMove()
{
	if (this.FreeReset())
	{
		return true;
	}

	if (this.centerStop * this.centerStop <= 1)
	{
		this.Stand_Init(null);
	}
	else if (this.y > this.centerY)
	{
		if (this.va.y > 6.00000000)
		{
			this.Fall_Init(null);
		}
		else
		{
			this.Up_Init(null);
		}
	}
	else if (this.va.y < -6.00000000)
	{
		this.Up_Init(null);
	}
	else
	{
		this.Fall_Init(null);
	}

	if (::battle.state == 8)
	{
		if (!this.cpuState && this.command)
		{
			this.command.Update(this.direction, this.hitStopTime <= 0 && this.damageStopTime <= 0);
		}

		this.Update_Input();
	}

	return;
}

function EndtoStand()
{
	if (this.FreeReset.call(this))
	{
		return true;
	}

	if (this.centerStop * this.centerStop <= 1)
	{
		this.Stand_Init(null);
	}
	else if (this.y > this.centerY)
	{
		if (this.va.y > 6.00000000)
		{
			this.Fall_Init(null);
		}
		else
		{
			this.Up_Init(null);
		}
	}
	else if (this.va.y < -6.00000000)
	{
		this.Up_Init(null);
	}
	else
	{
		this.Fall_Init(null);
	}

	if (::battle.state == 8)
	{
		if (!this.cpuState && this.command)
		{
			this.command.Update(this.direction, this.hitStopTime <= 0 && this.damageStopTime <= 0);
		}

		this.Update_Input();
	}
}

function EndtoFallLoop()
{
	if (this.FreeReset.call(this))
	{
		return true;
	}

	this.Fall_Init(1);

	if (::battle.state == 8)
	{
		if (!this.cpuState && this.command)
		{
			this.command.Update(this.direction, this.hitStopTime <= 0 && this.damageStopTime <= 0);
		}

		this.Update_Input();
	}
}

function EndtoUpLoop()
{
	if (this.FreeReset.call(this))
	{
		return true;
	}

	this.Up_Init(1);

	if (::battle.state == 8)
	{
		if (!this.cpuState && this.command)
		{
			this.command.Update(this.direction, this.hitStopTime <= 0 && this.damageStopTime <= 0);
		}

		this.Update_Input();
	}
}

function GetFront()
{
	local dir_ = this.direction;

	if (this.target)
	{
		if (this.target.x > this.x && this.direction < 0.00000000)
		{
			this.direction = 1.00000000;

			if (this.motion == 0 || this.motion == 9)
			{
				this.SetMotion(9, 0);
			}

			if (dir_ != this.direction)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else if (this.target.x < this.x && this.direction > 0.00000000)
		{
			if (this.motion == 0 || this.motion == 9)
			{
				this.SetMotion(9, 0);
			}

			this.direction = -1.00000000;

			if (dir_ != this.direction)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}

	return false;
}

function SetBaria()
{
	if (this.stanBossCount > 0 || this.team.life <= 0)
	{
		return false;
	}

	this.baria = true;
	this.SetEffect(this.x, this.y, this.direction, this.EF_StanBaria, {}, this.weakref());
	return true;
}

function SetGuardBaria()
{
	this.SetEffect(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(12, 1);
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0.20000000;
			this.alpha -= 0.10000000;

			if (this.alpha <= 0.00000000)
			{
				this.Release();
			}
		};
	}, {});

	if (!this.guardBaria)
	{
		this.guardBaria = true;
		this.SetEffect(this.x, this.y, this.direction, this.EF_GuardBaria, {}, this);
	}
}

function BattleTimeRestart()
{
	if (this.target.cpu_type == 1 || this.target.cpu_type == 2)
	{
		::battle.enableTimeCount = true;
		return true;
	}

	if (this.team.spell_time > 0 || this.target.team.spell_time > 0)
	{
		return false;
	}
	else
	{
		::battle.enableTimeCount = true;
		return true;
	}
}

function PlayerhitAction_Normal( t_ )
{
	this.KnockBackSetValue(t_);

	if (this.event_getDamage)
	{
		if (this.event_getDamage(t_))
		{
			this.event_getDamage = null;
		}
	}

	if (this.team.life <= 0 && this.enableKO && t_.atkType != 0)
	{
		this.BuffReset();
		this.enableStandUp = false;

		if (this.event_defeat)
		{
			this.event_defeat();
		}

		if (this.koExp)
		{
			this.DamageFinish(t_);
			return;
		}
	}

	if (this.debuff_animal.time > 0)
	{
		this.DamageAnimalB_Init(t_);
	}
	else
	{
		if (this.team.current == this.team.slave && (this.team.op == 0 && t_.atkType > 0 && t_.atkType != 23 || this.team.life <= 0))
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
			this.Team_Change_Common();
			this.team.current.Warp(this.x, this.y);
			this.Team_Bench_In();
			this.team.master.damageStopTime = this.damageStopTime + 15;
			this.team.master.recover = this.recover;
			this.team.master.stanCount = this.stanCount;
			this.team.master.invinBoss = this.invinBoss;
			this.team.master.damageTarget = this.damageTarget.weakref();
			this.baria = false;

			if (this.team.regain_life > this.team.life)
			{
				this.team.regain_life = this.team.life;
			}

			this.team.combo_reset_count = 0;
			this.team.combo_break = true;

			if (this.target.cpuState == null)
			{
				::trophy.OccultBreak(this.target.team.index);
			}

			this.endure = 0;
			t_.stopVecX = 0.00000000;
			t_.stopVecY = 0.00000000;
			this.team.current.vf.x = 0.00000000;
			this.team.current.vf.y = 0.00000000;
			this.team.current.vfBaria.x = 0.00000000;
			this.team.current.vfBaria.y = 0.00000000;
			this.team.master.PlayerhitAction_Normal(t_);
			return;
		}

		switch(t_.atkType)
		{
		case 1:
			if (this.team.life <= 0 || this.centerStop * this.centerStop > 1 || this.flagState & 8)
			{
				if (this.y <= this.centerY && this.centerStop != -1 || this.centerStop == 1)
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = -7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4.00000000;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = 7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4.00000000;
					}

					this.DamageUnderLight_Init(t_);
				}
			}
			else
			{
				this.DamageHead_Init(t_);
			}

			break;

		case 2:
			if (this.team.life <= 0 || this.centerStop * this.centerStop > 1 || this.flagState & 8)
			{
				if (this.y <= this.centerY && this.centerStop != -1 || this.centerStop == 1)
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = -7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4.00000000;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = 7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4.00000000;
					}

					this.DamageUnderLight_Init(t_);
				}
			}
			else
			{
				this.DamageBody_Init(t_);
			}

			break;

		case 3:
			this.DamageBack_Init(t_);
			break;

		case 4:
			this.DamageUpper_Init(t_);
			break;

		case 5:
			this.DamageUnder_Init(t_);
			break;

		case 6:
			this.DamageUnderSmash_Init(t_);
			break;

		case 7:
			this.DamageBodySmash_Init(t_);
			break;

		case 8:
			this.DamageUpperLight_Init(t_);
			break;

		case 9:
			this.DamageUnderLight_Init(t_);
			break;

		case 10:
			this.DamageUpperSpin_Init(t_);
			break;

		case 11:
			this.DamageBackSpin_Init(t_);
			break;

		case 12:
			this.DamageUpperHeavy_Init(t_);
			break;

		case 13:
			if (this.team.life <= 0)
			{
				this.DamageUpperLight_Init(t_);
			}
			else
			{
				this.DamageHeadPull_Init(t_);
			}

			break;

		case 14:
			if (this.team.life <= 0)
			{
				this.DamageUpperLight_Init(t_);
			}
			else
			{
				this.DamageBodyPull_Init(t_);
			}

			break;

		case 15:
			if (this.team.life <= 0)
			{
				this.DamageUpperLight_Init(t_);
			}
			else
			{
				this.DamageBackLong_Init(t_);
			}

			break;

		case 16:
			this.DamageBackLongSpin_Init(t_);
			break;

		case 17:
			if (this.team.life <= 0 || this.centerStop * this.centerStop > 1 || this.flagState & 8)
			{
				if (this.y <= this.centerY)
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = -7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4.00000000;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = 7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4.00000000;
					}

					this.DamageUnderLight_Init(t_);
				}
			}
			else
			{
				this.DamageHeadShort_Init(t_);
			}

			break;

		case 18:
			if (this.team.life <= 0 || this.centerStop * this.centerStop > 1 || this.flagState & 8)
			{
				if (this.y <= this.centerY)
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = -7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4.00000000;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = 7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4.00000000;
					}

					this.DamageUnderLight_Init(t_);
				}
			}
			else
			{
				this.DamageBodyShort_Init(t_);
			}

			break;

		case 19:
			if (this.team.life <= 0 || this.flagState & 8)
			{
				if (this.y <= this.centerY)
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = -7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4.00000000;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = 7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4.00000000;
					}

					this.DamageUnderLight_Init(t_);
				}
			}
			else
			{
				this.DamageHeadB_Init(t_);
			}

			break;

		case 20:
			if (this.team.life <= 0 || this.flagState & 8)
			{
				if (this.y <= this.centerY)
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = -7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4.00000000;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4.00000000;
					t_.hitVecY = 7.00000000;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4.00000000;
					}

					this.DamageUnderLight_Init(t_);
				}
			}
			else
			{
				this.DamageBodyB_Init(t_);
			}

			break;

		case 21:
			this.DamageHeightSelect_Init(t_);
			break;

		case 22:
			if (this.team.life <= 0)
			{
				this.DamageUpperLight_Init(t_);
			}
			else
			{
				this.SpellPush_Init(t_);
			}

			break;

		case 23:
			if (this.team.life <= 0)
			{
				this.DamageUpperLight_Init(t_);
			}
			else
			{
				this.DamageBullet_Init(t_);
			}

			break;

		case 24:
			if (this.team.life <= 0)
			{
				this.DamageUpperLight_Init(t_);
			}
			else
			{
				this.DamageTagSpin_Init(t_);
			}

			break;
		}
	}
}

function PlayerGuardAction_Point( t_ )
{
	this.PlaySE(810);
	this.hitBackFlag = t_.knockFlag;
}

function PlayerGuardAction_Normal( t_ )
{
	this.hitBackFlag = t_.knockFlag;

	if (this.cpuState)
	{
		if (this.rand() % 100 <= this.com_baria_rate)
		{
			this.autoBaria = 1;
		}
		else
		{
			this.autoBaria = 4;
		}
	}

	this.GetGuardReset();

	if (this.autoBaria == 2 || this.autoBaria == 3)
	{
		this.autoBaria = 2 + this.rand() % 2;
	}

	if (this.motion == 118 && this.keyTake <= 1 || this.input.b4 > 0 && this.input.x == 0 && this.input.y == 0 || this.autoBaria == 1 || this.autoBaria == 2)
	{
		this.BariaGuard_Init(t_);
	}
	else
	{
		this.Guard_Init(t_);
	}
}

function PlayerGuardAction_Normal_Practce( t_ )
{
	this.GetGuardReset();
	this.Guard_Init(t_);
}

function PlayerGuardAction_Just( t_ )
{
	this.hitBackFlag = t_.knockFlag;
	this.GetGuardReset();
	this.JustGuard_Init(t_);
}

function PlayerGuardAction_Push( t_ )
{
	this.hitBackFlag = t_.knockFlag;
	this.GetGuardReset();
	this.BariaGuard_Init(t_);
}

function PlayerMissGuardAction_Normal( t_ )
{
	this.hitBackFlag = t_.knockFlag;
	this.GetGuardReset();
	this.Guard_Init(t_);
}

function PlayerGuardCrashAction_Normal( t_ )
{
	this.hitBackFlag = t_.knockFlag;
	this.GetGuardReset();
	this.GuardCrash_Init(t_);
}

function PlayerAvoidEventF( t_ )
{
	this.SetEffect(this.x, this.y, this.direction, this.EF_Avoid, {});
	this.colorAvoid = 0.00000000;
	this.Avoid_F_Init(null);
}

function PlayerAvoidEventH( t_ )
{
	this.SetEffect(this.x, this.y, this.direction, this.EF_Avoid, {});
	this.colorAvoid = 0.00000000;
	this.Avoid_H_Init(null);
}

function PlayerAvoidEventV( t_ )
{
	this.SetEffect(this.x, this.y, this.direction, this.EF_Avoid, {});
	this.colorAvoid = 0.00000000;

	if (this.centerY - this.y <= 0)
	{
		this.Avoid_UP_Init(null);
	}
	else
	{
		this.Avoid_Fall_Init(null);
	}
}

function StoryDash_In( t )
{
	this.LabelClear();
	this.PlaySE(800);
	this.SetMotion(42, 2);

	if (this.team.index == 0)
	{
		this.direction = 1.00000000;
		this.Warp(0, this.centerY - 200);
	}
	else
	{
		this.direction = -1.00000000;
		this.Warp(1280, this.centerY - 200);
	}

	if (::actorPlayer[0] == this)
	{
		::actorPlayer[0].isVisible = true;
	}
	else if (::actorPlayer[1] == this)
	{
		::actorPlayer[1].isVisible = true;
	}

	this.centerStop = -2;
	this.SetSpeed_XY(11.00000000 * this.direction, 0.00000000);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.30000001, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(42, 3);
			this.stateLabel = function ()
			{
				if (this.VX_Brake(0.60000002))
				{
					if (this.team.index == 0)
					{
						this.x = ::battle.start_x[0];
					}
					else
					{
						this.x = ::battle.start_x[1];
					}

					this.stateLabel = function ()
					{
					};
				}
			};
		}
	};
}

function StoryBackDash_Out( t )
{
	this.LabelClear();
	this.SetMotion(42, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.direction = -this.direction;
	this.freeMap = true;
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.50000000 * this.direction, -0.12500000);

				if (this.IsScreen(300))
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = null;
				}
			};
		}
	];
}

function StorySlideUpper_Out( t )
{
	this.LabelClear();
	this.SetMotion(10, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.centerStop = -3;
			this.SetSpeed_XY(0.00000000, -8.00000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, -0.25000000);

				if (this.IsScreen(300))
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.stateLabel = null;
				}
			};
		}
	];
}

function Stand()
{
	this.GetFront();
	this.VX_Brake(0.50000000);
}

function MoveFront()
{
	if (this.debuff_hate.time <= 0)
	{
		this.GetFront();
	}

	if (this.subState)
	{
		this.subState();
	}

	if (this.input.x * this.direction <= 0 && this.keyTake <= 1 && this.debuff_hate.time <= 0)
	{
		this.subState = null;
		this.SetMotion(1, 2);
		return;
	}

	if (this.keyTake == 2)
	{
		this.VX_Brake(1.00000000);
	}
}

function MoveBack()
{
	if (this.debuff_fear.time <= 0)
	{
		this.GetFront();
	}

	if (this.subState)
	{
		this.subState();
	}

	if (this.input.x * this.direction >= 0 && this.keyTake <= 1 && this.debuff_fear.time <= 0)
	{
		this.subState = null;
		this.SetMotion(2, 2);
		return;
	}

	if (this.keyTake == 2)
	{
		this.VX_Brake(1.00000000);
	}
}

function SlideUp_Common( t )
{
	this.LabelClear();

	if (this.motion == 40 && this.keyTake <= 2)
	{
		this.flag1 = t.dash * this.direction;
	}
	else if (this.input.x == 0)
	{
		this.flag1 = 0.00000000;
	}
	else
	{
		this.flag1 = this.input.x > 0 ? t.front : t.back;
	}

	this.flag2 = t.v;
	this.flag3 = t.v2;
	this.flag4 = t.v3;

	if (this.input.x == 0)
	{
		this.flag5 = 0.00000000;
	}
	else
	{
		this.flag5 = this.input.x > 0 ? t.front_rev : t.back_rev;
	}

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(10, 0);
	}
	else
	{
		this.SetMotion(20, 0);
	}

	this.stateLabel = this.SlideUp;
	this.keyAction = [
		function ()
		{
			if (this.centerStop * this.centerStop > 1)
			{
				this.slideCount++;
				this.airSlide = true;

				if (this.y < this.centerY - 100)
				{
					this.SetSpeed_XY(this.flag1, this.flag2 * 0.80000001);
				}
				else
				{
					this.SetSpeed_XY(this.flag1, this.flag2);
				}
			}
			else
			{
				this.SetSpeed_XY(this.flag1, this.flag2);
			}

			this.GetFront();
			this.centerStop = -3;
			this.disableDash = 4;
			this.graze = 20;
			this.PlaySE(800);
			this.subState = function ()
			{
				if (this.va.y > this.flag3)
				{
					this.SetMotion(this.motion, 3);
					this.subState = function ()
					{
					};
				}
			};
		}
	];
}

function C_SlideUp_Common( t )
{
	this.LabelClear();
	this.SlideUp_Common(t);
	this.SetMotion(20, 0);
	this.keyAction = [
		function ()
		{
			if (this.centerStop * this.centerStop > 1)
			{
				this.slideCount++;
				this.airSlide = true;

				if (this.y < this.centerY - 100)
				{
					this.SetSpeed_XY(this.flag1, this.flag2 * 0.80000001);
				}
				else
				{
					this.SetSpeed_XY(this.flag1, this.flag2);
				}
			}
			else
			{
				this.SetSpeed_XY(this.flag1, this.flag2);
			}

			this.GetFront();
			this.disableGuard = 5;
			this.centerStop = -3;
			this.disableDash = 10;
			this.graze = 20;
			this.PlaySE(800);
			this.subState = function ()
			{
				if (this.va.y > this.flag3)
				{
					this.SetMotion(this.motion, 3);
					this.subState = function ()
					{
					};
				}
			};
		}
	];
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- this.baseSlideSpeed;
	this.Guard_Stance_Common(t_);
}

function Guard_Stance_Common( t )
{
	this.LabelClear();
	this.SetMotion(118, 0);
	this.count = 0;

	if (this.forceBariaCount <= 0)
	{
		this.forceBariaCount = 15;
	}

	this.flag1 = true;
	this.flag4 = t.v;
	this.SetGuardBaria();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.subState = function ()
			{
				this.VX_Brake(2.00000000);
				this.CenterUpdate(this.baseGravity, null);
			};
		}
		else
		{
			this.subState = function ()
			{
				this.CenterUpdate(this.baseGravity, this.flag4);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.subState = function ()
					{
						this.VX_Brake(2.00000000);
						this.CenterUpdate(this.baseGravity, null);
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.team.AddMP(-4, 30);
		this.subState();

		if (this.input.b4 == 0 || ::battle.state != 8)
		{
			this.flag1 = false;
		}

		if (this.count > 6 && !this.flag1)
		{
			this.SetMotion(118, 2);
			this.stateLabel = function ()
			{
				this.team.AddMP(-4, 30);
				this.subState();
			};
		}
	};
}

function SlideUp()
{
	if (this.subState)
	{
		this.subState();
	}

	if (this.keyTake == 0)
	{
		this.Vec_Brake(0.25000000);
	}
	else
	{
		this.CenterUpdate(this.baseGravity, this.flag4);

		if (this.va.y >= 0.00000000)
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.baseGravity, this.flag4);

				if (this.keyTake == 3 || this.keyTake == 4)
				{
					if (this.IsCenter(10.00000000) == 0)
					{
						this.SetMotion(10, 5);
					}
				}
			};
		}
	}
}

function GC_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 2.00000000;
	t_.front <- 2.00000000;
	t_.back <- -2.00000000;
	t_.front_rev <- 2.00000000;
	t_.back_rev <- -2.00000000;
	this.GC_SlideUp_Common(t_);
}

function GC_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 2.00000000;
	t_.front <- 2.00000000;
	t_.back <- -2.00000000;
	t_.front_rev <- 2.00000000;
	t_.back_rev <- -2.00000000;
	this.GC_SlideFall_Common(t_);
}

function GC_SlideUp_Common( t )
{
	this.LabelClear();
	this.SetMotion(22, 0);
	this.ResetSpeed();
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_GuardCancel, {});
	this.PlaySE(818);
	this.team.AddMP(-200, 180);

	if (this.input.x == 0)
	{
		this.flag1 = 0.00000000;
		this.flag5 = 0.00000000;
	}
	else
	{
		this.flag1 = this.input.x > 0 ? t.front : t.back;
		this.flag5 = this.input.x > 0 ? t.front_rev : t.back_rev;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
	this.keyAction = [
		function ()
		{
			if (this.centerStop * this.centerStop > 1)
			{
				this.slideCount++;
				this.airSlide = true;
				this.SetSpeed_XY(this.flag1, -15.50000000);
			}
			else
			{
				this.SetSpeed_XY(this.flag1, -15.50000000);
			}

			this.GetFront();
			this.disableGuard = 10;
			this.centerStop = -3;
			this.disableDash = 20;
			this.graze = 30;
			this.PlaySE(800);
			this.subState = function ()
			{
				this.CenterUpdate(0.82499999, 15.50000000);

				if (this.va.y > -4.00000000)
				{
					this.SetMotion(this.motion, 3);
					this.subState = function ()
					{
						this.CenterUpdate(0.34999999, 10.00000000);
					};
				}
			};
			this.stateLabel = function ()
			{
				if (this.subState)
				{
					this.subState();
				}

				if (this.va.y >= 0.00000000)
				{
					this.stateLabel = function ()
					{
						if (this.subState)
						{
							this.subState();
						}

						if (this.keyTake == 3 || this.keyTake == 4)
						{
							if (this.IsCenter(10.00000000) == 0)
							{
								this.SetMotion(10, 5);
							}
						}
					};
				}
			};
		}
	];
}

function SlideFall_Common( t )
{
	this.LabelClear();

	if (this.motion == 40 && this.keyTake <= 2)
	{
		this.flag1 = t.dash * this.direction;
	}
	else if (this.input.x == 0)
	{
		this.flag1 = 0.00000000;
	}
	else
	{
		this.flag1 = this.input.x > 0 ? t.front : t.back;
	}

	this.flag2 = t.v;
	this.flag3 = t.v2;
	this.flag4 = t.v3;

	if (this.input.x == 0)
	{
		this.flag5 = 0.00000000;
	}
	else
	{
		this.flag5 = this.input.x > 0 ? t.front_rev : t.back_rev;
	}

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetMotion(11, 0);
	}
	else
	{
		this.SetMotion(21, 0);
	}

	this.stateLabel = this.SlideFall;
	this.keyAction = [
		function ()
		{
			if (this.centerStop * this.centerStop > 1)
			{
				this.slideCount++;
				this.airSlide = true;

				if (this.y > this.centerY + 100)
				{
					this.SetSpeed_XY(this.flag1, this.flag2 * 0.80000001);
				}
				else
				{
					this.SetSpeed_XY(this.flag1, this.flag2);
				}
			}
			else
			{
				this.SetSpeed_XY(this.flag1, this.flag2);
			}

			this.GetFront();
			this.centerStop = 3;
			this.disableDash = 4;
			this.graze = 20;
			this.PlaySE(800);
			this.subState = function ()
			{
				if (this.va.y < this.flag3)
				{
					this.SetMotion(this.motion, 3);
					this.subState = function ()
					{
					};
				}
			};
		}
	];
}

function C_SlideFall_Common( t )
{
	this.SlideFall_Common(t);
	this.SetMotion(21, 0);
	this.keyAction = [
		function ()
		{
			if (this.centerStop * this.centerStop > 1)
			{
				this.slideCount++;
				this.airSlide = true;

				if (this.y > this.centerY + 100)
				{
					this.SetSpeed_XY(this.flag1, this.flag2 * 0.80000001);
				}
				else
				{
					this.SetSpeed_XY(this.flag1, this.flag2);
				}
			}
			else
			{
				this.SetSpeed_XY(this.flag1, this.flag2);
			}

			this.GetFront();
			this.disableGuard = 5;
			this.centerStop = 3;
			this.disableDash = 10;
			this.graze = 20;
			this.PlaySE(800);
			this.subState = function ()
			{
				if (this.va.y < this.flag3)
				{
					this.SetMotion(this.motion, 3);
					this.subState = function ()
					{
					};
				}
			};
		}
	];
}

function GC_SlideFall_Common( t )
{
	this.LabelClear();
	this.SetMotion(23, 0);
	this.ResetSpeed();
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_GuardCancel, {});
	this.PlaySE(818);
	this.team.AddMP(-200, 180);

	if (this.input.x == 0)
	{
		this.flag1 = 0.00000000;
		this.flag5 = 0.00000000;
	}
	else
	{
		this.flag1 = this.input.x > 0 ? t.front : t.back;
		this.flag5 = this.input.x > 0 ? t.front_rev : t.back_rev;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
	this.keyAction = [
		function ()
		{
			if (this.centerStop * this.centerStop > 1)
			{
				this.slideCount++;
				this.airSlide = true;
				this.SetSpeed_XY(this.flag1, 15.50000000);
			}
			else
			{
				this.SetSpeed_XY(this.flag1, 15.50000000);
			}

			this.GetFront();
			this.disableGuard = 10;
			this.centerStop = 3;
			this.disableDash = 20;
			this.graze = 30;
			this.PlaySE(800);
			this.subState = function ()
			{
				this.CenterUpdate(0.82499999, 15.50000000);

				if (this.va.y < 4.00000000)
				{
					this.SetMotion(this.motion, 3);
					this.subState = function ()
					{
						this.CenterUpdate(0.34999999, 10.00000000);
					};
				}
			};
			this.stateLabel = function ()
			{
				if (this.subState)
				{
					this.subState();
				}

				if (this.va.y <= 0.00000000)
				{
					this.stateLabel = function ()
					{
						if (this.subState)
						{
							this.subState();
						}

						if (this.keyTake == 3 || this.keyTake == 4)
						{
							if (this.IsCenter(10.00000000) == 0)
							{
								this.SetMotion(10, 5);
							}
						}
					};
				}
			};
		}
	];
}

function SlideFall()
{
	if (this.subState)
	{
		this.subState();
	}

	if (this.keyTake == 0)
	{
		this.Vec_Brake(0.25000000);
	}
	else
	{
		this.CenterUpdate(this.baseGravity, this.flag4);

		if (this.va.y <= 0.00000000)
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.baseGravity, this.flag4);

				if (this.keyTake == 3 || this.keyTake == 4)
				{
					if (this.IsCenter(10.00000000) == 0)
					{
						this.SetMotion(this.motion, 5);
					}
				}
			};
		}
	}
}

function Fall_Init( t )
{
	this.LabelClear();

	if (t)
	{
		this.SetMotion(19, 1);
	}
	else
	{
		this.SetMotion(19, 0);
	}

	this.stateLabel = function ()
	{
		this.GetFront();

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}

		if (this.keyTake <= 1)
		{
			if (this.IsCenter(50.00000000) == 0 && this.va.y <= 2.00000000 || this.va.y < 0.00000000 && this.y > this.centerY)
			{
				this.SetMotion(19, 2);
			}
		}
	};
	this.SetEndMotionCallbackFunction(this.EndtoStand);
}

function Up_Init( t )
{
	this.LabelClear();

	if (t)
	{
		this.SetMotion(18, 1);
	}
	else
	{
		this.SetMotion(18, 0);
	}

	this.stateLabel = function ()
	{
		this.GetFront();

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.50000000);
		}

		if (this.keyTake <= 1)
		{
			if (this.IsCenter(50.00000000) == 0 && this.va.y >= -2.00000000 || this.va.y > 0.00000000 && this.y < this.centerY)
			{
				this.SetMotion(18, 2);
			}
		}
	};
	this.SetEndMotionCallbackFunction(this.EndtoStand);
}

function DashFront_Common( t )
{
	this.flag1 = t.speed;
	this.flag2 = t.maxSpeed;
	this.flag3 = t.addSpeed;
	this.flag4 = t.wait;
	this.flag5 = null;

	if (t == null && this.GetFront.call(this))
	{
		this.DashBack_Init(null);
	}
	else
	{
		this.LabelClear();
		this.SetMotion(40, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(this.flag1 * this.direction, 0.00000000);
		this.SetEffect(this.x, this.y, this.direction, this.EF_Dash, {}, this.weakref());
		this.flag5 = this.SetEffect(this.x, this.y, this.direction, this.EF_DashLine, {}, this.weakref());
		this.count = 0;
		this.lavelClearEvent = function ()
		{
			if (this.flag5)
			{
				this.flag5.func();
				this.flag5 = null;
			}
		};
		this.subState = function ()
		{
		};
		this.stateLabel = function ()
		{
			if ((this.keyTake == 1 || this.keyTake == 2) && this.input.x * this.direction <= 0 || this.count >= this.flag4)
			{
				this.SetMotion(this.motion, 3);

				if (this.flag5)
				{
					this.flag5.func();
					this.flag5 = null;
				}

				this.lavelClearEvent = null;
				this.stateLabel = function ()
				{
					this.Vec_Brake(0.50000000);
				};
				return;
			}

			if (this.centerStop * this.centerStop <= 1)
			{
				if (this.input.y > 0)
				{
					this.command.ban_slide = 1;
					this.SlideFall_Init(null);
					return;
				}
				else if (this.input.y < 0)
				{
					this.command.ban_slide = -1;
					this.SlideUp_Init(null);
					return;
				}
			}

			this.AddSpeed_XY(this.flag3 * this.direction, 0.00000000);

			if (this.va.x * this.direction > this.flag2)
			{
				this.SetSpeed_XY(this.flag2 * this.direction, null);
			}

			this.subState();
		};
	}
}

function DashFront_Air_Init( t )
{
}

function DashFront_Air_Common( t )
{
	this.LabelClear();
	this.SetMotion(42, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.dashCount++;
	this.count = 0;
	this.flag1 = t.speed;
	this.flag2 = t.g;
	this.flag4 = t.wait;
	this.flag5 = t.minWait;
	this.flag5 = {};
	this.flag5.minWait <- t.minWait;
	this.flag5.addSpeed <- t.addSpeed;
	this.flag5.maxSpeed <- t.maxSpeed;
	this.flag5.dashLine <- null;
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.y < 50)
		{
			this.CenterUpdate(0.25000000, 6.00000000);
		}
		else
		{
			this.VY_Brake(0.75000000);
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(801);
			this.count = 0;
			this.SetSpeed_XY(this.flag1 * this.direction, 0.00000000);
			this.lavelClearEvent = function ()
			{
				if (this.flag5.dashLine)
				{
					this.flag5.dashLine.func();
					this.flag5.dashLine = null;
				}
			};
			this.stateLabel = function ()
			{
				if (this.y < 50)
				{
					this.CenterUpdate(0.25000000, 6.00000000);
				}
				else
				{
					this.VY_Brake(0.75000000);
				}

				this.AddSpeed_XY(this.flag5.addSpeed * this.direction, 0.00000000);

				if (this.va.x * this.direction > this.flag5.maxSpeed)
				{
					this.SetSpeed_XY(this.flag5.maxSpeed * this.direction, null);
				}

				if (this.input.x * this.direction <= 0 && this.count >= this.flag5.minWait || this.count >= this.flag4)
				{
					this.SetMotion(42, 3);
					this.lavelClearEvent = null;

					if (this.flag5.dashLine)
					{
						this.flag5.dashLine.func();
						this.flag5.dashLine = null;
					}

					this.stateLabel = function ()
					{
						if (this.centerStop * this.centerStop <= 1)
						{
							this.stateLabel = function ()
							{
								this.VX_Brake(0.50000000);
							};
						}
					};
				}
				else if (this.centerStop * this.centerStop <= 1)
				{
					this.lavelClearEvent = null;

					if (this.flag5.dashLine)
					{
						this.flag5.dashLine.func();
						this.flag5.dashLine = null;
					}

					this.SetMotion(42, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}

				this.subState();
			};
		}
	];
}

function DashBack_Air_Init( t )
{
}

function DashBack_Air_Common( t )
{
	this.LabelClear();
	this.SetMotion(43, 0);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.dashCount++;
	this.flag1 = t.speed;
	this.flag2 = t.g;
	this.flag4 = t.wait;
	this.flag5 = {};
	this.flag5.minWait <- t.minWait;
	this.flag5.dashLine <- null;
	this.stateLabel = function ()
	{
		if (this.y < 50)
		{
			this.CenterUpdate(0.25000000, 6.00000000);
		}
		else
		{
			this.VY_Brake(0.75000000);
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(801);
			this.count = 0;
			this.SetSpeed_XY(this.flag1 * this.direction, null);
			this.lavelClearEvent = function ()
			{
				if (this.flag5.dashLine)
				{
					this.flag5.dashLine.func();
					this.flag5.dashLine = null;
				}
			};
			this.stateLabel = function ()
			{
				if (this.y < 50)
				{
					this.CenterUpdate(0.25000000, 6.00000000);
				}
				else
				{
					this.VY_Brake(0.75000000);
				}

				if (this.input.x * this.direction >= 0 && this.count >= this.flag5.minWait || this.count >= this.flag4)
				{
					this.SetMotion(43, 3);

					if (this.flag5.dashLine)
					{
						this.flag5.dashLine.func();
						this.flag5.dashLine = null;
					}

					this.lavelClearEvent = null;
					this.stateLabel = function ()
					{
						if (this.centerStop * this.centerStop <= 1)
						{
							this.stateLabel = function ()
							{
								this.VX_Brake(0.50000000);
							};
						}
					};
				}
				else if (this.centerStop * this.centerStop <= 1)
				{
					if (this.flag5.dashLine)
					{
						this.flag5.dashLine.func();
						this.flag5.dashLine = null;
					}

					this.lavelClearEvent = null;
					this.SetMotion(43, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		}
	];
}

function Guard_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.flag1 = t.atkRank;
	this.flag2 = t.atk.weakref();
	this.flag3 = t.spellAttack;
	this.hitResult = 1;

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.count = -14;
			this.PlaySE(810);
			this.SetMotion(120, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, null);
			break;

		case 1:
			this.count = -21;
			this.PlaySE(810);
			this.SetMotion(121, 0);
			this.SetSpeed_XY(-14.00000000 * this.direction, null);
			break;

		case 2:
			this.count = -26;
			this.PlaySE(810);
			this.SetMotion(122, 0);
			this.SetSpeed_XY(-18.00000000 * this.direction, null);
			break;

		case 3:
			this.count = -18;
			this.PlaySE(810);
			this.SetMotion(123, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, null);
			break;
		}
	}
	else
	{
		local v_ = 0.00000000;

		if (this.y < this.centerY)
		{
			v_ = -1.00000000;
		}
		else if (this.y > this.centerY)
		{
			v_ = 1.00000000;
		}

		if (v_ < 0.00000000)
		{
			this.centerStop = -2;
		}
		else if (v_ > 0.00000000)
		{
			this.centerStop = 2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.count = -14;
			this.PlaySE(810);
			this.SetMotion(120, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, 2.00000000 * v_);
			break;

		case 1:
			this.count = -21;
			this.PlaySE(810);
			this.SetMotion(121, 0);
			this.SetSpeed_XY(-14.00000000 * this.direction, 2.00000000 * v_);
			break;

		case 2:
			this.count = -26;
			this.PlaySE(810);
			this.SetMotion(122, 0);
			this.SetSpeed_XY(-18.00000000 * this.direction, 2.00000000 * v_);
			break;

		case 3:
			this.count = -18;
			this.PlaySE(810);
			this.SetMotion(123, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, 2.00000000 * v_);
			break;
		}
	}

	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.stateLabel = this.Guard;
	this.keyAction = this.EndtoFreeMove;
}

function JustGuard_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.count = -14;
			this.PlaySE(817);
			this.SetMotion(100, 0);
			this.SetSpeed_XY(-6.00000000 * this.direction, null);
			break;

		case 1:
			this.count = -21;
			this.PlaySE(817);
			this.SetMotion(101, 0);
			this.SetSpeed_XY(-10.00000000 * this.direction, null);
			break;

		case 2:
			this.count = -26;
			this.PlaySE(817);
			this.SetMotion(102, 0);
			this.SetSpeed_XY(-12.50000000 * this.direction, null);
			break;

		case 3:
			this.count = -18;
			this.PlaySE(817);
			this.SetMotion(103, 0);
			this.SetSpeed_XY(-6.00000000 * this.direction, null);
			break;
		}
	}
	else
	{
		local v_ = 0.00000000;

		if (this.y < this.centerY)
		{
			v_ = -1.00000000;
		}
		else if (this.y > this.centerY)
		{
			v_ = 1.00000000;
		}

		if (v_ < 0.00000000)
		{
			this.centerStop = -2;
		}
		else if (v_ > 0.00000000)
		{
			this.centerStop = 2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.count = -14;
			this.PlaySE(817);
			this.SetMotion(100, 0);
			this.SetSpeed_XY(-6.00000000 * this.direction, 4.00000000 * v_);
			break;

		case 1:
			this.count = -21;
			this.PlaySE(817);
			this.SetMotion(101, 0);
			this.SetSpeed_XY(-10.00000000 * this.direction, 4.00000000 * v_);
			break;

		case 2:
			this.count = -26;
			this.PlaySE(817);
			this.SetMotion(102, 0);
			this.SetSpeed_XY(-12.50000000 * this.direction, 4.00000000 * v_);
			break;

		case 3:
			this.count = -18;
			this.PlaySE(817);
			this.SetMotion(103, 0);
			this.SetSpeed_XY(-6.00000000 * this.direction, 4.00000000 * v_);
			break;
		}
	}

	this.invinGrab = 8;
	this.shotGuardCount = 15;

	if (this.hitBackFlag == 1.00000000)
	{
		this.target.bariaBackFlag = 1.00000000;

		if (!this.target.resist_baria)
		{
			this.target.vfBaria.x = -this.va.x * 1.50000000;
		}
	}

	this.stateLabel = this.Guard;
	this.keyAction = this.EndtoFreeMove;
}

function Guard()
{
	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.CenterUpdate(0.75000000, 15.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		this.VX_Brake(1.00000000);
	}
	else
	{
		this.VX_Brake(this.va.x * this.direction <= -4.00000000 ? 1.00000000 * 0.75000000 : 0.00000000);
	}
}

function BariaGuard_Input( t )
{
	this.LabelClear();
	this.target.bariaBackFlag = 1.00000000;
	this.hitResult = 1;
	this.wall = this.IsWall(0.00000000);

	if (!this.freeMap && this.wall)
	{
		if (this.hitBackFlag > 0.00000000 && this.hitBackFlag <= 1.00000000)
		{
			if (this.damageTarget && this.damageTarget.owner)
			{
				if (this.damageTarget.owner.actorType == 1)
				{
					if (this.abs(this.damageTarget.owner.vf.x) < this.abs(this.va.x * this.hitBackFlag))
					{
						this.damageTarget.owner.vf.x = -this.va.x * this.hitBackFlag;
					}
				}
			}

			this.hitBackFlag = 0;
		}
	}

	this.PlaySE(834);
	this.SetMotion(119, 0);

	switch(t.atkRank)
	{
	case 0:
		this.SetSpeed_XY(-7.25000000 * this.direction, 0.00000000);
		break;

	case 1:
		this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
		break;

	case 2:
		this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
		break;

	case 3:
		this.SetSpeed_XY(-7.25000000 * this.direction, 0.00000000);
		break;
	}

	local v_ = this.va.x;

	if (this.flag3)
	{
		local v_ = this.va.x * 0.50000000;
	}

	if (!this.target.resist_baria && this.target.vfBaria.x * this.target.vfBaria.x < v_ * v_)
	{
		this.target.vfBaria.x = -v_;
	}

	this.SetGuardBaria();
	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.stateLabel = function ()
	{
		this.team.AddMP(-4, 30);
		this.invinGrab = 8;
		this.shotGuardCount = 15;
		this.VX_Brake(1.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.CenterUpdate(this.baseGravity, null);
		}
		else
		{
			this.CenterUpdate(0.10000000, null);
		}

		if (this.count >= -13 && this.keyTake == 1)
		{
			this.SetMotion(119, 2);
			this.stateLabel = function ()
			{
				this.team.AddMP(-4, 30);
				this.invinGrab = 8;
				this.shotGuardCount = 15;
				this.VX_Brake(1.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.CenterUpdate(this.baseGravity, null);
				}
				else
				{
					this.CenterUpdate(0.75000000, null);
				}
			};
		}
	};
}

function BariaGuard_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.target.bariaBackFlag = 1.00000000;

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.count = -14;
			this.PlaySE(810);
			this.SetMotion(110, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, null);
			break;

		case 1:
			this.count = -21;
			this.PlaySE(810);
			this.SetMotion(111, 0);
			this.SetSpeed_XY(-14.00000000 * this.direction, null);
			break;

		case 2:
			this.count = -26;
			this.PlaySE(810);
			this.SetMotion(112, 0);
			this.SetSpeed_XY(-18.00000000 * this.direction, null);
			break;

		case 3:
			this.count = -18;
			this.PlaySE(810);
			this.SetMotion(113, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, null);
			break;
		}
	}
	else
	{
		local v_ = 0.00000000;

		if (this.y < this.centerY)
		{
			v_ = -1.00000000;
		}
		else if (this.y > this.centerY)
		{
			v_ = 1.00000000;
		}

		if (v_ < 0.00000000)
		{
			this.centerStop = -2;
		}
		else if (v_ > 0.00000000)
		{
			this.centerStop = 2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.count = -14;
			this.PlaySE(810);
			this.SetMotion(110, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, 0.00000000);
			break;

		case 1:
			this.count = -21;
			this.PlaySE(810);
			this.SetMotion(111, 0);
			this.SetSpeed_XY(-14.00000000 * this.direction, 0.00000000);
			break;

		case 2:
			this.count = -26;
			this.PlaySE(810);
			this.SetMotion(112, 0);
			this.SetSpeed_XY(-18.00000000 * this.direction, 0.00000000);
			break;

		case 3:
			this.count = -18;
			this.PlaySE(810);
			this.SetMotion(113, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, 0.00000000);
			break;
		}
	}

	local v_ = this.va.x * 0.75000000;

	if (t.spellAttack)
	{
		local v_ = this.va.x * 0.50000000;
	}

	if (this.forceBariaCount >= 10 && this.input.b4 <= 6)
	{
		this.forceBariaCount = 9;
		v_ = v_ * 1.50000000;
		this.SetEffect(this.x, this.y, this.direction, this.EF_JustGuardBaria, {});
	}

	if (!this.target.resist_baria && this.target.vfBaria.x * this.target.vfBaria.x < v_ * v_)
	{
		this.target.vfBaria.x = -v_;
	}

	this.SetGuardBaria();
	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.stateLabel = this.BariaGuard;
}

function BariaGuard()
{
	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.team.AddMP(-4, 30);
	this.VX_Brake(1.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		this.CenterUpdate(this.baseGravity, null);
	}
	else
	{
		this.CenterUpdate(0.75000000, null);
	}
}

function BariaBreak_Init( t )
{
	this.LabelClear();
	this.count = 0;
	this.direction = t.direction;
	this.PlaySE(833);
	this.guardBariaCount = -300;
	this.SetMotion(129, 0);

	if (this.centerStop == 0)
	{
		this.SetSpeed_XY(-19.50000000 * this.direction, null);
	}
	else
	{
		local v_ = -1.00000000;

		if (this.y > this.centerY)
		{
			v_ = 1.00000000;
		}

		this.SetSpeed_XY(-19.50000000 * this.direction, 6.00000000 * v_);
	}

	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.invinGrab = 8;
		this.shotGuardCount = 15;

		if (this.va.x * this.direction >= -4.00000000)
		{
			if (this.count <= 30)
			{
				this.VX_Brake(1.00000000 * 0.10000000);
			}
			else
			{
				this.VX_Brake(1.00000000);
			}
		}
		else
		{
			this.VX_Brake(1.00000000);
		}
	};
	this.keyAction = this.EndtoFreeMove;
}

function MissGuard_Init( t )
{
	this.LabelClear();
	this.count = 0;
	this.direction = t.direction;

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.PlaySE(813);
			this.SetMotion(120, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, 0.00000000);
			break;

		case 1:
			this.PlaySE(814);
			this.SetMotion(121, 0);
			this.SetSpeed_XY(-14.00000000 * this.direction, 0.00000000);
			break;

		case 2:
			this.PlaySE(815);
			this.SetMotion(122, 0);
			this.SetSpeed_XY(-18.00000000 * this.direction, 0.00000000);
			break;
		}
	}
	else
	{
		local v_ = -1.00000000;

		if (this.y > this.centerY)
		{
			v_ = 1.00000000;
		}

		switch(t.atkRank)
		{
		case 0:
			this.PlaySE(813);
			this.SetMotion(120, 0);
			this.SetSpeed_XY(-8.00000000 * this.direction, 6.00000000 * v_);
			break;

		case 1:
			this.PlaySE(814);
			this.SetMotion(121, 0);
			this.SetSpeed_XY(-14.00000000 * this.direction, 6.00000000 * v_);
			break;

		case 2:
			this.PlaySE(815);
			this.SetMotion(122, 0);
			this.SetSpeed_XY(-18.00000000 * this.direction, 6.00000000 * v_);
			break;
		}
	}

	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.stateLabel = this.MissGuard;
	this.keyAction = this.EndtoFreeMove;
}

function MissGuard()
{
	this.invinGrab = 8;
	this.shotGuardCount = 15;
	this.VX_Brake(1.00000000);
}

function Avoid_H_Init( t )
{
	this.LabelClear();
	this.SetMotion(35, 0);
	this.SetTimeStop(10);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0.50000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Avoid_F_Init( t )
{
	this.LabelClear();
	this.SetMotion(38, 0);
	this.SetTimeStop(10);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12.50000000 * this.direction, -5.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0.40000001);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Avoid_UP_Init( t )
{
	this.LabelClear();
	this.SetMotion(36, 0);
	this.SetTimeStop(10);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-8.00000000 * this.direction, -15.00000000);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0.50000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Avoid_Fall_Init( t )
{
	this.LabelClear();
	this.SetMotion(37, 0);
	this.SetTimeStop(10);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-8.00000000 * this.direction, 15.00000000);
			this.centerStop = 2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, -0.50000000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Recover_Init( t )
{
	if (this.team.slave && this.team.slave.type != 19 && this.team.op_stop == 0 && this.team.slave_ban == 0 && this.input.b3 > 0)
	{
		this.Team_ChangeRecover_Init(this.input.x, 0);
		return;
	}

	this.LabelClear();
	this.team.ResetCombo();
	this.PlaySE(831);
	this.centerStop = -2;
	this.count = 0;
	this.GetFront();
	this.SetEffect(this.x, this.y, this.direction, this.EF_Recover, {});

	if (t * this.direction >= 1.00000000)
	{
		this.stateLabel = function ()
		{
			this.VX_Brake(0.40000001, 3.00000000 * this.direction);
			this.AddSpeed_XY(0.00000000, 0.50000000);
		};
		this.SetMotion(30, 0);
		this.SetSpeed_XY(this.va.x + 12.00000000 * this.direction, -10.00000000);

		if (this.va.x * this.direction > 12.00000000)
		{
			this.va.x = 12.00000000 * this.direction;
		}

		if (this.va.x * this.direction < 3.00000000)
		{
			this.va.x = 3.00000000 * this.direction;
		}

		this.ConvertTotalSpeed();
	}
	else
	{
		this.stateLabel = function ()
		{
			this.VX_Brake(0.40000001);
			this.AddSpeed_XY(0.00000000, 0.50000000);
		};
		this.SetMotion(31, 0);
		this.SetSpeed_XY(-12.00000000 * this.direction, -10.00000000);
	}

	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
}

function DownRecover_Init( t )
{
	if (this.team.slave && this.team.slave.type != 19 && this.team.op_stop == 0 && this.team.slave_ban == 0 && this.input.b3 > 0)
	{
		this.Team_DownRecover_Init(null);
		return;
	}

	this.LabelClear();
	this.team.ResetCombo();
	this.PlaySE(831);
	this.centerStop = -3;
	this.count = 0;
	this.GetFront();
	this.SetEffect(this.x, this.y, this.direction, this.EF_Recover, {});
	this.Warp(this.x, this.centerY);
	this.SetMotion(38, 0);
	this.SetSpeed_XY(-14.00000000 * this.direction, -6.00000000);
	this.stateLabel = function ()
	{
		this.VX_Brake(0.20000000);
		this.CenterUpdate(0.50000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	};
}

function StandUp_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.centerStop = -2;
	this.count = 0;

	if (t == 0)
	{
		this.SetMotion(37, 0);
		this.centerStop = -2;
		this.SetSpeed_XY(0.00000000, -5.00000000);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, 0.50000000);
		};
	}
	else if (t * this.direction >= 1.00000000)
	{
		this.stateLabel = function ()
		{
			this.VX_Brake(0.15000001);
			this.AddSpeed_XY(0.00000000, 0.50000000);
		};
		this.SetMotion(35, 0);
		this.centerStop = -2;
		this.SetSpeed_XY(12.50000000 * this.direction, -8.00000000);
	}
	else
	{
		this.stateLabel = function ()
		{
			this.VX_Brake(0.15000001);
			this.AddSpeed_XY(0.00000000, 0.50000000);
		};
		this.SetMotion(36, 0);
		this.centerStop = -2;
		this.SetSpeed_XY(-12.50000000 * this.direction, -8.00000000);
	}

	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		},
		function ()
		{
			this.GetFront();
		}
	];
}

function Revibe_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.isVisible = true;
	this.enableStandUp = true;
	this.SetEndMotionCallbackFunction(function ()
	{
		if (::story.demoTalk)
		{
			this.SetEndMotionCallbackFunction(this.EndtoFreeMove);
			this.EndtoFreeMove();
			::RoundStory_BattleDemo();
		}
		else if (this.cpu_bossSpellName && this.cpu_bossSpellName.len() > 0)
		{
			this.EndtoFreeMove();
		}
		else
		{
			this.EndtoFreeMove();
		}
	});
	this.centerStop = -2;
	this.count = 0;
	this.invin = 0;
	this.invinObject = 0;
	this.invinGrab = 0;
	this.SetMotion(37, 0);
	this.centerStop = -2;
	this.SetSpeed_XY(0.00000000, -5.00000000);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		},
		function ()
		{
			this.centerStop = 1;
			this.GetFront();
		}
	];
}

function RecoverContinue_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.SetMotion(308, 0);
	this.centerStop = -2;
	this.count = 0;
	this.GetFront();
	local a_ = this.SetEffect(this.x, this.y, this.direction, this.EF_RevibeContinue, {});
	a_.SetParent(this, 0, 0);
	this.flag5 = a_.weakref();
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			if (this.flag5)
			{
				this.isVisible = true;
				this.enableStandUp = true;
				this.PlaySE(831);
				this.SetParent.call(this.flag5, null, 0, 0);
				this.SetSpeed_XY(0.00000000, -15.00000000);
				this.SetMotion(10, 1);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0.00000000, 0.50000000);

					if (this.va.y > -4.00000000)
					{
						this.SetMotion(10, 3);
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0.00000000, 0.50000000);

							if (this.y > this.centerY)
							{
								this.SetSpeed_XY(0.00000000, 3.00000000);
								this.SetMotion(10, 5);
								this.centerStop = 1;
								this.stateLabel = function ()
								{
								};
							}
						};
					}
				};
			}
		}
	};
}

function TimeUpJump_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.centerStop = -2;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.15000001);
		this.AddSpeed_XY(0.00000000, 0.50000000);
		this.subState();

		if (this.count == 30)
		{
			this.stateLabel = function ()
			{
				this.subState();
				this.VX_Brake(0.15000001);
			};
		}
	};
	this.SetMotion(32, 0);
	this.SetSpeed_XY(-11.00000000 * this.direction, -12.50000000);
}

function DemoRevibe_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.enableStandUp = true;
	this.isVisible = true;
	this.team.life = this.team.lifeMax;
	this.guage.hp_b_max = this.team.lifeMax;
	this.guage.hp_f = this.team.lifeMax;
	this.guage.hp_f_max = this.team.lifeMax;
	this.centerStop = -2;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.15000001);
		this.AddSpeed_XY(0.00000000, 0.40000001);

		if (this.count == 30)
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000);
			};
		}
	};
	this.SetMotion(32, 0);
	this.SetSpeed_XY(-3.00000000 * this.direction, -8.00000000);
}

function GuardCrash_Init( t )
{
	this.LabelClear();

	if (this.team.current == this.team.slave && (this.team.op == 0 || this.team.life <= 0))
	{
		this.PlaySE(900);
		this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
		this.Team_Change_Common();
		this.team.current.Warp(this.x, this.y);
		this.Team_Bench_In();
		this.team.master.damageStopTime = this.damageStopTime;
		this.team.master.recover = this.recover;
		this.team.master.stanCount = this.stanCount;
		this.team.master.invinBoss = this.invinBoss;
		this.team.master.damageTarget = this.damageTarget.weakref();
		this.baria = false;

		if (this.team.regain_life > this.team.life)
		{
			this.team.regain_life = this.team.life;
		}

		this.team.combo_break = true;

		if (this.target.cpuState == null)
		{
			::trophy.OccultBreak(this.target.team.index);
		}

		this.endure = 0;
		this.team.current.GuardCrash_Init(t);
		return;
	}

	this.SetMotion(130, 0);
	this.direction = t.direction;
	this.PlaySE(816);
	this.SetEffect(this.x, this.y, this.direction, this.EF_GuardCrash, {});

	if (t.bariaBreak)
	{
		this.firstRate = 0.60000002;
	}
	else
	{
		this.firstRate = 0.69999999;
	}

	this.target.team.sp_rate = 0.50000000;
	this.count = -30;
	this.stanBossCount = 90;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
	}
	else
	{
		if (this.y < this.centerY)
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-15.00000000 * this.direction, -5.00000000);
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 2;
			this.SetSpeed_XY(-15.00000000 * this.direction, 5.00000000);
		}
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction <= -3.00000000 ? 1.00000000 : 0.05000000);
		this.CenterUpdate(0.25000000, null);

		if (this.count >= 0)
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	};
}

function SlaveCrash_Init( t )
{
	this.LabelClear();

	if (this.team.current == this.team.slave)
	{
		this.PlaySE(900);
		this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
		this.Team_Change_Common();
		this.team.current.Warp(this.x, this.y);
		this.team.slave.Team_Bench_In();
	}

	this.SetMotion(130, 0);
	this.PlaySE(816);
	this.SetEffect(this.x, this.y, this.direction, this.EF_GuardCrash, {});
	this.count = -30;
	this.stanBossCount = 0;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetSpeed_XY(-15.00000000 * this.direction, 0.00000000);
	}
	else
	{
		if (this.y < this.centerY)
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-15.00000000 * this.direction, -5.00000000);
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 2;
			this.SetSpeed_XY(-15.00000000 * this.direction, 5.00000000);
		}
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction <= -3.00000000 ? 1.00000000 : 0.05000000);
		this.CenterUpdate(0.25000000, null);

		if (this.count >= 0)
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	};
}

function SpellPush_Init( t )
{
	this.LabelClear();
	this.SetMotion(130, 0);
	this.direction = t.direction;
	this.count = -30;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetSpeed_XY(-20.00000000 * this.direction, 0.00000000);
	}
	else
	{
		if (this.y < this.centerY)
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-20.00000000 * this.direction, -5.00000000);
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 2;
			this.SetSpeed_XY(-20.00000000 * this.direction, 5.00000000);
		}
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction <= -3.00000000 ? 0.75000000 : 0.10000000);
		this.CenterUpdate(0.50000000, null);

		if (this.count >= 0)
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	};
}

function DamageBody_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;

	if (!t.forceKnock)
	{
		if (this.team.damage_scale <= 1.00000000)
		{
			v_ = 1.00000000 + (1.00000000 - this.team.damage_scale * 1.00000000);
		}
	}

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.89999998;
	}

	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, null);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, null);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, null);
			};
			break;
		}
	}
	else
	{
		if (vy_ > 0.00000000)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, 3.00000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, 4.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function DamageBodyB_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;

	if (!t.forceKnock)
	{
		if (this.team.damage_scale <= 1.00000000)
		{
			v_ = 1.00000000 + (1.00000000 - this.team.damage_scale * 1.00000000);
		}
	}

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.89999998;
	}

	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, null);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, null);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, null);
			};
			break;
		}
	}
	else
	{
		if (vy_ > 0.00000000)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, 3.00000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, 4.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function DamageBodyShort_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;

	if (!t.forceKnock)
	{
		if (this.team.damage_scale <= 1.00000000)
		{
			v_ = 1.00000000 + (1.00000000 - this.team.damage_scale * 1.00000000);
		}
	}

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.89999998;
	}

	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-6.50000000 * this.direction * v_, null);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-9.00000000 * this.direction * v_, null);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-12.50000000 * this.direction * v_, null);
			};
			break;
		}
	}
	else
	{
		if (vy_ > 0.00000000)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-6.50000000 * this.direction * v_, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-9.00000000 * this.direction * v_, 3.00000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-12.50000000 * this.direction * v_, 4.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function DamageHead_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;

	if (!t.forceKnock)
	{
		if (this.team.damage_scale <= 1.00000000)
		{
			v_ = 1.00000000 + (1.00000000 - this.team.damage_scale * 1.00000000);
		}
	}

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.89999998;
	}

	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, null);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, null);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, null);
			};
			break;
		}
	}
	else
	{
		if (vy_ > 0.00000000)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, 3.00000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, 4.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function DamageHeadB_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;

	if (!t.forceKnock)
	{
		if (this.team.damage_scale <= 1.00000000)
		{
			v_ = 1.00000000 + (1.00000000 - this.team.damage_scale * 1.00000000);
		}
	}

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.89999998;
	}

	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, null);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, null);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, null);
			};
			break;
		}
	}
	else
	{
		if (vy_ > 0.00000000)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-7.50000000 * this.direction * v_, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-11.00000000 * this.direction * v_, 3.00000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-17.50000000 * this.direction * v_, 4.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function DamageHeadShort_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;

	if (!t.forceKnock)
	{
		if (this.team.damage_scale <= 1.00000000)
		{
			v_ = 1.00000000 + (1.00000000 - this.team.damage_scale * 1.00000000);
		}
	}

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.89999998;
	}

	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-6.50000000 * this.direction * v_, null);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-9.00000000 * this.direction * v_, null);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-12.50000000 * this.direction * v_, null);
			};
			break;
		}
	}
	else
	{
		if (vy_ > 0.00000000)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(-6.50000000 * this.direction * v_, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(-9.00000000 * this.direction * v_, 3.00000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(-12.50000000 * this.direction * v_, 4.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function DamageHeadPull_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;
	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(7.50000000 * this.direction, null);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(11.00000000 * this.direction, null);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(17.50000000 * this.direction, null);
			};
			break;
		}
	}
	else
	{
		if (vy_ > 0.00000000)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(200, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(7.50000000 * this.direction, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(200, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(11.00000000 * this.direction, 2.50000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(200, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(17.50000000 * this.direction, 3.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function DamageBodyPull_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.recover = -1;
	local v_ = 1.00000000;
	local vy_ = -1.00000000;

	if (this.y > this.centerY)
	{
		vy_ = 1.00000000;
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.centerStop * this.centerStop <= 1)
	{
		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(7.50000000 * this.direction, null);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(11.00000000 * this.direction, null);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(17.50000000 * this.direction, null);
			};
			break;
		}
	}
	else
	{
		if (this.centerStop >= 2)
		{
			this.centerStop = 2;
		}
		else
		{
			this.centerStop = -2;
		}

		switch(t.atkRank)
		{
		case 0:
			this.SetMotion(201, 0);
			this.func = function ()
			{
				this.SetSpeed_XY(7.50000000 * this.direction, 2.00000000 * vy_);
			};
			break;

		case 1:
			this.SetMotion(201, 2);
			this.func = function ()
			{
				this.SetSpeed_XY(11.00000000 * this.direction, 2.50000000 * vy_);
			};
			break;

		case 2:
			this.SetMotion(201, 4);
			this.func = function ()
			{
				this.SetSpeed_XY(17.50000000 * this.direction, 3.00000000 * vy_);
			};
			break;
		}
	}

	this.stateLabel = this.Damage;
	this.keyAction = this.EndtoFreeMove;
}

function Damage()
{
	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (this.damageStopTime <= 0)
	{
		if (this.func)
		{
			this.func();
		}

		this.SetMotion(this.motion, this.keyTake + 1);
		this.stateLabel = function ()
		{
			if (this.team.life > 0)
			{
			}

			this.VX_Brake(1.00000000);
			this.CenterUpdate(0.50000000 * 0.50000000, null);
		};
	}
}

function DamageBack_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.60000002;
	}

	if (this.hitBackFlag == 2)
	{
		this.hitBackFlag = 1.60000002;
	}

	this.centerStop = -2;
	this.count = 0;

	if (t.atkRank == 2)
	{
		this.func = function ()
		{
			this.SetSpeed_XY(-35.00000000 * this.direction, -2.00000000);
		};
	}
	else
	{
		this.func = function ()
		{
			this.SetSpeed_XY(-25.00000000 * this.direction, -2.00000000);
		};
		  // [047]  OP_JMP            0      0    0    0
	}

	this.stateLabel = function ()
	{
		this.SetSpeed_XY(0.00000000, 0.00000000);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0.10000000);

				if (this.count >= 2)
				{
					this.hitBackFlag = 0;
				}

				if (!this.freeMap && this.wall == -this.direction)
				{
					this.DamageWall_Init(null);
					return;
				}
			};
		}
	};
	this.SetMotion(210, 0);
}

function DamageBackLong_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.60000002;
	}

	if (this.hitBackFlag == 2)
	{
		this.hitBackFlag = 1.60000002;
	}

	this.centerStop = -2;
	this.count = 0;
	this.func = function ()
	{
		this.SetSpeed_XY(-35.00000000 * this.direction, -2.00000000);
	};
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(0.00000000, 0.00000000);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0.10000000);

				if (this.count >= 2)
				{
					this.hitBackFlag = 0;
				}

				if (!this.freeMap && this.wall == -this.direction)
				{
					this.DamageWallLong_Init(null);
					return;
				}
			};
		}
	};
	this.SetMotion(210, 0);
}

function DamageBodySmash_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;

	if (this.hitBackFlag == 1)
	{
		this.hitBackFlag = 0.60000002;
	}

	if (this.hitBackFlag == 2)
	{
		this.hitBackFlag = 1.60000002;
	}

	this.count = 0;

	if (t.atkRank == 2)
	{
		this.func = function ()
		{
			this.SetSpeed_XY(-25.00000000 * this.direction, 0.00000000);
		};
	}
	else
	{
		this.func = function ()
		{
			this.SetSpeed_XY(-20.00000000 * this.direction, 0.00000000);
		};
		  // [043]  OP_JMP            0      0    0    0
	}

	this.SetMotion(202, 0);
	this.stateLabel = function ()
	{
		this.SetSpeed_XY(0.00000000, 0.00000000);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
				this.CenterUpdate(0.50000000 * 0.50000000, 6.00000000);

				if (!this.freeMap && this.wall == -this.direction && this.keyTake <= 1)
				{
					this.DamageWall_Init(null);
					return;
				}
			};
		}
	};
}

function DamageDown_Init( t )
{
	this.count = 0;
	this.stanCount = 20;

	if (this.recover > 20)
	{
		this.recover = 20;
	}

	this.SetSpeed_XY(this.va.x * this.direction <= -5.00000000 ? -5.00000000 * this.direction : null, this.va.y >= 0.00000000 ? 3.00000000 : -3.00000000);
	this.stateLabel = function ()
	{
		if (this.recover <= 0)
		{
			if (this.stanBossCount <= 0 && this.count <= 15 && this.input.x * this.direction < 0 && this.enableStandUp && this.centerStop * this.centerStop <= 1)
			{
				if (this.team.combo_stun < 100 && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b4 > 0))
				{
					this.Recover_Init(this.input.x);
					return;
				}

				if (this.team.slave && this.team.slave.type != 19 && this.team.op_stop == 0 && this.team.slave_ban == 0 && this.input.b3 > 0)
				{
					this.stanCount = 0;
					this.Team_ChangeRecover_Init(this.input.x, 0);
					return;
				}
			}
		}

		this.VX_Brake(0.30000001);
		this.stanCount--;

		if (this.enableStandUp && this.stanCount <= 0 && this.stanBossCount <= 0 && this.centerStop == 0)
		{
			if (this.team.slave && this.team.slave.type != 19 && this.team.op_stop == 0 && this.team.slave_ban == 0 && this.input.b3 > 0)
			{
				this.Team_ChangeStandUp_Init(this.input.x);
				return;
			}

			this.StandUp_Init(this.input.x);
			return;
		}
	};
}

function DamageBackSpin_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = -2;
	this.SetMotion(213, 0);
	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;
	this.flag3 = this.y;
	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.subState = function ()
	{
		if (this.team.life > 0)
		{
			if (this.team.combo_stun >= 100)
			{
			}
			else if (this.stanBossCount <= 0 && this.enableStandUp && this.recover <= 0 && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
			{
				this.Recover_Init(this.input.x);
			}
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.keyTake <= 2)
				{
					if (!this.freeMap && this.wall == -this.direction)
					{
						this.DamageWall_Init(null);
						return;
					}

					if (this.va.y <= -6.00000000)
					{
						this.AddSpeed_XY(null, 0.50000000 * 1.50000000);
					}
					else
					{
						this.AddSpeed_XY(null, 0.50000000 * 0.50000000);

						if (this.va.x * this.direction >= -2.00000000 && this.va.x * this.direction < 0.00000000)
						{
							this.SetSpeed_XY(-2.00000000 * this.direction, null);
						}
					}

					if (this.keyTake == 2 && this.va.y >= -3.00000000)
					{
						this.SetMotion(this.motion, 3);
					}
				}
				else
				{
					if (this.keyTake <= 4)
					{
						if (!this.freeMap && this.wall == -this.direction)
						{
							this.DamageWall_Init(null);
							return;
						}

						this.AddSpeed_XY(null, 0.50000000 * 0.50000000);
					}

					if ((this.flag3 <= this.centerY && this.y >= this.centerY || this.flag3 > this.centerY && this.y >= this.flag3) && this.va.y > 0.00000000)
					{
						this.SetMotion(211, 5);
						this.centerStop = 1;
						this.DamageDown_Init(null);
						return;
					}
				}

				this.subState();
			};
		}
	};
}

function DamageBackLongSpin_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = -2;
	this.SetMotion(213, 0);
	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;
	this.flag3 = this.y;
	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.subState = function ()
	{
		if (this.team.life > 0)
		{
			if (this.team.combo_stun >= 100)
			{
			}
			else if (this.stanBossCount <= 0 && this.enableStandUp && this.recover <= 0 && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
			{
				this.Recover_Init(this.input.x);
			}
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.keyTake <= 2)
				{
					if (!this.freeMap && this.wall == -this.direction)
					{
						this.DamageWallLong_Init(null);
						return;
					}

					if (this.va.y <= -6.00000000)
					{
						this.AddSpeed_XY(null, 0.50000000 * 1.50000000);

						if (this.y < ::battle.scroll_top + 128.00000000)
						{
							this.AddSpeed_XY(null, 0.50000000 * 1.00000000);
						}
					}
					else
					{
						this.AddSpeed_XY(null, 0.50000000 * 0.50000000);

						if (this.va.x * this.direction >= -2.00000000 && this.va.x * this.direction < 0.00000000)
						{
							this.SetSpeed_XY(-2.00000000 * this.direction, null);
						}
					}

					if (this.keyTake == 2 && this.va.y >= -3.00000000)
					{
						this.SetMotion(this.motion, 3);
					}
				}
				else
				{
					if (this.keyTake <= 4)
					{
						if (!this.freeMap && this.wall == -this.direction)
						{
							this.DamageWallLong_Init(null);
							return;
						}

						this.AddSpeed_XY(null, 0.50000000 * 0.50000000);
					}

					if (this.flag3 <= this.centerY && this.y >= this.centerY || (this.flag3 > this.centerY && this.y >= this.flag3) && this.va.y > 0.00000000)
					{
						this.SetMotion(211, 5);
						this.centerStop = 1;
						this.DamageDown_Init(null);
						return;
					}
				}

				this.subState();
			};
		}
	};
}

function DamageWall_Init( t )
{
	this.LabelClear();
	::camera.Shake(3.00000000);
	local t_ = {};
	t_.num <- 5;
	this.SetFreeObject(this.x, this.y - 20, 1.00000000, this.Occult_PowerCreatePoint, t_);
	this.hitBackFlag = 0;
	this.stateLabel = this.DamageWall;
	this.team.combo_wall++;
	this.va.y = 0.00000000;
	this.va.x = 0.00000000;
	this.SetMotion(220, 0);
	this.PlaySE(840);
	this.SetEffect(this.x - 25 * this.direction, this.y, this.direction, this.EF_HitWall, {});
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(5.00000000 * this.direction, -4.50000000);

			if (this.team.combo_wall >= 2)
			{
				this.SetRecoverFrame(0);
			}
			else
			{
				this.SetRecoverFrame(-30);
			}
		}
	];
	this.count = 0;
}

function DamageWall()
{
	if (this.keyTake == 0 && this.team.combo_wall >= 2 && this.count >= 6 && this.team.combo_stun == 0)
	{
		this.keyAction[0].call(this);
		this.SetMotion(220, 1);
		return;
	}

	if (this.keyTake >= 2)
	{
		this.VX_Brake(0.20000000);
	}

	if (this.keyTake == 1 || this.keyTake == 2)
	{
		this.va.y += 0.25000000;

		if (this.va.y >= 3.00000000)
		{
			this.va.y = 3.00000000;
		}
	}

	if (this.recover <= 0 && this.keyTake == 2)
	{
		if (this.stanBossCount > 0)
		{
			this.DamageBossStan_Init(null);
			return;
		}

		if (this.team.combo_stun >= 100 || this.team.life <= 0)
		{
			this.DamageStan_Init(null);
			return;
		}
		else
		{
			this.SetMotion(220, 3);
			this.keyAction = function ()
			{
				this.autoGuardCount = 9;
			};
		}
	}
}

function DamageWallLong_Init( t )
{
	this.LabelClear();
	::camera.Shake(3.00000000);
	local t_ = {};
	t_.num <- 5;
	this.SetFreeObject(this.x, this.y - 20, 1.00000000, this.Occult_PowerCreatePoint, t_);
	this.hitBackFlag = 0;
	this.stateLabel = this.DamageWallLong;
	this.team.combo_wall++;
	this.va.y = 0.00000000;
	this.va.x = 0.00000000;
	this.SetMotion(220, 0);
	this.PlaySE(840);
	this.SetEffect(this.x - 25 * this.direction, this.y, this.direction, this.EF_HitWall, {});
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(5.00000000 * this.direction, -7.50000000);

			if (this.team.combo_wall >= 2)
			{
				this.SetRecoverFrame(0);
			}
			else
			{
				this.SetRecoverFrame(-30);
			}
		}
	];
}

function DamageWallLong()
{
	if (this.keyTake >= 2)
	{
		this.VX_Brake(0.20000000);
	}

	if (this.keyTake == 1 || this.keyTake == 2)
	{
		this.va.y += 0.25000000;

		if (this.va.y >= 3.00000000)
		{
			this.va.y = 3.00000000;
		}

		this.SetSpeed_XY(this.va.x, this.va.y);
	}

	if (this.recover <= 0 && this.keyTake == 2)
	{
		if (this.stanBossCount > 0)
		{
			this.DamageBossStan_Init(null);
			return;
		}

		if (this.team.combo_stun >= 100)
		{
			this.DamageStan_Init(null);
		}
		else if (this.team.combo_wall >= 2)
		{
			this.SetMotion(220, 3);
		}
		else
		{
			this.LabelClear();
			this.SetMotion(221, 0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.20000000);

				if (this.count >= 45)
				{
					this.SetMotion(221, 2);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.20000000);
					};
				}
			};
		}
	}
}

function DamageUnder_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;

	if (t.hitVecY < 0)
	{
		t.hitVecY = -t.hitVecY;
	}

	this.centerStop = 2;
	this.SetMotion(212, 0);
	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.subState = function ()
	{
		if (this.IsCenter(0.00000000) >= 0.00000000)
		{
			this.AddSpeed_XY(null, -0.50000000 * 1.50000000);
		}
		else
		{
			this.AddSpeed_XY(null, 0.50000000);
		}

		if (this.keyTake == 2 && this.va.y <= 4.00000000)
		{
			this.SetMotion(this.motion, 3);
			this.subState = function ()
			{
				this.CenterUpdate(0.50000000, 20.00000000);
				this.VX_Brake(0.10000000);

				if (this.keyTake == 3 || this.keyTake == 4)
				{
					if (this.y <= this.centerY)
					{
						this.count = 0;
						this.SetMotion(this.motion, 5);
						this.centerStop = -1;
						this.DamageDown_Init(null);
						return;
					}
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				if (this.team.life > 0 && this.recover <= 0)
				{
					if (this.team.combo_stun >= 100)
					{
					}
					else if (this.stanBossCount <= 0 && this.enableStandUp && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
					{
						this.Recover_Init(this.input.x);
						return;
					}
				}

				this.subState();
			};
		}
	};
}

function DamageUnderLight_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = 3;
	this.SetMotion(212, 0);

	if (t.hitVecY < 0)
	{
		t.hitVecY = -t.hitVecY;
	}

	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;
	this.flag3 = this.y;
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.subState = function ()
	{
		if (this.IsCenter(0.00000000) >= 0.00000000)
		{
			this.AddSpeed_XY(null, this.va.y > 0.00000000 ? -0.50000000 * 1.50000000 : -0.50000000);
		}
		else
		{
			this.AddSpeed_XY(null, 0.50000000);
		}

		if (this.centerStop == 3 && this.y > this.centerY)
		{
			this.centerStop = 2;

			if (this.va.y > this.flag1.vy)
			{
				this.SetSpeed_XY(null, this.flag1.vy);
			}
		}

		if (this.keyTake == 2 && this.va.y <= 4.00000000)
		{
			this.SetMotion(this.motion, 3);
			this.subState = function ()
			{
				this.CenterUpdate(0.50000000, 20.00000000);
				this.VX_Brake(0.10000000);

				if (this.keyTake == 3 || this.keyTake == 4)
				{
					if (this.y <= this.centerY)
					{
						this.SetMotion(this.motion, 5);
						this.centerStop = -1;
						this.DamageDown_Init(null);
						return;
					}
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.team.life > 0 && this.recover <= 0)
				{
					if (this.team.combo_stun >= 100)
					{
					}
					else if (this.stanBossCount <= 0 && this.enableStandUp && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
					{
						this.Recover_Init(this.input.x);
						return;
					}
				}

				this.subState();
			};
		}
	};
}

function DamageUnderSmash_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = 2;
	this.SetMotion(212, 0);
	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.keyTake <= 2)
				{
					if (this.ground)
					{
						this.DamageGround_Init(null);
						return;
					}
				}
			};
		}
	};
}

function DamageGround_Init( t )
{
	this.LabelClear();
	::camera.Shake(3.00000000);
	local t_ = {};
	t_.num <- 5;
	this.SetFreeObject(this.x, this.y - 20, 1.00000000, this.Occult_PowerCreatePoint, t_);
	this.PlaySE(841);
	this.hitBackFlag = 0;
	this.centerStop = 2;
	this.SetMotion(225, 0);
	this.team.combo_ground++;
	this.SetEffect(this.x, this.y, this.direction, this.EF_HitGround, {});
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x;
	this.flag1.y = this.va.y;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.subState = function ()
	{
		if (this.team.life > 0 && this.recover <= 0)
		{
			if (this.team.combo_stun >= 100)
			{
			}
			else if (this.stanBossCount <= 0 && this.enableStandUp && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
			{
				this.Recover_Init(this.input.x);
				return true;
			}
		}
	};
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.count = 0;
			this.SetSpeed_XY(this.flag1.x * 0.50000000, -this.flag1.y * 0.75000000);

			if (this.team.combo_ground >= 2 && !this.forceKnock)
			{
				this.SetRecoverFrame(0);
			}
			else if (this.recover < 30)
			{
				this.SetRecoverFrame(-30);
			}

			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				if (this.y < this.centerY)
				{
					this.AddSpeed_XY(0.00000000, 0.50000000 * 2.00000000);
				}
				else
				{
					this.AddSpeed_XY(0.00000000, 0.50000000);
				}

				if (this.va.y > 6.00000000)
				{
					this.DamageDown_Init(null);
					this.SetMotion(this.motion, 3);
					this.centerStop = -2;
					return;
				}
			};
		}
	];
}

function DamageUpper_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = -2;

	if (t.hitVecY > 0)
	{
		t.hitVecY = -t.hitVecY;
	}

	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;

	if (this.y <= this.centerY)
	{
		this.flag3 = this.centerY;
	}
	else
	{
		this.flag3 = this.y;
	}

	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.SetMotion(211, 0);
	this.subState = function ()
	{
		if (this.team.life > 0 && this.recover <= 0)
		{
			if (this.team.combo_stun >= 100)
			{
			}
			else if (this.stanBossCount <= 0 && this.enableStandUp && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
			{
				this.Recover_Init(this.input.x);
			}
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.va.y < 0.00000000)
				{
					this.AddSpeed_XY(null, 0.50000000 * 1.50000000);
				}
				else
				{
					this.va.y += 0.50000000;

					if (this.va.y > 20.00000000)
					{
						this.va.y = 20.00000000;
					}

					this.SetSpeed_XY(this.va.x, this.va.y);
				}

				if (this.keyTake <= 2)
				{
					if (this.keyTake == 2 && this.va.y >= -3.00000000)
					{
						this.SetMotion(this.motion, 3);
					}
				}
				else
				{
					if (this.y < this.centerY)
					{
						this.flag3 = this.centerY;
					}

					if ((this.y >= this.flag3 || this.y > this.centerY && this.va.y > 6.00000000) && this.va.y > 0.00000000)
					{
						this.centerStop = 1;
						this.SetMotion(this.motion, 5);
						this.DamageDown_Init(null);
						return;
					}
				}

				this.subState();
			};
		}
	};
}

function DamageUpperLight_Init( t )
{
	this.DamageUpper_Loop(t);
	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.flag1.g <- 1.50000000;
	this.flag1.fallG <- 1.00000000;
}

function DamageUpperHeavy_Init( t )
{
	this.DamageUpper_Loop(t);
	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.flag1.g <- 1.50000000;
	this.flag1.fallG <- 1.50000000;
}

function DamageUpper_Loop( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = -2;
	this.SetMotion(211, 0);

	if (t.hitVecY > 0)
	{
		t.hitVecY = -t.hitVecY;
	}

	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

	if (this.y <= this.centerY)
	{
		this.flag3 = this.centerY;
	}
	else
	{
		this.flag3 = this.y;
	}

	this.subState = function ()
	{
		if (this.team.life > 0 && this.recover <= 0)
		{
			if (this.team.combo_stun >= 100)
			{
			}
			else if (this.stanBossCount <= 0 && this.enableStandUp && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
			{
				this.Recover_Init(this.input.x);
			}
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			if (this.func)
			{
				this.func();
			}

			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.va.y < 0.00000000)
				{
					this.AddSpeed_XY(null, 0.50000000 * this.flag1.g);
				}
				else
				{
					this.va.y += 0.50000000 * this.flag1.fallG;

					if (this.va.y > 20.00000000)
					{
						this.va.y = 20.00000000;
					}

					this.SetSpeed_XY(null, null);
				}

				if (this.keyTake <= 2)
				{
					if (this.keyTake == 2 && this.va.y >= -3.00000000)
					{
						this.SetMotion(this.motion, 3);
					}
				}
				else
				{
					if (this.y < this.centerY)
					{
						this.flag3 = this.centerY;
					}

					if ((this.y >= this.flag3 || this.y > this.centerY && this.va.y > 6.00000000) && this.va.y > 0.00000000)
					{
						this.SetMotion(this.motion, 5);
						this.centerStop = 1;
						this.DamageDown_Init(null);
						return;
					}
				}

				this.subState();
			};
		}
	};
}

function DamageUpperSpin_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = -2;
	this.SetMotion(213, 0);

	if (t.hitVecY > 0)
	{
		t.hitVecY = -t.hitVecY;
	}

	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;

	if (this.y <= this.centerY)
	{
		this.flag3 = this.centerY;
	}
	else
	{
		this.flag3 = this.y;
	}

	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.subState = function ()
	{
		if (this.team.life > 0 && this.recover <= 0)
		{
			if (this.team.combo_stun >= 100)
			{
			}
			else if (this.stanBossCount <= 0 && this.enableStandUp && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
			{
				this.Recover_Init(this.input.x);
			}
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			this.func();
			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.keyTake <= 2)
				{
					if (this.va.y <= -6.00000000)
					{
						this.AddSpeed_XY(null, 0.50000000 * 1.50000000);

						if (this.y < ::battle.scroll_top + 128.00000000)
						{
							this.AddSpeed_XY(null, 0.50000000 * 1.00000000);
						}
					}
					else
					{
						this.va.y += 0.50000000 * 0.50000000;

						if (this.va.y > 20.00000000)
						{
							this.va.y = 20.00000000;
						}

						this.SetSpeed_XY(this.va.x, this.va.y);
						this.VX_Brake(0.10000000);

						if (this.va.x * this.direction >= -2.00000000 && this.va.x * this.direction < 0.00000000)
						{
							this.SetSpeed_XY(-2.00000000 * this.direction, null);
						}
					}

					if (this.va.y >= -3.00000000)
					{
						this.SetMotion(this.motion, 3);
					}
				}
				else
				{
					if (this.keyTake <= 4)
					{
						this.AddSpeed_XY(null, 0.50000000 * 1.00000000);
					}

					if (this.y < this.centerY)
					{
						this.flag3 = this.centerY;
					}

					if ((this.y >= this.flag3 || this.y > this.centerY && this.va.y > 6.00000000) && this.va.y > 0.00000000)
					{
						this.SetMotion(211, 5);
						this.centerStop = 1;
						this.DamageDown_Init(null);
						return;
					}

					this.VX_Brake(0.10000000);
				}

				this.subState();
			};
		}
	};
}

function DamageTagSpin_Init( t )
{
	this.LabelClear();
	this.direction = t.direction;
	this.centerStop = -2;
	this.SetMotion(213, 0);

	if (t.hitVecY > 0)
	{
		t.hitVecY = -t.hitVecY;
	}

	this.flag1 = {};
	this.flag1.vx <- t.hitVecX;
	this.flag1.vy <- t.hitVecY;
	this.flag2 = this.Vector3();
	this.flag2.x = t.stopVecX;
	this.flag2.y = t.stopVecY;

	if (this.y <= this.centerY)
	{
		this.flag3 = this.centerY;
	}
	else
	{
		this.flag3 = this.y;
	}

	this.func = function ()
	{
		this.SetSpeed_XY(this.flag1.vx * this.direction, this.flag1.vy);
	};
	this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);
	this.subState = function ()
	{
		if (this.team.life > 0 && this.recover <= 0)
		{
			if (this.team.combo_stun >= 100)
			{
			}
			else if (this.stanBossCount <= 0 && this.enableStandUp && (this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0 || this.input.b4 > 0))
			{
				this.Recover_Init(this.input.x);
			}
		}
	};
	this.stateLabel = function ()
	{
		this.hitBackFlag = 0;
		this.SetSpeed_XY(this.flag2.x * this.direction, this.flag2.y);

		if (this.damageStopTime <= 0)
		{
			this.func();
			this.SetMotion(this.motion, this.keyTake + 1);
			this.stateLabel = function ()
			{
				if (this.keyTake <= 2)
				{
					if (this.va.y < -2.00000000)
					{
						this.AddSpeed_XY(null, 0.50000000 * 2.00000000);
					}
					else
					{
						this.VX_Brake(0.25000000, -1.00000000 * this.direction);

						if (this.va.y < 2.00000000)
						{
							this.AddSpeed_XY(null, 0.15000001);
						}
						else
						{
							this.SetMotion(this.motion, 3);
						}
					}
				}
				else
				{
					if (this.keyTake <= 4)
					{
						this.AddSpeed_XY(null, 0.50000000 * 1.00000000);
					}

					if ((this.flag3 <= this.centerY && this.y >= this.centerY || this.flag3 > this.centerY && this.y >= this.flag3) && this.va.y > 0.00000000)
					{
						this.SetMotion(211, 5);
						this.centerStop = 1;
						this.DamageDown_Init(null);
						return;
					}

					this.VX_Brake(0.10000000);
				}

				this.subState();
			};
		}
	};
}

function DamageHeightSelect_Init( t )
{
	if (this.centerStop * this.centerStop > 2 && this.y > this.centerY)
	{
		t.hitVecY = -t.hitVecY;
		this.DamageUnderLight_Init(t);
	}
	else
	{
		this.DamageUpperLight_Init(t);
	}
}

function DamageBullet_Init( t )
{
	this.vf.x = -15.00000000 * t.direction;
}

function DamageStan_Init( t )
{
	this.LabelClear();
	this.SetMotion(290, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y);
	this.count = 0;
	this.flag1 = 0;
	this.recover = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.25000000);
		this.stanCount--;

		if (this.enableStandUp && this.stanCount <= this.flag1 && this.stanBossCount <= 0)
		{
			this.stanCount = 0;

			if (this.team.slave && this.team.slave.type != 19 && this.team.op_stop == 0 && this.team.slave_ban == 0 && this.team.op >= 1000 && this.input.b3 > 0)
			{
				this.Team_ChangeStandUp_Init(this.input.x);
				return;
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
			this.SetMotion(this.motion, 2);
		}
	};
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.FreeReset();
		}
	];
}

function DamageBossStan_Init( t )
{
	this.LabelClear();
	this.SetMotion(290, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y);
	this.stateLabel = function ()
	{
		this.VX_Brake(0.25000000);

		if (this.enableStandUp && this.stanBossCount <= 0)
		{
			this.team.ResetCombo();
			this.stateLabel = function ()
			{
				this.VX_Brake(0.25000000);
			};
			this.SetMotion(this.motion, 2);
		}
	};
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.FreeReset();
		}
	];
}

function DamageKO_Init( t )
{
	this.LabelClear();
	this.SetMotion(290, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y);
	this.stateLabel = function ()
	{
		this.VX_Brake(0.25000000);
	};
}

function DamageGrab_Common( motion_, take_, direction_ )
{
	this.LabelClear();
	this.SetSpeed_XY(0.00000000, 0.00000000);

	if (direction_)
	{
		this.direction = direction_;
	}

	this.SetMotion(motion_, take_);
	this.stateLabel = function ()
	{
	};
}

function DamageGrab_Head_Init( t )
{
	this.DamageGrab_Common(t);
	this.SetMotion(300, 0);
}

function DamageGrab_Body_Init( t )
{
	this.DamageGrab_Common(t);
	this.SetMotion(301, 0);
}

function Damage_Slice( t )
{
	this.LabelClear();
	this.SetMotion(311, 2);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Damage_SliceUnder, {}).weakref();
	this.rz = 10 * 0.01745329;
	this.lavelClearEvent = function ()
	{
		this.rz = 0.00000000;

		if (this.flag1)
		{
			this.flag1.ReleaseActor();
		}
	};
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.30000001);
				this.flag1.Warp(this.x, this.centerY);

				if (this.y >= this.centerY)
				{
					this.rz = 0;

					if (this.flag1)
					{
						this.flag1.ReleaseActor();
					}

					this.flag1 = null;
					this.SetMotion(211, 5);
					this.SetSpeed_XY(0.00000000, 3.00000000);
					this.centerStop = 1;
					this.DamageDown_Init(null);
					return;
				}
			};
		}
	];
	this.SetSpeed_XY(-2.00000000 * this.direction, -18.00000000);
	this.stateLabel = function ()
	{
		this.Vec_Brake(1.85000002, 0.25000000);
		this.flag1.Warp(this.x, this.centerY);
	};
}

function Damage_SliceUnder( t )
{
	this.SetMotion(311, 3);
	this.rz = 10 * 0.01745329;
	this.red = this.green = this.blue = 0.00000000;
	this.DrawActorPriority(1000);
	this.stateLabel = function ()
	{
		this.red = this.owner.red;
		this.green = this.owner.green;
		this.blue = this.owner.blue;
	};
}

function DamageFinish( t )
{
	this.LabelClear();
	this.SetMotion(211, 0);

	if (this.damageStopTime > 10)
	{
		this.damageStopTime = 10;
	}

	this.direction = t.direction;
	this.invin = -1;
	this.invinGrab = -1;
	this.invinObject = -1;
	this.SetSpeed_XY(-2.50000000 * this.direction, -2.50000000);
	this.centerStop = -3;
	this.count = 0;
	this.func = function ()
	{
		this.isVisible = false;
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.stateLabel = null;
		this.centerStop = -2;
	};
	this.stateLabel = function ()
	{
		if (this.count >= 4)
		{
			this.PlaySE(846);
			this.SetEffect(this.x, this.y, 1.00000000, this.EF_KO_Flash, {}, this);
			this.count = 0;
			this.SetMotion(this.motion, 1);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.00500000);
				this.AddSpeed_XY(0.00000000, 0.02500000);
			};
		}

		this.VX_Brake(0.01000000);
	};
}

function StandAnimal_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.SetMotion(49, 0);
	this.stateLabel = function ()
	{
		this.GetFront();
		this.CenterUpdate(0.75000000, 17.50000000);

		if (this.centerStop == 0)
		{
			if (this.input.y)
			{
				this.SetSpeed_XY(null, this.input.y > 0 ? 17.50000000 : -17.50000000);
				this.centerStop = this.input.y > 0 ? 3 : -3;
				this.graze = 15;
			}
		}

		if (this.input.x)
		{
			this.SetSpeed_XY(this.input.x > 0 ? 4.00000000 : -4.00000000, null);
		}
		else
		{
			this.VX_Brake(0.50000000);
		}

		if (this.debuff_animal.time <= 0)
		{
			this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffAnimal, {});
			this.EndtoFreeMove();
		}
	};
}

function DamageAnimalBegin_Init( t )
{
	this.LabelClear();
	this.centerStop = -3;

	if (this.y > this.centerY)
	{
		this.centerStop = 3;
	}

	this.direction = t.direction;
	this.SetSpeed_XY(-4.50000000 * this.direction, this.centerStop < 0 ? -10.00000000 : 10.00000000);
	this.SetMotion(289, 0);
	this.count = 0;
	this.flag1 = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.50000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0.25000000);
			this.flag1++;

			if (this.flag1 > 30)
			{
				this.StandAnimal_Init(null);
				this.SetSpeed_XY(0.00000000, 0.00000000);
			}
		}
	};
}

function DamageAnimalB_Init( t )
{
	this.LabelClear();
	this.flag1 = this.y;
	this.centerStop = -3;
	this.direction = t.direction;

	switch(t.atkRank)
	{
	case 1:
		this.SetSpeed_XY(-4.50000000 * this.direction, -4.00000000 - this.rand() % 4);
		break;

	case 2:
		this.SetSpeed_XY(-4.50000000 * this.direction, -8.00000000 - this.rand() % 4);
		break;

	default:
		this.SetSpeed_XY(-4.50000000 * this.direction, -3.50000000 - this.rand() % 2);
		break;
	}

	this.SetMotion(289, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.va.y > 0.00000000 && this.y + this.va.y >= this.flag1 || this.count >= 90)
		{
			if (this.debuff_animal.time <= 0)
			{
				this.SetEffect(this.x, this.y, this.direction, this.EF_DebuffAnimal, {});
				this.EndtoFreeMove();
			}
			else
			{
				this.StandAnimal_Init(null);
				this.SetSpeed_XY(null, this.va.y * 0.50000000);
			}
		}
	};
}

function Atk_Grab_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1800, 0);
	this.flag4 = 4;
	this.flag5 = false;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.75000000);
		this.flag4--;

		if (this.hitResult & 1)
		{
			if (this.target.centerStop * this.target.centerStop <= 1)
			{
				if (this.target.motion == 1800 && this.target.flag4 > 0)
				{
					this.PlaySE(807);
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
					this.Grab_Blocked(null);
					this.team.current.target.Grab_Blocked(null);
					return;
				}

				if (this.team.current.target.IsGuard())
				{
					this.PlaySE(816);
					this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_StunBreak, {});
					this.target.team.regain_life = this.target.team.life;
					this.flag5 = true;
				}
				else if (this.team.current.target.IsAttack())
				{
					this.flag5 = true;
				}
				else
				{
					this.flag5 = false;
				}

				this.ResetSpeed();
				this.Atk_Grab_Hit(null);
				return;
			}
			else
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0.75000000);
				};
			}
		}
	};
}

function Atk_Grab_Hit_Update()
{
	if (this.flag5 == false && this.team.current.target.input.b0 == 1 && this.team.current.target.input.x * this.team.current.target.direction > 0)
	{
		this.team.current.target.Grab_Block(null);
		return true;
	}

	return false;
}

function Grab_Blocked( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(131, 0);
	this.Warp(this.target.team.current.x - 48 * this.direction, this.centerY);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	::battle.enableTimeUp = true;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-17.50000000 * this.direction, 0.00000000);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1.00000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1.00000000, -5.00000000 * this.direction);
	};
}

function Grab_Block( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1801, 0);

	if (this.x > ::battle.corner_right - 64 && this.direction == 1.00000000)
	{
		this.Warp(::battle.corner_right - 64, this.y);
	}

	if (this.x < ::battle.corner_left + 64 && this.direction == -1.00000000)
	{
		this.Warp(::battle.corner_left + 64, this.y);
	}

	if (!this.layerSwitch)
	{
		this.target.layerSwitch = false;
		this.layerSwitch = true;
		this.ConnectRenderSlot(::graphics.slot.actor, 190);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(807);
			this.target.team.current.damageTarget = this.weakref();
			this.target.team.current.hitBackFlag = 0.89999998;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0.50000000);
	};
}

function Shot_Charge_Common( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.PlaySE(829);
	this.SetMotion(2025, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AddSpeed_XY(-10.00000000 * this.direction, 0.00000000, -10.00000000 * this.direction, null);
	this.flag1 = this.SetCommonFreeObjectDynamic(0, 0, 1.00000000, this.ChargeShot_Aura, {}, this.weakref()).weakref();
	this.flag2 = {};
	this.flag2.use_total <- 0;
	this.flag2.tap_count <- 20;
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func[0].call(this.flag1);
		}
	};
	this.team.AddMP(-200, 120);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.subState();
				this.GetFront();
				this.team.AddMP(0, 120);

				if (this.count % 30 == 1)
				{
					this.PlaySE(828);
				}

				if (this.input.x == 0)
				{
					this.VX_Brake(0.25000000);

					if (this.keyTake == 3 || this.keyTake == 4)
					{
						this.SetMotion(this.motion, 5);
					}

					if (this.keyTake == 6 || this.keyTake == 7)
					{
						this.SetMotion(this.motion, 8);
					}
				}
				else
				{
					this.SetSpeed_XY(this.input.x > 0 ? this.flag2.vx : -this.flag2.vx, null);

					if (this.input.x * this.direction > 0)
					{
						if (this.keyTake == 1 || this.keyTake >= 6)
						{
							this.SetMotion(this.motion, 3);
						}
					}
					else if (this.keyTake == 1 || this.keyTake >= 3 && this.keyTake <= 5)
					{
						this.SetMotion(this.motion, 6);
					}
				}

				local y_ = 0;

				if (this.input.y)
				{
					y_ = this.input.y > 0 ? 1.00000000 : -1.00000000;
				}

				if (y_ == 0)
				{
					this.CenterUpdate(0.40000001, 3.00000000);
				}
				else if (this.input.y < 0 && this.y < this.centerY - 200 || this.input.y > 0 && this.y > this.centerY + 200)
				{
					this.CenterUpdate(0.40000001, 3.00000000);
				}
				else
				{
					if (this.y < this.centerY)
					{
						this.centerStop = -2;
					}

					if (this.y > this.centerY)
					{
						this.centerStop = 2;
					}

					if (this.input.y < 0 && this.y + this.flag2.vy * y_ <= this.centerY - 200 || this.input.y > 0 && this.y + this.flag2.vy * y_ >= this.centerY + 200)
					{
						y_ = 0;
					}

					this.SetSpeed_XY(null, this.flag2.vy * y_);
				}

				local t_ = {};
				t_.kx <- this.input.x;
				t_.ky <- this.input.y;
				t_.charge <- false;

				if (this.input.b1 == 0 || ::battle.state != 8)
				{
					this.Shot_Charge_Fire(t_);
					return;
				}
			};
		},
		null,
		null,
		null,
		null,
		function ()
		{
			this.SetMotion(2025, 1);
		},
		null,
		null,
		function ()
		{
			this.SetMotion(2025, 1);
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
		this.team.AddMP(0, 120);
		this.GetFront();

		if (this.count % 30 == 1)
		{
			this.PlaySE(828);
		}

		this.VX_Brake(0.25000000);
		local y_ = 0;
		this.CenterUpdate(0.40000001, 3.00000000);
		local t_ = {};
		t_.kx <- this.input.x;
		t_.ky <- this.input.y;
		t_.charge <- false;

		if (this.input.b1 == 0 || ::battle.state != 8)
		{
			this.Shot_Charge_Fire(t_);
			return;
		}
	};
}

function Shot_Burrage_Common( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.count = 0;
	this.PlaySE(829);
	this.SetMotion(2025, 0);
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.25000000);
	this.AddSpeed_XY(-10.00000000 * this.direction, 0.00000000, -10.00000000 * this.direction, null);
	this.flag2 = {};
	this.flag2.use_total <- 0;
	this.flag2.tap_count <- 20;
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.subState();
				this.GetFront();

				if (this.team.mp <= 0)
				{
					this.team.AddMP(0, 60);
				}
				else
				{
					this.team.AddMP(-2, 60);
					this.flag2.use_total += 2;
				}

				if (this.input.x == 0)
				{
					this.VX_Brake(0.25000000);

					if (this.keyTake == 3 || this.keyTake == 4)
					{
						this.SetMotion(this.motion, 5);
					}

					if (this.keyTake == 6 || this.keyTake == 7)
					{
						this.SetMotion(this.motion, 8);
					}
				}
				else
				{
					this.SetSpeed_XY(this.input.x > 0 ? this.flag2.vx : -this.flag2.vx, null);

					if (this.input.x * this.direction > 0)
					{
						if (this.keyTake == 1 || this.keyTake >= 6)
						{
							this.SetMotion(this.motion, 3);
						}
					}
					else if (this.keyTake == 1 || this.keyTake >= 3 && this.keyTake <= 5)
					{
						this.SetMotion(this.motion, 6);
					}
				}

				local y_ = 0;

				if (this.input.y)
				{
					y_ = this.input.y > 0 ? 1.00000000 : -1.00000000;
				}

				if (y_ == 0)
				{
					this.CenterUpdate(0.40000001, 3.00000000);
				}
				else if (this.input.y < 0 && this.y < this.centerY - 200 || this.input.y > 0 && this.y > this.centerY + 200)
				{
					this.CenterUpdate(0.40000001, 3.00000000);
				}
				else
				{
					if (this.y < this.centerY)
					{
						this.centerStop = -2;
					}

					if (this.y > this.centerY)
					{
						this.centerStop = 2;
					}

					if (this.input.y < 0 && this.y + this.flag2.vy * y_ <= this.centerY - 200 || this.input.y > 0 && this.y + this.flag2.vy * y_ >= this.centerY + 200)
					{
						y_ = 0;
					}

					this.SetSpeed_XY(null, this.flag2.vy * y_);
				}

				if (this.input.b1 >= 1 && ::battle.state == 8)
				{
					this.flag2.tap_count = 10;
				}

				this.flag2.tap_count--;

				if (this.keyTake >= 0 && this.flag2.use_total >= 50)
				{
					if (this.flag2.tap_count <= 0 || ::battle.state != 8 || this.team.mp <= 0)
					{
						this.EndtoFreeMove();
						return;
					}
				}
			};
		},
		null,
		null,
		null,
		null,
		function ()
		{
			this.SetMotion(2025, 1);
		},
		null,
		null,
		function ()
		{
			this.SetMotion(2025, 1);
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
		this.GetFront();

		if (this.team.mp <= 0)
		{
			this.team.AddMP(0, 120);
		}
		else
		{
			this.team.AddMP(-2, 60);
			this.flag2.use_total += 2;
		}

		if (this.count % 30 == 1)
		{
			this.PlaySE(828);
		}

		this.VX_Brake(0.25000000);
		local y_ = 0;

		if (this.input.y)
		{
			y_ = this.input.y > 0 ? 1.00000000 : -1.00000000;
		}

		if (y_ == 0)
		{
			this.CenterUpdate(0.40000001, 3.00000000);
		}
		else if (this.input.y < 0 && this.y < this.centerY - 200 || this.input.y > 0 && this.y > this.centerY + 200)
		{
			this.CenterUpdate(0.40000001, 3.00000000);
		}
		else
		{
			if (this.y < this.centerY)
			{
				this.centerStop = -2;
			}

			if (this.y > this.centerY)
			{
				this.centerStop = 2;
			}

			if (this.input.y < 0 && this.y + this.flag2.vy * y_ <= this.centerY - 200 || this.input.y > 0 && this.y + this.flag2.vy * y_ >= this.centerY + 200)
			{
				y_ = 0;
			}

			this.SetSpeed_XY(null, this.flag2.vy * y_);
		}
	};
}

function SpellCall_Init( t )
{
	this.LabelClear();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3990, 0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.count = 0;

			if (::battle.state == 8)
			{
				this.flag1 = this.team.sp;
			}
			else
			{
				this.flag1 = 0;
			}

			if (this.flag1 >= 2000)
			{
				this.flag1 = 2000;
			}

			this.CallSpellCard(45, this.spellcard.id);
			this.BackColorFilter(0.50000000, 0.00000000, 0.00000000, 0.00000000, 2);
			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				if (this.count >= 45)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = null;
				}
			};
		},
		null,
		null,
		function ()
		{
			this.BackColorFilterOut(0.50000000, 0.00000000, 0.00000000, 0.00000000, 10);

			if (this.spellList && this.spellList[this.spellcard.id].func.len() > 0)
			{
				this[this.spellList[this.spellcard.id].func]();
			}
		}
	];
}

function SpellCallB_Init( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3991, 0);
	this.count = 0;
	this.flag1 = null;
	this.BackColorFilter(0.50000000, 0.00000000, 0.00000000, 0.00000000, 2);
	this.team.sp -= this.team.sp_max;

	if (this.team.sp < 0)
	{
		this.team.sp = 0;
	}

	this.CallSpellCard(60, this.spellList.name);
	this.stateLabel = function ()
	{
		this.ResetSpeed();
	};
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.ResetSpeed();

				if (this.count >= 45)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.ResetSpeed();
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.BackColorFilterOut(0.50000000, 0.00000000, 0.00000000, 0.00000000, 10);

			if (this.spellList && this.spellList.func.len() > 0)
			{
				this.spellList.func.call(this);
			}
		}
	];
}

function SpellCallC_Init( t )
{
	this.LabelClear();
	this.BackColorFilter(0.50000000, 0.00000000, 0.00000000, 0.00000000, 2);
	this.event_getAttack = function ()
	{
		this.BackColorFilterOut(0.50000000, 0.00000000, 0.00000000, 0.00000000, 10);

		if (this.spellList && this.spellList.func.len() > 0)
		{
			this.spellList.func.call(this);
		}

		return true;
	};
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(3992, 0);
	this.count = 0;
	this.SetTimeStop(10);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.CallSpellCard(0, this.spellList.name);
			this.sp -= 1000;

			if (this.sp < 0)
			{
				this.sp = 0;
			}

			this.SetCommonShot(this.x, this.y, this.direction, this.CallAttack_Shot, {});
			this.event_getAttack = function ()
			{
				this.BackColorFilterOut(0.50000000, 0.00000000, 0.00000000, 0.00000000, 10);

				if (this.spellList && this.spellList.func.len() > 0)
				{
					this.spellList.func.call(this);
				}

				return true;
			};
			this.stateLabel = function ()
			{
				if (this.count >= 40)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = null;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.event_getAttack = null;
			this.BackColorFilterOut(0.50000000, 0.00000000, 0.00000000, 0.00000000, 10);

			if (this.spellList && this.spellList.func.len() > 0)
			{
				this.spellList.func.call(this);
			}
		}
	];
}

function ObjectInit_CommonObject( t )
{
	this.SetMotion(t.motion, t.keyTake);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
}

function ChangeCharacter()
{
}

