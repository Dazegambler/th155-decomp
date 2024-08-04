function Slave_Miko_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function S_Lance_Fire( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};
	this.flag5 = {};
	this.flag5.charge <- 90;
	this.flag5.shotNum <- 0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.charge = 90;
		this.flag5.shotNum = 4;
		break;

	case 2:
		this.flag5.charge = 60;
		this.flag5.shotNum = 10;
		break;

	case 3:
		this.flag5.charge = 60;
		this.flag5.shotNum = 20;
		break;
	}

	this.keyAction = [
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
			if (this.flag2)
			{
				this.flag2.func();
			}

			local t_ = {};
			t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			t_.rot = this.Math_MinMax(t_.rot, -0,10471975.0, 0,10471975.0);
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_Lance, t_);
			this.PlaySE(1710);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.S_Miko_1_Change_Master(null);
		}
	];
	this.stateLabel = function ()
	{
		if (this.count >= this.flag5.charge)
		{
			this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
			this.SetMotion(4910, 2);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0, 0,25000000.0 * this.direction);
			};
		}
	};
	return true;
}

function S_Miko_1_Change_Master( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MS1_Move(null);
	this.Set_BossSpellBariaRate(1);
}

function S_FallKick_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4920, 0);
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag1 = 20;
	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.PlaySE(1713);
			this.SetSpeed_XY(25,00000000.0 * this.direction, 20,00000000.0);
			this.centerStop = 2;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				if (this.y > this.centerY + 50)
				{
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(this.va.x * 0,34999999.0, this.va.y * 0,34999999.0);
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,50000000.0, 2,00000000.0);
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0,00000000.0, -0,20000000.0);
						};
					};
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.PlaySE(1712);
			this.SetSpeed_XY(0,00000000.0, -10,00000000.0);
			this.centerStop = -2;
			this.flag2.x = this.target.x - (this.target.y - 200) * this.direction;
			this.stateLabel = function ()
			{
				this.SetSpeed_XY((this.flag2.x - this.x) * 0,10000000.0, this.va.y);
			};
		},
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, this.va.y * 0,50000000.0);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY((this.flag2.x - this.x) * 0,10000000.0, this.va.y);
				this.VY_Brake(0,50000000.0);

				if (this.count >= this.flag1)
				{
					this.func[0].call(this);
				}
			};
		},
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, null);

				if (this.count == 90)
				{
					this.S_Miko_2_Change_Master(null);
					return;
				}
			};
		},
		function ()
		{
			this.S_Miko_2_Change_Master(null);
		}
	];
}

function S_Miko_2_Change_Master( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MS2_Attack(null);

	if (this.team.life > 1000)
	{
		this.Set_BossSpellBariaRate(1);
	}
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
	this.SetMotion(4930, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotCount <- 25;
	this.flag5.shotNum <- 1;
	this.flag5.charge <- 120;
	this.flag5.rotSpeed <- 0,00000000.0;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotNum = 2;
		this.flag5.shotCount = 25;
		this.flag5.charge = 90;
		this.flag5.rotSpeed = 0,01745329.0;
		break;

	case 2:
		this.flag5.shotNum = 3;
		this.flag5.shotCount = 25;
		this.flag5.charge = 60;
		this.flag5.rotSpeed = 0,03490658.0;
		break;

	case 3:
		this.flag5.shotNum = 4;
		this.flag5.shotCount = 25;
		this.flag5.charge = 45;
		this.flag5.rotSpeed = 0,05235988.0;
		break;
	}

	this.AjustCenterStop();
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.count = 0;
			this.GetFront();
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.PlaySE(1708);
			this.flag5.shotNum--;
			this.rz = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.rz = this.Math_MinMax(this.rz, -1,57079601.0, 1,57079601.0);
			this.SetSpeed_Vec(20,00000000.0, this.rz, this.direction);
			this.count = 0;
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				if (this.flag5.rotSpeed)
				{
					this.TargetHoming(this.target, this.flag5.rotSpeed, this.direction);
				}

				this.rz = this.atan2(this.va.y, this.va.x * this.direction);

				if (this.count >= this.flag5.shotCount)
				{
					this.rz = 0,00000000.0;
					this.SetMotion(4930, 5);
					this.AjustCenterStop();
					this.stateLabel = function ()
					{
						if (this.Vec_Brake(2,00000000.0, 2,00000000.0))
						{
							this.stateLabel = function ()
							{
								this.CenterUpdate(0,10000000.0, 2,00000000.0);
							};
						}
					};
					return;
				}

				local t_ = {};
				t_.rot <- this.rz;
				this.SetShot(this.x + 100 - this.rand() % 201, this.y - 100 + this.rand() % 201, this.direction, this.Boss_Shot_MS1_B, t_);
			};
		},
		null,
		function ()
		{
			if (this.flag5.shotNum > 0)
			{
				this.GetFront();
				this.SetMotion(4930, 3);
				return;
			}

			this.Change_Master_Jyoon(null);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);

		if (this.count == this.flag5.charge)
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(4930, 3);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function Change_Master_Jyoon( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_3_Move();
}

