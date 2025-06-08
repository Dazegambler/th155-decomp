function Master_Spell_1()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
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
	this.SetMotion(4992, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 - 400 * this.direction;
	this.flag5.pos.y = 240;
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.flag5.moveV += 0.25000000;

		if (this.flag5.moveV > 10.00000000)
		{
			this.flag5.moveV = 10.00000000;
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

				if (this.Vec_Brake(0.25000000))
				{
					this.Master_Spell_1_Dream_Attack();
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(-this.direction);
		}
	};
}

function Master_Spell_2()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.team.slave.Slave_Kasen_1();
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

					this.MS2_Step(null);
				}
			};
		}
	};
	return true;
}

function MS2_Step( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.centerStop = -2;
	this.AjustCenterStop();

	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
		{
			this.SetMotion(4993, 0);
			this.keyAction = function ()
			{
				this.keyAction = null;
				this.PlaySE(800);
				this.SetSpeed_XY(7.50000000 * this.direction, -12.00000000);
				this.centerStop = -3;
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);

					if (this.keyTake == 2 && this.va.y > -2.50000000)
					{
						this.SetMotion(4993, 3);
					}

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(4993, 5);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(0.50000000);
							this.keyAction = function ()
							{
								this.MS2_Attack(null);
								return;
							};
						};
					}
				};
			};
		}
		else
		{
			this.SetMotion(4996, 0);
			this.PlaySE(801);
			this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(4996, 3);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.34999999);
						this.keyAction = function ()
						{
							this.MS2_Attack(null);
							return;
						};
					};
				}
			};
		}
	}
	else if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
	{
		this.SetMotion(4995, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(6.00000000 * this.direction, this.y <= this.centerY ? -3.50000000 : 3.50000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.25000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4995, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.34999999);
					this.keyAction = function ()
					{
						this.MS2_Attack(null);
						return;
					};
				};
			}
		};
	}
	else
	{
		this.SetMotion(4996, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(-6.00000000 * this.direction, this.y <= this.centerY ? -3.50000000 : 3.50000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.25000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4996, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.34999999);
					this.keyAction = function ()
					{
						this.MS2_Attack(null);
						return;
					};
				};
			}
		};
	}
}

function MS2_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4950, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag3 = null;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag3)
		{
			this.flag3.func();
		}

		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotNum <- 12;
	this.flag5.shotCycle <- 120;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0.52359873;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 12;
		this.flag5.shotRot = 0.52359873;
		this.flag5.shotCycle = 60;
		break;

	case 2:
		this.flag5.shotNum = 15;
		this.flag5.shotRot = 24 * 0.01745329;
		this.flag5.shotCycle = 60;
		break;

	case 3:
	case 4:
		this.flag5.shotNum = 18;
		this.flag5.shotRot = 0.34906584;
		this.flag5.shotCycle = 60;
		break;
	}

	this.func = [
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			this.flag3 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS2_Charge, {}).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 30 == 0)
				{
					this.PlaySE(3030);
				}

				if (this.count % this.flag5.shotCycle == 1 && this.count <= 300)
				{
					this.PlaySE(3031);
					local rot2 = (45 - this.rand() % 91) * 0.01745329;
					local r_ = this.rand() % 360 * 0.01745329;

					for( local i = 0; i < this.flag5.shotNum; i++ )
					{
						local t_ = {};
						t_.rot <- i * this.flag5.shotRot + r_;
						t_.rot2 <- rot2;
						t_.wait <- 60 + i * 4;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS2, t_);
					}
				}

				if (this.count == 240)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 330)
				{
					this.M2_Change_Slave(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Kasen(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2B()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.team.slave.Slave_Kasen_1();
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

					this.MS2B_Step(null);
				}
			};
		}
	};
	return true;
}

function MS2B_Step( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.centerStop = -2;
	this.AjustCenterStop();

	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
		{
			this.SetMotion(4993, 0);
			this.keyAction = function ()
			{
				this.keyAction = null;
				this.PlaySE(800);
				this.SetSpeed_XY(7.50000000 * this.direction, -12.00000000);
				this.centerStop = -3;
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);

					if (this.keyTake == 2 && this.va.y > -2.50000000)
					{
						this.SetMotion(4993, 3);
					}

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(4993, 5);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(0.50000000);
							this.keyAction = function ()
							{
								this.MS2B_Attack(null);
								return;
							};
						};
					}
				};
			};
		}
		else
		{
			this.SetMotion(4996, 0);
			this.PlaySE(801);
			this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(4996, 3);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.34999999);
						this.keyAction = function ()
						{
							this.MS2B_Attack(null);
							return;
						};
					};
				}
			};
		}
	}
	else if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
	{
		this.SetMotion(4995, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(6.00000000 * this.direction, this.y <= this.centerY ? -3.50000000 : 3.50000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.25000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4995, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.34999999);
					this.keyAction = function ()
					{
						this.MS2B_Attack(null);
						return;
					};
				};
			}
		};
	}
	else
	{
		this.SetMotion(4996, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(-6.00000000 * this.direction, this.y <= this.centerY ? -3.50000000 : 3.50000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.25000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4996, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.34999999);
					this.keyAction = function ()
					{
						this.MS2B_Attack(null);
						return;
					};
				};
			}
		};
	}
}

function MS2B_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4950, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag3 = null;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag3)
		{
			this.flag3.func();
		}

		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotNum <- 12;
	this.flag5.shotCycle <- 120;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0.52359873;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 12;
		this.flag5.shotRot = 0.52359873;
		this.flag5.shotCycle = 60;
		break;

	case 2:
		this.flag5.shotNum = 15;
		this.flag5.shotRot = 24 * 0.01745329;
		this.flag5.shotCycle = 60;
		break;

	case 3:
	case 4:
		this.flag5.shotNum = 18;
		this.flag5.shotRot = 0.34906584;
		this.flag5.shotCycle = 60;
		break;
	}

	this.func = [
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			this.flag3 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS2_Charge, {}).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 30 == 0)
				{
					this.PlaySE(3030);
				}

				if (this.count % this.flag5.shotCycle == 1)
				{
					this.PlaySE(3031);
					local rot2 = (45 - this.rand() % 91) * 0.01745329;
					local r_ = this.rand() % 360 * 0.01745329;

					for( local i = 0; i < this.flag5.shotNum; i++ )
					{
						local t_ = {};
						t_.rot <- i * this.flag5.shotRot + r_;
						t_.rot2 <- rot2;
						t_.wait <- 60 + i * 4;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS2B, t_);
					}
				}

				if (this.count == 240)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 330)
				{
					this.M2B_Change_Slave(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function M2B_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Kasen(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_3()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.team.slave.Slave_Kasen_3();
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

					this.MS3_Attack(null);
				}
			};
		}
	};
	return true;
}

function MS3_Step( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.centerStop = -2;
	this.AjustCenterStop();

	if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
	{
		this.SetMotion(4993, 0);
		this.keyAction = function ()
		{
			this.keyAction = null;
			this.PlaySE(800);
			this.SetSpeed_XY(7.50000000 * this.direction, -12.00000000);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, null);

				if (this.keyTake == 2 && this.va.y > -2.50000000)
				{
					this.SetMotion(4993, 3);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(4993, 5);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.50000000);
						this.keyAction = function ()
						{
							this.MS3_Attack(null);
							return;
						};
					};
				}
			};
		};
	}
	else
	{
		this.SetMotion(4996, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.50000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4996, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.34999999);
					this.keyAction = function ()
					{
						this.MS3_Attack(null);
						return;
					};
				};
			}
		};
	}
}

function MS3_Attack( t )
{
	if (this.rand() % 100 <= 50)
	{
		this.MS3_AttackB(t);
		return true;
	}

	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4960, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = this.Vector3();
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
	this.flag5.shot <- null;
	this.flag5.scale <- 1.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.scale = 1.33000004;
		break;

	case 2:
		this.flag5.scale = 1.65999997;
		break;

	case 3:
		this.flag5.scale = 2.00000000;
		break;

	case 4:
		this.flag5.scale = 2.32999992;
		break;
	}

	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.PlaySE(3050);
			local t_ = {};
			t_.scale <- this.flag5.scale;
			t_.rot <- -1.04719746;
			this.flag5.shot = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS3, t_).weakref();
			this.SetSpeed_Vec(15.00000000, 120 * 0.01745329, this.direction);
			this.centerStop = 2;
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.y < this.centerY + 100)
				{
					this.Vec_Brake(1.00000000, 5.00000000);
				}
				else
				{
					this.Vec_Brake(1.00000000, 0.50000000);
				}

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 120)
				{
					this.flag5.shot.func[1].call(this.flag5.shot);
					this.M3_Change_Slave(null);
					return;
				}
			};
		}
	];
	return true;
}

function M3_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Kasen3(null);
	this.Set_BossSpellBariaRate(10);
}

function MS3_AttackB( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4993, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(800);
			this.SetSpeed_XY(-2.00000000 * this.direction, -12.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.34999999);

				if (this.va.y > -2.00000000 && this.keyTake == 2)
				{
					this.SetMotion(this.motion, 3);
				}

				if (this.count == 35)
				{
					this.MS3_AttackB_Main(null);
					return;
				}
			};
		}
	];
	return true;
}

function MS3_AttackB_Main( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4961, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = this.Vector3();
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
	this.flag5.shot <- null;
	this.flag5.scale <- 1.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.scale = 1.33000004;
		break;

	case 2:
		this.flag5.scale = 1.65999997;
		break;

	case 3:
		this.flag5.scale = 2.00000000;
		break;

	case 4:
		this.flag5.scale = 2.32999992;
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3050);
			local t_ = {};
			t_.scale <- this.flag5.scale;
			t_.rot <- 0.17453292;
			this.flag5.shot = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS3, t_).weakref();
			this.SetSpeed_Vec(15.00000000, 120 * 0.01745329, this.direction);
			this.centerStop = 2;
			this.count = 0;
			this.SetSpeed_Vec(-160 * 0.01745329, 10.00000000, this.direction);
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 0.50000000);

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 120)
				{
					this.flag5.shot.func[1].call(this.flag5.shot);
					this.M3_Change_Slave2(null);
					return;
				}
			};
		}
	];
	return true;
}

function M3_Change_Slave2( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack2_Kasen3(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_3B()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.team.slave.Slave_Kasen_3();
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

					this.MS3B_Attack(null);
				}
			};
		}
	};
	return true;
}

function MS3B_Step( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.centerStop = -2;
	this.AjustCenterStop();

	if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
	{
		this.SetMotion(4993, 0);
		this.keyAction = function ()
		{
			this.keyAction = null;
			this.PlaySE(800);
			this.SetSpeed_XY(7.50000000 * this.direction, -12.00000000);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, null);

				if (this.keyTake == 2 && this.va.y > -2.50000000)
				{
					this.SetMotion(4993, 3);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(4993, 5);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.50000000);
						this.keyAction = function ()
						{
							this.MS3B_Attack(null);
							return;
						};
					};
				}
			};
		};
	}
	else
	{
		this.SetMotion(4996, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.50000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4996, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.34999999);
					this.keyAction = function ()
					{
						this.MS3B_Attack(null);
						return;
					};
				};
			}
		};
	}
}

function MS3B_Attack( t )
{
	if (this.rand() % 100 <= 50)
	{
		this.MS3B_Attack2(t);
		return true;
	}

	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4960, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = this.Vector3();
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
	this.flag5.shot <- null;
	this.flag5.scale <- 1.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.scale = 1.33000004;
		break;

	case 2:
		this.flag5.scale = 1.65999997;
		break;

	case 3:
	case 4:
		this.flag5.scale = 2.00000000;
		break;
	}

	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.PlaySE(3050);
			local t_ = {};
			t_.scale <- this.flag5.scale;
			t_.rot <- -1.04719746;
			this.flag5.shot = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS3B, t_).weakref();
			this.SetSpeed_Vec(15.00000000, 120 * 0.01745329, this.direction);
			this.centerStop = 2;
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.y < this.centerY + 100)
				{
					this.Vec_Brake(1.00000000, 5.00000000);
				}
				else
				{
					this.Vec_Brake(1.00000000, 0.50000000);
				}

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 120)
				{
					this.flag5.shot.func[1].call(this.flag5.shot);
					this.M3B_Change_Slave(this.flag5.shot);
					return;
				}
			};
		}
	];
	return true;
}

function M3B_Change_Slave( actor_ )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Kasen3(actor_);
	this.Set_BossSpellBariaRate(10);
}

function MS3B_Attack2( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4993, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(800);
			this.SetSpeed_XY(-2.00000000 * this.direction, -12.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.34999999);

				if (this.va.y > -2.00000000 && this.keyTake == 2)
				{
					this.SetMotion(this.motion, 3);
				}

				if (this.count == 35)
				{
					this.MS3B_Attack2_Main(null);
					return;
				}
			};
		}
	];
	return true;
}

function MS3B_Attack2_Main( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4961, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = this.Vector3();
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
	this.flag5.shot <- null;
	this.flag5.scale <- 1.00000000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.scale = 1.33000004;
		break;

	case 2:
		this.flag5.scale = 1.65999997;
		break;

	case 3:
	case 4:
		this.flag5.scale = 2.00000000;
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3050);
			local t_ = {};
			t_.scale <- this.flag5.scale;
			t_.rot <- 0.17453292;
			this.flag5.shot = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS3B, t_).weakref();
			this.SetSpeed_Vec(15.00000000, 120 * 0.01745329, this.direction);
			this.centerStop = 2;
			this.count = 0;
			this.SetSpeed_Vec(-160 * 0.01745329, 10.00000000, this.direction);
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 0.50000000);

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 120)
				{
					this.flag5.shot.func[1].call(this.flag5.shot);
					this.M3B_Change_Slave2(this.flag5.shot);
					return;
				}
			};
		}
	];
	return true;
}

function M3B_Change_Slave2( actor_ )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Kasen3(actor_);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_D1()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 0;
	this.resist_baria = true;
	this.team.slave.Slave_Dream_1();
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

					this.DS1_Step(null);
				}
			};
		}
	};
	return true;
}

function DS1_Step( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.centerStop = -2;
	this.AjustCenterStop();

	if (this.centerStop * this.centerStop <= 1)
	{
		if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
		{
			this.SetMotion(4993, 0);
			this.keyAction = function ()
			{
				this.keyAction = null;
				this.PlaySE(800);
				this.SetSpeed_XY(12.50000000 * this.direction, -12.00000000);
				this.centerStop = -3;
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.75000000, null);

					if (this.keyTake == 2 && this.va.y > -2.50000000)
					{
						this.SetMotion(4993, 3);
					}

					if (this.centerStop * this.centerStop <= 1)
					{
						this.SetMotion(4993, 5);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0.50000000, null);
							this.VX_Brake(0.50000000);
							this.keyAction = function ()
							{
								this.DS1_Attack(null);
								return;
							};
						};
					}
				};
			};
		}
		else
		{
			this.SetMotion(4996, 0);
			this.PlaySE(801);
			this.SetSpeed_XY(-15.00000000 * this.direction, -5.00000000);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.75000000, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(4996, 3);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.75000000);
						this.keyAction = function ()
						{
							this.DS1_Attack(null);
							return;
						};
					};
				}
			};
		}
	}
	else if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
	{
		this.SetMotion(4995, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(12.50000000 * this.direction, this.y <= this.centerY ? -3.50000000 : 3.50000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.75000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4995, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.75000000);
					this.keyAction = function ()
					{
						this.DS1_Attack(null);
						return;
					};
				};
			}
		};
	}
	else
	{
		this.SetMotion(4996, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(-15.00000000 * this.direction, this.y <= this.centerY ? -3.50000000 : 3.50000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.75000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4996, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.75000000);
					this.keyAction = function ()
					{
						this.DS1_Attack(null);
						return;
					};
				};
			}
		};
	}
}

function DS1_Attack( t )
{
	this.com_flag2++;

	if (this.com_flag2 % 2 == 0)
	{
		this.DS1_AttackB(t);
		return true;
	}

	this.LabelClear();
	this.GetFront();
	this.SetMotion(4950, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag3 = null;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag3)
		{
			this.flag3.func();
		}

		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotNum <- 12;
	this.flag5.shotCycle <- 120;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0.52359873;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 12;
		this.flag5.shotRot = 0.52359873;
		this.flag5.shotCycle = 60;
		break;

	case 2:
		this.flag5.shotNum = 15;
		this.flag5.shotRot = 24 * 0.01745329;
		this.flag5.shotCycle = 60;
		break;

	case 3:
	case 4:
		this.flag5.shotNum = 18;
		this.flag5.shotRot = 0.34906584;
		this.flag5.shotCycle = 60;
		break;
	}

	this.func = [
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			this.flag3 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS2_Charge, {}).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 30 == 0)
				{
					this.PlaySE(3030);
				}

				if (this.count % this.flag5.shotCycle == 1 && this.count <= 300 && this.count >= 60)
				{
					this.PlaySE(3031);
					local rot2 = (45 - this.rand() % 91) * 0.01745329;
					local r_ = this.rand() % 360 * 0.01745329;

					for( local i = 0; i < this.flag5.shotNum; i++ )
					{
						local t_ = {};
						t_.rot <- i * this.flag5.shotRot + r_;
						t_.rot2 <- rot2;
						t_.wait <- 60 + i * 4;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS2, t_);
					}
				}

				if (this.count == 300)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == 390)
				{
					this.DS1_ChangeShort_Slave(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function DS1_AttackB( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4950, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag3 = null;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag3)
		{
			this.flag3.func();
		}

		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.keyAction = [
		function ()
		{
			this.flag3 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS2_Charge, {}).weakref();
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % 30 == 0)
				{
					this.PlaySE(3030);
				}

				if (this.count == 90)
				{
					this.DS1_AttackB_Fire(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function DS1_AttackB_Fire( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4951, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag3 = null;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag3)
		{
			this.flag3.func();
		}

		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.flag5 = {};
	this.flag5.shotNum <- 4;
	this.flag5.shotCycle <- 90;
	this.flag5.shotLine <- 2;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0.00000000;
	this.flag5.baseV <- 15.00000000;
	this.flag5.rate <- 33;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotLine = 3;
		this.flag5.shotNum = 6;
		this.flag5.shotCycle = 60;
		this.flag5.baseV = 13.50000000;
		break;

	case 2:
		this.flag5.shotLine = 4;
		this.flag5.shotNum = 7;
		this.flag5.shotCycle = 52;
		this.flag5.baseV = 12.50000000;
		break;

	case 3:
	case 4:
		this.flag5.shotLine = 5;
		this.flag5.shotNum = 8;
		this.flag5.shotCycle = 45;
		this.flag5.baseV = 10.00000000;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(3031);
			::camera.Shake(5.00000000);

			if (this.rand() % 100 <= this.flag5.rate && this.com_difficulty >= 1)
			{
				local r_ = 1.57079601;
				this.flag5.rate = 33;

				for( local i = 0; i < this.flag5.shotLine - 1; i++ )
				{
					local t_ = {};
					t_.rot <- r_;
					t_.wait <- 45;
					t_.v <- this.flag5.baseV + i * 10;
					t_.rot2 <- (i + 1) * 0.17453292;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_DS1B, t_);
					local t_ = {};
					t_.rot <- r_ + 3.14159203;
					t_.wait <- 45;
					t_.v <- this.flag5.baseV + i * 10;
					t_.rot2 <- (i + 1) * -0.17453292;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_DS1B, t_);
				}
			}
			else
			{
				this.flag5.rate += 25;
				local r_ = (70 + this.rand() % 41) * 0.01745329;

				for( local i = 0; i < this.flag5.shotLine; i++ )
				{
					local t_ = {};
					t_.rot <- r_;
					t_.wait <- 45;
					t_.v <- this.flag5.baseV + i * 10;
					t_.rot2 <- (i + 1) * 0.17453292;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_DS1, t_);
					local t_ = {};
					t_.rot <- r_ + 3.14159203;
					t_.wait <- 45;
					t_.v <- this.flag5.baseV + i * 10;
					t_.rot2 <- (i + 1) * -0.17453292;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_DS1, t_);
				}
			}
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.Vec_Brake(2.50000000, 0.25000000);

				if (this.count % 30 == 0)
				{
					this.PlaySE(3030);
				}

				if (this.count % this.flag5.shotCycle == 1)
				{
					if (this.flag5.shotNum > 0)
					{
						this.flag5.shotNum--;
						this.func[0].call(this);

						if (this.flag5.shotNum == 1)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}
					}
					else
					{
						this.DS1_Change_Slave(null);
						return;
					}
				}

				if (this.count % this.flag5.shotCycle == this.flag5.shotCycle - 30)
				{
					this.SetSpeed_Vec(25.00000000, (-30 - this.rand() % 25) * 0.01745329, -this.direction);

					if (this.y < this.centerY - 100 || this.rand() % 100 <= 49 && this.y < this.centerY + 100)
					{
						this.SetSpeed_XY(this.va.x, -this.va.y);
					}

					this.PlaySE(3031);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function DS1_ChangeShort_Slave( t )
{
	this.LabelClear();
	this.team.slave.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream_VeryShort(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.DS1_Step(null);
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function DS1_Change_Slave( t )
{
	this.LabelClear();
	this.team.slave.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.DS1_Step(null);
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_D2()
{
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 1;
	this.resist_baria = true;
	this.team.slave.Slave_Dream_1();
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

					this.DS2_Attack(null);
				}
			};
		}
	};
	return true;
}

function DS2_Step( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.centerStop = -2;
	this.AjustCenterStop();

	if (this.direction == 1.00000000 && this.x < ::battle.scroll_left + 360 || this.direction == -1.00000000 && this.x > ::battle.scroll_right - 360)
	{
		this.SetMotion(4993, 0);
		this.keyAction = function ()
		{
			this.keyAction = null;
			this.PlaySE(800);
			this.SetSpeed_XY(7.50000000 * this.direction, -12.00000000);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, null);

				if (this.keyTake == 2 && this.va.y > -2.50000000)
				{
					this.SetMotion(4993, 3);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(4993, 5);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.50000000);
						this.keyAction = function ()
						{
							this.DS2_Attack(null);
							return;
						};
					};
				}
			};
		};
	}
	else
	{
		this.SetMotion(4996, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(-10.00000000 * this.direction, -5.00000000);
		this.centerStop = -3;
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.50000000, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(4996, 3);
				this.stateLabel = function ()
				{
					this.CenterUpdate(0.50000000, null);
					this.VX_Brake(0.34999999);
					this.keyAction = function ()
					{
						this.DS2_Attack(null);
						return;
					};
				};
			}
		};
	}
}

function DS2_Attack_End( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.AjustCenterStop();

	if (this.y < this.centerY)
	{
		this.SetMotion(4993, 3);
	}
	else
	{
		this.SetMotion(4994, 3);
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0.25000000, 5.00000000);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 5);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.50000000, null);
				this.VX_Brake(0.50000000);
				this.keyAction = function ()
				{
					this.stateLabel = function ()
					{
						if (this.target.team.life > 0)
						{
							this.DS2_Attack(null);
							return;
						}

						this.CenterUpdate(0.50000000, null);
						this.VX_Brake(0.50000000);
					};
				};
			};
		}
	};
}

function DS2_Attack( t )
{
	if (this.com_flag1 % 2 == 1)
	{
		if (this.com_difficulty == 4 && this.com_flag1 >= 3)
		{
			this.com_flag1 = 0;
			this.DS2_AttackOD(t);
			return true;
		}

		this.com_flag1++;
		this.DS2_AttackB(t);
		return true;
	}

	this.com_flag1++;
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4960, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = this.Vector3();
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
	this.flag5.shot <- null;
	this.flag5.scale <- 1.00000000;
	this.flag5.scale_speed <- 0.00500000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.scale = 1.50000000;
		this.flag5.scale_speed = 0.00750000;
		break;

	case 2:
		this.flag5.scale = 1.89999998;
		this.flag5.scale_speed = 0.01000000;
		break;

	case 3:
	case 4:
		this.flag5.scale = 2.25000000;
		this.flag5.scale_speed = 0.01250000;
		break;
	}

	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.PlaySE(3050);
			local t_ = {};
			t_.scale <- this.flag5.scale;
			t_.rot <- -1.04719746;
			t_.scale_speed <- this.flag5.scale_speed;
			t_.limit <- 60;
			this.flag5.shot = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_DS2, t_).weakref();
			this.SetSpeed_Vec(15.00000000, 120 * 0.01745329, this.direction);
			this.centerStop = 3;
			this.count = 0;

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 2.50000000);

				if (this.count == 90)
				{
					this.flag5.shot.func[2].call(this.flag5.shot);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.05000000, 1.00000000);

						if (this.count == 240)
						{
							this.AjustCenterStop();
							this.SetMotion(this.motion, 5);
							this.stateLabel = function ()
							{
								this.CenterUpdate(0.25000000, 5.00000000);
							};
						}
					};
				}
			};
		},
		null,
		function ()
		{
			this.DS2_Attack_End(null);
		}
	];
	return true;
}

function DS2_AttackB( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4993, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(800);
			this.SetSpeed_XY(4.00000000 * this.direction, -12.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.34999999);

				if (this.va.y > -2.00000000 && this.keyTake == 2)
				{
					this.SetMotion(this.motion, 3);
				}

				if (this.count == 35)
				{
					this.DS2_AttackB_Main(null);
					return;
				}
			};
		}
	];
	return true;
}

function DS2_AttackB_Main( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4961, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = this.Vector3();
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
	this.flag5.shot <- null;
	this.flag5.scale <- 1.00000000;
	this.flag5.scale_speed <- 0.00500000;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.scale = 1.50000000;
		this.flag5.scale_speed = 0.00750000;
		break;

	case 2:
		this.flag5.scale = 1.89999998;
		this.flag5.scale_speed = 0.01000000;
		break;

	case 3:
	case 4:
		this.flag5.scale = 2.25000000;
		this.flag5.scale_speed = 0.01250000;
		break;
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0.25000000);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3050);
			local t_ = {};
			t_.scale <- this.flag5.scale;
			t_.rot <- 0.17453292;
			t_.scale_speed <- this.flag5.scale_speed;
			t_.limit <- 60;
			this.flag5.shot = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_DS2, t_).weakref();
			this.SetSpeed_Vec(15.00000000, 120 * 0.01745329, this.direction);
			this.centerStop = 2;
			this.count = 0;
			this.SetSpeed_Vec(-160 * 0.01745329, 10.00000000, this.direction);

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 0.50000000);

				if (this.count == 90)
				{
					this.flag5.shot.func[3].call(this.flag5.shot);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.05000000, 1.00000000);

						if (this.count == 180)
						{
							if (this.com_flag1 >= 3 || this.com_difficulty == 0)
							{
								this.com_flag1 = 0;
								this.DS2_Change_Slave(null);
								return;
							}

							this.AjustCenterStop();
							this.SetMotion(this.motion, 3);
							this.stateLabel = function ()
							{
								this.CenterUpdate(0.25000000, 5.00000000);
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
			this.DS2_Attack_End(null);
		}
	];
	return true;
}

function DS2_AttackOD( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4993, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(800);
			local x_ = (640 - 300 * this.direction - this.x) / 35.00000000;
			this.SetSpeed_XY(x_, -12.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.34999999);

				if (this.va.y > -2.00000000 && this.keyTake == 2)
				{
					this.SetMotion(this.motion, 3);
				}

				if (this.count == 35)
				{
					this.DS2_AttackOD_Main(null);
					return;
				}
			};
		}
	];
	return true;
}

function DS2_AttackOD_Main( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(4963, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = this.Vector3();
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
	this.flag5.shot <- null;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3050);
			local t_ = {};
			t_.rot <- 0.17453292;
			this.flag5.shot = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_DS3, t_).weakref();
			this.centerStop = -2;
			this.count = 0;
			this.SetSpeed_XY(-10.00000000 * this.direction, -2.50000000);

			if (this.flag4)
			{
				this.flag4.func();
			}

			this.stateLabel = function ()
			{
				::camera.Shake(4.00000000);
				this.Vec_Brake(0.20000000, 1.50000000);

				if (this.count == 90)
				{
					::camera.Shake(15.00000000);
					this.PlaySE(3050);

					if (this.flag5.shot)
					{
						this.flag5.shot.func[1].call(this.flag5.shot);
					}

					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.05000000, 0.50000000);

						if (this.count == 300)
						{
							this.com_flag1 = 0;
							this.DS2_Change_Slave(null);
							return;
						}
					};
				}
			};
		}
	];
	return true;
}

function DS2_Change_Slave( t )
{
	this.LabelClear();
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.team.slave.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream_Short(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.DS2_Step(null);
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Slave_Reimu_1()
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

function Slave_Attack_Reimu( t )
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
	this.flag5.charge <- null;
	this.flag5.shotNum <- 6;
	this.flag5.shotRot <- 1.04719746;
	this.flag5.chargeCount <- 120;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0.00000000;
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
		this.flag5.shotNum = 8;
		this.flag5.shotRot = 0.78539813;
		this.flag5.chargeCount = 60;
		break;

	case 2:
		this.flag5.shotNum = 10;
		this.flag5.shotRot = 36 * 0.01745329;
		this.flag5.chargeCount = 60;
		break;

	case 3:
	case 4:
		this.flag5.shotNum = 12;
		this.flag5.shotRot = 0.52359873;
		this.flag5.chargeCount = 60;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.abs(this.eagle.x - this.x) <= 25 && this.abs(this.eagle.y - (this.y - 85)) <= 25)
				{
					this.centerStop = -2;
					this.SetMotion(this.motion, 2);
					this.PlaySE(3039);
					this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
					this.count = 0;
					this.stateLabel = function ()
					{
						this.VX_Brake(0.15000001, -2.00000000 * this.direction);
						this.SetSpeed_XY(null, (200 - this.y) * 0.05000000);
						this.eagle.x = this.x;
						this.eagle.y = this.y - 105;

						if (this.count == 120)
						{
							this.eagle.Eagle_PreAssult_Boss(null);
							this.stateLabel = function ()
							{
								this.VX_Brake(this.va.x * this.direction <= -2.00000000 ? 0.15000001 : 0.01000000);
								this.SetSpeed_XY(null, (200 - this.y) * 0.05000000);
								this.eagle.x = this.point0_x;
								this.eagle.y = this.point0_y;
							};
						}
					};
					return;
				}
			};
		},
		null,
		null,
		function ()
		{
			if (this.flag5.charge)
			{
				this.flag5.charge.func();
			}

			this.flag5.charge = null;
			this.count = 0;
			this.centerStop = -2;
			this.SetSpeed_XY(-10.00000000 * this.direction, -10.00000000);
			local t_ = {};
			t_.direction <- this.direction;
			this.eagle.Eagle_Assult_Boss(t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction < -3.00000000 ? 0.50000000 : 0.02500000);
				this.AddSpeed_XY(0.00000000, this.va.y < -1.00000000 ? 0.50000000 : 0.02500000);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.30000001);

				if (this.y >= this.centerY)
				{
					this.SetMotion(this.motion, 8);
					this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.Vec_Brake(1.00000000);

						if (this.count == this.flag5.chargeCount)
						{
							this.Change_Master_Reimu(null);
							return;
						}
					};
				}
			};
		}
	];
	this.eagle.Eagle_Catch_Boss(null);
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Reimu( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1_Move();
}

