function Master_Spell_1()
{
	this.team.slave.Slave_Udonge_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.Master_Spell_1_Attack(null);
				}
			};
		}
	};
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag5 = {};
	this.flag5.charge <- 120;
	this.flag5.shotFunc <- function ()
	{
		for( local i = 0; i < 2; i++ )
		{
			local t_ = {};
			t_.rot <- 22.50000000 * 0.01745329 - 0.78539813 * i;
			t_.v <- 10.00000000;
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2, t_, this.weakref());
			local t_ = {};
			t_.rot <- 22.50000000 * 0.01745329 - 0.78539813 * i;
			t_.v <- 10.00000000;
			this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M2, t_, this.weakref());
		}
	};

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.charge = 90;
		this.flag5.shotFunc = function ()
		{
			for( local i = 0; i < 4; i++ )
			{
				local t_ = {};
				t_.rot <- 1.04719746 - 0.69813168 * i;
				t_.v <- 10.00000000;
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2, t_, this.weakref());
				local t_ = {};
				t_.rot <- 1.04719746 - 0.69813168 * i;
				t_.v <- 10.00000000;
				this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M2, t_, this.weakref());
			}
		};
		break;

	case 2:
		this.flag5.charge = 90;
		this.flag5.shotFunc = function ()
		{
			for( local i = 0; i < 4; i++ )
			{
				local t_ = {};
				t_.rot <- 1.04719746 - 0.69813168 * i;
				t_.v <- 10.00000000;
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2, t_, this.weakref());
				local t_ = {};
				t_.rot <- 1.04719746 - 0.69813168 * i;
				t_.v <- 10.00000000;
				this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M2, t_, this.weakref());
			}

			for( local i = 0; i < 3; i++ )
			{
				local t_ = {};
				t_.rot <- 0.69813168 - 0.69813168 * i;
				t_.v <- 6.00000000;
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2, t_, this.weakref());
				local t_ = {};
				t_.rot <- 0.69813168 - 0.69813168 * i;
				t_.v <- 6.00000000;
				this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M2, t_, this.weakref());
			}
		};
		break;

	case 3:
	case 4:
		this.flag5.charge = 75;
		this.flag5.shotFunc = function ()
		{
			for( local i = 0; i < 6; i++ )
			{
				local t_ = {};
				t_.rot <- 50 * 0.01745329 - 0.34906584 * i;
				t_.v <- 10.00000000;
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2, t_, this.weakref());
				local t_ = {};
				t_.rot <- 50 * 0.01745329 - 0.34906584 * i;
				t_.v <- 10.00000000;
				this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M2, t_, this.weakref());
			}

			for( local i = 0; i < 5; i++ )
			{
				local t_ = {};
				t_.rot <- 40 * 0.01745329 - 0.34906584 * i;
				t_.v <- 5.00000000;
				this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M2, t_, this.weakref());
				local t_ = {};
				t_.rot <- 40 * 0.01745329 - 0.34906584 * i;
				t_.v <- 5.00000000;
				this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M2, t_, this.weakref());
			}
		};
		break;
	}

	this.count = 0;
	this.flag1 = [];
	this.flag2 = null;
	this.flag3 = 0.00000000;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.stateLabel = function ()
	{
		if (this.count == this.flag5.charge)
		{
			this.flag2 = this.SetFreeObject(this.x, this.y - 50, this.direction, this.SPShot_E_Pulse, {}).weakref();
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
			};
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 4);
			local x_ = 30.00000000 + this.rand() % 20;
			local y_ = 10 + this.rand() % 11;

			if (this.rand() % 100 <= 50)
			{
				x_ = x_ * -1;
			}

			if (this.rand() % 100 <= 50)
			{
				y_ = y_ * -1;
			}

			if (y_ < 0.00000000 && this.y < 200.00000000 || y_ > 0.00000000 && this.y > 520)
			{
				y_ = y_ * -1;
			}

			if (x_ < 0.00000000 && this.x < 400.00000000 || x_ > 0.00000000 && this.x > 880)
			{
				x_ = x_ * -1;
			}

			this.SetSpeed_XY(x_, y_);
			this.PlaySE(3855);

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func[1].call(a);
				}
			}

			if (this.flag2)
			{
				this.flag2.func();
			}

			this.stateLabel = function ()
			{
				if (this.fabs(this.flag1[0].x - this.x) <= 45)
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);

					foreach( a in this.flag1 )
					{
						if (a)
						{
							this.ReleaseActor.call(a);
						}
					}

					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		},
		null,
		function ()
		{
			this.com_flag2++;

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;

			if (this.com_flag2 >= 3)
			{
				this.com_flag2 = 0;

				if (this.flag2)
				{
					this.flag2.func();
				}

				this.flag5.shotFunc.call(this);
				this.M1_Change_Slave(null);
				return;
			}
			else
			{
				local t_ = {};
				t_.rot <- 0;
				local a_ = [];
				a_.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1, t_, this.weakref()));
				a_.append(this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M1, t_, this.weakref()));
				local t_ = {};
				t_.rot <- 45 * 0.01745329;
				a_.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1, t_, this.weakref()));
				a_.append(this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M1, t_, this.weakref()));
				local t_ = {};
				t_.rot <- -45 * 0.01745329;
				a_.append(this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1, t_, this.weakref()));
				a_.append(this.SetShot(this.x, this.y, -this.direction, this.Boss_Shot_M1, t_, this.weakref()));
				this.PlaySE(3854);
				this.flag1 = a_;
				this.flag5.shotFunc.call(this);
				this.count = 0;
				this.stateLabel = function ()
				{
					if (this.count == 40)
					{
						this.func[0].call(this);
						return;
					}
				};
			}
		},
		null,
		null,
		null,
		function ()
		{
			this.Master_Spell_1_Attack(null);
			return;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 1.00000000);
			};
		}
	];
}

function Master_Spell_1_Attack_B( t )
{
	this.Master_Spell_1_Attack(t);
	this.flag2 = this.SetFreeObject(this.x, this.y - 50, this.direction, this.SPShot_E_Pulse, {}).weakref();
	this.SetMotion(this.motion, 2);
	this.stateLabel = function ()
	{
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Udonge(null);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Mokou_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function Slave_Attack_Mokou( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4920, 4);
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.owner.hide = false;
	this.flag2 = 0;
	this.GetFront();
	this.SetSpeed_XY(-10.00000000 * this.direction, 0.00000000);
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotCount <- 0;
	this.flag5.shotCycle <- 20;
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.count = 0;
	this.subState[1] = function ()
	{
		this.flag5.shotCount++;

		if (this.flag5.shotCount % this.flag5.shotCycle == 1)
		{
			this.GetFront();
			this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_S1_Vision, {});
		}
	};
	this.subState[0] = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.20000000);

		if (this.VX_Brake(0.20000000))
		{
			this.subState[0] = function ()
			{
				this.AddSpeed_XY(0.25000000 * this.direction, 0.00000000, 12.50000000 * this.direction, null);

				if (this.VY_Brake(0.25000000))
				{
					this.count = 0;
					this.subState[0] = function ()
					{
						this.AddSpeed_XY(0.25000000 * this.direction, -0.34999999, 12.50000000 * this.direction, null);

						if (this.count == 30)
						{
							this.subState[0] = function ()
							{
								if (this.Vec_Brake(0.50000000))
								{
									this.func[0].call(this);
									return;
								}
							};
						}
					};
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.SetMotion(4920, 5);
			this.GetFront();
			this.centerStop = -2;
			this.AjustCenterStop();
			this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
			this.SetSpeed_Vec(-10.00000000, this.rz, this.direction);
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 1.00000000);
			};
		}
	];
	this.keyAction = [
		null,
		null,
		function ()
		{
			this.PlaySE(3897);
		},
		function ()
		{
		},
		null,
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.10000000, 2.00000000);

				if (this.count >= 5 && this.count % 4 == 1)
				{
					if (this.flag2 <= 2)
					{
						this.PlaySE(3844);
						local t_ = {};
						t_.rot <- this.rz;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_S1_Bullet, t_);
					}

					this.flag2++;
				}

				if (this.count == 90)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count >= 180)
				{
					this.Change_Master_Mokou(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState[0].call(this))
		{
			return;
		}

		this.subState[1].call(this);
	};
	return true;
}

function Slave_Attack_MokouB( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag2 = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 60;
	this.flag5.shotNum <- 6;
	this.flag5.shotRot <- 1.04719746;
	this.flag5.wait <- 240;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0.00000000;
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
		this.flag5.shotCycle = 40;
		this.flag5.shotNum = 8;
		this.flag5.shotRot = 0.78539813;
		break;

	case 2:
		this.flag5.shotCycle = 25;
		this.flag5.shotNum = 10;
		this.flag5.shotRot = 36 * 0.01745329;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 15;
		this.flag5.shotNum = 12;
		this.flag5.shotRot = 0.52359873;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == this.flag5.wait - 90)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == this.flag5.wait)
				{
					this.Change_Master_Mokou(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Mokou( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1_Attack(null);
}

