function Slave_Tutorial_2()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function ST2_PositionChange( t )
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0.00000000;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0.50000000)
	{
		this.flag1.x = ::battle.corner_right - 200;
		this.flag1.y = this.centerY - 250;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 200;
		this.flag1.y = this.centerY - 250;
	}

	this.flag3 = this.flag1.x - this.x;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag2 += 0.33000001;

		if (this.flag2 >= 7.50000000)
		{
			this.flag2 = 7.50000000;
		}

		this.SetSpeed_XY((this.flag1.x - this.x) * 0.10000000, (this.flag1.y - this.y) * 0.10000000);
		local v_ = this.va.Length();

		if (v_ >= this.flag2)
		{
			this.va.SetLength(this.flag2);
			this.ConvertTotalSpeed();
		}

		if (v_ <= 7.00000000)
		{
			this.flag3 = 0.00000000;
		}

		if (v_ <= 2.00000000)
		{
			this.ST2_Attack(null);
			return;
		}
	};
}

function ST2_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0.50000000)
	{
		this.direction = 1.00000000;
	}
	else
	{
		this.direction = -1.00000000;
	}

	this.flag5 = {};
	this.flag5.shotNum <- 6;
	this.flag5.shotCycle <- 15;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 12;
		this.flag5.shotCycle = 10;
		break;

	case 2:
		this.flag5.shotNum = 24;
		this.flag5.shotCycle = 5;
		break;

	case 3:
		this.flag5.shotNum = 36;
		this.flag5.shotCycle = 3;
		break;
	}

	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.25000000, 0.50000000);

				if (this.count == 15)
				{
					this.SetMotion(this.motion, 2);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.PlaySE(2502);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 0.50000000);

				if (this.flag5.shotNum > 0 && this.count % this.flag5.shotCycle == 1)
				{
					this.flag5.shotNum--;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_T_HeartFall, {});
				}

				if (this.count >= 180)
				{
					this.SetMotion(this.motion, 5);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.05000000, 0.50000000);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.SetMotion(4990, 0);
			this.stateLabel = function ()
			{
				this.ST2_Change_Master(null);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000, 0.50000000);
	};
}

function ST2_Change_Master( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MT2_Position_Change(null);
	this.Set_BossSpellBariaRate(1);
}

function ST2_Change_Attack( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MT2_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_B_Wait()
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(90, 0);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		if (this.count >= 120)
		{
			this.Slave_B_Marisa_Change();
			return;
		}
	};
}

function Slave_B_Marisa_Change()
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_B_Wait();
}

function Slave_Jyoon_3()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function Slave_Attack_Jyoon3()
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotNum <- 5;
	this.flag5.shotWay <- 4;
	this.flag5.shotCycle <- 30;
	this.flag5.shotCount <- 0;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotWay = 6;
		this.flag5.shotNum = 6;
		this.flag5.shotCycle = 20;
		break;

	case 2:
		this.flag5.shotWay = 8;
		this.flag5.shotNum = 8;
		this.flag5.shotCycle = 18;
		break;

	case 3:
		this.flag5.shotWay = 10;
		this.flag5.shotNum = 10;
		this.flag5.shotCycle = 15;
		break;
	}

	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.25000000, 0.50000000);

				if (this.count == 90)
				{
					this.SetMotion(this.motion, 2);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.PlaySE(2502);

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 0.50000000);

				if (this.flag5.shotNum > 0)
				{
					if (this.count % this.flag5.shotCycle == 1)
					{
						this.flag5.shotNum--;

						for( local i = 0; i < this.flag5.shotWay; i++ )
						{
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_T_HeartFall_B, {});
						}
					}
				}
				else
				{
					this.flag5.shotCount++;

					if (this.flag5.shotCount >= 120)
					{
						this.SetMotion(this.motion, 5);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.05000000, 0.50000000);
						};
						return;
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.SetMotion(4990, 0);
			this.stateLabel = function ()
			{
				this.Change_Master_Jyoon(null);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000, 0.50000000);
	};
}

function Change_Master_Jyoon( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_3_Move();
}

