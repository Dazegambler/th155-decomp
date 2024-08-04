function Master_Spell_1()
{
	this.team.slave.Slave_Mokou_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
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
	this.Master_Spell_1_Charge(null);
}

function Master_Spell_1_Charge( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4960, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
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
	this.flag5.shotCount <- 180;
	this.count = 0;

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

	this.stateLabel = function ()
	{
		if (this.count == this.flag5.shotCount)
		{
			this.Master_Spell_1_Attack(null);
			return;
		}
	};
}

function Master_Spell_1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4951, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.occultCount = 0;
	this.flag2 = null;
	this.flag3 = 0,10000000.0;
	this.flag4 = ::manbow.Actor2DProcGroup();
	this.flag5 = {};
	this.flag5.priority <- 220;
	this.flag5.size <- 1,50000000.0;
	this.flag5.level <- 0;
	this.flag5.charge <- null;
	this.flag5.shotCycle <- 20;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 10;
		this.flag5.size = 2,00000000.0;
		break;

	case 2:
		this.flag5.shotCycle = 8;
		this.flag5.size = 2,50000000.0;
		break;

	case 3:
		this.flag5.shotCycle = 6;
		this.flag5.size = 3,00000000.0;

	case 4:
		this.flag5.shotCycle = 5;
		this.flag5.size = 3,00000000.0;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag5.charge)
		{
			this.flag5.charge.func();
		}

		this.flag5.charge = null;
	};
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3269);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.count = 0;
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, this.va.y > -7,50000000.0 ? -0,25000000.0 : 0,00000000.0);

				if (this.y < this.centerY - 200)
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
				}

				if (this.count % 6 == 1)
				{
					local t_ = {};
					t_.scale <- this.flag5.size;
					t_.occult <- false;
					this.flag4.Add(this.SetFreeObjectDynamic(this.x, ::battle.scroll_bottom - this.rand() % 360, this.direction, this.SPShot_E_Vortex, t_));
				}

				if (this.count >= 35)
				{
					this.SetMotion(this.motion, 3);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, this.va.y > -15,00000000.0 ? -0,75000000.0 : 0,00000000.0);

						if (this.y < this.centerY - 200)
						{
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
						}

						if (this.count % 6 == 1)
						{
							local t_ = {};
							t_.scale <- this.flag5.size;
							t_.occult <- false;
							this.flag4.Add(this.SetFreeObjectDynamic(this.x, ::battle.scroll_bottom - this.rand() % 360, this.direction, this.SPShot_E_Vortex, t_));
						}

						if (this.count == 90)
						{
							this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.count == 150)
						{
							this.PlaySE(3272);
							this.flag4.Foreach(function ()
							{
								this.func[0].call(this);
							});
							this.M1_Change_Slave(null);
							return;
						}

						if (this.flag5.shotCycle > 0 && this.count % this.flag5.shotCycle == 1)
						{
							local d_ = 1,00000000.0 - this.rand() % 2 * 2;
							this.SetShot(this.x + this.rand() % 128 * this.direction, ::battle.scroll_bottom + 50, d_, this.Boss_Shot_M1_Fall, {});
						}

						if (this.count % 5 == 1)
						{
							local t_ = {};
							t_.take <- 4 + this.rand() % 4;
							t_.occult <- false;

							if (this.count % 4 <= 1)
							{
								this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, this.SPShot_E_FirePart, t_);
							}
							else
							{
								this.SetFreeObject(this.x, ::battle.scroll_bottom, -this.direction, this.SPShot_E_FirePart, t_);
							}
						}

						if (this.count % 10 == 1)
						{
							local t_ = {};
							t_.scale <- this.flag5.size;
							this.flag2 = this.SetShot(this.x, ::battle.scroll_bottom + 1024, 1,00000000.0 - this.rand() % 2 * 2, this.Boss_Shot_M1_Pilar, t_).weakref();
						}
					};
					return;
				}

				if (this.count % 5 == 1)
				{
					local t_ = {};
					t_.take <- 4 + this.rand() % 4;
					t_.occult <- false;

					if (this.count % 4 <= 1)
					{
						this.SetFreeObject(this.x, ::battle.scroll_bottom, this.direction, this.SPShot_E_FirePart, t_);
					}
					else
					{
						this.SetFreeObject(this.x, ::battle.scroll_bottom, -this.direction, this.SPShot_E_FirePart, t_);
					}
				}

				if (this.count % 10 == 1)
				{
					local t_ = {};
					t_.scale <- this.flag5.size;
					this.flag2 = this.SetShot(this.x, ::battle.scroll_bottom + 1024, 1,00000000.0 - this.rand() % 2 * 2, this.Boss_Shot_M1_Pilar, t_).weakref();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
		this.CenterUpdate(0,10000000.0, 2,00000000.0);
	};
	return true;
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Mokou(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2()
{
	this.team.slave.Slave_Mokou_2();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
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

					this.MS2_Start();
				}
			};
		}
	};
	return true;
}

function MS2_Start()
{
	this.MS2_Charge(null);
}

function MS2_Charge( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4960, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
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
	this.flag5.shotCount <- 90;
	this.count = 0;

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

	this.stateLabel = function ()
	{
		if (this.count == this.flag5.shotCount)
		{
			this.MS2_Attack(null);
			return;
		}
	};
}

function MS2_Attack( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.pos <- this.Vector3();
	this.flag5.backFire <- null;
	this.flag5.shotDirA <- 1,00000000.0;
	this.flag5.handFire <- null;
	this.flag5.addPos <- this.Vector3();
	this.flag5.maxV <- 0,00000000.0;
	this.flag5.height <- 0;
	this.flag5.homing <- true;
	this.flag5.homingRot <- 0,00000000.0;
	this.flag5.cycle <- 0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.homingRot = 0,20000000.0 * 0,01745329.0;
		break;

	case 2:
		this.flag5.homingRot = 0,30000001.0 * 0,01745329.0;
		break;

	case 3:
		this.flag5.homingRot = 0,40000001.0 * 0,01745329.0;
		break;

	case 4:
		this.flag5.homingRot = 0,50000000.0 * 0,01745329.0;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag1 = null;
	};
	this.func = [
		function ()
		{
			this.count = 0;
			this.SetMotion(4961, 0);
			this.keyAction = function ()
			{
				this.freeMap = true;
				this.keyAction = null;
				this.flag5.handFire = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_M2_BodyFire_Core, {}, this.weakref());
				this.count = 0;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, -0,50000000.0);

					if (this.y < this.centerY - 50)
					{
						this.stateLabel = function ()
						{
							if (this.count >= 30)
							{
								if (this.count % 3 == 1)
								{
									this.SetFreeObject(this.x, this.y, this.direction, this.Climax_Shadow2, {});
								}

								if (this.keyTake != 3)
								{
									this.masterAlpha -= 0,02500000.0;

									if (this.masterAlpha <= 0,00000000.0)
									{
										this.SetMotion(this.motion, 3);
										this.masterAlpha = 1,00000000.0;
									}
								}
							}

							if (this.count == 80)
							{
								this.func[1].call(this);
								return;
							}

							this.VY_Brake(0,75000000.0);
						};
					}
				};
			};
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.count = 0;
			this.flag5.cycle = 3;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, -0,25000000.0, 0,00000000.0, -2,50000000.0);

				if (this.count == 30)
				{
					this.stateLabel = function ()
					{
						if (this.team.life > 1)
						{
							this.team.life--;
						}

						this.AddSpeed_XY(0,00000000.0, -0,75000000.0, 0,00000000.0, -25,00000000.0);

						if (this.y < ::battle.scroll_top - 600)
						{
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

							if (this.count == 120)
							{
								::camera.lock = false;
								::camera.auto_zoom_limit = 1,04999995.0;
								::camera.lock = true;
								this.lavelClearEvent = function ()
								{
									if (this.flag4)
									{
										this.flag4.func();
									}

									this.flag4 = null;
									::camera.lock = false;
									::camera.auto_zoom_limit = 2,00000000.0;
								};
								this.flag5.handFire.func[3].call(this.flag5.handFire);
								this.func[2].call(this);
								return;
							}
						}
					};
				}
			};
		},
		function ()
		{
			this.Warp(this.x, this.y < this.centerY ? ::battle.scroll_top - 300 : ::battle.scroll_bottom + 300);
			local r_ = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.SetSpeed_Vec(20,00000000.0, r_, this.direction);
			this.flag5.homing = true;
			this.count = 0;
			this.PlaySE(3267);
			::camera.Shake(12);
			this.flag5.cycle--;
			this.stateLabel = function ()
			{
				if (this.team.life > 1)
				{
					this.team.life--;
				}

				local tVec_ = this.Vector3();
				tVec_.x = this.target.x - this.x;
				tVec_.y = this.target.y - this.y;

				if (this.flag5.cycle <= 0 && tVec_.Length() <= 300)
				{
					this.func[3].call(this);
					return;
				}

				if (this.flag5.homing && this.va.x * tVec_.x + this.va.y * tVec_.y >= this.cos(1,57079601.0))
				{
					this.TargetHoming(this.target, this.flag5.homingRot, this.direction);
				}
				else
				{
					this.flag5.homing = false;
				}

				if (this.com_difficulty == 4 && this.count % 3 == 1)
				{
					local t_ = {};
					t_.rot <- this.atan2(this.va.y, this.va.x * this.direction);
					this.SetShot(this.x - 160 + this.rand() % 321, this.y - 160 + this.rand() % 321, this.direction, this.Boss_Shot_M2_TrailShot, t_);
				}

				if (this.count >= 120 && this.IsScreen(300))
				{
					this.func[2].call(this);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.team.life > 1)
				{
					this.team.life--;
				}

				if (this.Vec_Brake(1,00000000.0))
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count >= 30)
						{
							if (this.team.life > 2)
							{
								this.team.life -= 2;
							}
							else if (this.team.life > 1)
							{
								this.team.life--;
							}
						}

						if (this.count == 30)
						{
							::camera.Shake(30,00000000.0);
							this.flag5.handFire.func[2].call(this.flag5.handFire);
						}

						if (this.count == 60)
						{
							this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
						}

						if (this.count == 120)
						{
							this.flag5.handFire.func[0].call(this.flag5.handFire);
							this.M2_Change_Slave(null);
						}
					};
				}
			};
		}
	];
	this.func[0].call(this);
	return true;
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Mokou2(null);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Mamizou_1()
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

function S_Assult_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);

	if (this.x > 640)
	{
		this.direction = -1,00000000.0;
	}
	else
	{
		this.direction = 1,00000000.0;
	}

	this.armor = -1;
	this.count = 0;
	this.AjustCenterStop();
	this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,20000000.0 * this.direction, 0,00000000.0);
			};
		},
		function ()
		{
			this.SetMotion(this.motion, 4);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.CenterUpdate(0,05000000.0, 1,00000000.0);
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
					this.AddSpeed_XY(0,20000000.0 * this.direction, 0,00000000.0, 20,00000000.0 * this.direction, null);
				}
				else
				{
					this.AddSpeed_XY(1,25000000.0 * this.direction, 0,00000000.0, 25,00000000.0 * this.direction, null);
				}

				if (this.count % 3 == 1)
				{
					this.SetFreeObject(this.x - this.rand() % 75, this.y - 50 + this.rand() % 100, this.direction, this.Boss_S1_Particle, {});
				}

				if (this.direction == 1,00000000.0 && this.x > ::battle.corner_right - 200,00000000.0 || this.direction == -1,00000000.0 && this.x < ::battle.corner_left + 200,00000000.0)
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
		this.Vec_Brake(0,50000000.0, 1,00000000.0);

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
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
	this.func = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Boss_S2_FireBall, {}).weakref();
			this.stateLabel = function ()
			{
				this.VY_Brake(0,75000000.0);

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
				this.AddSpeed_XY(0,00000000.0, -0,25000000.0);

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
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0,00000000.0;
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
	case 4:
		this.flag5.shotNum = 30;
		break;
	}

	this.func = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VY_Brake(0,75000000.0);

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
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
	this.func = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.Boss_S2_FireBall, {}).weakref();
			this.stateLabel = function ()
			{
				this.VY_Brake(0,75000000.0);

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
				this.AddSpeed_XY(0,00000000.0, -0,25000000.0);

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
	this.resist_baria = true;
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
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0,00000000.0;
	this.flag2 = null;
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
	this.flag5.shotCycle <- 12;
	this.flag5.shotCount <- 60;
	this.flag5.shotNum <- 3;
	this.flag5.shotRotate <- 2,09439468.0;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 8;
		this.flag5.shotNum = 8;
		this.flag5.shotCount = 60;
		this.flag5.shotRotate = 0,78539813.0;
		break;

	case 2:
		this.flag5.shotCycle = 5;
		this.flag5.shotNum = 12;
		this.flag5.shotCount = 90;
		this.flag5.shotRotate = 0,52359873.0;
		break;

	case 3:
		this.flag5.shotCycle = 3;
		this.flag5.shotNum = 20;
		this.flag5.shotCount = 120;
		this.flag5.shotRotate = 13 * 0,01745329.0;
		break;

	case 4:
		this.flag5.shotCycle = 3;
		this.flag5.shotNum = 20;
		this.flag5.shotCount = 180;
		this.flag5.shotRotate = 13 * 0,01745329.0;
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
					local r_ = this.rand() % 360 * 0,01745329.0;

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
							t_.rot <- this.rand() % 360 * 0,01745329.0;
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

