function Master_Spell_1()
{
	this.team.slave.Slave_Miko_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.com_flag3 = 0;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.MS1_Move(null);
				}
			};
		}
	};
}

function MS1_Move( t )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.GetFront();
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag1 = this.Vector3();
	this.flag2 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag3 = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};

	if (this.direction == 1,00000000.0 && this.x > ::battle.corner_left + 400 || this.direction == -1,00000000.0 && this.x < ::battle.corner_right - 400)
	{
		this.count = -40;
		this.flag1.x = -0,75000000.0 * this.direction;

		if (this.y >= this.target.y)
		{
			this.flag1.y = -0,25000000.0;
		}
		else
		{
			this.flag1.y = 0,25000000.0;
		}

		if (this.y < this.centerY - 125)
		{
			this.flag1.y = 0,25000000.0;
		}

		if (this.y > this.centerY + 125)
		{
			this.flag1.y = -0,25000000.0;
		}
	}
	else
	{
		if (this.rand() % 100 <= 49)
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0,40000001.0;
			}
			else
			{
				this.flag1.y = 0,40000001.0;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0,40000001.0;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0,40000001.0;
			}
		}
		else
		{
			if (this.y >= this.target.y)
			{
				this.flag1.y = -0,25000000.0;
			}
			else
			{
				this.flag1.y = 0,25000000.0;
			}

			if (this.y < this.centerY - 125)
			{
				this.flag1.y = 0,25000000.0;
			}

			if (this.y > this.centerY + 125)
			{
				this.flag1.y = -0,25000000.0;
			}
		}

		this.count = -20;

		if (this.com_flag1 == 0)
		{
			this.flag1.x = -0,50000000.0 * this.direction;
			this.com_flag1 = -1;
		}
		else
		{
			this.flag1.x = 0,50000000.0 * this.com_flag1 * this.direction;
			this.com_flag1 *= -1;
		}

		if (this.direction == 1,00000000.0 && this.x < ::battle.corner_left + 200 || this.direction == -1,00000000.0 && this.x > ::battle.corner_right - 200)
		{
			this.flag1.x = 0,50000000.0 * this.direction;
		}
	}

	this.stateLabel = function ()
	{
		if (this.count >= 0)
		{
			this.flag3 = false;

			if (this.Vec_Brake(0,50000000.0))
			{
				this.MS1_Attack(null);
				return;
			}
		}
		else if (this.va.Length() <= 8,00000000.0)
		{
			this.AddSpeed_XY(this.flag1.x, this.flag1.y);
		}

		if (this.flag3)
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
		else
		{
			this.Boss_WalkMotionUpdate(0);
		}
	};
}

function MS1_Wait( wait_ )
{
	this.LabelClear();
	this.SetMotion(4990, 0);
	this.count = -wait_;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, 2,00000000.0);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,20000000.0);
		}

		if (this.keyTake == 1)
		{
			if ((this.target.x - this.x) * this.direction < 0,00000000.0)
			{
				this.SetMotion(4998, 0);
				this.direction = -this.direction;
			}
		}

		if (this.count >= 0)
		{
			this.MS1_Attack(null);
			return;
		}
	};
}

function MS1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.count = 0;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.shotNum <- 10;
	this.flag5.shotCount <- 10;
	this.flag5.shotRot <- 0,17453292.0;
	this.flag5.targetRot <- 0,00000000.0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 45;
		this.flag5.shotRot = 0,13962634.0;
		break;

	case 2:
		this.flag5.shotCount = 90;
		this.flag5.shotRot = 0,10471975.0;
		break;

	case 3:
		this.flag5.shotCount = 180;
		this.flag5.shotRot = 0,08726646.0;
		break;
	}

	this.subState = function ()
	{
		this.SetSpeed_XY((640 - this.flag1.x * this.direction - this.x) * 0,10000000.0, (this.centerY + 0 + this.flag1.y * 0,50000000.0 - this.y) * 0,10000000.0);
	};
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag5.targetRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.stateLabel = function ()
			{
				if (this.count % 2 == 1)
				{
					if (this.flag5.shotNum >= 0)
					{
						this.PlaySE(2050);
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * -0,05235988.0 + this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_M1_Laser, t_));
						local t_ = {};
						t_.rot <- (this.flag5.shotNum - 10) * 0,05235988.0 - this.flag5.shotRot + this.flag5.targetRot;
						t_.count <- this.flag5.shotCount;
						this.flag3.Add(this.SetShot(this.x - 600 * this.cos(this.flag5.targetRot) * this.direction, this.y - 600 * this.sin(this.flag5.targetRot), this.direction, this.Boss_Shot_M1_Laser, t_));
						this.flag5.shotNum--;
					}
				}

				if (this.count == 45)
				{
					this.PlaySE(2103);
					this.flag3.Foreach(function ()
					{
						this.func[1].call(this);
					});
					this.M1_Change_Slave(null);
					return;
				}
			};
		},
		null,
		null,
		null,
		function ()
		{
			this.MS1_Move(null);
		}
	];
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.S_Lance_Fire(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2()
{
	this.team.slave.Slave_Miko_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 0;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.MS2_Attack(null);
				}
			};
		}
	};
}

function MS2_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.direction = this.com_flag1;
	this.flag1 = this.Vector3();
	this.flag1.x = 640 - 480 * this.direction;
	this.flag1.y = this.centerY - 150 - this.rand() % 25;
	this.flag2 = 0,00000000.0;
	this.flag3 = true;
	this.flag4 = null;
	this.com_flag1 *= -1,00000000.0;
	this.subState = function ()
	{
		this.flag2 += 0,50000000.0;

		if (this.flag2 > 15,00000000.0)
		{
			this.flag2 = 15,00000000.0;
		}

		this.va.x = (this.flag1.x - this.x) * 0,10000000.0;
		this.va.y = (this.flag1.y - this.y) * 0,10000000.0;
		local v_ = this.va.Length();

		if (v_ > this.flag2)
		{
			this.va.SetLength(this.flag2);
		}

		if (v_ <= 5,00000000.0)
		{
			this.flag3 = false;
		}

		this.ConvertTotalSpeed();
	};
	this.func = [
		function ()
		{
			this.SetMotion(4920, 0);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,25000000.0);
			};
			this.keyAction = [
				function ()
				{
					this.count = 0;
					local t_ = {};
					t_.rot <- 60 * 0,01745329.0;
					this.flag4 = this.SetShot(this.x, ::battle.scroll_top - 400, this.direction, this.Boss_Shot_M2_Light, t_).weakref();
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,25000000.0);

						if (this.count == 240)
						{
							if (this.flag4)
							{
								this.flag4.func[0].call(this.flag4);
							}

							this.flag4 = null;
						}

						if (this.count >= 300)
						{
							this.M2_Change_Slave(null);
							return;
						}
					};
				}
			];
		},
		function ()
		{
			this.SetMotion(4920, 3);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 2,00000000.0);

				if (this.count >= 90)
				{
					this.MS2_Attack(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();

		if (this.flag3)
		{
			this.Boss_WalkMotionUpdate(this.va.x);
		}
		else
		{
			this.Boss_WalkMotionUpdate(0);
		}

		if (this.flag3 == false && this.va.Length() <= 1,00000000.0)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.keyAction = [];
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.S_FallKick_Attack(this.direction);
	this.Set_BossSpellBariaRate(10);
}

