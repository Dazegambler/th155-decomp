function Master_Spell_1_Dream()
{
	this.team.slave.Slave_Dream_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 0;
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
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);
	this.flag3 = this.flag5.pos.x * this.direction > 0 ? 1.00000000 : -1.00000000;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotCycle = 20;
		break;

	case 2:
		this.flag5.shotCycle = 12;
		break;

	case 3:
		this.flag5.shotCycle = 5;
		break;
	}

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
		this.flag5.shotCycle = 20;
		break;

	case 2:
		this.flag5.shotCycle = 15;
		break;

	case 3:
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
				::camera.Shake(2.00000000);

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
	this.direction = this.x > 640 ? -1.00000000 : 1.00000000;
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
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);
	this.flag3 = this.flag5.pos.x * this.direction > 0 ? 1.00000000 : -1.00000000;

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
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
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
	this.flag5.shotCycle <- 180;
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
		this.Vec_Brake(0.75000000);
	};
	this.subState[1] = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.flag5.shotCount = 0;
			this.subState[1] = function ()
			{
				this.flag5.shotCount++;

				if (this.flag5.shotCount >= this.flag5.chargeCount)
				{
					this.SetMotion(4962, 2);
					this.subState[1] = function ()
					{
						::camera.Shake(2.00000000);
					};
				}
			};
		},
		null,
		function ()
		{
			this.flag5.shotCount = 0;
			this.SetSpeed_XY(0.00000000, -0.25000000);
			this.subState[1] = function ()
			{
				this.HitCycleUpdate(30);
				this.flag5.shotCount++;
				::camera.Shake(2.00000000);

				if (this.flag5.shotCount % 40 == 1)
				{
					this.PlaySE(4231);
				}

				if (this.flag5.shotCount % this.flag5.shotCycle == 1)
				{
					this.flag5.shotNum++;
					local t_ = {};
					t_.namazu <- false;

					if (this.team.life <= this.team.life_max * 0.50000000 && this.flag5.shotNum == 1)
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
	this.direction = this.x > 640 ? -1.00000000 : 1.00000000;
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
	this.SetSpeed_Vec(0.25000000, -160 * 0.01745329, this.direction);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

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

				if (this.Vec_Brake(0.75000000))
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
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
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
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag5 = {};
	this.flag5.shotCycle <- 120;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.shotNum <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- null;
	this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
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
			this.SetSpeed_XY(17.50000000 * this.direction, -12.50000000);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000, 1.00000000 * this.direction);
				this.AddSpeed_XY(0.00000000, 0.25000000, null, 2.00000000);

				if (this.count == 25)
				{
					this.stateLabel = function ()
					{
						this.VX_Brake(0.50000000);
						this.AddSpeed_XY(0.00000000, 1.50000000, 0.00000000, 30.00000000);

						if (this.ground)
						{
							this.count = 0;
							this.PlaySE(4253);
							this.SetMotion(4963, 3);
							::camera.Shake(6.00000000);
							this.SetSpeed_XY(0.00000000, 0.00000000);
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
			::camera.Shake(12.00000000);
			this.SetSpeed_XY(0.00000000, -22.50000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000, 0.00000000, -10.00000000);

				if (this.y < this.centerY - 200)
				{
					if (this.flag5.namazu)
					{
						this.flag5.namazu.SetMotion(5001, 1);
					}

					this.flag5.moveCount = 0;
					this.stateLabel = function ()
					{
						this.Vec_Brake(0.75000000);
						this.flag5.moveCount++;

						if (this.flag5.moveCount >= 45)
						{
							this.GetFront();
							this.SetMotion(this.motion, 6);
							this.SetSpeed_XY(-2.00000000 * this.direction, -10.00000000);

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
								this.VX_Brake(0.25000000, -1.00000000 * this.direction);
								this.AddSpeed_XY(0.00000000, 0.50000000, null, 4.50000000);

								if (this.va.y > 0 && this.y >= this.centerY)
								{
									this.SetMotion(this.motion, 8);
									this.SetSpeed_XY(this.va.x, 3.00000000);
									this.stateLabel = function ()
									{
										this.VX_Brake(0.50000000);

										if (this.y < this.centerY && this.va.y < 0)
										{
											this.SetSpeed_XY(this.va.x, 0.00000000);
											this.y = this.centerY;
											this.stateLabel = function ()
											{
												this.VX_Brake(0.50000000);
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
	this.SetMotion(4964, 0);
	this.HitReset();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag5 = {};
	this.flag5.shotCycle <- 120;
	this.flag5.bigCycle <- 300;
	this.flag5.scaleAdd <- 0.10000000;
	this.flag5.shotCount <- 0;
	this.flag5.chargeCount <- 60;
	this.flag5.shotRot <- 0;
	this.flag5.shotNum <- 0;
	this.flag5.moveCount <- 0;
	this.flag5.moveV <- 0;
	this.flag5.charge <- null;
	this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
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
		this.flag5.scaleAdd = 0.15000001;
		break;

	case 2:
		this.flag5.bigCycle = 240;
		this.flag5.scaleAdd = 0.20000000;
		break;

	case 3:
		this.flag5.bigCycle = 240;
		this.flag5.scaleAdd = 0.25000000;
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
			this.flag5.charge = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellChargeBig, {}, this.weakref()).weakref();
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
					this.SetSpeed_XY(0.00000000, -25.00000000);
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
							this.SetSpeed_XY(0.00000000, 0.00000000);
							this.stateLabel = function ()
							{
								if (this.count == 120)
								{
									this.Warp(640, -800);
									this.SetMotion(4964, 5);
									this.SetSpeed_XY(0.00000000, 40.00000000);
									this.PlaySE(4251);
									this.stateLabel = function ()
									{
										if (this.ground)
										{
											this.count = 0;
											this.PlaySE(4253);
											this.SetMotion(4964, 6);
											::camera.Shake(6.00000000);
											this.SetSpeed_XY(0.00000000, 0.00000000);
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
			::camera.Shake(12.00000000);
			this.func[1].call(this);
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
	pos_.y = 240 + 180 * this.sin(this.flag5.moveCount * 0.01745329 * 0.50000000);
	this.va.x = (pos_.x - this.x) * 0.10000000;
	this.va.y = (pos_.y - this.y) * 0.10000000;
	this.flag5.moveV += 0.20000000;

	if (this.flag5.moveV > 5.00000000)
	{
		this.flag5.moveV = 5.00000000;
	}

	if (this.va.Length() > this.flag5.moveV)
	{
		this.va.SetLength(this.flag5.moveV);
	}

	this.ConvertTotalSpeed();
}

