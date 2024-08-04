function Master_Spell_1()
{
	this.team.slave.Slave_Tenshi_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
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
	this.GetFront();
	this.SetMotion(4990, 0);
	this.flag5 = {};
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 400 * this.direction;
	this.flag5.pos.y = 240;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);
	this.flag3 = this.flag5.pos.x > 0 ? 1,00000000.0 : -1,00000000.0;
	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 10,00000000.0)
		{
			this.flag5.moveV = 10,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0,25000000.0))
				{
					this.Master_Spell_1_Attack();
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.flag3);
		}
	};
}

function Master_Spell_1_Attack()
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.com_flag2++;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCycle <- 30;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 20;
		break;

	case 2:
		this.flag5.shotCycle = 15;
		break;

	case 3:
		this.flag5.shotCycle = 10;
		break;

	case 4:
		this.flag5.shotCycle = 10;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[1] = function ()
	{
		this.flag5.shotCount++;

		if (this.flag5.shotCount == this.flag5.chargeCount)
		{
			this.SetMotion(4910, 2);
		}
	};
	this.keyAction = [
		null,
		null,
		function ()
		{
			if (this.flag5.charge)
			{
				this.flag5.charge.func();
			}

			this.flag5.charge = null;
			this.flag5.shotCount = 0;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;
				::camera.Shake(2,00000000.0);

				if (this.flag5.shotCount % 60 == 1)
				{
					this.PlaySE(4236);
				}

				if (this.flag5.shotCount % this.flag5.shotCycle == 1)
				{
					this.SetShot(640 + (-1280 + this.rand() % 1920) * this.direction, ::battle.scroll_bottom + 128, this.direction, this.Shot_1_Kaname, {});
				}

				if (this.flag5.shotCount == 210)
				{
					this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.flag5.shotCount >= 300)
				{
					this.S1_Change_Slave(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_1_Move()
{
	this.LabelClear();
	this.direction = this.x > 640 ? -1,00000000.0 : 1,00000000.0;
	this.SetMotion(4991, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 + (260 + this.rand() % 180) * this.direction;
	this.flag5.pos.y = 240 + this.rand() % 240;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);
	this.flag3 = this.flag5.pos.x > 0 ? 1,00000000.0 : -1,00000000.0;

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 15,00000000.0)
		{
			this.flag5.moveV = 15,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0,75000000.0))
				{
					this.GetFront();
					this.flag5.moveCount = 0;
					this.stateLabel = function ()
					{
						this.flag5.moveCount++;

						if (this.flag5.moveCount == 30)
						{
							this.Master_Spell_1_Attack();
						}
					};
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.flag3 * this.direction);
		}
	};
}

function S1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Tenshi(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2()
{
	this.team.slave.Slave_Tenshi_2();
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
	this.GetFront();
	this.HitReset();
	this.flag5 = {};
	this.flag5.shotCycle <- 60;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.shotNum <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- null;
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};
	this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 45;
		break;

	case 2:
		this.flag5.shotCycle = 30;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 15;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[0] = function ()
	{
		this.Vec_Brake(0,75000000.0);
	};
	this.subState[1] = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount >= this.flag5.chargeCount)
				{
					if (this.flag5.charge)
					{
						this.flag5.charge.func();
					}

					this.flag5.charge = null;
					this.flag5.shotCount = 0;
					this.subState[1] = function ()
					{
						this.flag5.shotCount++;

						if (this.flag5.shotCount % this.flag5.shotCycle == 1)
						{
							this.PlaySE(4231);
							this.SetShot(this.target.x, ::battle.scroll_top - 64, this.direction, this.Shot_2_Kaname, {});
						}

						if (this.flag5.shotCount == 240)
						{
							this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.flag5.shotCount >= 330)
						{
							this.S2_Change_Slave(null);
							this.flag5.shotCount = 0;
							return;
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_2_Move()
{
	this.LabelClear();
	this.direction = this.x > 640 ? -1,00000000.0 : 1,00000000.0;
	this.SetMotion(4991, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 + (120 + this.rand() % 120) * this.direction;
	this.flag5.pos.y = 320 + this.rand() % 80;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stone.func[2].call(this.stone);
	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 10,00000000.0)
		{
			this.flag5.moveV = 10,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0,75000000.0))
				{
					this.GetFront();
					this.flag5.moveCount = 0;
					this.stateLabel = function ()
					{
						this.flag5.moveCount++;

						if (this.flag5.moveCount == 30)
						{
							this.Master_Spell_2_Attack();
						}
					};
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.direction);
		}
	};
}

function S2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack2_Tenshi(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_3_OD()
{
	this.team.slave.Slave_Tenshi_3();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	::battle.enable_demo_talk = true;
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

					this.Master_Spell_3_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_3_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4990, 0);
	this.stone.func[2].call(this.stone);
	this.com_flag1 = 0;
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 240 * this.direction;
	this.flag5.pos.y = this.centerY - 160;
	this.centerStop = -2;
	this.flag3 = this.flag5.pos.x > 0 ? 1,00000000.0 : -1,00000000.0;

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 15,00000000.0)
		{
			this.flag5.moveV = 15,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Master_Spell_3_Attack();
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.va.x);
		}
	};
}

function Master_Spell_3_Attack()
{
	this.LabelClear();
	this.SetMotion(4940, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 30;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag5.sword <- null;
	this.flag5.g <- 0,00000000.0;

	switch(this.com_flag2)
	{
	case 0:
		this.flag5.g = 0,02500000.0;
		break;

	case 1:
		this.flag5.g = 0,07500000.0;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;

		if (this.flag5.sword)
		{
			this.flag5.sword.func[0].call(this.flag5.sword);
		}

		this.flag5.sword = null;
	};

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 20;
		break;

	case 2:
		this.flag5.shotCycle = 15;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 10;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[0] = function ()
	{
		this.Vec_Brake(0,50000000.0, 0,50000000.0);
	};
	this.subState[1] = function ()
	{
		this.flag5.shotCount++;

		if (this.flag5.shotCount == this.flag5.chargeCount)
		{
			if (this.y < this.centerY)
			{
				this.flag5.sword = this.SetShot(this.x, this.y, this.direction, this.Shot_S3_Sword, {}).weakref();
			}
			else
			{
				this.flag5.sword = this.SetShot(this.x, this.y, this.direction, this.Shot_S3_Sword_R, {}).weakref();
			}

			this.SetMotion(this.motion, 1);
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			if (this.flag5.charge)
			{
				this.flag5.charge.func();
			}

			this.flag5.charge = null;
			this.flag5.shotCount = 0;
			this.SetSpeed_Vec(-2,00000000.0, 1,04719746.0, this.direction);
			this.centerStop = -2;
			this.subState[0] = function ()
			{
				this.CenterUpdate(this.flag5.g, 0,75000000.0);
			};
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;
				::camera.Shake(2,00000000.0);

				if (this.com_flag1 == 2 && this.flag5.shotCount == 60)
				{
					this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.flag5.shotCount >= 150)
				{
					this.com_flag1++;

					if (this.com_flag1 <= 2)
					{
						this.subState[0] = function ()
						{
							this.CenterUpdate(0,10000000.0, 6,00000000.0);
						};
						this.subState[1] = function ()
						{
						};

						if (this.flag5.sword)
						{
							this.flag5.sword.func[0].call(this.flag5.sword);
						}

						this.flag5.sword = null;
						this.SetMotion(this.motion, 3);
						return;
					}
					else
					{
						if (this.flag5.sword)
						{
							this.flag5.sword.func[1].call(this.flag5.sword);
						}

						this.flag5.sword = null;
						this.com_flag1 = 0;
						this.S3_Change_Slave(null);
						return;
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Spell_3_Move();
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_3_Move()
{
	this.LabelClear();
	this.stone.func[2].call(this.stone);
	this.SetMotion(4991, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.direction = this.x > 640 ? 1,00000000.0 : -1,00000000.0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 240 * this.direction;
	local r_ = this.rand() % 3;

	switch(r_)
	{
	case 0:
		this.com_flag2 = 0;
		this.flag5.pos.y = this.centerY - 160;
		break;

	case 1:
		this.com_flag2 = 1;
		this.flag5.pos.y = this.centerY - 300;
		break;

	case 2:
		this.com_flag2 = 1;
		this.flag5.pos.y = this.centerY + 160;
		break;
	}

	this.flag3 = this.flag5.pos.x > 0 ? 1,00000000.0 : -1,00000000.0;

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 20,00000000.0)
		{
			this.flag5.moveV = 20,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Master_Spell_3_Attack();
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.va.x);
		}
	};
}

function S3_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack3_Tenshi(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_1_Dream()
{
	this.team.slave.Slave_Dream_1();
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

					this.Master_Spell_1_Dream_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_1_Dream_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4990, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 30;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 400 * this.direction;
	this.flag5.pos.y = 240;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);
	this.flag3 = this.flag5.pos.x * this.direction > 0 ? 1,00000000.0 : -1,00000000.0;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 20;
		break;

	case 2:
		this.flag5.shotCycle = 12;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 5;
		break;
	}

	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 10,00000000.0)
		{
			this.flag5.moveV = 10,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0,25000000.0))
				{
					this.Master_Spell_1_Dream_Attack();
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.flag3);
		}
	};
}

function Master_Spell_1_Dream_Attack()
{
	this.LabelClear();
	this.SetMotion(4960, 0);
	this.com_flag2++;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCycle <- 30;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 20;
		break;

	case 2:
		this.flag5.shotCycle = 15;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 10;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[1] = function ()
	{
		this.flag5.shotCount++;

		if (this.flag5.shotCount == this.flag5.chargeCount)
		{
			this.SetMotion(4960, 2);
		}
	};
	this.keyAction = [
		null,
		null,
		function ()
		{
			if (this.flag5.charge)
			{
				this.flag5.charge.func();
			}

			this.flag5.charge = null;
			this.flag5.shotCount = 0;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;
				::camera.Shake(2,00000000.0);

				if (this.flag5.shotCount % 40 == 1)
				{
					this.PlaySE(4225);
				}

				if (this.flag5.shotCount % this.flag5.shotCycle == 1)
				{
					this.SetShot(640 + (-1280 + this.rand() % 1920) * this.direction, ::battle.scroll_bottom + 128, this.direction, this.Shot_Dream1_Kaname, {});
					this.SetShot(640 + (-1280 + this.rand() % 1920) * this.direction, ::battle.scroll_bottom + 128, this.direction, this.Shot_Dream1_Kaname_Back, {});
				}

				if (this.flag5.shotCount >= 300)
				{
					this.flag5.shotCount = 0;
					this.subState[1] = function ()
					{
						this.flag5.shotCount++;

						if (this.flag5.shotCount >= 120)
						{
							this.SetMotion(4960, 5);
							this.subState[1] = function ()
							{
							};

							if (this.com_flag2 >= 1)
							{
								this.com_flag2 = 0;
								this.D1_Change_Slave(null);
								return;
							}
						}
					};
				}
			};
		},
		null,
		null,
		this.Master_Spell_1_Dream_Move
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_1_Dream_Move()
{
	this.LabelClear();
	this.direction = this.x > 640 ? -1,00000000.0 : 1,00000000.0;
	this.SetMotion(4991, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 + (260 + this.rand() % 180) * this.direction;
	this.flag5.pos.y = 240 + this.rand() % 240;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);
	this.flag3 = this.flag5.pos.x * this.direction > 0 ? 1,00000000.0 : -1,00000000.0;

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 15,00000000.0)
		{
			this.flag5.moveV = 15,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0,75000000.0))
				{
					this.GetFront();
					this.flag5.moveCount = 0;
					this.stateLabel = function ()
					{
						this.flag5.moveCount++;

						if (this.flag5.moveCount == 30)
						{
							this.Master_Spell_1_Dream_Attack();
						}
					};
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.flag3);
		}
	};
}

function D1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.Master_Spell_1_Dream_Move();
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2_Dream()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.team.slave.Slave_Dream_1();
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

					this.Master_Spell_2_Dream_Attack();
				}
			};
		}
	};
	return true;
}

function Master_Spell_2_Dream_Attack()
{
	this.LabelClear();
	this.SetMotion(4962, 0);
	this.GetFront();
	this.HitReset();
	this.flag5 = {};
	this.flag5.shotCycle <- 240;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.shotNum <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- null;
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 150;
		break;

	case 2:
		this.flag5.shotCycle = 120;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 90;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.subState[0] = function ()
	{
		this.Vec_Brake(0,75000000.0);
	};
	this.subState[1] = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.flag5.shotCount = 0;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount >= this.flag5.chargeCount)
				{
					this.SetMotion(4962, 2);
					this.subState[1] = function ()
					{
						::camera.Shake(2,00000000.0);
					};
				}
			};
		},
		null,
		function ()
		{
			this.flag5.shotCount = 0;
			this.SetSpeed_XY(0,00000000.0, -0,25000000.0);
			this.subState[1] = function ()
			{
				this.HitCycleUpdate(30);
				this.flag5.shotCount++;
				::camera.Shake(2,00000000.0);

				if (this.flag5.shotCount % 40 == 1)
				{
					this.PlaySE(4231);
				}

				if (this.flag5.shotCount % this.flag5.shotCycle == 1)
				{
					this.flag5.shotNum++;
					local t_ = {};
					t_.namazu <- false;

					if (this.team.life <= this.team.life_max * 0,50000000.0 && this.flag5.shotNum == 1)
					{
						t_.namazu = true;
					}

					this.SetShot(this.target.x, ::battle.scroll_top - 256, this.direction, this.Shot_Dream2_Kaname, t_);
				}

				if (this.flag5.shotCount >= 420)
				{
					this.D2_Change_Slave(null);
					this.flag5.shotCount = 0;
					return;
					this.flag5.shotCount = 0;
					this.subState[1] = function ()
					{
						if (this.flag5.charge)
						{
							this.flag5.charge.func();
						}

						this.flag5.charge = null;
						this.SetMotion(4962, 4);
						this.subState[1] = function ()
						{
						};
					};
				}
			};
		},
		null,
		function ()
		{
			this.flag5.moveCount = 0;
			this.stateLabel = function ()
			{
				this.flag5.moveCount++;

				if (this.flag5.moveCount == 90)
				{
					this.Master_Spell_2_Dream_Move();
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function Master_Spell_2_Dream_Move()
{
	this.LabelClear();
	this.direction = this.x > 640 ? -1,00000000.0 : 1,00000000.0;
	this.SetMotion(4991, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 + (120 + this.rand() % 120) * this.direction;
	this.flag5.pos.y = 320 + this.rand() % 80;
	this.SetSpeed_Vec(0,25000000.0, -160 * 0,01745329.0, this.direction);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		this.flag5.moveV += 0,25000000.0;

		if (this.flag5.moveV > 10,00000000.0)
		{
			this.flag5.moveV = 10,00000000.0;
		}

		this.va.x = this.flag5.pos.x - this.x;
		this.va.y = this.flag5.pos.y - this.y;

		if (this.va.Length() <= 100)
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.stateLabel = function ()
			{
				this.Boss_WalkMotionUpdate(0);

				if (this.Vec_Brake(0,75000000.0))
				{
					this.GetFront();
					this.flag5.moveCount = 0;
					this.stateLabel = function ()
					{
						this.flag5.moveCount++;

						if (this.flag5.moveCount == 30)
						{
							this.Master_Spell_2_Dream_Attack();
						}
					};
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.direction);
		}
	};
}

function D2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.Master_Spell_2_Dream_Move();
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_3_Dream()
{
	this.team.slave.Slave_Dream_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.team.life_limit = 2500;
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

					this.Master_Spell_3_Dream_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_3_Dream_OD()
{
	this.team.slave.Slave_Dream_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.team.life_limit = 2500;
	this.koExp = true;
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

					this.Master_Spell_3_Dream_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_3_Dream_Start()
{
	if (this.team.life <= 2500)
	{
		this.Master_Spell_4_Dream_Start();
		return true;
	}

	this.LabelClear();
	this.GetFront();
	this.SetMotion(4963, 0);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag5 = {};
	this.flag5.shotCycle <- 120;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.shotNum <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- null;
	this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag5.namazu <- null;
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};
	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			if (this.flag5.charge)
			{
				this.flag5.charge.func();
			}

			this.flag5.charge = null;
			this.SetSpeed_XY(17,50000000.0 * this.direction, -12,50000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0, 1,00000000.0 * this.direction);
				this.AddSpeed_XY(0,00000000.0, 0,25000000.0, null, 2,00000000.0);

				if (this.count == 25)
				{
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
						this.AddSpeed_XY(0,00000000.0, 1,50000000.0, 0,00000000.0, 30,00000000.0);

						if (this.ground)
						{
							this.count = 0;
							this.PlaySE(4253);
							this.SetMotion(4963, 3);
							::camera.Shake(6,00000000.0);
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							this.stateLabel = function ()
							{
							};
						}
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			if (this.stone)
			{
				this.stone.func[4].call(this.stone);
			}

			this.flag5.namazu = this.SetShot(this.x, this.y + 64, this.direction, this.Shot_Dream3_CrainNamazu, {}).weakref();
			::camera.Shake(12,00000000.0);
			this.SetSpeed_XY(0,00000000.0, -22,50000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0, 0,00000000.0, -10,00000000.0);

				if (this.y < this.centerY - 200)
				{
					if (this.flag5.namazu)
					{
						this.flag5.namazu.SetMotion(5001, 1);
					}

					this.flag5.moveCount = 0;
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,75000000.0);
						this.flag5.moveCount++;

						if (this.flag5.moveCount >= 45)
						{
							this.GetFront();
							this.SetMotion(this.motion, 6);
							this.SetSpeed_XY(-2,00000000.0 * this.direction, -10,00000000.0);

							if (this.flag5.namazu)
							{
								this.flag5.namazu.direction = this.direction;

								if (this.rand() % 100 <= 49)
								{
									this.flag5.namazu.func[2].call(this.flag5.namazu);
								}
								else
								{
									this.flag5.namazu.func[1].call(this.flag5.namazu);
								}
							}

							this.stateLabel = function ()
							{
								this.VX_Brake(0,25000000.0, -1,00000000.0 * this.direction);
								this.AddSpeed_XY(0,00000000.0, 0,50000000.0, null, 4,50000000.0);

								if (this.va.y > 0 && this.y >= this.centerY)
								{
									this.SetMotion(this.motion, 8);
									this.SetSpeed_XY(this.va.x, 3,00000000.0);
									this.stateLabel = function ()
									{
										this.VX_Brake(0,50000000.0);

										if (this.y < this.centerY && this.va.y < 0)
										{
											this.SetSpeed_XY(this.va.x, 0,00000000.0);
											this.y = this.centerY;
											this.stateLabel = function ()
											{
												this.VX_Brake(0,50000000.0);
											};
										}
									};
								}
							};
						}
					};
				}
			};
		},
		null,
		null,
		null,
		null,
		function ()
		{
			this.D3_Change_Slave(null);
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Master_Spell_3_Dream_Attack()
{
}

function D3_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.Master_Spell_3_Dream_Start();
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_4_Dream_Start()
{
	this.LabelClear();
	this.GetFront();

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	::battle.gauge.SetFace("slave1", "slave1", 8011, 2);
	this.team.slave_ban = -1;
	this.team.slave.Slave_Smash_Dream(null);
	this.team.regain_life = 0;
	this.SetMotion(4964, 0);
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag5 = {};
	this.flag5.shotCycle <- 120;
	this.flag5.bigCycle <- 300;
	this.flag5.scaleAdd <- 0,10000000.0;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.shotNum <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- null;
	this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag5.namazu <- null;
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;

		if (this.flag5.namazu)
		{
			this.flag5.namazu.func[0].call(this.flag5.namazu);
		}
	};

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.bigCycle = 270;
		this.flag5.scaleAdd = 0,15000001.0;
		break;

	case 2:
		this.flag5.bigCycle = 240;
		this.flag5.scaleAdd = 0,20000000.0;
		break;

	case 3:
	case 4:
		this.flag5.bigCycle = 240;
		this.flag5.scaleAdd = 0,25000000.0;
		break;
	}

	this.stone.func[2].call(this.stone);
	this.func = [
		function ()
		{
		},
		function ()
		{
			this.flag5.shotCount = 0;
			this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellChargeBig, {}, this.weakref()).weakref();
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount >= this.flag5.chargeCount)
				{
					if (this.flag5.charge)
					{
						this.flag5.charge.func();
					}

					this.flag5.charge = null;
					this.flag5.shotCount = 0;
					this.flag5.namazu.func[2].call(this.flag5.namazu, this.flag5.scaleAdd);
					this.subState[1] = function ()
					{
						this.flag5.shotCount++;

						if (this.flag5.shotCount >= this.flag5.bigCycle)
						{
							this.func[1].call(this);
							return;
						}
					};
				}
			};
		}
	];
	this.subState = [
		function ()
		{
		},
		function ()
		{
		},
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 120)
				{
					this.SetMotion(4964, 2);
					this.centerStop = -2;
					this.SetSpeed_XY(0,00000000.0, -25,00000000.0);
					this.stone.func[0].call(this.stone);
					this.count = 0;

					if (this.flag5.charge)
					{
						this.flag5.charge.func();
					}

					this.flag5.charge = null;
					this.stateLabel = function ()
					{
						if (this.count >= 60)
						{
							this.SetMotion(4964, 4);
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							this.stateLabel = function ()
							{
								if (this.count == 120)
								{
									this.Warp(640, -800);
									this.SetMotion(4964, 5);
									this.SetSpeed_XY(0,00000000.0, 40,00000000.0);
									this.PlaySE(4251);
									this.stateLabel = function ()
									{
										if (this.ground)
										{
											this.count = 0;
											this.PlaySE(4253);
											this.SetMotion(4964, 6);
											::camera.Shake(6,00000000.0);
											this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
											this.stateLabel = function ()
											{
											};
										}
									};
								}
							};
						}
					};
				}
			};
		},
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			if (this.stone)
			{
				this.stone.func[4].call(this.stone);
			}

			this.flag5.namazu = this.SetShot(this.x, this.y + 64, this.direction, this.Shot_Dream3_RideNamazu, {}).weakref();
			::camera.Shake(12,00000000.0);
			this.func[1].call(this);
			this.team.life_limit = 0;
			this.stateLabel = function ()
			{
				this.subState[0].call(this);
				this.subState[1].call(this);
				this.Warp(this.flag5.namazu.x, this.flag5.namazu.y - 60);
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Master_Spell_4_Dream_Move()
{
	this.flag5.moveCount++;
	local pos_ = this.Vector3();
	pos_.x = 640;
	pos_.y = 240 + 180 * this.sin(this.flag5.moveCount * 0,01745329.0 * 0,50000000.0);
	this.va.x = (pos_.x - this.x) * 0,10000000.0;
	this.va.y = (pos_.y - this.y) * 0,10000000.0;
	this.flag5.moveV += 0,20000000.0;

	if (this.flag5.moveV > 5,00000000.0)
	{
		this.flag5.moveV = 5,00000000.0;
	}

	if (this.va.Length() > this.flag5.moveV)
	{
		this.va.SetLength(this.flag5.moveV);
	}

	this.ConvertTotalSpeed();
}

function Master_Spell_5_Dream_OD()
{
	this.team.slave.Slave_Dream_1();
	this.team.ResetCombo();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.team.life_limit = 2500;
	this.target.team.master.wait_input = true;
	::battle.enable_demo_talk = true;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.boss_cpu = function ()
	{
		this.Master_Spell_5_Dream_Start();
		this.boss_cpu = function ()
		{
			if (this.Cancel_Check(10))
			{
				if (this.team.shield == null)
				{
					this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
				}

				this.Master_Spell_5_Dream_Attack();
			}
		};
	};
	return true;
}

function Master_Spell_5_Dream_Start()
{
	this.LabelClear();
	this.stone.func[4].call(this.stone);
	this.direction = -1,00000000.0;
	this.SetMotion(4970, 0);
	this.flag5 = {};
	this.flag5.v <- 0,00000000.0;
	this.flag5.back <- null;
	this.flag5.height <- 200;
	this.isVisible = true;
	this.enableKO = false;
	::battle.state = 4;
	this.freeMap = true;
	this.count = 0;
	this.SetFreeObject(640, 800, 1,00000000.0, this.Shot_Dream5_BackBebri, {});
	this.stateLabel = function ()
	{
		this.flag5.v += 0,75000000.0;
		this.SetSpeed_XY((640 - this.x) * 0,10000000.0, (960 - this.y) * 0,10000000.0);

		if (this.va.Length() > this.flag5.v)
		{
			this.va.SetLength(this.flag5.v);
			this.ConvertTotalSpeed();
		}

		if (this.count == 60)
		{
			this.BossForceCall2_Init();
		}

		if (this.count == 75)
		{
			::camera.lock = false;
			::camera.auto_zoom_limit = 1,50000000.0;
			::camera.lock = true;
			this.Warp(860, this.y);
			this.invin = 0;
			this.invinObject = 0;
			this.DrawActorPriority(300);
			this.SetMotion(4970, 1);
			this.sx = this.sy = 2,50000000.0;
			this.SetSpeed_XY(0,00000000.0, -5,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 45)
				{
					this.target.team.master.VS_NamazuMode(null);
					this.target.team.master.VS_NamazuMove_Pre(null);
				}

				if (this.y < 560)
				{
					this.AddSpeed_XY(0,00000000.0, -0,50000000.0, 0,00000000.0, -25,00000000.0);
					::camera.Shake(10,00000000.0);
				}
				else
				{
					::camera.Shake(2,00000000.0);
				}

				if (this.y < ::battle.scroll_top - 480)
				{
					this.SetMotion(4970, 0);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count == 60)
						{
							this.target.team.master.func();

							if (::battle.state == 4)
							{
								::battle.state = 8;
							}

							this.sx = this.sy = 1,00000000.0;
							this.DrawActorPriority(189);
							this.SetMotion(4970, 2);
							this.namazu = this.SetShot(this.x, this.y + 64, this.direction, this.Shot_Dream5_RideNamazu, {}).weakref();
							this.stateLabel = function ()
							{
								this.flag5.height = 200 + 50 * this.sin(this.count * 0,03490658.0);
								this.SetSpeed_XY(0,00000000.0, (this.flag5.height - this.y) * 0,05000000.0);

								if (this.fabs(this.va.y) <= 0,10000000.0)
								{
									this.count = 0;
									this.stateLabel = function ()
									{
										this.flag5.height = 200 + 50 * this.sin(this.count * 0,03490658.0);
										this.SetSpeed_XY(0,00000000.0, (this.flag5.height - this.y) * 0,05000000.0);

										if (this.count == 15)
										{
											this.namazu.func[1].call(this.namazu);
											this.Master_Spell_5_Dream_Attack();
										}
									};
								}
							};
						}
					};
				}
			};
		}
	};
}

function Master_Spell_5_Dream_Attack()
{
	if (this.team.life <= 2500)
	{
		this.Master_Spell_6_Dream_OD();
		return;
	}

	this.com_flag2++;

	switch(this.com_flag2)
	{
	case 1:
	case 2:
		this.Master_Spell_5_Dream_BeamRush();
		break;

	case 3:
		this.Master_Spell_5_Dream_SwordRay();
		break;

	case 4:
		this.Master_Spell_5_Dream_SwordRing();
		break;
	}

	if (this.com_flag2 >= 4)
	{
		this.com_flag2 = 0;
	}
}

function Master_Spell_5_Dream_BeamRush()
{
	this.LabelClear();
	this.flag5 = {};
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;
	this.SetMotion(4971, 4);
	this.func = [
		function ()
		{
			if (this.keyTake == 2)
			{
				this.SetMotion(this.motion, 3);
			}

			this.flag5.v = 0,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			local y_ = this.centerY;
			this.flag5.pos.y += y_;
			this.flag5.pos.x = 1180;
			this.subState = function ()
			{
				this.flag5.v += 0,34999999.0;

				if (this.flag5.v > 17,50000000.0)
				{
					this.flag5.v = 17,50000000.0;
				}

				this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,15000001.0, (this.flag5.pos.y - this.y) * 0,15000001.0);

				if (this.va.Length() > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}
			};
		},
		function ()
		{
			if (this.keyTake == 2)
			{
				this.SetMotion(this.motion, 3);
			}

			this.flag5.v = 0,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			local y_ = this.target.y - this.y;

			if (this.fabs(y_) >= 300)
			{
				y_ = y_ < 0 ? -300,00000000.0 : 300,00000000.0;
			}

			this.flag5.pos.y += y_;
			this.flag5.pos.x = 960 + this.rand() % 300;
			this.subState = function ()
			{
				this.flag5.v += 0,34999999.0;

				if (this.flag5.v > 17,50000000.0)
				{
					this.flag5.v = 17,50000000.0;
				}

				this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,15000001.0, (this.flag5.pos.y - this.y) * 0,15000001.0);

				if (this.va.Length() > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 0);
			this.keyAction = function ()
			{
				this.keyAction = null;
				this.PlaySE(4246);

				for( local i = 0; i < 12; i++ )
				{
					local t_ = {};
					t_.rot <- 0,52359873.0 * i;
					t_.v <- 1,50000000.0;
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Dream5_Barrage, t_);
				}

				this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.Shot_Dream5_Fire, {});
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.keyAction = function ()
			{
				this.keyAction = null;
				this.Master_Spell_5_Dream_Attack();
			};
		}
	];
	this.count = 45;
	this.func[0].call(this);
	this.stateLabel = function ()
	{
		this.subState();

		if (this.count == 90)
		{
			this.func[2].call(this);
		}

		if (this.count == 120)
		{
			this.func[1].call(this);
		}

		if (this.count == 150)
		{
			this.func[2].call(this);
		}

		if (this.count == 180)
		{
			this.func[1].call(this);
		}

		if (this.count == 210)
		{
			this.func[2].call(this);
		}

		if (this.count == 320)
		{
			this.func[3].call(this);
		}
	};
}

function Master_Spell_5_Dream_SwordRay()
{
	this.LabelClear();
	this.keyAction = null;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;
	this.flag5.sword <- null;
	this.flag5.shotRot <- -1,57079601.0;
	this.flag5.shotCount <- 0;
	this.flag5.rotSpeed <- 0,00000000.0;
	this.SetMotion(4972, 0);
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.func = [
		function ()
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.flag5.v = 0,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag5.pos.y = 200;
			this.flag5.pos.x = 1000;
			this.subState = function ()
			{
				this.flag5.v += 0,34999999.0;

				if (this.flag5.v > 17,50000000.0)
				{
					this.flag5.v = 17,50000000.0;
				}

				this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,15000001.0, (this.flag5.pos.y - this.y) * 0,15000001.0);
				local r_ = this.va.Length();

				if (r_ > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}
			};
		},
		function ()
		{
			this.centerStop = -2;

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.subState = function ()
			{
				this.CenterUpdate(0,01500000.0, null);
				this.flag5.shotCount++;

				if (this.flag5.shotCount % 6 == 1)
				{
					this.PlaySE(870);
				}

				if (this.flag5.shotCount % 2 == 1)
				{
					local t_ = {};
					t_.rot <- this.flag5.shotRot + (20 - this.rand() % 41) * 0,01745329.0;
					this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Dream5_BarrageB, t_);
				}

				if (this.flag5.shotCount == 60)
				{
					this.subState = function ()
					{
						this.flag5.rotSpeed += 0,05000000.0 * 0,01745329.0;

						if (this.flag5.rotSpeed > 0,06981317.0)
						{
							this.flag5.rotSpeed = 0,06981317.0;
						}

						this.flag5.shotRot += this.flag5.rotSpeed;
						this.flag5.shotCount++;

						if (this.flag5.shotCount % 6 == 1)
						{
							this.PlaySE(870);
						}

						if (this.flag5.shotCount % 2 == 1)
						{
							local t_ = {};
							t_.rot <- this.flag5.shotRot;
							this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Dream5_BarrageB, t_);
						}
					};
				}
			};
		},
		function ()
		{
			this.flag5.shotCount = 0;
			this.subState = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount == 60)
				{
					this.SetMotion(4972, 3);
				}
			};
			this.keyAction = function ()
			{
				this.keyAction = null;
				this.Master_Spell_5_Dream_Attack();
			};
		}
	];
	this.count = 0;
	this.func[0].call(this);
	this.stateLabel = function ()
	{
		this.subState();

		if (this.count == 90)
		{
			this.func[1].call(this);
		}

		if (this.count == 480)
		{
			this.func[2].call(this);
		}
	};
}

function Master_Spell_5_Dream_SwordRing()
{
	this.LabelClear();
	this.keyAction = null;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag5 = {};
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;
	this.flag5.sword <- null;
	this.flag5.shotRot <- -1,57079601.0;
	this.flag5.shotCount <- 0;
	this.flag5.rotSpeed <- 0,00000000.0;
	this.SetMotion(4973, 0);
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.func = [
		function ()
		{
			this.flag5.v = 0,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag5.pos.y = 150;
			this.flag5.pos.x = 640 - 440 * this.direction;
			this.subState = function ()
			{
				this.flag5.v += 0,50000000.0;

				if (this.flag5.v > 20,00000000.0)
				{
					this.flag5.v = 20,00000000.0;
				}

				this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,15000001.0, (this.flag5.pos.y - this.y) * 0,15000001.0);
				local r_ = this.va.Length();

				if (r_ > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}
			};
		},
		function ()
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(4973, 2);
			this.keyAction = function ()
			{
				this.keyAction = null;
				local t_ = {};
				t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				t_.rot = this.Math_MinMax(t_.rot, 0, 1,57079601.0);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Dream5_Ring, t_);
				this.PlaySE(4266);
				this.SetSpeed_XY(-5,00000000.0 * this.direction, -3,50000000.0);
			};
			this.subState = function ()
			{
				this.Vec_Brake(0,50000000.0, 1,00000000.0);
			};
		},
		function ()
		{
			this.SetMotion(4973, 4);
			this.keyAction = function ()
			{
				this.SetMotion(4973, 0);
				this.keyAction = null;
			};
			this.flag5.v = 0,00000000.0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.flag5.pos.y = 540;
			this.flag5.pos.x = 640 - 540 * this.direction;
			this.subState = function ()
			{
				this.flag5.v += 0,50000000.0;

				if (this.flag5.v > 20,00000000.0)
				{
					this.flag5.v = 20,00000000.0;
				}

				this.SetSpeed_XY((this.flag5.pos.x - this.x) * 0,15000001.0, (this.flag5.pos.y - this.y) * 0,15000001.0);
				local r_ = this.va.Length();

				if (r_ > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}
			};
		},
		function ()
		{
			this.SetMotion(4973, 2);
			this.keyAction = function ()
			{
				this.keyAction = null;
				local t_ = {};
				t_.rot <- this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				t_.rot = this.Math_MinMax(t_.rot, -1,57079601.0, 0);
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Dream5_Ring, t_);
				this.PlaySE(4266);
				this.SetSpeed_XY(-5,00000000.0 * this.direction, 3,50000000.0);
			};
			this.subState = function ()
			{
				this.Vec_Brake(0,50000000.0, 1,00000000.0);
			};
		},
		function ()
		{
			this.SetMotion(4973, 4);
			this.centerStop = -2;
			this.AjustCenterStop();
			this.subState = function ()
			{
				this.CenterUpdate(0,05000000.0, null);
			};
			this.keyAction = function ()
			{
				this.keyAction = null;
				this.Master_Spell_5_Dream_Attack();
			};
		}
	];
	this.count = 0;
	this.func[0].call(this);
	this.stateLabel = function ()
	{
		this.subState();

		if (this.count == 120)
		{
			this.func[1].call(this);
		}

		if (this.count == 140)
		{
			this.func[2].call(this);
		}

		if (this.count == 180)
		{
			this.func[3].call(this);
		}

		if (this.count == 300)
		{
			this.func[4].call(this);
		}
	};
}

function Master_Spell_6_Dream_OD()
{
	::battle.enable_demo_talk = false;
	::battle.Clear_BattleMessage();
	::battle.Boss_Spell_Lost();
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
		this.Master_Spell_6_Dream_Start();
		this.boss_cpu = function ()
		{
			if (this.Cancel_Check(10))
			{
				if (this.team.shield == null)
				{
					this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
				}

				this.Master_Spell_6_Dream_Attack();
			}
		};
	};
	return true;
}

function Master_Spell_6_Dream_Start()
{
	this.LabelClear();
	this.direction = -1,00000000.0;
	this.SetMotion(4975, 3);
	this.flag5 = {};
	this.flag5.v <- 0,00000000.0;
	this.flag5.back <- null;
	this.flag5.pos <- this.Vector3;
	this.flag5.moveCount <- 0;
	this.freeMap = true;
	this.count = 0;
	this.team.master.koExp = true;

	if (this.team.slave)
	{
		this.team.slave.koExp = true;
	}

	if (this.team.slave_sub)
	{
		this.team.slave_sub.koExp = true;
	}

	this.team.master.ko_slave = false;

	if (this.team.slave)
	{
		this.team.slave.ko_slave = false;
	}

	if (this.team.slave_sub)
	{
		this.team.slave_sub.ko_slave = false;
	}

	this.func = [
		function ()
		{
			this.flag5.moveCount = 0;
			this.shot_actor.Foreach(function ()
			{
				this.func[0].call(this);
			});
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.flag5.v += 0,50000000.0;

				if (this.flag5.v > 10,00000000.0)
				{
					this.flag5.v = 10,00000000.0;
				}

				this.SetSpeed_XY((640 - this.x) * 0,10000000.0, (300 - this.y) * 0,10000000.0);

				if (this.va.Length() > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 0);
			this.flag5.moveCount = 0;
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.flag5.v += 0,50000000.0;

				if (this.flag5.v > 10,00000000.0)
				{
					this.flag5.v = 10,00000000.0;
				}

				this.SetSpeed_XY((640 - this.x) * 0,10000000.0, (300 - this.y) * 0,10000000.0);

				if (this.va.Length() > this.flag5.v)
				{
					this.va.SetLength(this.flag5.v);
				}

				if (this.flag5.moveCount == 30)
				{
					this.BossForceCall2_Init();
				}
			};
		},
		function ()
		{
			this.flag5.moveCount = 0;
			this.target.team.master.VS_NamazuMove_Pre(null);
			this.stateLabel = function ()
			{
				this.subState();
			};
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.AddSpeed_XY(0,00000000.0, -0,25000000.0, 0,00000000.0, -1,50000000.0);

				if (this.flag5.moveCount == 40)
				{
					this.namazu.func[3].call(this.namazu);
					this.FadeOut(1,00000000.0, 1,00000000.0, 1,00000000.0, 60);
					this.subState = function ()
					{
						this.AddSpeed_XY(0,00000000.0, -0,75000000.0, 0,00000000.0, -17,50000000.0);
						this.flag5.moveCount++;

						if (this.flag5.moveCount == 150)
						{
							this.Master_Spell_6_Dream_Attack();
						}
					};
				}
			};
		}
	];
	this.func[0].call(this);
	this.stateLabel = function ()
	{
		this.subState();

		if (this.count == 120)
		{
			this.func[1].call(this);
		}

		if (this.count >= 240 && this.target.team.current.IsAttack())
		{
			this.func[2].call(this);
		}
	};
}

function Master_Spell_6_Dream_Attack()
{
	this.LabelClear();
	this.direction = -1,00000000.0;
	this.SetMotion(4975, 2);
	this.Warp(640, 360);
	this.target.team.master.VS_NamazuMove_Pre2(null);
	this.EraceBackGround();
	this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 120);
	this.team.life_limit = 0;
	this.enableKO = true;
	::battle.corner_left = 320;
	::battle.corner_right = 960;
	this.flag5 = {};
	this.flag5.v <- 0,00000000.0;
	this.flag5.back <- this.SetFreeObject(640, 360, 1,00000000.0, this.Shot_Dream6_Back, {}).weakref();
	this.flag5.pos <- this.Vector3;
	this.flag5.moveCount <- 0;
	this.flag5.camera <- this.Vector3();
	this.flag5.camera.x = 640;
	this.flag5.camera.y = 760;
	this.flag5.zoom <- 1,00000000.0;
	this.flag5.sword <- null;
	this.freeMap = true;
	this.count = 0;

	if (this.namazu)
	{
		this.namazu.ReleaseActor();
	}

	this.namazu = this.SetShot(this.x, this.y + 64, this.direction, this.Shot_Dream6_RideNamazu, {}).weakref();
	::camera.lock = false;
	::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
	this.lavelClearEvent = function ()
	{
		if (this.namazu)
		{
			this.namazu.func[0].call(this.namazu);
		}
	};
	this.func = [
		function ()
		{
			this.flag5.moveCount = 0;
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.flag5.camera.y += (260 - this.flag5.camera.y) * 0,03000000.0;
				this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,03000000.0;
				::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

				if (this.flag5.moveCount == 90)
				{
					this.PlaySE(4242);
					this.Warp(640 - 400, 360 + 300);
					this.SetMotion(this.motion, 5 + this.rand() % 4);
					this.namazu.func[1].call(this.namazu);
					this.DrawActorPriority(21);
					this.sx = this.sy = 0,66000003.0;
					this.namazu.sx = this.namazu.sy = 0,66000003.0;
					this.namazu.red = this.namazu.blue = this.namazu.green = 0,66000003.0;
					this.SetSpeed_XY(3,00000000.0, -8,00000000.0);
					this.flag5.moveCount = 0;
					this.subState = function ()
					{
						this.masterRed = this.masterGreen = this.masterBlue = 0,50000000.0;
						this.rz -= 0,75000000.0 * 0,01745329.0;
						this.flag5.moveCount++;

						if (this.flag5.moveCount == 120)
						{
							this.PlaySE(4242);
							this.target.team.current.flag5.input = true;
							this.Warp(640 + 600, 360 - 700);
							this.SetMotion(this.motion, 9);
							this.namazu.func[2].call(this.namazu);
							this.DrawActorPriority(180);
							this.sx = this.sy = 1,00000000.0;
							this.masterRed = this.masterGreen = this.masterBlue = 1,00000000.0;
							this.namazu.sx = this.namazu.sy = 1,00000000.0;
							this.namazu.red = this.namazu.blue = this.namazu.green = 1,00000000.0;
							this.SetSpeed_XY(-2,00000000.0, 5,00000000.0);
							this.subState = function ()
							{
								this.flag5.camera.x += (800 - this.flag5.camera.x) * 0,05000000.0;
								this.flag5.camera.y += (260 - this.flag5.camera.y) * 0,05000000.0;
								this.flag5.zoom += (1,25000000.0 - this.flag5.zoom) * 0,05000000.0;
								::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
								this.rz += 0,50000000.0 * 0,01745329.0;

								if (this.y > 1060)
								{
									this.func[1].call(this);
								}
							};
						}
					};
				}
			};
		},
		function ()
		{
			this.flag5.moveCount = 0;
			this.SetMotion(this.motion, 2);
			this.namazu.func[3].call(this.namazu);
			this.Warp(1600, 260);
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
				this.flag5.camera.y += (360 - this.flag5.camera.y) * 0,05000000.0;
				this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
				::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

				if (this.flag5.moveCount == 30)
				{
					this.Warp(640 + 400, 260);
					this.PlaySE(4242);
					this.SetMotion(this.motion, 4 + this.rand() % 4);
					this.namazu.func[1].call(this.namazu);
					this.DrawActorPriority(21);
					this.flag5.moveCount = 0;
					this.sx = this.sy = 0,33000001.0;
					this.namazu.sx = this.namazu.sy = 0,33000001.0;
					this.namazu.red = this.namazu.blue = this.namazu.green = 0,50000000.0;
					this.SetSpeed_XY(-8,50000000.0, -1,00000000.0);
					this.subState = function ()
					{
						this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
						this.masterRed = this.masterGreen = this.masterBlue = 0,50000000.0;
						this.rz -= 1,50000000.0 * 0,01745329.0;
						this.flag5.moveCount++;
						this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
						this.flag5.camera.y += (260 - this.flag5.camera.y) * 0,05000000.0;
						this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
						::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

						if (this.flag5.moveCount == 120)
						{
							this.PlaySE(4242);
							this.flag5.moveCount = 0;
							this.Warp(640 - 200, 360 + 360);
							this.sx = this.sy = 0,50000000.0;
							this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
							this.namazu.sx = this.namazu.sy = 0,50000000.0;
							this.namazu.red = this.namazu.blue = this.namazu.green = 0,66000003.0;
							this.SetSpeed_XY(1,50000000.0, -5,50000000.0);
							this.SetMotion(this.motion, 12);
							this.subState = function ()
							{
								this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
								this.rz += 1,00000000.0 * 0,01745329.0;
								this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
								this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
								this.flag5.camera.y += (260 - this.flag5.camera.y) * 0,05000000.0;
								this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
								::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
								this.flag5.moveCount++;

								if (this.flag5.moveCount == 210)
								{
									this.PlaySE(4242);
									this.PlaySE(4223);
									this.flag5.moveCount = 0;
									this.Warp(640 + 540, 360 - 500);
									this.SetMotion(this.motion, 13);
									this.rz = 3,14159203.0;
									this.namazu.func[2].call(this.namazu);
									this.DrawActorPriority(180);
									this.sx = this.sy = 1,00000000.0;
									this.masterRed = this.masterGreen = this.masterBlue = 1,00000000.0;
									this.namazu.sx = this.namazu.sy = 1,00000000.0;
									this.namazu.red = this.namazu.blue = this.namazu.green = 1,00000000.0;
									this.SetSpeed_XY(-1,00000000.0, 2,50000000.0);
									this.flag5.sword = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Dream6_Blade, {}).weakref();
									this.subState = function ()
									{
										this.rz += 1,25000000.0 * 0,01745329.0;
										this.flag5.camera.x += (this.x - this.flag5.camera.x) * 0,02500000.0;
										this.flag5.camera.y += (this.y - this.flag5.camera.y) * 0,02500000.0;
										this.flag5.zoom += (1,20000005.0 - this.flag5.zoom) * 0,02500000.0;
										::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
										this.flag5.moveCount++;

										if (this.flag5.sword)
										{
											this.flag5.sword.Warp(this.point1_x, this.point1_y);
											this.flag5.sword.rz = this.rz;
										}

										if (this.y > 800 && this.flag5.sword)
										{
											this.flag5.sword.func[0].call(this.flag5.sword);
											this.flag5.sword = null;
										}

										if (this.flag5.moveCount == 600)
										{
											if (this.flag5.sword)
											{
												this.flag5.sword.func[0].call(this.flag5.sword);
											}

											this.func[2].call(this);
										}
									};
								}
							};
						}
					};
				}
			};
		},
		function ()
		{
			this.flag5.moveCount = 0;
			this.SetMotion(this.motion, 2);
			this.namazu.func[3].call(this.namazu);
			this.Warp(1600, 260);
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
				this.flag5.camera.y += (360 - this.flag5.camera.y) * 0,05000000.0;
				this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
				::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

				if (this.flag5.moveCount == 30)
				{
					this.Warp(640 + 400, 460);
					this.PlaySE(4242);
					this.SetMotion(this.motion, 4 + this.rand() % 4);
					this.namazu.func[1].call(this.namazu);
					this.DrawActorPriority(21);
					this.flag5.moveCount = 0;
					this.sx = this.sy = 0,33000001.0;
					this.namazu.sx = this.namazu.sy = 0,33000001.0;
					this.namazu.red = this.namazu.blue = this.namazu.green = 0,33000001.0;
					this.SetSpeed_XY(-8,50000000.0, 1,00000000.0);
					this.subState = function ()
					{
						this.masterRed = this.masterGreen = this.masterBlue = 0,50000000.0;
						this.rz += 1,50000000.0 * 0,01745329.0;
						this.flag5.moveCount++;
						this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
						this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
						this.flag5.camera.y += (460 - this.flag5.camera.y) * 0,05000000.0;
						this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
						::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

						if (this.flag5.moveCount == 120)
						{
							this.PlaySE(4242);
							this.flag5.moveCount = 0;
							this.Warp(640 - 200, 360 - 360);
							this.sx = this.sy = 0,50000000.0;
							this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
							this.namazu.sx = this.namazu.sy = 0,50000000.0;
							this.namazu.red = this.namazu.blue = this.namazu.green = 0,66000003.0;
							this.SetSpeed_XY(1,50000000.0, 5,50000000.0);
							this.SetMotion(this.motion, 12);
							this.subState = function ()
							{
								this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
								this.rz -= 1,00000000.0 * 0,01745329.0;
								this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
								this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
								this.flag5.camera.y += (460 - this.flag5.camera.y) * 0,05000000.0;
								this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
								::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
								this.flag5.moveCount++;

								if (this.flag5.moveCount == 210)
								{
									this.PlaySE(4242);
									this.PlaySE(4223);
									this.flag5.moveCount = 0;
									this.Warp(640 + 540, 360 + 500);
									this.SetMotion(this.motion, 13);
									this.rz = -3,14159203.0;
									this.namazu.func[2].call(this.namazu);
									this.DrawActorPriority(180);
									this.sx = this.sy = 1,00000000.0;
									this.masterRed = this.masterGreen = this.masterBlue = 1,00000000.0;
									this.namazu.sx = this.namazu.sy = 1,00000000.0;
									this.namazu.red = this.namazu.blue = this.namazu.green = 1,00000000.0;
									this.SetSpeed_XY(-1,00000000.0, -2,50000000.0);
									this.flag5.sword = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Dream6_Blade, {}).weakref();
									this.subState = function ()
									{
										this.rz -= 1,25000000.0 * 0,01745329.0;
										this.flag5.camera.x += (this.x - this.flag5.camera.x) * 0,02500000.0;
										this.flag5.camera.y += (this.y - this.flag5.camera.y) * 0,02500000.0;
										this.flag5.zoom += (1,20000005.0 - this.flag5.zoom) * 0,02500000.0;
										::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
										this.flag5.moveCount++;

										if (this.flag5.sword)
										{
											this.flag5.sword.Warp(this.point1_x, this.point1_y);
											this.flag5.sword.rz = this.rz;
										}

										if (this.y < -40 && this.flag5.sword)
										{
											this.flag5.sword.func[0].call(this.flag5.sword);
											this.flag5.sword = null;
										}

										if (this.flag5.moveCount == 600)
										{
											if (this.flag5.sword)
											{
												this.flag5.sword.func[0].call(this.flag5.sword);
											}

											this.func[3].call(this);
										}
									};
								}
							};
						}
					};
				}
			};
		},
		function ()
		{
			if (this.rand() % 100 <= 49)
			{
				this.func[4].call(this);
				return;
			}

			this.flag5.moveCount = 0;
			this.SetMotion(this.motion, 2);
			this.namazu.func[3].call(this.namazu);
			this.Warp(1600, 460);
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
				this.flag5.camera.y += (360 - this.flag5.camera.y) * 0,05000000.0;
				this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
				::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

				if (this.flag5.moveCount == 30)
				{
					this.Warp(640 + 400, 460);
					this.PlaySE(4242);
					this.SetMotion(this.motion, 4 + this.rand() % 4);
					this.namazu.func[1].call(this.namazu);
					this.DrawActorPriority(21);
					this.flag5.moveCount = 0;
					this.sx = this.sy = 0,33000001.0;
					this.namazu.sx = this.namazu.sy = 0,33000001.0;
					this.namazu.red = this.namazu.blue = this.namazu.green = 0,50000000.0;
					this.SetSpeed_XY(-8,50000000.0, -1,00000000.0);
					this.subState = function ()
					{
						this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
						this.masterRed = this.masterGreen = this.masterBlue = 0,50000000.0;
						this.rz += 1,50000000.0 * 0,01745329.0;
						this.flag5.moveCount++;
						this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
						this.flag5.camera.y += (460 - this.flag5.camera.y) * 0,05000000.0;
						this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
						::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

						if (this.flag5.moveCount == 120)
						{
							this.PlaySE(4242);
							this.flag5.moveCount = 0;
							this.Warp(640 - 480, 360);
							this.sx = this.sy = 0,50000000.0;
							this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
							this.namazu.sx = this.namazu.sy = 0,50000000.0;
							this.namazu.red = this.namazu.blue = this.namazu.green = 0,66000003.0;
							this.SetSpeed_XY(6,00000000.0, 0,75000000.0);
							this.SetMotion(this.motion, 12);
							this.subState = function ()
							{
								this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
								this.rz -= 2,00000000.0 * 0,01745329.0;
								this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
								this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
								this.flag5.camera.y += (460 - this.flag5.camera.y) * 0,05000000.0;
								this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
								::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
								this.flag5.moveCount++;

								if (this.flag5.moveCount == 210)
								{
									this.PlaySE(4242);
									this.PlaySE(4223);
									this.flag5.moveCount = 0;
									this.Warp(640 + 920, 360);
									this.SetMotion(this.motion, 14);
									this.rz = 0,00000000.0;
									this.namazu.func[2].call(this.namazu);
									this.DrawActorPriority(180);
									this.sx = this.sy = 1,00000000.0;
									this.masterRed = this.masterGreen = this.masterBlue = 1,00000000.0;
									this.namazu.sx = this.namazu.sy = 1,00000000.0;
									this.namazu.red = this.namazu.blue = this.namazu.green = 1,00000000.0;
									this.SetSpeed_XY(-6,00000000.0, -0,50000000.0);
									this.flag5.sword = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Dream6_BladeB, {}).weakref();
									this.subState = function ()
									{
										this.rz -= 2,00000000.0 * 0,01745329.0;
										this.flag5.camera.x += (this.x - this.flag5.camera.x) * 0,02500000.0;
										this.flag5.camera.y += (this.y - this.flag5.camera.y) * 0,02500000.0;
										this.flag5.zoom += (1,20000005.0 - this.flag5.zoom) * 0,02500000.0;
										::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
										this.flag5.moveCount++;

										if (this.flag5.sword)
										{
											this.flag5.sword.Warp(this.point1_x, this.point1_y);
											this.flag5.sword.rz = this.rz;
										}

										if (this.x < -400)
										{
											this.flag5.sword.func[0].call(this.flag5.sword);
											this.flag5.sword = null;
											this.func[1].call(this);
										}
									};
								}
							};
						}
					};
				}
			};
		},
		function ()
		{
			this.flag5.moveCount = 0;
			this.SetMotion(this.motion, 2);
			this.namazu.func[3].call(this.namazu);
			this.Warp(1600, 460);
			this.subState = function ()
			{
				this.flag5.moveCount++;
				this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
				this.flag5.camera.y += (360 - this.flag5.camera.y) * 0,05000000.0;
				this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
				::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

				if (this.flag5.moveCount == 30)
				{
					this.Warp(640 + 400, 460);
					this.PlaySE(4242);
					this.SetMotion(this.motion, 4 + this.rand() % 4);
					this.namazu.func[1].call(this.namazu);
					this.DrawActorPriority(21);
					this.flag5.moveCount = 0;
					this.sx = this.sy = 0,33000001.0;
					this.namazu.sx = this.namazu.sy = 0,33000001.0;
					this.namazu.red = this.namazu.blue = this.namazu.green = 0,50000000.0;
					this.SetSpeed_XY(-8,50000000.0, -1,00000000.0);
					this.subState = function ()
					{
						this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
						this.masterRed = this.masterGreen = this.masterBlue = 0,50000000.0;
						this.rz -= 1,50000000.0 * 0,01745329.0;
						this.flag5.moveCount++;
						this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
						this.flag5.camera.y += (460 - this.flag5.camera.y) * 0,05000000.0;
						this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
						::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);

						if (this.flag5.moveCount == 120)
						{
							this.PlaySE(4242);
							this.flag5.moveCount = 0;
							this.Warp(640 - 480, 360);
							this.sx = this.sy = 0,50000000.0;
							this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
							this.namazu.sx = this.namazu.sy = 0,50000000.0;
							this.namazu.red = this.namazu.blue = this.namazu.green = 0,66000003.0;
							this.SetSpeed_XY(6,00000000.0, 0,75000000.0);
							this.SetMotion(this.motion, 12);
							this.subState = function ()
							{
								this.sx = this.sy = this.namazu.sx = this.namazu.sy += 0,00100000.0;
								this.rz += 2,00000000.0 * 0,01745329.0;
								this.masterRed = this.masterGreen = this.masterBlue = 0,66000003.0;
								this.flag5.camera.x += (640 - this.flag5.camera.x) * 0,05000000.0;
								this.flag5.camera.y += (460 - this.flag5.camera.y) * 0,05000000.0;
								this.flag5.zoom += (2,00000000.0 - this.flag5.zoom) * 0,05000000.0;
								::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
								this.flag5.moveCount++;

								if (this.flag5.moveCount == 210)
								{
									this.PlaySE(4242);
									this.PlaySE(4223);
									this.flag5.moveCount = 0;
									this.Warp(640 + 920, 360);
									this.SetMotion(this.motion, 14);
									this.rz = 3,14159203.0;
									this.namazu.func[2].call(this.namazu);
									this.DrawActorPriority(180);
									this.sx = this.sy = 1,00000000.0;
									this.masterRed = this.masterGreen = this.masterBlue = 1,00000000.0;
									this.namazu.sx = this.namazu.sy = 1,00000000.0;
									this.namazu.red = this.namazu.blue = this.namazu.green = 1,00000000.0;
									this.SetSpeed_XY(-6,00000000.0, -0,50000000.0);
									this.flag5.sword = this.SetShot(this.point1_x, this.point1_y, this.direction, this.Shot_Dream6_BladeB, {}).weakref();
									this.subState = function ()
									{
										this.rz += 2,00000000.0 * 0,01745329.0;
										this.flag5.camera.x += (this.x - this.flag5.camera.x) * 0,02500000.0;
										this.flag5.camera.y += (this.y - this.flag5.camera.y) * 0,02500000.0;
										this.flag5.zoom += (1,20000005.0 - this.flag5.zoom) * 0,02500000.0;
										::camera.SetTarget(this.flag5.camera.x, this.flag5.camera.y, this.flag5.zoom, true);
										this.flag5.moveCount++;

										if (this.flag5.sword)
										{
											this.flag5.sword.Warp(this.point1_x, this.point1_y);
											this.flag5.sword.rz = this.rz;
										}

										if (this.x < -400)
										{
											this.flag5.sword.func[0].call(this.flag5.sword);
											this.flag5.sword = null;
											this.func[1].call(this);
										}
									};
								}
							};
						}
					};
				}
			};
		}
	];
	this.func[0].call(this);
	this.stateLabel = function ()
	{
		::battle.corner_left = ::camera.camera2d.left;
		::battle.corner_right = ::camera.camera2d.right;
		this.subState();

		if (this.namazu)
		{
			this.namazu.Warp(this.point0_x, this.point0_y);
			this.namazu.rz = this.rz;
			this.namazu.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
		}
	};
}

function Slave_Doremy_2()
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

function Slave_Attack_Doremy2( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4963, 1);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag5 = {};
	this.flag5.shotCycle <- 9;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.shotNum <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- null;
	this.flag5.namazu <- null;
	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};

	switch(this.com_difficulty)
	{
	case 0:
		this.flag5.shotCycle = 8;
		break;

	case 1:
		this.flag5.shotCycle = 4;
		break;

	case 2:
		this.flag5.shotCycle = 3;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 2;
		break;
	}

	this.subState = [
		function ()
		{
		},
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			if (this.flag5.charge)
			{
				this.flag5.charge.func();
			}

			this.flag5.charge = null;
			this.SetSpeed_XY(17,50000000.0 * this.direction, -12,50000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0, 1,00000000.0 * this.direction);
				this.AddSpeed_XY(0,00000000.0, 0,25000000.0, null, 2,00000000.0);

				if (this.count == 25)
				{
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
						this.AddSpeed_XY(0,00000000.0, 1,50000000.0, 0,00000000.0, 30,00000000.0);

						if (this.ground)
						{
							this.team.master.shot_actor.Foreach(function ()
							{
								this.func[2].call(this);
							});
							this.shot_actor.Foreach(function ()
							{
								this.func[2].call(this);
							});
							this.count = 0;
							this.PlaySE(4253);
							this.SetMotion(4963, 3);
							::camera.Shake(10,00000000.0);
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							this.team.master.shot_actor.Foreach(function ()
							{
								this.func[2].call(this);
							});
							this.stateLabel = function ()
							{
								if (this.count % this.flag5.shotCycle == 1)
								{
									this.SetShot(this.x + 100 + this.count * 50 + this.rand() % 50, ::battle.scroll_bottom + 196, this.direction, this.Shot_S2_Kaname, {});
									this.SetShot(this.x - 100 - this.count * 50 + this.rand() % 50, ::battle.scroll_bottom + 196, this.direction, this.Shot_S2_Kaname, {});
								}
							};
						}
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.SetMotion(this.motion, 6);
			this.centerStop = -3;
			this.SetSpeed_XY(-2,50000000.0 * this.direction, -12,50000000.0);
			this.stateLabel = function ()
			{
				if (this.y < this.centerY)
				{
					this.CenterUpdate(0,60000002.0, 7,50000000.0);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 8);
					this.count = 0;
					this.stone.func[2].call(this.stone);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,50000000.0, null);
						this.VX_Brake(0,50000000.0);

						if (this.count >= 80)
						{
							this.Change_Master_Doremy2(null);
						}
					};
				}
			};
		},
		null,
		null,
		null,
		null,
		function ()
		{
		}
	];
	this.keyAction[0].call(this);
}

function Change_Master_Doremy2( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	local pos_ = this.Vector3();
	pos_.x = 160 + this.rand() % 160;
	pos_.y = 80 + this.rand() % 120;

	if (this.x > ::battle.scroll_right - 360)
	{
		pos_.x = -pos_.x;
	}
	else if (this.x > ::battle.scroll_left + 360 && this.rand() % 100 <= 49)
	{
		pos_.x = -pos_.x;
	}

	if (this.y > ::battle.scroll_bottom - 360)
	{
		pos_.y = -pos_.y;
	}
	else if (this.y > ::battle.scroll_top + 360 && this.rand() % 100 <= 49)
	{
		pos_.y = -pos_.y;
	}

	this.team.current.MS2_Move(pos_);
	this.Set_BossSpellBariaRate(1);
}

