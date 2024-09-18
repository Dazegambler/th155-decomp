function Master_Spell_1()
{
	this.team.slave.Slave_Reimu_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.com_flag3 = [];
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
					this.Master_Spell_1_Attack();
				}
			};
		}
		else
		{
			this.va.SetLength(this.flag5.moveV);
			this.ConvertTotalSpeed();
			this.Boss_WalkMotionUpdate(this.va.x);
		}
	};
}

function Master_Spell_1_Attack()
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.com_flag2++;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCycle <- 30;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.scale <- 1.50000000;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.colorCycle <- 0;
	this.flag5.charge <- this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.com_flag3 = [];
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
		this.flag5.scale = 2.00000000;
		break;

	case 2:
		this.flag5.shotCycle = 15;
		this.flag5.scale = 2.25000000;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 10;
		this.flag5.scale = 2.50000000;
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
		this.Vec_Brake(0.75000000);
	};
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
			this.flag5.shotRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount % this.flag5.shotCycle == 1)
				{
					this.PlaySE(1156);
					local t_ = {};
					t_.type <- this.flag5.colorCycle % 3;
					t_.stop <- false;

					if (this.flag5.colorCycle % 4 == 1)
					{
						t_.stop = true;
					}

					t_.rot <- this.flag5.shotRot;
					t_.scale <- this.flag5.scale;
					this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_1, t_);
					this.flag5.colorCycle++;
				}

				this.flag5.shotRot += 0.08726646;

				if (this.flag5.shotCount >= 270)
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
	this.direction = this.x > 640 ? -1.00000000 : 1.00000000;
	this.SetMotion(4991, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.flag5.shotRot <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.x = 640 + (180 + this.rand() % 120) * this.direction;
	this.flag5.pos.y = 360 - this.rand() % 80;
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		this.flag5.moveV += 0.25000000;

		if (this.flag5.moveV > 15.00000000)
		{
			this.flag5.moveV = 15.00000000;
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

				if (this.Vec_Brake(0.75000000))
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
			this.Boss_WalkMotionUpdate(this.va.x);
		}
	};
}

function S1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Reimu(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2()
{
	this.team.slave.Slave_Reimu_2();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = null;
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

					this.Master_Spell_2_Start(null);
					this.boss_cpu = function ()
					{
						if (this.Cancel_Check(10))
						{
							if (this.team.shield == null)
							{
								this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
							}

							this.Master_Spell_2_Attack(null);
							return;
						}
					};
				}
			};
		}
	};
	return true;
}

function Master_Spell_2_Attack( t )
{
	local r_ = this.rand() % 3;
	this.com_flag1++;

	if (this.com_flag1 >= 4)
	{
		this.com_flag1 = 0;
		this.M2_Change_Slave(null);
		return true;
	}

	switch(r_)
	{
	case 0:
		this.Master_Spell_2_A(t);
		break;

	case 1:
		this.Master_Spell_2_A2(t);
		break;

	case 2:
		this.Master_Spell_2_A3(t);
		break;
	}

	if (this.com_flag1 == 3)
	{
		this.com_flag2 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	}

	this.lavelClearEvent = function ()
	{
		if (this.com_flag2)
		{
			this.com_flag2.func();
		}

		this.com_flag2 = null;
	};
	return true;
}

function Master_Spell_2_A( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(4993, 0);
	this.stateLabel = function ()
	{
		this.subState();
	};
	this.subState = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.centerStop = -3;

			if (this.direction == 1.00000000 && this.x < ::battle.corner_left + 200 || this.direction == -1.00000000 && this.x > ::battle.corner_right - 200)
			{
				this.SetSpeed_XY(12.00000000 * this.direction, -19.50000000);
			}
			else
			{
				this.SetSpeed_XY(-3.50000000 * this.direction, -19.50000000);
			}

			this.count = 0;
			this.subState = function ()
			{
				this.CenterUpdate(1.00000000, null);

				if (this.count == 18)
				{
					this.Master_Spell_2_SideSlash(null);
				}
			};
		}
	];
	return true;
}

function Master_Spell_2_A2( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetMotion(4994, 0);
	this.GetFront();
	this.stateLabel = function ()
	{
		this.subState();
	};
	this.subState = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.centerStop = 3;

			if (this.direction == 1.00000000 && this.x < ::battle.corner_left + 200 || this.direction == -1.00000000 && this.x > ::battle.corner_right - 200)
			{
				this.SetSpeed_XY(12.00000000 * this.direction, 19.50000000);
			}
			else
			{
				this.SetSpeed_XY(-3.50000000 * this.direction, 19.50000000);
			}

			this.count = 0;
			this.subState = function ()
			{
				this.CenterUpdate(1.00000000, null);

				if (this.count == 18)
				{
					this.Master_Spell_2_SideSlash(null);
				}
			};
		}
	];
	return true;
}

function Master_Spell_2_A3( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4996, 0);
	this.GetFront();

	if (this.direction == 1.00000000 && this.x < ::battle.corner_left + 200 || this.direction == -1.00000000 && this.x > ::battle.corner_right - 200)
	{
		this.Master_Spell_2_A4(t);
		return;
	}

	this.stateLabel = function ()
	{
		this.subState();
	};
	this.PlaySE(801);
	this.centerStop = -3;
	this.SetSpeed_XY(-10.00000000 * this.direction, -4.50000000);
	this.count = 0;
	this.subState = function ()
	{
		this.VX_Brake(0.10000000);
		this.CenterUpdate(0.30000001, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.count = 0;
			this.subState = function ()
			{
				this.CenterUpdate(0.50000000, null);

				if (this.count == 14)
				{
					this.Master_Spell_2_V_Slash(null);
					return;
				}

				this.VX_Brake(0.50000000);
			};
		}
	};
	this.keyAction = [
		function ()
		{
		},
		null,
		null,
		function ()
		{
			this.Master_Spell_2_V_Slash(null);
		}
	];
	return true;
}

function Master_Spell_2_A4( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4995, 0);
	this.GetFront();
	this.stateLabel = function ()
	{
		this.subState();
	};
	this.PlaySE(801);
	this.SetSpeed_XY(13.50000000 * this.direction, 0.00000000);
	this.count = 0;
	this.subState = function ()
	{
		this.VX_Brake(0.50000000, 10.00000000 * this.direction);
		this.CenterUpdate(0.50000000, null);

		if (this.count >= 30)
		{
			this.SetMotion(this.motion, 3);
			this.count = 0;
			this.subState = function ()
			{
				this.CenterUpdate(0.50000000, null);

				if (this.count == 10)
				{
					this.Master_Spell_2_V_Slash(null);
					return;
				}

				this.VX_Brake(0.50000000);
			};
		}
	};
	this.keyAction = [
		function ()
		{
		},
		null,
		null,
		function ()
		{
			this.Master_Spell_2_V_Slash(null);
		}
	];
	return true;
}

function Master_Spell_2_SideSlash( t )
{
	this.LabelReset();
	this.HitReset();
	this.GetFront();
	this.SetMotion(4931, 0);
	this.stateLabel = function ()
	{
		this.subState();
	};
	this.subState = function ()
	{
		this.CenterUpdate(0.50000000, null);
	};
	this.keyAction = [
		function ()
		{
			local t_ = {};
			t_.rot <- 0 * 0.01745329;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_SlashEffect, t_);
			this.PlaySE(1130);
			this.centerStop = this.y < this.centerY ? -3 : 3;
			this.SetSpeed_XY(-10.00000000 * this.direction, this.y < this.centerY ? -1.00000000 : 1.00000000);
			this.count = 0;
			local t_ = {};
			t_.rot2 <- -1.00000000;

			if (this.y < this.centerY)
			{
				t_.rot2 <- 1.00000000;
			}

			this.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_SideSlashCore, t_, null));
			this.subState = function ()
			{
				this.CenterUpdate(0.02000000, null);
				this.VX_Brake(0.60000002, -1.00000000 * this.direction);
				local r_ = this.team.life / this.team.life_max.tofloat();
				local c_ = 60;

				if (this.count >= c_)
				{
					this.SetMotion(4931, 5);
					this.subState = function ()
					{
						this.CenterUpdate(0.50000000, null);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(4931, 8);
							this.subState = function ()
							{
								this.VX_Brake(0.50000000);
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
		null,
		null,
		function ()
		{
			this.Master_Spell_2_Attack(null);
		}
	];
}

function Master_Spell_2_V_Slash( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4932, 0);
	this.GetFront();
	this.stateLabel = function ()
	{
		this.subState();
	};
	this.subState = function ()
	{
		this.VX_Brake(0.50000000);
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(1130);
			local t_ = {};
			t_.rot <- 90 * 0.01745329;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_SlashEffect, t_);
			this.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_V_SlashCore, {}));
		},
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				local r_ = this.team.life / this.team.life_max.tofloat();
				local c_ = 60;

				if (this.count >= c_)
				{
					this.SetMotion(4932, 4);
					this.subState = function ()
					{
					};
				}
			};
		},
		null,
		function ()
		{
			this.Master_Spell_2_Attack(null);
		}
	];
}

function Master_Spell_2_MAX( t )
{
	if (!this.Cancel_Check(10, 0, 0))
	{
		return false;
	}

	this.SetMotion(4933, 0);
	this.LabelReset();
	this.HitReset();
	this.SetSpeed_XY(-12.50000000 * this.direction, 0.00000000);
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.flag1 = null;
	};
	this.PlaySE(849);
	this.flag1 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.va.x * this.direction < -2.00000000)
				{
					this.VX_Brake(1.25000000);
				}
				else
				{
					this.VX_Brake(0.02500000);
				}

				if (this.count == 60)
				{
					this.PlaySE(1130);
					this.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_CoreB, {}));
					local t_ = {};
					t_.rot <- 90 * 0.01745329;
					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_SlashEffect, t_);
					this.count = 0;
					this.SetMotion(4933, 2);
					this.stateLabel = function ()
					{
						if (this.va.x * this.direction < -2.00000000)
						{
							this.VX_Brake(1.25000000);
						}
						else
						{
							this.VX_Brake(0.02500000);
						}
					};
				}
			};
		},
		null,
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func();
			}

			this.flag1 = null;
			this.lavelClearEvent = null;
			this.count = 0;
			this.SetSpeed_XY(12.50000000 * this.direction, 0.00000000);
			this.stateLabel = function ()
			{
				this.VX_Brake(1.25000000);
				local r_ = this.team.life / this.team.life_max.tofloat();
				local c_ = 90;

				if (this.count >= c_)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Spell_2_Attack(null);
		}
	];
	this.stateLabel = function ()
	{
		if (this.va.x * this.direction < -2.00000000)
		{
			this.VX_Brake(1.25000000);
		}
		else
		{
			this.VX_Brake(0.02500000);
		}
	};
	return true;
}

function Master_Spell_2_Start( t )
{
	this.SetMotion(4930, 0);
	this.LabelClear();
	this.HitReset();
	this.GetFront();
	this.count = 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.stateLabel = function ()
	{
		this.subState();
	};
	this.subState = function ()
	{
		this.CenterUpdate(0.50000000, null);
	};
	this.keyAction = [
		function ()
		{
			this.centerStop = -3;
			this.SetSpeed_XY(-7.50000000 * this.direction, -11.00000000);
			this.count = 0;
			this.PlaySE(1130);
			this.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_CoreA, {}));
			local t_ = {};
			t_.rot <- 90 * 0.01745329;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_SlashEffect, t_);
			this.subState = function ()
			{
				if (this.Vec_Brake(0.75000000, 1.00000000))
				{
					this.subState = function ()
					{
						this.CenterUpdate(0.02000000, null);

						if (this.count >= 60 + 60 * (this.team.life / this.team.life_max.tofloat()))
						{
							this.SetMotion(4930, 4);
							this.subState = function ()
							{
								this.CenterUpdate(0.34999999, null);

								if (this.centerStop * this.centerStop <= 1)
								{
									this.SetMotion(4930, 7);
									this.subState = function ()
									{
										this.VX_Brake(0.50000000);
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
		null,
		function ()
		{
			this.Master_Spell_2_Attack(null);
		}
	];
	return true;
}

function Master_Spell_2_UpperSlash( t )
{
	this.SetMotion(4930, 0);
	this.LabelReset();
	this.HitReset();
	this.GetFront();
	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0.25000000);
		}
	};
	this.keyAction = function ()
	{
	};
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Reimu_2(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_3()
{
	this.team.slave.Slave_Dream_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.com_flag3 = [];
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

					this.MS3_Attack();
				}
			};
		}
	};
	return true;
}

function MS3_Attack()
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.com_flag2++;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCycle <- 20;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.rotCycle <- -135 * 0.01745329;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.colorCycle <- 0;
	this.flag5.charge <- this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
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
		this.flag5.shotCycle = 10;
		break;

	case 2:
		this.flag5.shotCycle = 8;
		break;

	case 3:
	case 4:
		this.flag5.shotCycle = 5;
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
		this.Vec_Brake(0.75000000);
	};
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

			this.flag5.moveCount = 0;
			this.subState[0] = function ()
			{
				this.flag5.moveCount++;
				this.Vec_Brake(0.02500000);

				if (this.flag5.moveCount >= 180)
				{
					this.flag5.moveCount = 0;
					this.SetSpeed_Vec(3.00000000, this.rand() % 31 * 0.01745329, 1.00000000);

					if (this.x > ::battle.corner_right - 200 || this.rand() % 100 <= 49 && this.x < ::battle.corner_right - 200)
					{
						this.va.x *= -1;
					}

					if (this.y > this.centerY + 125 || this.rand() % 100 <= 49 && this.y < this.centerY - 125)
					{
						this.va.y *= -1;
					}

					this.ConvertTotalSpeed();
				}
			};
			this.flag5.charge = null;
			this.flag5.shotCount = 0;
			this.flag5.shotRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;
				this.flag5.rotCycle += 0.05235988;

				if (this.flag5.shotCount % this.flag5.shotCycle == 1)
				{
					this.PlaySE(1156);
					local v_ = this.Vector3();
					v_.x = this.cos(this.flag5.rotCycle) * 100;
					v_.y = this.sin(this.flag5.rotCycle * 2) * 50;
					this.flag5.colorCycle++;
					local t_ = {};
					t_.rot <- this.atan2(v_.y, v_.x);
					t_.type <- this.flag5.colorCycle % 3;
					t_.v <- 2 + v_.Length() * 0.12500000;
					this.SetLightShot(this.x + v_.x * this.direction, this.y + v_.y, this.direction, this.Boss_Shot_3, t_);
				}

				if (this.flag5.shotCount == 390)
				{
					this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.flag5.shotCount >= 480)
				{
					this.M3_Change_Slave(null);
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

function M3_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.MS3_Attack();
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

function Slave_Marisa_1()
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

function Slave_Move_Marisa( t )
{
	this.LabelClear();
	this.flag1 = this.Vector3();
	this.flag2 = 0.00000000;
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < 640 && this.target.x < 640)
	{
		this.flag1.x = ::battle.corner_right - 128 - this.rand() % 200;
	}
	else if (this.x > 640 && this.target.x > 640)
	{
		this.flag1.x = ::battle.corner_left + 128 + this.rand() % 200;
		this.flag1.y = this.centerY + 150 - this.rand() % 300;
	}
	else if (this.x < ::battle.corner_left + 200)
	{
		this.flag1.x = this.x + 160 + this.rand() % 100;
	}
	else if (this.x > ::battle.corner_right - 200)
	{
		this.flag1.x = this.x - 160 - this.rand() % 100;
	}
	else
	{
		this.flag1.x = this.x + (160 + this.rand() % 100) * (1 - 2 * this.rand() % 2);
	}

	this.flag1.y = this.centerY + 150 - this.rand() % 300;
	this.flag3 = true;
	this.stateLabel = function ()
	{
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

		this.Boss_WalkMotionUpdate(this.va.x);

		if (v_ <= 7.00000000 || this.count >= 60)
		{
			this.flag3 = 0.00000000;
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0.33000001))
				{
					this.Slave_Attack_Marisa(null);
					return;
				}

				this.Boss_WalkMotionUpdate(0);
			};
		}
	};
}

function Slave_Attack_Marisa( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.com_flag2++;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCount <- 3;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.addRot <- 2.09439468;
	this.flag5.colorCycle <- 0;
	this.flag5.charge <- this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.com_flag3 = [];
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
		this.flag5.shotCount = 6;
		this.flag5.addRot = 1.04719746;
		break;

	case 2:
		this.flag5.shotCount = 8;
		this.flag5.addRot = 0.78539813;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 10;
		this.flag5.addRot = 36 * 0.01745329;
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
		this.Vec_Brake(0.75000000);
	};
	this.subState[1] = function ()
	{
		this.flag5.chargeCount--;

		if (this.flag5.chargeCount <= 0)
		{
			this.SetMotion(4910, 2);
			this.subState[1] = function ()
			{
			};
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
			this.flag5.shotRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.count = 0;
			this.subState[1] = function ()
			{
				if (this.count % 5 == 1 && this.flag5.shotCount > 0)
				{
					this.PlaySE(1156);
					local t_ = {};
					t_.type <- this.flag5.colorCycle % 3;
					t_.rot <- this.flag5.shotRot;
					t_.wait <- 60;
					this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3, t_);
					this.flag5.colorCycle++;
					this.flag5.shotCount--;
					this.flag5.shotRot += this.flag5.addRot;
				}

				if (this.count == 180)
				{
					this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count >= 240)
				{
					this.Change_Master_Marisa(null);
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

function Change_Master_Marisa( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1_Move(null);
}

function Slave_Futo_1()
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

function Slave_Attack_Futo( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.com_flag2++;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCount <- 3;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.addRot <- 2.09439468;
	this.flag5.colorCycle <- 0;
	this.flag5.charge <- this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.com_flag3 = [];
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
		this.flag5.shotCount = 6;
		this.flag5.addRot = 1.04719746;
		break;

	case 2:
		this.flag5.shotCount = 8;
		this.flag5.addRot = 0.78539813;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 10;
		this.flag5.addRot = 36 * 0.01745329;
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
		this.Vec_Brake(0.75000000);
	};
	this.subState[1] = function ()
	{
		this.flag5.chargeCount--;

		if (this.flag5.chargeCount <= 0)
		{
			this.SetMotion(4910, 2);
			this.subState[1] = function ()
			{
			};
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
			this.flag5.shotRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.count = 0;
			this.subState[1] = function ()
			{
				if (this.count % 5 == 1 && this.flag5.shotCount > 0)
				{
					this.PlaySE(1156);
					local t_ = {};
					t_.type <- this.flag5.colorCycle % 3;
					t_.rot <- this.flag5.shotRot;
					t_.wait <- 60;
					this.SetLightShot(this.x, this.y, this.direction, this.Boss_Shot_SL3, t_);
					this.flag5.colorCycle++;
					this.flag5.shotCount--;
					this.flag5.shotRot += this.flag5.addRot;
				}

				if (this.count >= 300)
				{
					this.Change_Master_Futo(null);
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

function Change_Master_Futo( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1_Attack(null);
}

function Slave_Kasen_1()
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

function Slave_Attack_Kasen( t )
{
	this.LabelClear();
	this.SetMotion(4911, 1);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.com_flag2++;
	this.GetFront();
	this.flag5 = {};
	this.flag5.shotCount <- 3;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.addRot <- 2.09439468;
	this.flag5.colorCycle <- 0;
	this.flag5.charge <- null;
	this.com_flag3 = [];
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
		this.flag5.shotCount = 6;
		this.flag5.addRot = 1.04719746;
		break;

	case 2:
		this.flag5.shotCount = 8;
		this.flag5.addRot = 0.78539813;
		break;

	case 3:
	case 4:
		this.flag5.shotCount = 10;
		this.flag5.addRot = 36 * 0.01745329;
		break;
	}

	this.SetSpeed_Vec(17.50000000, (-150 - this.rand() % 60) * 0.01745329, this.direction);
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
		this.Vec_Brake(0.30000001);
	};
	this.subState[1] = function ()
	{
		this.flag5.chargeCount--;

		if (this.flag5.chargeCount <= 0)
		{
			this.SetMotion(4910, 2);
			this.subState[1] = function ()
			{
			};
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
			this.flag5.shotRot = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.count = 0;
			this.subState[1] = function ()
			{
				if (this.count % 5 == 1 && this.flag5.shotCount > 0)
				{
					this.PlaySE(1156);
					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					this.team.master.SetLightShot(this.x, this.y, this.direction, this.team.master.Boss_Shot_MS2_Reimu, t_);
					this.flag5.colorCycle++;
					this.flag5.shotCount--;
					this.flag5.shotRot += this.flag5.addRot;
				}

				if (this.count == 150)
				{
					this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count >= 270)
				{
					this.Change_Master_Kasen(null);
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

function Change_Master_Kasen( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.MS2_Step(null);
}

function Slave_Kasen_3()
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

function Slave_Attack_Kasen3( t )
{
	this.LabelClear();
	this.SetMotion(4960, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.HitReset();
	this.direction = this.team.master.direction;
	this.flag5 = {};
	this.flag5.shotCount <- 3;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.addRot <- 2.09439468;
	this.flag5.colorCycle <- 0;
	this.flag5.charge <- null;
	this.com_flag3 = [];
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
		break;

	case 2:
		break;

	case 3:
	case 4:
		break;
	}

	if (this.GetFront())
	{
		this.SetSpeed_XY(-8.00000000 * this.direction, -19.50000000);
	}
	else
	{
		this.SetSpeed_XY(2.00000000 * this.direction, -19.50000000);
	}

	this.centerStop = -3;
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000, 0.50000000);
			};
		},
		function ()
		{
			this.SetSpeed_Vec(10.00000000, 1.04719746, this.direction);
			this.team.master.flag5.shot.direction = this.direction;
			this.team.master.flag5.shot.func[2].call(this.team.master.flag5.shot);
			this.count = 0;
			this.PlaySE(1163);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.75000000, 0.50000000);

				if (this.count == 120)
				{
					this.SetMotion(4960, 4);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.34999999, 10.00000000);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(4960, 7);
							this.stateLabel = function ()
							{
								this.CenterUpdate(0.50000000, null);
								this.VX_Brake(0.50000000);
							};
							this.keyAction = function ()
							{
								this.Change_Master_Kasen3(null);
							};
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, 0.34999999);
	};
}

function Slave_Attack2_Kasen3( t )
{
	this.LabelClear();
	this.SetMotion(4961, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.HitReset();
	this.direction = this.team.master.direction;
	this.flag5 = {};
	this.flag5.shotCount <- 3;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.addRot <- 2.09439468;
	this.flag5.colorCycle <- 0;
	this.flag5.charge <- null;
	this.com_flag3 = [];
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
		break;

	case 2:
		break;

	case 3:
	case 4:
		break;
	}

	if (this.GetFront())
	{
		this.SetSpeed_XY(-15.00000000 * this.direction, -3.00000000);
		this.stateLabel = function ()
		{
			this.VX_Brake(0.20000000, -3.50000000 * this.direction);
			this.AddSpeed_XY(0.00000000, 0.07500000);
		};
	}
	else
	{
		this.SetSpeed_XY(3.50000000 * this.direction, -3.00000000);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, 0.07500000);
		};
	}

	this.centerStop = -3;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_Vec(10.00000000, -160 * 0.01745329, this.direction);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000, 0.50000000);
			};
		},
		function ()
		{
			this.team.master.flag5.shot.direction = this.direction;
			this.team.master.flag5.shot.func[3].call(this.team.master.flag5.shot);
			this.count = 0;
			this.PlaySE(1163);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
			this.stateLabel = function ()
			{
				if (this.count <= 30)
				{
					this.Vec_Brake(1.00000000, 0.50000000);
				}
				else
				{
					this.CenterUpdate(0.05000000, 1.50000000);
				}

				if (this.count == 90)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0.34999999, 10.00000000);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(this.motion, 6);
							this.stateLabel = function ()
							{
								this.CenterUpdate(0.50000000, null);
								this.VX_Brake(0.50000000);
							};
							this.keyAction = function ()
							{
								this.Change_Master_Kasen3(null);
							};
						}
					};
				}
			};
		}
	];
}

function Change_Master_Kasen3( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.MS3_Step(null);
}

function Slave_Mokou_2()
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

function Slave_Attack_Mokou2( t )
{
	this.LabelClear();
	this.SetMotion(4910, 2);
	::camera.Shake(10.00000000);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 50;
	this.flag5.shotNum <- 1;
	this.flag5.shotWay <- 8;
	this.flag5.shotRot <- 0.00000000;
	this.flag5.shotRotAdd <- 0.78539813;
	this.flag5.wait <- 180;
	this.flag5.dir <- this.direction;
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
		this.flag5.shotNum = 2;
		break;

	case 2:
		this.flag5.shotNum = 3;
		break;

	case 3:
	case 4:
		this.flag5.shotNum = 4;
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
			this.count = 0;
			this.stateLabel = function ()
			{
				this.team.life += 2;

				if (this.team.life > this.team.regain_life)
				{
					this.team.life = this.team.regain_life;
				}

				if (this.flag5.shotNum > 0 && this.count % this.flag5.shotCycle == 1)
				{
					this.PlaySE(1156);

					for( local i = 0; i < this.flag5.shotWay; i++ )
					{
						local t_ = {};
						t_.rot <- i * this.flag5.shotRotAdd;
						this.team.master.SetLightShot(this.x, this.y, this.flag5.dir, this.team.master.Boss_Shot_M2_Reimu, t_);
					}

					this.flag5.shotNum--;
					this.flag5.dir *= -1.00000000;
				}

				if (this.flag5.shotNum <= 0)
				{
					this.flag5.wait--;

					if (this.flag5.wait <= 0)
					{
						this.Change_Master_Mokou2(null);
						return;
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Mokou2( t )
{
	this.LabelClear();
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.MS2_Charge(null);
}

function Slave_Yukari_1()
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

function Slave_Attack_Yukari( t )
{
	this.LabelClear();
	this.SetMotion(4910, 2);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 3;
	this.flag5.shotNum <- 6;
	this.flag5.shotRot <- 0.00000000;
	this.flag5.shotRotAdd <- 1.04719746;
	this.flag5.wait <- 150;
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
		this.flag5.shotNum = 8;
		this.flag5.shotRotAdd = 0.78539813;
		break;

	case 2:
		this.flag5.shotNum = 10;
		this.flag5.shotRotAdd = 36 * 0.01745329;
		break;

	case 3:
		this.flag5.shotNum = 12;
		this.flag5.shotRotAdd = 0.52359873;
		break;

	case 4:
		this.flag5.shotNum = 12;
		this.flag5.shotRotAdd = 0.52359873;
		break;
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(1155);
			this.SetFreeObject(this.point2_x, this.point2_y, this.direction, this.SpellShot_A_Bou, {});
		},
		function ()
		{
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag5.shotNum > 0 && this.count % this.flag5.shotCycle == 1)
				{
					this.PlaySE(1156);
					local t_ = {};
					t_.rot <- this.flag5.shotRot;
					this.flag5.shotRot += this.flag5.shotRotAdd;
					this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_SL1, t_);
					this.flag5.shotNum--;

					if (this.flag5.shotNum <= 0)
					{
						this.count = 0;
						this.stateLabel = function ()
						{
							if (this.count >= 180)
							{
								this.Change_Master_Yukari(null);
								return;
							}
						};
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Change_Master_Yukari( t )
{
	this.LabelClear();
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_1B_Move();
}

function Slave_Attack_Yukari2( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4921, 0);
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.count = 0;
	this.flag1 = 0.00000000;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotNum <- 2;
	this.flag5.shotWay <- 3.14159203;
	this.flag5.shotCycle <- 10;
	this.flag5.shotCount <- 120;
	this.flag5.shotRot <- 0;
	this.flag5.shotRotSpeed <- 0.26179937;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 120;
		break;

	case 2:
		this.flag5.shotNum = 3;
		this.flag5.shotWay = 2.09439468;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 180;
		break;

	case 3:
	case 4:
		this.flag5.shotNum = 4;
		this.flag5.shotWay = 1.57079601;
		this.flag5.shotCycle = 5;
		this.flag5.shotCount = 240;
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(4430);
			local pos_ = this.Vector3();
			pos_.x = 100.00000000;
			pos_.RotateByRadian(this.flag5.shotRot);

			for( local i = 0; i < this.flag5.shotNum; i++ )
			{
				local t_ = {};
				t_.rot <- this.flag5.shotRot;
				this.SetLightShot(this.x + pos_.x * this.direction, this.y + pos_.y, this.direction, this.Boss_Shot_SL2, t_);
				pos_.RotateByRadian(this.flag5.shotWay);
				this.flag5.shotRot += this.flag5.shotWay;
			}

			this.flag5.shotRot += this.flag5.shotRotSpeed;
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0.50000000;

		if (this.flag1 > 10.00000000)
		{
			this.flag1 = 10.00000000;
		}

		this.va.x = (640 - this.x) * 0.10000000;
		this.va.y = (200 - this.y) * 0.10000000;

		if (this.va.Length() >= this.flag1)
		{
			this.va.SetLength(this.flag1);
		}

		this.ConvertTotalSpeed();

		if (this.count % this.flag5.shotCycle == 1)
		{
			this.func[0].call(this);
		}

		if (this.count == this.flag5.shotCount)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count == this.flag5.shotCount + 90)
		{
			this.Change_Master2_Yukari(null);
			return;
		}
	};
}

function Change_Master2_Yukari( t )
{
	this.LabelClear();
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_2B_FastAttack(null);
}

