function Master_Spell_1()
{
	this.team.slave.Slave_Mamizou_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
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

					this.MS1_MoveStart(null);
				}
			};
		}
	};
}

function MS1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 120;
	this.flag5.shotRot <- 0,00000000.0;
	this.flag5.shotRotSpeed <- 13 * 0,01745329.0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCount = 150;
		this.flag5.shotCycle = 7;
		break;

	case 2:
		this.flag5.shotCount = 180;
		this.flag5.shotCycle = 5;
		break;

	case 3:
		this.flag5.shotCount = 180;
		this.flag5.shotCycle = 3;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.subState = function ()
	{
	};
	this.func = [
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.M1_Change_Slave(null);
			return;
			this.flag3++;

			if (this.flag3 >= 3)
			{
				this.M2_Change_Slave(null);
				this.flag3 = 0;
				return;
			}

			this.SetSpeed_XY(10,00000000.0 - 20,00000000.0 * (this.rand() % 2), 4 - 8 * (this.rand() % 2));

			if (this.va.y < 0 && this.y < this.centerY - 200 || this.va.y > 0 && this.y > this.centerY + 200)
			{
				this.va.y *= -1,00000000.0;
			}

			if (this.va.x < 0 && this.x < 240 || this.va.x > 0,00000000.0 && this.x > 1080)
			{
				this.va.x *= -1,00000000.0;
			}

			this.ConvertTotalSpeed();
			this.subState = function ()
			{
				this.Vec_Brake(0,25000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count % this.flag5.shotCycle == 1)
				{
					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					this.SetShot(this.x, this.y - 25, this.direction, this.Boss_Shot_MS2_Leaf, t_);
					local t_ = {};
					t_.rot <- this.flag5.shotRot + 3,14159203.0;
					this.SetShot(this.x, this.y - 25, this.direction, this.Boss_Shot_MS2_Leaf, t_);
					this.flag5.shotRot += this.flag5.shotRotSpeed;
				}

				if (this.count == 120)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count % 180 == 179)
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();

		if (this.count == 30)
		{
			this.func[1].call(this);
			return;
		}
	};
	this.keyAction = [];
}

function MS1_MoveStart( t )
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0,00000000.0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x > (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
	{
		this.flag1.x = ::battle.corner_right - 200;
		this.flag1.y = this.centerY - 100 + this.rand() % 201;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 200;
		this.flag1.y = this.centerY - 100 + this.rand() % 201;
	}

	this.flag3 = this.flag1.x - this.x;
	this.MS1_MoveCommon();
}

function MS1_Move( t )
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0,00000000.0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
	{
		this.flag1.x = ::battle.corner_right - 200;
		this.flag1.y = this.centerY - 100 + this.rand() % 201;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 200;
		this.flag1.y = this.centerY - 100 + this.rand() % 201;
	}

	this.flag3 = this.flag1.x - this.x;
	this.MS1_MoveCommon();
}

function MS1_MoveCommon()
{
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
			this.MS1_Attack(null);
			return;
		}
	};
}

function MS1_BackFire( t )
{
	this.LabelClear();
	this.SetMotion(4920, 2);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = 13 * 0,01745329.0;
	this.flag3 = 0;
	this.flag4 = null;
	this.func = [
		function ()
		{
			this.SetMotion(4920, 4);
			this.freeMap = true;
			this.lavelClearEvent = function ()
			{
				this.freeMap = false;

				if (this.flag4)
				{
					this.flag4.func[0].call(this.flag4);
					this.flag4 = null;
				}
			};
			this.flag3 = 3;
			this.flag4 = this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS2_BackFire, {}).weakref();
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,50000000.0 * this.direction, 0,00000000.0, 25,00000000.0 * this.direction, null);

				if (this.direction == 1,00000000.0 && this.x > ::battle.scroll_right + 480 || this.direction == -1,00000000.0 && this.x < ::battle.scroll_left - 480)
				{
					this.func[1].call(this);
				}
			};
		},
		function ()
		{
			this.direction = -this.direction;
			this.SetSpeed_XY(-this.va.x, 0,00000000.0);
			this.flag3--;

			if (this.flag3 <= 0)
			{
				if (this.flag4)
				{
					this.flag4.func[0].call(this.flag4);
					this.flag4 = null;
				}

				this.Warp(this.x, this.centerY);
				this.count = 0;
				this.stateLabel = function ()
				{
					this.VX_Brake(0,25000000.0);

					if (this.count == 50)
					{
						this.SetMotion(4920, 6);
						this.count = 0;
						this.stateLabel = function ()
						{
							this.VX_Brake(0,50000000.0);
						};
					}
				};
			}
			else
			{
				if (this.flag4)
				{
					this.flag4.direction *= -1,00000000.0;
				}

				this.Warp(this.x, this.target.y);
				this.centerStop = 0;
			}
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.keyAction = [
		null,
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			this.GetFront();
			this.lavelClearEvent = null;
			this.freeMap = false;
			this.Set_BossSpellBariaRate(1);
			this.stateLabel = function ()
			{
				this.GetFront();
				this.MS1_Attack(null);
				return;
			};
		}
	];
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.S_WideFire_Attack(null);
	this.Set_BossSpellBariaRate(10);
}

