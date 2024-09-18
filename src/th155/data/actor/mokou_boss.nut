function Slave_Mamizou_1()
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

function S_Assult_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);

	if (this.x > 640)
	{
		this.direction = -1.00000000;
	}
	else
	{
		this.direction = 1.00000000;
	}

	this.armor = -1;
	this.count = 0;
	this.AjustCenterStop();
	this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.20000000 * this.direction, 0.00000000);
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 4);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
				this.CenterUpdate(0.05000000, 1.00000000);
			};
		}
	];
	this.keyAction = [
		function ()
		{
		},
		null,
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count <= 30)
				{
					this.AddSpeed_XY(0.20000000 * this.direction, 0.00000000, 20.00000000 * this.direction, null);
				}
				else
				{
					this.AddSpeed_XY(1.25000000 * this.direction, 0.00000000, 25.00000000 * this.direction, null);
				}

				if (this.count % 3 == 1)
				{
					this.SetFreeObject(this.x - this.rand() % 75, this.y - 50 + this.rand() % 100, this.direction, this.Boss_S1_Particle, {});
				}

				if (this.direction == 1.00000000 && this.x > ::battle.corner_right - 200.00000000 || this.direction == -1.00000000 && this.x < ::battle.corner_left + 200.00000000)
				{
					this.func[1].call(this);
					return;
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.keyAction = null;
			this.stateLabel = function ()
			{
				if (this.GetFront())
				{
					this.SetMotion(4998, 0);
				}

				if (this.count == 30)
				{
					if (this.team.life >= this.team.regain_life)
					{
						this.S_Mamizou_1_Change_Master(null);
					}
					else
					{
						this.S_Mamizou_1_Change_Master(null);
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000, 1.00000000);

		if (this.count == 60)
		{
			this.func[0].call(this);
			return;
		}
	};
}

function S_Fire_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 0.00000000;
	this.flag2 = null;
	this.func = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Boss_S2_FireBall, {}).weakref();
			this.stateLabel = function ()
			{
				this.VY_Brake(0.75000000);

				if (this.count == 90)
				{
					this.flag2.func[0].call(this.flag2);
					this.S_Mamizou_2_Change_Master(null);
					return;
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, -0.25000000);

				if (this.count == 20)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function S_WideFire_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4921, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 0.00000000;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 3;
	this.flag5.shotNum <- 8;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 12;
		break;

	case 2:
		this.flag5.shotNum = 20;
		break;

	case 3:
		this.flag5.shotNum = 30;
		break;
	}

	this.func = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VY_Brake(0.75000000);

				if (this.count == 90)
				{
					this.flag2.func[0].call(this.flag2);
					this.S_Mamizou_2_Change_Master(null);
					return;
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag5.shotNum > 0 && this.count % 3 == 1)
				{
					this.flag5.shotNum--;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_S2_FireShot, {});
				}

				if (this.count == 180)
				{
					this.S_Mamizou_1_Change_Master(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function S_SelfFire_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 0.00000000;
	this.flag2 = null;
	this.func = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Boss_S2_FireBall, {}).weakref();
			this.stateLabel = function ()
			{
				this.VY_Brake(0.75000000);

				if (this.count == 90)
				{
					this.flag2.func[0].call(this.flag2);
					this.S_Mamizou_1_Change_Master(null);
					return;
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, -0.25000000);

				if (this.count == 20)
				{
					this.func[0].call(this);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function S_Mamizou_1_Change_Master( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MS1_Move(null);
	this.Set_BossSpellBariaRate(1);
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
	this.SetMotion(4921, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 0.00000000;
	this.flag2 = null;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotCycle <- 12;
	this.flag5.shotCount <- 60;
	this.flag5.shotNum <- 3;
	this.flag5.shotRotate <- 2.09439468;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 8;
		this.flag5.shotNum = 8;
		this.flag5.shotCount = 60;
		this.flag5.shotRotate = 0.78539813;
		break;

	case 2:
		this.flag5.shotCycle = 5;
		this.flag5.shotNum = 12;
		this.flag5.shotCount = 90;
		this.flag5.shotRotate = 0.52359873;
		break;

	case 3:
		this.flag5.shotCycle = 3;
		this.flag5.shotNum = 20;
		this.flag5.shotCount = 120;
		this.flag5.shotRotate = 13 * 0.01745329;
		break;
	}

	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					local r_ = this.rand() % 360 * 0.01745329;

					while (this.flag5.shotNum > 0)
					{
						local t_ = {};
						t_.rot <- r_;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_S2_FireShot_B, t_);
						r_ = r_ + this.flag5.shotRotate;
						this.flag5.shotNum--;
					}

					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count < this.flag5.shotCount && this.count % this.flag5.shotCycle == 1)
						{
							local t_ = {};
							t_.rot <- this.rand() % 360 * 0.01745329;
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_S2_FireShot_B, t_);
						}

						if (this.count == this.flag5.shotCount + 90)
						{
							this.Change_Master_Jyoon(null);
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Jyoon( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_3_Move();
}

