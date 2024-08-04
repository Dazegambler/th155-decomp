function Master_Spell_1()
{
	this.team.slave.Slave_Ichirin_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
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

					this.Master_Spell_1_Attack(null);
				}
			};
		}
	};
	return true;
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4992, 0);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 25;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 90;
	this.flag5.charge <- 90;
	this.flag5.moveV <- 0;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);
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
	case 0:
		break;

	case 1:
		this.flag5.shotCycle = 17;
		this.flag5.shotRot = 120;
		break;

	case 2:
		this.flag5.shotCycle = 11;
		this.flag5.shotRot = 150;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 7;
		this.flag5.shotRot = 180;
		break;
	}

	this.count = -20;
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, 1,00000000.0);

		if (this.count < 0)
		{
			this.AddSpeed_XY(-0,50000000.0 * this.direction, 0,00000000.0, -6,00000000.0 * this.direction, null);
		}
		else
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.SetMotion(4910, 0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0, -0,50000000.0 * this.direction);
				this.CenterUpdate(0,10000000.0, 1,00000000.0);

				if (this.count >= this.flag5.charge)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					this.SetMotion(this.motion, 2);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(-0,05000000.0 * this.direction, 0,00000000.0, -3,00000000.0 * this.direction, null);

						if (this.count % 15 == 1)
						{
							this.PlaySE(1553);
						}

						if (this.count % this.flag5.shotCycle == 1)
						{
							this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS1, {});
						}

						if (this.count == 90)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.count == 210)
						{
							this.M1_Change_Slave(null);
						}
					};
				}
			};
		}
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Ichirin(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_1B()
{
	this.team.slave.Slave_Ichirin_1B();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
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

					this.Master_Spell_1B_Attack(null);
				}
			};
		}
	};
	return true;
}

function Master_Spell_1B_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4992, 0);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 25;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 90;
	this.flag5.charge <- 90;
	this.flag5.moveV <- 0;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);
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
	case 0:
		break;

	case 1:
		this.flag5.shotCycle = 17;
		this.flag5.shotRot = 120;
		break;

	case 2:
		this.flag5.shotCycle = 11;
		this.flag5.shotRot = 150;
		break;

	case 3:
		this.flag5.shotCycle = 9;
		this.flag5.shotRot = 165;
		break;

	case 4:
		this.flag5.shotCycle = 7;
		this.flag5.shotRot = 180;
		break;
	}

	this.count = -20;
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, 1,00000000.0);

		if (this.count < 0)
		{
			this.AddSpeed_XY(-0,50000000.0 * this.direction, 0,00000000.0, -6,00000000.0 * this.direction, null);
		}
		else
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.SetMotion(4910, 0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0, -0,50000000.0 * this.direction);
				this.CenterUpdate(0,10000000.0, 1,00000000.0);

				if (this.count >= this.flag5.charge)
				{
					if (this.flag4)
					{
						this.flag4.func();
					}

					this.flag4 = null;
					this.SetMotion(this.motion, 2);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.direction == 1,00000000.0 && this.x < 200 || this.direction == -1,00000000.0 && this.x > 1080)
						{
							this.VX_Brake(0,25000000.0);
						}
						else
						{
							this.AddSpeed_XY(-0,05000000.0 * this.direction, 0,00000000.0, -3,00000000.0 * this.direction, null);
						}

						if (this.count % 15 == 1)
						{
							this.PlaySE(1553);
						}

						if (this.count % this.flag5.shotCycle == 1)
						{
							this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_MS1, {});
						}

						if (this.count == 90)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.count == 210)
						{
							this.M1B_Change_Slave(null);
						}
					};
				}
			};
		}
	};
}

function M1B_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Ichirin1B(null);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Koishi_1()
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

function Slave_Attack_Koishi( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4920, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(-12,50000000.0 * this.direction, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
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
	this.flag5.charge <- 45;
	this.flag5.wait <- 210;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.wait = 210;
		break;

	case 2:
		this.flag5.wait = 210;
		break;

	case 3:
	case 4:
		this.flag5.wait = 210;
		break;
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(0,44999999.0, -0,50000000.0 * this.direction);
		this.CenterUpdate(0,10000000.0, 1,00000000.0);

		if (this.count > this.flag5.charge)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.func = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.keyAction = [
		null,
		null,
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.PlaySE(1480);
			this.SetSpeed_Vec(20,00000000.0, -5 * 0,01745329.0, this.direction);
			this.centerStop = -2;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(1,00000000.0, 0,50000000.0);

				if (this.count == this.flag5.wait - 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count > this.flag5.wait)
				{
					this.Change_Master_Koishi(null);
					return;
				}
			};
		},
		function ()
		{
			this.SetShot(640 - 800 * this.direction, this.y, this.direction, this.Boss_Shot_SL1B, {});
		}
	];
}

function Change_Master_Koishi( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_1_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_Hijiri_1()
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

function Slave_Attack_Hijiri( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4920, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(-12,50000000.0 * this.direction, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
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
	this.flag5.charge <- 45;
	this.flag5.wait <- 210;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.wait = 210;
		break;

	case 2:
		this.flag5.wait = 210;
		break;

	case 3:
	case 4:
		this.flag5.wait = 210;
		break;
	}

	this.stateLabel = function ()
	{
		this.VX_Brake(0,44999999.0, -0,50000000.0 * this.direction);
		this.CenterUpdate(0,10000000.0, 1,00000000.0);

		if (this.count > this.flag5.charge)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.func = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.keyAction = [
		null,
		null,
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.PlaySE(1480);
			this.SetSpeed_Vec(20,00000000.0, -5 * 0,01745329.0, this.direction);
			this.centerStop = -2;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(1,00000000.0, 0,50000000.0);

				if (this.count == this.flag5.wait - 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count > this.flag5.wait)
				{
					this.Change_Master_Hijiri(null);
					return;
				}
			};
		},
		function ()
		{
			this.SetShot(640 - 800 * this.direction, this.y, this.direction, this.Boss_Shot_SL1, {});
		}
	];
}

function Change_Master_Hijiri( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_1_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_Hijiri_2()
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

function Slave_Attack_Hijiri2( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4930, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(t.x * 0,25000000.0, t.y * 0,25000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
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
	this.flag5.charge <- 120;
	this.flag5.wait <- 150;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.charge = 90;
		this.flag5.wait = 180;
		break;

	case 2:
		this.flag5.charge = 90;
		this.flag5.wait = 180;
		break;

	case 3:
	case 4:
		this.flag5.charge = 90;
		this.flag5.wait = 150;
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0, 1,00000000.0);
	};
	this.keyAction = [
		null,
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.PlaySE(1480);
			this.centerStop = -2;
			this.AjustCenterStop();
			this.SetShot(640 - 800 * this.direction, this.y, 1,00000000.0, this.Boss_Shot_SL2, {});
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0,50000000.0, 1,00000000.0))
				{
					this.AjustCenterStop();
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,10000000.0, 1,00000000.0);

						if (this.centerStop == 0)
						{
							this.VX_Brake(0,10000000.0);
						}

						if (this.count > 210)
						{
							this.Change_Master_Hijiri2(null);
							return;
						}
					};
				}
			};
		}
	];
}

function Change_Master_Hijiri2( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.MS2_First(null);
	this.Set_BossSpellBariaRate(1);
}

