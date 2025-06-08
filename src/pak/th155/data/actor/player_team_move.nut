function Team_Update_Master()
{
	if (::battle.state == 8)
	{
		if (this.slave_ban > 0)
		{
			this.slave_ban--;

			if (this.op < 9999)
			{
				this.op = 0;
			}
		}

		if (this.op_leak > 0)
		{
			this.op_leak -= 4;
			this.op -= 4;

			if (this.op < 0)
			{
				this.op = 0;
			}

			if (this.op_leak <= 0 || this.op <= 0)
			{
				this.op_leak = 0;
			}
		}

		if (this.op_stop > 0 && this.op_stop < 9999)
		{
			this.op_stop--;

			if (this.op_leak > 0)
			{
				this.op -= this.op_leak;
				this.op_leak = 0;

				if (this.op < 0)
				{
					this.op = 0;
				}
			}
		}
		else if (this.op_leak == 0)
		{
			if (this.op < 1000 && this.slave_ban == 0)
			{
				this.AddOP(2, 0);

				if (this.op >= 1000)
				{
					this.op = 1000;
					this.PlaySE(907);
				}
			}
		}

		if (this.mp_stop > 0)
		{
			this.mp_stop--;
		}
		else
		{
			this.AddMP(10, 0);
		}

		if (this.spell_active)
		{
			if (this.spell_time < 0)
			{
				this.spell_time++;

				if (this.spell_time >= 0)
				{
					if (this.sp_stop > 0)
					{
						this.sp_stop = 0;
					}

					this.spell_active = false;
					return;
				}
			}
			else if (this.spell_time >= 0 && this.spell_time < 9999)
			{
				this.spell_time--;

				if (this.spell_time < 0)
				{
					this.spell_time = 0;
				}

				if ((this.spell_time == 0 || this.spell_use_count > 0) && this.current.IsAttack() <= 3 && this.spell_enable_end)
				{
					this.current.EndSpellCard();
					this.spell_active = true;
					this.spell_time = -60;
					this.sp_stop = 9999;
				}
			}
		}
	}
}

function Team_Update_Slave()
{
	if (::battle.state == 8)
	{
		if (this.op_leak > 0)
		{
			this.op_leak -= 4;
			this.op -= 4;

			if (this.op < 0)
			{
				this.op = 0;
			}

			if (this.op_leak <= 0 || this.op <= 0)
			{
				this.op_leak = 0;
			}
		}

		if (this.op_stop > 0 && this.op_stop < 9999)
		{
			this.op_stop--;

			if (this.op_leak > 0)
			{
				this.op -= this.op_leak;
				this.op_leak = 0;

				if (this.op < 0)
				{
					this.op = 0;
				}
			}
		}
		else if (this.life < this.regain_life && !this.current.IsDamage())
		{
			this.SetDamage(-2, false);
		}

		if (this.mp_stop > 0)
		{
			this.mp_stop--;
		}
		else
		{
			this.AddMP(10, 0);
		}

		if (this.spell_active)
		{
			if (this.spell_time < 0)
			{
				this.spell_time++;

				if (this.spell_time >= 0)
				{
					if (this.sp_stop > 0)
					{
						this.sp_stop = 0;
					}

					this.spell_active = false;
					return;
				}
			}
			else if (this.spell_time >= 0 && this.spell_time < 9999)
			{
				this.spell_time--;

				if (this.spell_time < 0)
				{
					this.spell_time = 0;
				}

				if ((this.spell_time == 0 || this.spell_use_count > 0) && this.current.IsAttack() <= 3 && this.spell_enable_end)
				{
					this.current.EndSpellCard();
					this.spell_active = true;
					this.spell_time = -60;
					this.sp_stop = 9999;
				}
			}
		}
	}
}

function TeamReset_Change_Master()
{
	if (this.team.current != this.team.master)
	{
		this.team.current.Team_Bench_In();
		this.team.Change();
		this.target.team.current.target = this.target.team.target.weakref();
		this.team.current.target = this.team.target.weakref();
		this.team.current.direction = this.direction;
		this.team.current.centerStop = this.centerStop;
		this.change_reserve = false;
		this.team.current.change_reserve = false;
		this.team.current.direction = this.direction;
		this.team.current.Warp(this.x, this.y);

		if (this.team.current == this.team.master)
		{
			this.team.master.team_update = this.Team_Update_Master;
		}
		else
		{
			this.team.master.team_update = this.Team_Update_Slave;
		}

		if (this.team.slave_sub)
		{
			this.team.slave_sub.Team_Bench_In();
		}
	}
	else
	{
		if (this.team.slave)
		{
			this.team.slave.Team_Bench_In();
		}

		if (this.team.slave_sub)
		{
			this.team.slave_sub.Team_Bench_In();
		}
	}
}

function Team_Change_Common()
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
	this.team.Change();
	this.target.team.master.target = this.target.team.target.weakref();

	if (this.target.team.slave)
	{
		this.target.team.slave.target = this.target.team.target.weakref();
	}

	this.team.master.target = this.team.target.weakref();
	this.team.slave.target = this.team.target.weakref();
	this.team.current.direction = this.direction;
	this.team.current.centerStop = this.centerStop;
	this.team.current.centerStopCheck = this.y < this.centerY ? -1 : 1;
	this.change_reserve = false;
	this.team.current.change_reserve = false;
	this.team.current.slideCount = this.slideCount;
	this.team.current.dashCount = this.dashCount;
	this.BuffReset();
	this.team.current.DrawActorPriority(190);
	this.team.current.masterAlpha = 1.00000000;
	this.team.current.Warp(this.x, this.y);
	this.change_reset();
	this.team.current.Team_FreeChangeAction();

	if (this.team.current == this.team.master)
	{
		this.team.master.team_update = this.Team_Update_Master;

		if (this.team.slave.hyouiAura)
		{
			this.team.slave.hyouiAura.func();
		}
	}
	else
	{
		this.team.current.hyouiAura = this.SetEffect(this.team.current.x, this.team.current.y, 1.00000000, this.Hyoui_Aura, {}, this.team.current.weakref()).weakref();
		this.team.master.team_update = this.Team_Update_Slave;
	}
}

function Team_Bench_In()
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3910, 2);
}

function Team_Master_Out()
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3918, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count >= 30)
		{
			this.masterAlpha -= 0.05000000;

			if (this.masterAlpha <= 0)
			{
				this.SetMotion(3910, 2);
				this.LabelClear();
				return;
			}
		}
	};
}

function Team_Lose()
{
	this.LabelClear();
	this.ResetSpeed();
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.PlaySE(903);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
	this.team.current.func_timeDemo();
}

function Team_Win()
{
	this.LabelClear();
	this.ResetSpeed();
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.PlaySE(903);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
	this.team.current.Func_Win();
}

function Team_Bench_Fade()
{
	this.LabelClear();
	this.ResetSpeed();
	this.DrawActorPriority(189);
	this.SetMotion(3910, 0);
	this.SetSpeed_XY(-8.00000000 * this.direction, -5.00000000);
	this.stateLabel = function ()
	{
		this.vf.x = this.vf.y = this.vfBaria.x = this.vfBaria.y = 0.00000000;
		this.Vec_Brake(0.50000000, 0.50000000);
		this.masterAlpha -= 0.02500000;

		if (this.masterAlpha <= 0.00000000)
		{
			this.LabelClear();
			this.ResetSpeed();
			this.SetMotion(3910, 2);
		}
	};
}

function Team_Bench_Fade_Spell()
{
	this.LabelClear();
	this.ResetSpeed();
	this.DrawActorPriority(189);
	this.SetMotion(3910, 0);
	this.SetSpeed_XY(-8.00000000 * this.direction, -5.00000000);
	this.flag1 = this.team.current.weakref();
	this.stateLabel = function ()
	{
		this.vf.x = this.vf.y = this.vfBaria.x = this.vfBaria.y = 0.00000000;
		this.Vec_Brake(0.50000000, 0.50000000);

		if (this.flag1.IsAttack() == 0)
		{
			this.stateLabel = function ()
			{
				this.vf.x = this.vf.y = this.vfBaria.x = this.vfBaria.y = 0.00000000;
				this.Vec_Brake(0.50000000, 0.50000000);
				this.masterAlpha -= 0.10000000;

				if (this.masterAlpha <= 0.00000000)
				{
					this.LabelClear();
					this.ResetSpeed();
					this.SetMotion(3910, 2);
				}
			};
		}
	};
}

function Team_Bench_Recover( t_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.Team_Change_Common();
	this.DrawActorPriority(189);
	this.SetMotion(3910, 0);
	this.SetSpeed_XY(-8.00000000 * this.direction, -5.00000000);
	this.team.current.Team_Change_Recover.call(this.team.current, this.direction);
	this.stateLabel = function ()
	{
		this.vf.x = this.vf.y = this.vfBaria.x = this.vfBaria.y = 0.00000000;
		this.Vec_Brake(0.50000000, 0.50000000);
		this.masterAlpha -= 0.02500000;

		if (this.masterAlpha <= 0.00000000)
		{
			this.LabelClear();
			this.ResetSpeed();
			this.SetMotion(3910, 2);
		}
	};
}

function Team_Change_Recover( dir_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.direction = dir_;
	this.recover = 60;
	this.SetMotion(203, 0);
	this.AjustCenterStop();
	this.team.AddOP(-1000, 0);
	this.PlaySE(903);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetSpeed_XY(-17.50000000 * this.direction, 0.00000000);
	}
	else if (this.y <= this.centerY)
	{
		this.centerStop = -3;
		this.SetSpeed_XY(-17.50000000 * this.direction, -6.00000000);
	}
	else
	{
		this.centerStop = 3;
		this.SetSpeed_XY(-17.50000000 * this.direction, 6.00000000);
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.20000000, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(1.00000000);
		}
		else
		{
			this.VX_Brake(1.00000000, -3.00000000 * this.direction);
		}

		if (this.count == 40)
		{
			this.SetMotion(203, 2);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(1.00000000);
				}
				else
				{
					this.VX_Brake(1.00000000, -3.00000000 * this.direction);
				}
			};
		}
	};
}

function Team_Bench_Suicide( t_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.Team_Change_Common();
	this.DrawActorPriority(189);
	this.SetMotion(218, 0);
	this.team.current.Team_Change_Suicide.call(this.team.current, this.direction);
	this.SetSpeed_XY(-1.50000000 * this.direction, -11.00000000);
	this.count = 0;
	this.subState = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.34999999);

		if (this.va.y > -1.00000000)
		{
			this.subState = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.05000000);
			};
		}
	};
	this.stateLabel = function ()
	{
		this.vf.x = this.vf.y = this.vfBaria.x = this.vfBaria.y = 0.00000000;
		this.subState();

		if (this.va.x > 0 && this.x > ::battle.corner_right || this.va.x < 0 && this.x < ::battle.corner_left)
		{
			this.SetSpeed_XY(0.00000000, null);
		}

		if (this.count == 40)
		{
			this.PlaySE(847);
			this.SetCommonShot(this.x, this.y, this.direction, this.Suicide_Exp, {});
			this.Team_Bench_In();
			return;
		}
	};
}

function Team_Change_Suicide( t_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.team.ResetCombo();
	this.SetMotion(3994, 0);
	this.AjustCenterStop();
	this.team.AddOP(-2000, 9999);
	this.team.sp2_enable = false;

	if (this.team.sp > this.team.sp_max)
	{
		this.team.sp = this.team.sp_max;
	}

	this.PlaySE(903);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
	this.centerStop = -2;
	this.SetSpeed_Vec(8.00000000, -160 * 0.01745329, this.direction);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count >= 20)
		{
			this.Vec_Brake(0.75000000, 0.50000000);
		}

		if (this.count == 90)
		{
			this.SetMotion(3994, 2);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, 8.00000000);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(3994, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		}
	};
}

function Team_ChangeReserve_Common()
{
	this.Team_Change_Common();
	this.team.current.Warp(this.x, this.y);
	this.Team_Bench_In();

	if (this.team.current == this.team.master)
	{
		this.team.op_stop = 60;
		this.team.op_stop_max = this.team.op_stop;
	}

	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
}

function Team_Change_FreeMove( t )
{
	this.Team_Change_Common();
	this.team.current.Warp(this.x, this.y);
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.ResetSpeed();
	this.team.current.EndtoFreeMove();
}

function Team_Change_AirMove( t_ )
{
	local v_ = this.va.x;
	this.ResetSpeed();
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.team.current.ResetSpeed();

	if (v_ == 0.00000000)
	{
		if (this.y < this.centerY)
		{
			this.team.current.Team_Change_AirSlideUpperB.call(this.team.current, t_);
		}
		else
		{
			this.team.current.Team_Change_AirSlideUnderB.call(this.team.current, t_);
		}
	}
	else if (v_ * this.direction > 0)
	{
		this.team.current.Team_Change_AirMoveB.call(this.team.current, t_);
	}
	else
	{
		this.team.current.Team_Change_AirBackB.call(this.team.current, t_);
	}

	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());

	if (this.team.current == this.team.master)
	{
		this.team.op_stop = 60;
		this.team.op_stop_max = this.team.op_stop;
	}
}

function Team_Change_AirMoveB( t_ )
{
	this.ResetSpeed();
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 6.00000000;
	this.flag5.vy = 3.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirMoveCommon( t_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3940, 0);
	this.flag5 = {};
	this.flag5.vy <- 0.00000000;
	this.flag5.vx <- 0.00000000;
	this.flag5.g <- 0;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			if (this.y <= this.centerY)
			{
				this.SetSpeed_XY(this.flag5.vx * this.direction, -this.flag5.vy);
				this.centerStop = -3;
			}
			else
			{
				this.SetSpeed_XY(this.flag5.vx * this.direction, this.flag5.vy);
				this.centerStop = 3;
			}

			this.stateLabel = function ()
			{
				this.CenterUpdate(this.flag5.g, this.baseSlideSpeed);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.baseGravity, this.baseSlideSpeed);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
}

function Team_Change_AirBackB( t_ )
{
	this.ResetSpeed();
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -6.00000000;
	this.flag5.vy = 3.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackCommon( t_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3941, 0);
	this.flag5 = {};
	this.flag5.vy <- 0.00000000;
	this.flag5.vx <- 0.00000000;
	this.flag5.g <- 0;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			if (this.y <= this.centerY)
			{
				this.SetSpeed_XY(this.flag5.vx * this.direction, -this.flag5.vy);
				this.centerStop = -3;
			}
			else
			{
				this.SetSpeed_XY(this.flag5.vx * this.direction, this.flag5.vy);
				this.centerStop = 3;
			}

			this.stateLabel = function ()
			{
				this.CenterUpdate(this.flag5.g, this.baseSlideSpeed);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.baseGravity, this.baseSlideSpeed);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = -6.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperCommon( t_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3942, 0);
	this.flag5 = {};
	this.flag5.vy <- 0.00000000;
	this.flag5.vx <- 0.00000000;
	this.flag5.g <- 0;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(this.flag5.vx * this.direction, this.flag5.vy);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.flag5.g, this.baseSlideSpeed);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		}
	];
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.ResetSpeed();
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0.00000000;
	this.flag5.vy = 6.50000000;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderCommon( t_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3943, 0);
	this.flag5 = {};
	this.flag5.vy <- 0.00000000;
	this.flag5.vx <- 0.00000000;
	this.flag5.g <- 0;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(this.flag5.vx * this.direction, this.flag5.vy);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.flag5.g, this.baseSlideSpeed);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
					};
				}
			};
		}
	];
}

function Team_GC_DashBack_Init( t )
{
	this.ResetSpeed();
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.team.current.Warp(this.x, this.y);
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	::battle.SetTimeStop(10);

	if (this.centerStop * this.centerStop <= 1)
	{
		this.team.current.Team_ChangeDashBack_Init(null);
	}
	else
	{
		this.team.current.Team_ChangeDashBack_Air_Init(null);
	}
}

function Team_ChangeDashBack_Init( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(45, 0);
	this.PlaySE(818);
	this.team.op_leak += 500;
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_GuardCancel, {});
	this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.50000000);

		if (this.y > this.centerY && this.va.y > 0.00000000)
		{
			this.SetMotion(this.motion, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 2.50000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.75000000);
			};
		}
	};
}

function Team_ChangeDashBack_Air_Init( t )
{
	this.LabelClear();
	this.SetMotion(46, 0);
	this.ResetSpeed();
	this.PlaySE(818);
	this.team.op_leak += 500;
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_GuardCancel, {});

	if (this.y < this.centerY)
	{
		this.SetSpeed_XY(-10.00000000 * this.direction, -4.00000000);
		this.centerStop = -3;
	}
	else
	{
		this.SetSpeed_XY(-10.00000000 * this.direction, 4.00000000);
		this.centerStop = -3;
	}

	this.count = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0.20000000);
		this.CenterUpdate(0.15000001, null);

		if (this.count == 15)
		{
			this.SetMotion(46, 3);
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0.50000000);
				}
			};
		}
	};
}

function Team_Change_ChangeSkillEnd( t )
{
	this.team.stop_reserve = 120;
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.team.current.Warp(this.x, this.y);
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.EndtoFreeMove();
}

function CallSpellCard_Slave( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.masterAlpha = 0.00000000;
	this.SetMotion(3993, 1);
	this.DrawActorPriority(189);
	this.Warp(this.team.master.x, this.team.master.y - 25);
	this.direction = this.team.master.direction;
	this.SetSpeed_XY(-10.00000000 * this.direction, -1.00000000);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.masterAlpha += 0.10000000;
		this.Vec_Brake(0.40000001, 0.25000000);

		if (this.count >= 30)
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.40000001);
				this.masterAlpha -= 0.10000000;

				if (this.masterAlpha <= 0.00000000)
				{
					this.Team_Bench_In();
				}
			};
		}
	};
}

function Team_Change_Reigeki( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3911, 0);
	this.keyAction = function ()
	{
		this.Team_Change_Common();
		this.Team_Bench_In();
		this.team.current.Team_Change_ReigekiB.call(this.team.current, this.direction);
	};
}

function Team_Change_ReigekiB( dir_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3911, 1);
	this.AjustCenterStop();
	this.SetCommonShot(this.x, this.y, this.direction, this.CallAttack_Shot, {});
	local val_ = this.team.op;
	this.team.op_leak += 2000;
	this.PlaySE(901);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
}

function Team_Change_Counter( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3912, 0);
	this.BackColorFilter(0.50000000, 0.00000000, 0.00000000, 0.00000000, 2);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_GuardCancel, {});
	this.SetTimeStop(15);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.BackColorFilterOut(0.50000000, 0.00000000, 0.00000000, 0.00000000, 2);
			this.Team_Change_Common();
			this.Team_Bench_In();
			this.team.current.Team_Change_CounterB.call(this.team.current, this.direction);
		}
	];
}

function Team_Change_CounterB( dir_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3912, 2);
	this.AjustCenterStop();
	this.SetCommonShot(this.x, this.y, this.direction, this.CallAttack_Shot, {});
	local val_ = this.team.op;
	this.team.op_leak += 2000;
	this.PlaySE(903);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
}

function Team_Change_CounterC( dir_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3912, 3);
	this.AjustCenterStop();
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
}

function Team_SetFront_Slave()
{
	this.LabelClear();
	this.ResetSpeed();
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.team.current.EndtoFreeMove();
}

function Team_Change_Slave( t )
{
	if (this.centerStop * this.centerStop >= 4)
	{
		this.Team_Change_AirMove(null);
	}
	else
	{
		this.LabelClear();
		this.ResetSpeed();
		this.Team_Change_Common();
		this.Team_Bench_In();
		this.team.current.Team_Change_SlaveB(this.direction);
	}
}

function Team_Change_SlaveB( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3917, 1);
	this.AjustCenterStop();
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
}

function Team_Change_Master( t )
{
	if (this.centerStop * this.centerStop >= 4)
	{
		this.Team_Change_AirMove(null);
	}
	else
	{
		this.LabelClear();
		this.ResetSpeed();
		this.team.op_stop = 120;
		this.team.op_stop_max = this.team.op_stop;
		this.Team_Change_Common();
		this.Team_Bench_In();
		this.team.current.Team_Change_MasterB(this.direction);
	}
}

function Team_FreeChangeAction()
{
}

function Team_Change_MasterB( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.SetMotion(3917, 1);
	this.AjustCenterStop();
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
}

function Team_ChangeRecover_Init( t, leak_ )
{
	this.LabelClear();
	this.ResetSpeed();
	this.team.op_leak += leak_;
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.stanCount = 0;
	this.team.current.Recover_Init(t);
}

function Team_ChangeStandUp_Init( t )
{
	this.LabelClear();
	this.ResetSpeed();
	this.team.op_leak += 500;
	this.Team_Change_Common();
	this.Team_Bench_In();
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	local t_ = -this.direction;

	if (t * this.direction > 0)
	{
		t_ = this.direction;
	}

	this.team.current.StandUp_Init(t_);
}

function Team_Change_Attack( t )
{
	this.Team_Change_Common();

	if (this.team.master == this)
	{
		this.Team_Master_Out();
	}
	else
	{
		this.Team_Bench_In();
		this.team.op_stop = 120;
		this.team.op_stop_max = this.team.op_stop;
	}

	this.team.stop_reserve = 0;
	local scale_ = 0.66000003 + (this.team.op - 1000) / 1000.00000000 * 0.34000000;
	scale_ = this.Math_MinMax(scale_, 0.66000003, 1.00000000);

	if (this.target.team.kaiki_scale == 1.00000000)
	{
		this.target.team.kaiki_scale = scale_;
	}

	this.team.op_leak += 1000;
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.Team_Change_AttackB(this.direction);
}

function Team_Change_Attack_Air( t )
{
	this.Team_Change_Common();

	if (this.team.master == this)
	{
		this.Team_Master_Out();
	}
	else
	{
		this.Team_Bench_In();
		this.team.op_stop = 120;
		this.team.op_stop_max = this.team.op_stop;
	}

	this.team.stop_reserve = 0;
	local scale_ = 0.66000003 + (this.team.op - 1000) / 1000.00000000 * 0.34000000;
	scale_ = this.Math_MinMax(scale_, 0.66000003, 1.00000000);

	if (this.target.team.kaiki_scale == 1.00000000)
	{
		this.target.team.kaiki_scale = scale_;
	}

	this.team.op_leak += 1000;
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.Team_Change_Attack_AirB(this.direction);
}

function Team_Change_Shot( t )
{
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Team_Change_Common();

	if (this.team.master == this)
	{
		this.Team_Master_Out();
	}
	else
	{
		this.Team_Bench_In();
		this.team.op_stop = 120;
		this.team.op_stop_max = this.team.op_stop;
	}

	this.team.stop_reserve = 0;
	local scale_ = 0.66000003 + (this.team.op - 1000) / 1000.00000000 * 0.34000000;
	scale_ = this.Math_MinMax(scale_, 0.66000003, 1.00000000);

	if (this.target.team.kaiki_scale == 1.00000000)
	{
		this.target.team.kaiki_scale = scale_;
	}

	this.team.op_leak += 1000;
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.Team_Change_ShotB(v_);
}

function Team_Change_ShotB( t )
{
}

function Team_Change_ShotFin( t )
{
	this.Team_Change_Common();

	if (this.team.master == this)
	{
		this.Team_Master_Out();
	}
	else
	{
		this.Team_Bench_In();
	}

	this.team.stop_reserve += 0;
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.op_stop = 60;
	this.team.op_stop_max = this.team.op_stop;
	this.team.current.Team_Change_ShotFinB(t);
}

function Team_Change_HeavyShot( t )
{
}

function TeamSkillChain_Input( command_ )
{
	return false;
}

function Team_Change_SkillCommon()
{
	this.Team_Change_Common();
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.Team_Bench_In();
}

function Team_Change_Skill()
{
	local c_ = this.team.master;

	if (this.team.master == this.team.current)
	{
		c_ = this.team.slave;
	}

	c_.centerStop = this.centerStop;
	c_.Warp(this.x, this.y);
	c_.direction = this.direction;
	c_.ResetSpeed();

	if (c_.TeamSkillChain_Input(this))
	{
		this.ResetSpeed();
		this.Team_Change_Common();
		this.PlaySE(900);
		this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
		local scale_ = 0.66000003 + (this.team.op - 1000) / 1000.00000000 * 0.34000000;
		scale_ = this.Math_MinMax(scale_, 0.66000003, 1.00000000);

		if (this.target.team.kaiki_scale == 1.00000000)
		{
			this.target.team.kaiki_scale = scale_;
		}

		this.team.op_leak += 1000;

		if (this.team.current == this.team.master)
		{
			this.team.op_stop = 120;
			this.team.op_stop_max = this.team.op_stop;
		}

		this.Team_Bench_In();
		return true;
	}
	else
	{
		return false;
	}
}

function Team_Change_Skill_Front( t )
{
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Team_Change_Common();

	if (this.team.master == this)
	{
		this.Team_Master_Out();
	}
	else
	{
		this.Team_Bench_In();
	}

	this.team.stop_reserve = 300;
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.Team_Change_Skill_FrontB(t, v_);
	this.team.current.change_reserve = true;
	this.team.current.event_getDamage = function ( t_ )
	{
		this.team.current.change_reserve = false;
		return true;
	};
}

function Team_Change_SpellCheck()
{
	return true;
}

function Team_Change_Spell( t )
{
	if (this.team.slave.Team_Change_SpellCheck())
	{
		local v_ = this.Vector3();
		v_.x = this.va.x;
		v_.y = this.va.y;
		this.Team_Change_Common();

		if (this.team.master == this)
		{
			this.Team_Bench_Fade_Spell();
		}
		else
		{
			this.Team_Bench_In();
		}

		this.team.stop_reserve = 0;
		local scale_ = 0.66000003 + (this.team.op - 1000) / 1000.00000000 * 0.34000000;
		scale_ = this.Math_MinMax(scale_, 0.66000003, 1.00000000);

		if (this.target.team.kaiki_scale == 1.00000000)
		{
			this.target.team.kaiki_scale = scale_;
		}

		this.team.op_leak += 2000;
		this.PlaySE(900);
		this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
		this.team.current.GetFront();
		this.team.current.Team_Change_SpellB(v_);
		return true;
	}
}

