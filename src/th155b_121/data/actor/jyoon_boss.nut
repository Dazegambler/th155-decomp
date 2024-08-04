function Master_Spell_1()
{
	this.team.slave.Slave_Jyoon_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					if (this.team.shield == null)
					{
						this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
					}

					this.Master_Spell_1_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_1_Start()
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.centerStop = -2;

	if (this.x > (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
	{
		this.flag5.pos.x = ::battle.corner_right - 200;
		this.flag5.pos.y = this.centerY - 100 + this.rand() % 201;
	}
	else
	{
		this.flag5.pos.x = ::battle.corner_left + 200;
		this.flag5.pos.y = this.centerY - 100 + this.rand() % 201;
	}

	this.flag3 = this.flag5.pos.x - this.x;
	this.MS1_MoveCommon();
}

function Master_Spell_1_Move()
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
	{
		this.flag5.pos.x = ::battle.corner_right - 400 - this.rand() % 150;
		this.flag5.pos.y = this.centerY - 150 + this.rand() % 301;
	}
	else
	{
		this.flag5.pos.x = ::battle.corner_left + 400 + this.rand() % 150;
		this.flag5.pos.y = this.centerY - 150 + this.rand() % 301;
	}

	this.flag3 = this.flag5.pos.x - this.x;
	this.MS1_MoveCommon();
}

function MS1_MoveCommon()
{
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag5.moveCount++;
		this.flag5.moveV += 0,50000000.0;

		if (this.flag5.moveV >= 15,00000000.0)
		{
			this.flag5.moveV = 15,00000000.0;
		}

		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		if (v_ <= 7,00000000.0)
		{
			this.flag3 = 0,00000000.0;
		}

		if (v_ <= 2,00000000.0)
		{
			this.MS1_Attack(null);
			return;
		}
	};
}

function MS1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4911, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 15;
	this.flag5.shotCount <- 360;
	this.flag5.shotWay <- 1;
	this.flag5.shotRotAdd <- 0;
	this.flag5.scale <- 1,00000000.0;
	this.flag5.shotPos <- this.Vector3();
	this.flag5.shotPos.x = -1,00000000.0;
	this.flag5.shotRange <- 100,00000000.0;
	this.flag5.rotSpeed <- 10,00000000.0;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.count = 0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCycle = 5;
		this.flag5.scale = 1,20000005.0;
		break;

	case 2:
		this.flag5.shotCycle = 5;
		this.flag5.scale = 1,39999998.0;
		this.flag5.shotWay = 2;
		this.flag5.shotRotAdd = 3,14159203.0;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 5;
		this.flag5.scale = 1,50000000.0;
		this.flag5.shotWay = 3;
		this.flag5.shotRotAdd = 2,09439468.0;
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);

		if (this.flag5.shotCount > this.count)
		{
			if (this.count >= 0 && this.count % this.flag5.shotCycle == 1)
			{
				local pos_ = this.Vector3();
				pos_.x = this.flag5.shotPos.x * this.flag5.shotRange;
				pos_.y = this.flag5.shotPos.y * this.flag5.shotRange;

				for( local i = 0; i < this.flag5.shotWay; i++ )
				{
					local t_ = {};
					t_.scale <- this.flag5.scale;
					this.SetLightShot(this.x + pos_.x * this.direction, this.y + pos_.y, 1,00000000.0, this.Boss_Shot_MS1, t_);
					pos_.RotateByRadian(this.flag5.shotRotAdd);
				}
			}

			this.flag5.shotRange += 4,00000000.0;

			if (this.flag5.shotRange > 1240)
			{
				this.flag5.shotRange = 1240;
			}

			this.flag5.shotPos.RotateByDegree(2,00000000.0);
		}

		if (this.count % 6 == 1)
		{
			this.PlaySE(870);
		}

		if (this.count % 30 == 1)
		{
			this.PlaySE(4638);
		}

		if (this.count == this.flag5.shotCount)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count >= this.flag5.shotCount + 120)
		{
			this.M1_Change_Slave(null);
			return;
		}
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Jyoon(null);
	this.Set_BossSpellBariaRate(10);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
}

function Master_Spell_2()
{
	this.team.slave.Slave_Jyoon_1();
	this.shot_actor.Clear();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					if (this.team.shield == null)
					{
						this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
					}

					this.Master_Spell_2_Attack();
				}
			};
		}
	};
	return true;
}

function Master_Spell_2_Attack()
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.direction = this.com_flag1;
	this.com_flag1 *= -1,00000000.0;
	this.flag5 = {};
	this.flag5.charge <- 90;
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.func = [
		null,
		function ()
		{
			this.SetLightShot(this.x - 32 + this.rand() % 64, ::battle.scroll_bottom, 1,00000000.0, this.Boss_Shot_MS2_High, {});
			this.SetLightShot(this.x - 32 + this.rand() % 64, ::battle.scroll_bottom, 1,00000000.0, this.Boss_Shot_MS2, {});
		}
	];

	switch(this.com_difficulty)
	{
	case 0:
		this.func[1] = function ()
		{
			this.SetLightShot(this.x - 32 + this.rand() % 64, ::battle.scroll_bottom, 1,00000000.0, this.Boss_Shot_MS2, {});
		};
		break;

	case 1:
		this.flag5.shotCycle = 7;
		break;

	case 2:
		this.flag5.shotCycle = 4;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 2;
		break;
	}

	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.centerStop = -2;
	this.flag5.pos.x = 640 - 480 * this.direction;
	this.flag5.pos.y = this.centerY;
	this.count = 0;
	this.com_flag2++;
	this.func[0] = function ()
	{
		this.SetMotion(4920, 2);

		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
		this.PlaySE(4619);
		this.flag5.moveCount = 0;
		this.stateLabel = function ()
		{
			this.centerStop = 2;
			this.flag5.moveCount++;
			this.AddSpeed_XY(0,50000000.0 * this.direction, 0,00000000.0, 12,00000000.0 * this.direction, null);
			this.SetSpeed_XY(this.va.x, (this.centerY + 260 - this.y) * 0,05000000.0);

			if (this.count % this.flag5.shotCycle == 0)
			{
				this.func[1].call(this);
			}

			if (this.count % 15 == 0)
			{
				this.PlaySE(4638);
			}

			if (this.flag5.moveCount >= 60)
			{
				this.SetMotion(4920, 4);
				this.count = 0;
				this.keyAction = function ()
				{
					this.SetMotion(4990, 0);
				};
				this.stateLabel = function ()
				{
					if (this.motion == 4990)
					{
						if (this.GetFront())
						{
							this.SetMotion(4998, 0);
						}
					}

					if (this.centerStop != 0 && this.count % this.flag5.shotCycle == 0)
					{
						this.func[1].call(this);
					}

					this.VX_Brake(0,10000000.0);
					this.CenterUpdate(0,50000000.0, null);

					if (this.count >= 60)
					{
						if (this.com_flag2 % 2 == 0)
						{
							this.M1_Change_Slave2(null);
						}
						else
						{
							this.Master_Spell_2_Attack();
							this.flag5.charge = 30;
						}

						return;
					}
				};
			}
		};
	};
	this.stateLabel = function ()
	{
		this.flag5.moveCount++;
		this.flag5.moveV += 0,75000000.0;

		if (this.flag5.moveV >= 12,50000000.0)
		{
			this.flag5.moveV = 12,50000000.0;
		}

		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		if (this.count > this.flag5.charge)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function M1_Change_Slave2( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Jyoon2(this.x + (200 + this.rand() % 440) * this.direction, this.y - 150 + this.rand() % 300);
	this.Set_BossSpellBariaRate(10);
	this.shot_actor.Foreach(function ()
	{
		this.func[1].call(this);
	});
}

function Master_Spell_3()
{
	this.team.slave.Slave_Jyoon_3();
	this.team.slave_sub.Slave_Jyoon_3();
	this.shot_actor.Clear();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.invin = -1;
	this.invinObject = -1;
	::battle.enable_demo_talk = true;

	if (this.team.master)
	{
		this.team.master.ko_slave = true;
	}

	if (this.team.slave)
	{
		this.team.slave.ko_slave = true;
	}

	if (this.team.slave_sub)
	{
		this.team.slave_sub.ko_slave = true;
	}

	this.boss_spell_func = function ()
	{
	};
	this.boss_cpu = function ()
	{
		if (this.Cancel_Check(10))
		{
			this.Master_Spell_3_Start();
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					this.Master_Spell_3_Move();
				}
			};
		}
	};
	return true;
}

function Master_Spell_3_Start()
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4990, 0);
	this.direction = -1,00000000.0;
	this.flag5 = {};
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.centerStop = -2;
	this.flag5.pos.x = 640;
	this.flag5.pos.y = this.centerY - 100;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag3 = this.flag5.pos.x - this.x;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.count = 0;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag5.moveV += 0,75000000.0;

		if (this.flag5.moveV >= 12,50000000.0)
		{
			this.flag5.moveV = 12,50000000.0;
		}

		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ < 4,00000000.0 && this.flag5.moveV > 4,00000000.0)
		{
			this.flag3 = 0,00000000.0;
		}

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		if (this.flag3 == 0,00000000.0)
		{
			this.flag5.moveCount++;

			if (this.flag5.moveCount >= 15)
			{
				this.Master_Spell_3_Change();
				return;
			}
		}
	};
}

function Master_Spell_3_Change()
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4930, 0);
	this.flag5.moveV = 12,50000000.0;
	this.flag5.core <- null;
	this.centerStop = -2;
	this.subState = function ()
	{
	};
	this.func = [
		function ()
		{
			this.FadeOut(1,00000000.0, 1,00000000.0, 1,00000000.0, 10);
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 10)
				{
					::battle.SetSlow(120);
					this.flag5.core.func[0].call(this.flag5.core);
					this.flag5.core = null;
					this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 60);
					this.target.team.master.SlaveCrash_Init(null);
				}

				if (this.count == 11)
				{
					::battle.team[0].current.EndSpellCard();
					::battle.change_slave = true;
					::battle.team[0].ChangeSlave();
					::battle.team[1].ChangeSlave();
					::battle.gauge.SetFace("master0", "master0", 8010, 3);
					::battle.gauge.SetFace("slave0", "slave1", 8010, 1);
					::battle.gauge.SetFace("slave1", "slave0", 8011, 2);
					::battle.team[0].slave_ban = -1;
					::camera.Shake(15,00000000.0);
					this.SetShot(this.target.x, this.target.y, this.target.direction, this.Shion_Wait_Behind_Boss, {});
					this.SetMotion(this.motion, 2);
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 30)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					this.BossForceCall_Init();
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
					this.flag5.core = this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS3, {}).weakref();
				}

				if (this.count == 75)
				{
					this.SetSpellBack(false);
					this.flag5.core.func[1].call(this.flag5.core);
				}

				if (this.hitResult & 1)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, 9,00000000.0);
			};
		},
		this.Master_Spell_3_Move
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		this.subState();
	};
}

function Master_Spell_3_SetShion()
{
}

function Master_Spell_3_Move()
{
	this.LabelClear();
	this.invin = 0;
	this.invinObject = 0;
	this.SetMotion(4990, 0);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0,00000000.0;
	this.com_flag2++;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.com_flag2 % 2 == 1)
	{
		this.flag1.x = ::battle.corner_right - 200 - this.rand() % 480;
		this.flag1.y = this.centerY - 200 + this.rand() % 401;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 200 + this.rand() % 480;
		this.flag1.y = this.centerY - 200 + this.rand() % 401;
	}

	this.flag3 = this.flag1.x - this.x;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag2 += 0,40000001.0;

		if (this.flag2 >= 10,00000000.0)
		{
			this.flag2 = 10,00000000.0;
		}

		this.SetSpeed_XY((this.flag1.x - this.x) * 0,10000000.0, (this.flag1.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag2)
		{
			this.va.SetLength(this.flag2);
			this.ConvertTotalSpeed();
		}

		if (v_ <= 7,00000000.0)
		{
			this.flag3 = 0,00000000.0;
		}

		if (v_ <= 2,00000000.0)
		{
			this.M1_Change_Slave3(null);
			return;
		}
	};
}

function M1_Change_Slave3( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Jyoon3();
	this.Set_BossSpellBariaRate(10);
	this.shot_actor.Foreach(function ()
	{
		this.func[1].call(this);
	});
}

function Master_Spell_3B()
{
	this.team.slave.Slave_Jyoon_3();
	this.shot_actor.Clear();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.invin = -1;
	this.invinObject = -1;

	if (this.team.master)
	{
		this.team.master.ko_slave = true;
	}

	if (this.team.slave)
	{
		this.team.slave.ko_slave = true;
	}

	if (this.team.slave_sub)
	{
		this.team.slave_sub.ko_slave = true;
	}

	this.boss_spell_func = function ()
	{
	};
	this.boss_cpu = function ()
	{
		if (this.Cancel_Check(10))
		{
			this.Master_Spell_3B_Start();
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					this.Master_Spell_3B_Move();
				}
			};
		}
	};
	return true;
}

function Master_Spell_3B_Start()
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.direction = -1,00000000.0;
	this.flag5 = {};
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.centerStop = -2;
	this.flag5.pos.x = 640;
	this.flag5.pos.y = this.centerY - 100;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag3 = this.flag5.pos.x - this.x;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.count = 0;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag5.moveV += 0,75000000.0;

		if (this.flag5.moveV >= 12,50000000.0)
		{
			this.flag5.moveV = 12,50000000.0;
		}

		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ < 4,00000000.0 && this.flag5.moveV > 4,00000000.0)
		{
			this.flag3 = 0,00000000.0;
		}

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		if (this.flag3 == 0,00000000.0)
		{
			this.flag5.moveCount++;

			if (this.flag5.moveCount >= 15)
			{
				this.Master_Spell_3B_Change();
				return;
			}
		}
	};
}

function Master_Spell_3B_Change()
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4930, 0);
	this.flag5.moveV = 12,50000000.0;
	this.flag5.core <- null;
	this.centerStop = -2;
	this.subState = function ()
	{
	};
	this.func = [
		function ()
		{
			this.FadeOut(1,00000000.0, 1,00000000.0, 1,00000000.0, 10);
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 10)
				{
					::battle.team[0].current.DamageGrab_Common(308, 0, -this.direction);
					::battle.gauge.Hide();
				}

				if (this.count == 120)
				{
					::sound.StopBGM(3000);
					::battle.Go_NextStage();
					return;
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 30)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					this.BossForceCall_Init();
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
					this.flag5.core = this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS3, {}).weakref();
				}

				if (this.count == 75)
				{
					this.SetSpellBack(false);
					this.flag5.core.func[1].call(this.flag5.core);
				}

				if (this.hitResult & 1)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, 9,00000000.0);
			};
		},
		this.Master_Spell_3_Move
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		this.subState();
	};
}

function Master_Spell_3_DemoStart()
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.direction = -1,00000000.0;
	this.flag5 = {};
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.centerStop = -2;
	this.flag5.pos.x = 860;
	this.flag5.pos.y = this.centerY - 100;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag3 = this.flag5.pos.x - this.x;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.count = 0;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag5.moveV += 0,75000000.0;

		if (this.flag5.moveV >= 12,50000000.0)
		{
			this.flag5.moveV = 12,50000000.0;
		}

		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ < 4,00000000.0 && this.flag5.moveV > 4,00000000.0)
		{
			this.flag3 = 0,00000000.0;
		}

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		if (this.flag3 == 0,00000000.0)
		{
			this.flag5.moveCount++;

			if (this.flag5.moveCount >= 15)
			{
				this.Master_Spell_3_DemoChange();
				return;
			}
		}
	};
}

function Master_Spell_3_DemoChange()
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4930, 0);
	this.flag5.moveV = 12,50000000.0;
	this.flag5.core <- null;
	this.centerStop = -2;
	this.subState = function ()
	{
	};
	this.func = [
		function ()
		{
			this.FadeOut(1,00000000.0, 1,00000000.0, 1,00000000.0, 10);
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 10)
				{
					::battle.team[0].current.DamageGrab_Common(308, 0, -this.direction);
					::battle.gauge.Hide();
				}

				if (this.count == 120)
				{
					::sound.StopBGM(3000);
					return;
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 30)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					this.PlaySE(827);
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
					this.flag5.core = this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS3, {}).weakref();
					this.FadeOut(1,00000000.0, 1,00000000.0, 1,00000000.0, 90);
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, 9,00000000.0);
			};
		},
		this.Master_Spell_3_Move
	];
	this.stateLabel = function ()
	{
		this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,10000000.0, (this.flag5.pos.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag5.moveV)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
		}

		this.subState();
	};
}

