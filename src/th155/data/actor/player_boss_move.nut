function PlayerhitAction_Boss( t_ )
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
		if (this.team.current == this.team.master)
		{
			if (this.team.life <= 0 && this.ko_slave && this.team.slave)
			{
				this.PlaySE(900);
				this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
				this.Team_Change_Common();
				this.team.current.Warp(this.x, this.y);
				this.Team_Bench_In();
				this.team.slave.damageStopTime = this.damageStopTime;
				this.team.slave.recover = this.recover;
				this.team.slave.stanCount = this.stanCount;
				this.team.slave.invinBoss = this.invinBoss;
				this.team.slave.damageTarget = this.damageTarget.weakref();
				this.baria = false;
				this.team.combo_reset_count = 0;
				this.endure = 0;
				this.team.slave.PlayerhitAction_Boss(t_);
				return;
			}
		}
		else if (this.team.slave && this.team.current == this.team.slave && !this.ko_slave && this.team.life <= 0)
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
			this.Boss_ChangeCurrent();
			this.team.current.Warp(this.x, this.y);
			this.Team_Bench_In();
			this.team.master.damageStopTime = this.damageStopTime;
			this.team.master.recover = this.recover;
			this.team.master.stanCount = this.stanCount;
			this.team.master.invinBoss = this.invinBoss;
			this.team.master.damageTarget = this.damageTarget.weakref();
			this.baria = false;
			this.team.combo_reset_count = 0;
			this.endure = 0;
			this.team.master.PlayerhitAction_Boss(t_);
			return;
		}

		this.team.master.shot_actor.Foreach(function ()
		{
			this.func[0].call(this);
		});

		if (this.team.slave)
		{
			this.team.slave.shot_actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
		}

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

	if (this != this.team.current)
	{
		return;
	}

	if (this.debuff_animal.time > 0)
	{
		this.DamageAnimalB_Init(t_);
	}
	else
	{
		switch(t_.atkType)
		{
		case 1:
			if (this.team.life <= 0 || this.centerStop * this.centerStop > 1 || this.flagState & 8)
			{
				if (this.y <= this.centerY && this.centerStop != -1 || this.centerStop == 1)
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
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
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
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
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
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
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = 7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4,00000000.0;
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
			if (this.team.life <= 0 || this.centerStop * this.centerStop > 1 || this.flagState & 8)
			{
				if (this.y <= this.centerY)
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = 7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4,00000000.0;
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
			if (this.team.life <= 0 || this.centerStop * this.centerStop > 1 || this.flagState & 8)
			{
				if (this.y <= this.centerY)
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = -7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = -4,00000000.0;
					}

					this.DamageUpperLight_Init(t_);
				}
				else
				{
					t_.hitVecX = -4,00000000.0;
					t_.hitVecY = 7,00000000.0;

					if (t_.atkRank == 0)
					{
						t_.hitVecY = 4,00000000.0;
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

function SpellCrash_Init( t )
{
	this.LabelClear();
	this.SetMotion(130, 0);
	::battle.SetTimeStop(45);
	::camera.shake_radius = 20,00000000.0;
	this.GetFront();
	this.PlaySE(816);
	this.SetSpeed_XY(-13,00000000.0 * this.direction, 0,00000000.0);
	::camera.SetTarget(this.x, this.y, 2,50000000.0, true);
	this.count = -45;
	this.stanBossCount = 240;
	this.SetFreeObject(this.x, this.y, 1,00000000.0, function ( t_ )
	{
		this.stateLabel = function ()
		{
			::camera.ResetTarget();
			this.ReleaseActor();
			return;
		};
	}, {});
	this.team.master.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});

	if (this.team.slave)
	{
		this.team.slave.shot_actor.Foreach(function ()
		{
			this.func[0].call(this);
		});
	}

	local t_ = {};
	t_.count <- 45;
	t_.priority <- 520;
	this.SetEffect(640, 360, 1,00000000.0, this.EF_SpeedLine, t_);

	if (this.centerStop * this.centerStop <= 1)
	{
		this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
	}
	else
	{
		if (this.y < this.centerY)
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-15,00000000.0 * this.direction, -5,00000000.0);
		}

		if (this.y > this.centerY)
		{
			this.centerStop = 2;
			this.SetSpeed_XY(-15,00000000.0 * this.direction, 5,00000000.0);
		}
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction <= -3,00000000.0 ? 1,00000000.0 : 0,05000000.0);
		this.CenterUpdate(0,25000000.0, null);
		this.stateLabel = function ()
		{
			this.VX_Brake(this.va.x * this.direction <= -3,00000000.0 ? 1,00000000.0 : 0,05000000.0);
			this.CenterUpdate(0,25000000.0, null);

			if (this.count >= 0)
			{
				this.SetMotion(this.motion, 2);
				this.stateLabel = function ()
				{
					this.VX_Brake(1,00000000.0);
				};
			}
		};
	};
}

function SpellStan_Init( t )
{
	this.SetMotion(130, 0);
}

function BossCall_Init()
{
	if (!this.Cancel_Check(10))
	{
		return false;
	}

	this.LabelClear();
	this.invin = 6;
	this.invinObject = 6;
	this.invinGrab = 6;
	this.armor = -1;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(3999, 0);
	this.count = 0;
	::battle.enableTimeCount = false;
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		this.invin = 3;
		this.invinObject = 3;
		this.invinGrab = 3;
	};
	this.keyAction = [
		function ()
		{
			this.subState = function ()
			{
				this.invin = 3;
				this.invinObject = 3;
				this.invinGrab = 3;
			};
			this.count = 0;
			this.CallBossCard(90, ::battle.boss_spell[0].master_name);
			this.SetFreeObject(640 - 640, 720, -1,00000000.0, this.SpellUseFace, {});
			this.SetTimeStop(90);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count >= 90)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.subState();
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			if (this.boss_spell_func)
			{
				this.boss_spell_func();
			}
		}
	];
	return true;
}

function Boss_SetLife_Actor( t )
{
	this.flag1 = this.team.life_max - this.team.life;
	this.flag2 = 0;
	this.stateLabel = function ()
	{
		local l_ = ((this.flag1 - this.flag2) * 0,20000000.0).tointeger();

		if (l_ <= 10)
		{
			this.team.life += this.flag1 - this.flag2;

			if (this.team.life > this.team.life_max)
			{
				this.team.life = this.team.life_max;
			}

			this.ReleaseActor();
		}
		else
		{
			this.team.life += l_;
			this.flag2 += l_;

			if (this.team.life > this.team.life_max)
			{
				this.team.life = this.team.life_max;
			}
		}
	};
}

function Boss_ChangeCurrent()
{
	this.Team_Change_Boss();
	this.team.current.Warp(this.x, this.y);
	this.PlaySE(900);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
	this.team.current.EndtoFreeMove();
	this.Team_Bench_In();
	return true;
}

function Boss_WalkMotionUpdate( move_ )
{
	if (move_ == 0)
	{
		if (this.keyTake == 1)
		{
			this.SetMotion(this.motion, 2);
			this.keyAction = function ()
			{
				this.keyAction = null;

				if (this.team.shield)
				{
					this.SetMotion(4990, 0);
				}
				else
				{
					this.SetMotion(4980, 0);
				}
			};
		}
	}
	else if (move_ * this.direction > 0)
	{
		if (this.team.shield)
		{
			if (this.motion != 4991)
			{
				this.SetMotion(4991, 0);
			}
		}
		else if (this.motion != 4981)
		{
			this.SetMotion(4981, 0);
		}
	}
	else if (this.team.shield)
	{
		if (this.motion != 4992)
		{
			this.SetMotion(4992, 0);
		}
	}
	else if (this.motion != 4982)
	{
		this.SetMotion(4982, 0);
	}
}

function Boss_SlideMotionUpdate( move_ )
{
	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.keyTake >= 1 && this.keyTake <= 4)
		{
			this.SetMotion(this.motion, 5);
			this.keyAction = function ()
			{
				this.keyAction = null;

				if (this.team.shield)
				{
					this.SetMotion(4990, 0);
				}
				else
				{
					this.SetMotion(4980, 0);
				}
			};
		}
	}
	else if (move_ <= 0)
	{
		if (this.keyTake == 2 && this.va.y >= 0,00000000.0)
		{
			this.SetMotion(this.motion, 3);
		}
	}
	else if (this.keyTake == 2 && this.va.y <= 0,00000000.0)
	{
		this.SetMotion(this.motion, 3);
	}
}

