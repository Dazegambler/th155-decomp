function Master_Spell_D1()
{
	this.team.slave.Slave_Usami_D1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.com_flag3 = null;
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

					this.Master_Spell_D1_Start();
				}
			};
		}
	};
	return true;
}

function Slave_Usami_D1()
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

function Master_Spell_D1_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4910, 0);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;

	if (this.com_flag3 == null)
	{
		this.com_flag3 = this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1, {}).weakref();
	}

	this.PlaySE(3643);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count == 120)
		{
			this.D1_Change_Slave(null);
			return;
		}
	};
}

function D1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_D1_Usami(null);
	this.Set_BossSpellBariaRate(10);
	this.PlaySE(3624);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
	this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
}

function Slave_Attack_D1_Usami( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4910, 0);
	this.com_flag2++;

	if (this.x < 640)
	{
		this.Warp(800 + this.rand() % 360, 200 + this.rand() % 400);
	}
	else
	{
		this.Warp(480 - this.rand() % 360, 200 + this.rand() % 400);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
	this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
	this.flag4 = null;
	this.count = 0;
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
		if (this.count == 60)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count == 120)
		{
			if (this.com_flag2 >= 2)
			{
				this.com_flag2 = 0;
				this.Slave_Attack_D1_UsamiB(null);
				return;
			}
			else
			{
				this.Change_Master_D1_Usami(null);
				return;
			}
		}
	};
}

function Slave_Attack_D1_UsamiB( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4910, 2);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};

	if (this.team.master.com_flag3)
	{
		this.team.master.com_flag3.func[2].call(this.team.master.com_flag3);
		this.team.master.com_flag3 = null;
	}

	this.stateLabel = function ()
	{
		if (this.count == 200)
		{
			this.Change_Master_D1_Usami(null);
			return;
		}
	};
}

function Change_Master_D1_Usami( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_D1_Attack(null);
	this.PlaySE(3624);
	this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
	this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
}

function Master_Spell_D1_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4910, 0);

	if (this.x < 640)
	{
		this.Warp(800 + this.rand() % 360, 200 + this.rand() % 400);
	}
	else
	{
		this.Warp(480 - this.rand() % 360, 200 + this.rand() % 400);
	}

	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
	this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
	this.count = 0;

	if (this.com_flag3 == null)
	{
		this.com_flag3 = this.SetShot(this.x, this.y, this.direction, this.Boss_Shot_M1, {}).weakref();
	}

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
		if (this.count == 60)
		{
			this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		}

		if (this.count == 120)
		{
			this.D1_Change_Slave(null);
			return;
		}
	};
}

function Master_Spell_D2()
{
	this.team.slave.Slave_Usami_D2();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.com_flag3 = null;
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

					this.Master_Spell_D2_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_D2_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4992, 0);
	this.flag5 = {};
	this.flag5.shotCycle <- 5;
	this.flag5.shotCount <- 0;
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.count = 0;
	this.centerStop = -2;
	this.stateLabel = function ()
	{
		if (this.count <= 10)
		{
			this.AddSpeed_XY(-0.50000000 * this.direction, -0.15000001);
		}

		if (this.count == 70)
		{
			this.SetMotion(4992, 2);
		}

		if (this.count >= 70)
		{
			this.Vec_Brake(0.20000000);
		}

		if (this.count == 100)
		{
			this.Master_Spell_D2_Attack(null);
			return;
		}
	};
}

function Master_Spell_D2_Move()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4991, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.direction = this.x < 640 ? 1.00000000 : -1.00000000;
	this.count = 0;
	this.centerStop = -2;
	this.flag1 = this.Vector3();
	this.flag1.x = 0.50000000;
	this.flag1.y = this.y < this.centerY ? 0.10000000 : -0.10000000;
	this.stateLabel = function ()
	{
		if (this.count <= 15)
		{
			this.AddSpeed_XY(this.flag1.x * this.direction, this.flag1.y);
		}

		if (this.count == 70)
		{
			this.SetMotion(4992, 2);
		}

		if (this.count >= 70)
		{
			this.Vec_Brake(0.20000000);
		}

		if (this.count == 100)
		{
			this.Master_Spell_D2_Attack(null);
			return;
		}
	};
}

function Master_Spell_D2_Attack( t )
{
	this.LabelReset();
	this.com_flag2++;
	this.GetFront();
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};

	switch(this.com_flag2 % 3)
	{
	case 0:
		this.SetMotion(4922, 0);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
		this.keyAction = [
			function ()
			{
				if (this.flag4)
				{
					this.flag4.func();
				}

				this.flag4 = null;
				this.SetShot(this.x + 100 * this.direction, ::battle.scroll_bottom, this.direction, this.Boss_Shot_D2_HoleCore, {});
			},
			null,
			function ()
			{
				this.count = 0;
				this.stateLabel = function ()
				{
					this.Vec_Brake(0.50000000);

					if (this.count == 120)
					{
						this.SetMotion(this.motion, 4);
					}
				};
			},
			null,
			function ()
			{
				if (!this.com_flag3)
				{
					this.PlaySE(900);
					this.PlaySE(3717);
					this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
					this.com_flag3 = this.SetObject(this.x, this.y, this.direction, this.Boss_Doppel_Hole_D2, {}).weakref();
				}

				this.Master_Spell_D2_Move();
			}
		];
		break;

	case 1:
		this.SetMotion(4923, 0);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.keyAction = [
			function ()
			{
			},
			null,
			function ()
			{
				this.PlaySE(3637);
				this.SetShot(this.direction == 1.00000000 ? ::camera.camera2d.right + 100 : ::camera.camera2d.left - 100, 860, -this.direction, this.Boss_Shot_D2_Denchu, {});
				this.SetSpeed_XY(-5.00000000 * this.direction, 3.00000000);
				this.stateLabel = function ()
				{
					this.Vec_Brake(0.25000000);
				};
			},
			null,
			function ()
			{
				if (!this.com_flag3)
				{
					this.PlaySE(900);
					this.PlaySE(3717);
					this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
					this.com_flag3 = this.SetObject(this.x, this.y, this.direction, this.Boss_Doppel_Denchu_D2, {}).weakref();
				}

				this.Master_Spell_D2_Move();
			}
		];
		this.count = 0;
		this.stateLabel = function ()
		{
			this.Vec_Brake(0.50000000);
		};
		break;

	case 2:
		this.SetMotion(4921, 0);
		this.SetSpeed_XY(0.00000000, 0.00000000);
		this.keyAction = [
			function ()
			{
				this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			},
			null,
			function ()
			{
				if (this.flag4)
				{
					this.flag4.func();
				}

				this.flag4 = null;
				this.SetShot(640 + 1160 * this.direction, ::battle.scroll_bottom + 260, -this.direction, this.Boss_Shot_D2, {});
				this.SetSpeed_XY(-15.00000000 * this.direction, 8.00000000);
				this.stateLabel = function ()
				{
					this.Vec_Brake(0.50000000);
				};
			},
			null,
			function ()
			{
				if (!this.com_flag3)
				{
					this.PlaySE(900);
					this.PlaySE(3717);
					this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
					this.com_flag3 = this.SetObject(this.x, this.y, this.direction, this.Boss_Doppel_Tower_D2, {}).weakref();
				}

				this.Master_Spell_D2_Move();
			}
		];
		this.count = 0;
		this.stateLabel = function ()
		{
			this.Vec_Brake(0.50000000);
		};
		break;
	}
}

function Master_Spell_D2_MoveB()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4991, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.direction = this.x < 640 ? 1.00000000 : -1.00000000;
	this.count = 0;
	this.centerStop = -2;
	this.flag1 = this.Vector3();
	this.flag1.x = 0.25000000;
	this.flag1.y = this.y < this.centerY ? 0.10000000 : -0.10000000;
	this.stateLabel = function ()
	{
		if (this.count <= 10)
		{
			this.AddSpeed_XY(this.flag1.x * this.direction, this.flag1.y);
		}

		if (this.count == 40)
		{
			this.SetMotion(4992, 2);
		}

		if (this.count >= 40)
		{
			this.Vec_Brake(0.20000000);
		}

		if (this.count == 70)
		{
			this.Master_Spell_D2_Attack_B(null);
			return;
		}
	};
}

function Master_Spell_D2_Attack_B( t )
{
	this.LabelReset();
	this.direction = this.x < 640 ? 1.00000000 : -1.00000000;
	this.SetMotion(4995, 0);
	this.flag1 = this.Vector3();
	this.flag1.x = 640 + 360 * this.direction - this.x;
	this.flag1.y = this.centerY - this.y;
	this.flag1.Normalize();
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count <= 10)
		{
			this.AddSpeed_XY(this.flag1.x, this.flag1.y);
		}

		if (this.direction == 1.00000000 && this.x > 900 || this.direction == -1.00000000 && this.x < 340)
		{
			this.SetMotion(4995, 3);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.33000001);
				this.keyAction = function ()
				{
					this.LabelReset();
					this.SetMotion(4921, 0);
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
					this.flag5 = {};
					this.flag5.shotCycle <- 5;
					this.flag5.shotCount <- 0;
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.lavelClearEvent = function ()
					{
						if (this.flag4)
						{
							this.flag4.func();
						}

						this.flag4 = null;
					};
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
							this.SetShot(640 + 1160 * this.direction, ::battle.scroll_bottom + 260, -this.direction, this.Boss_Shot_D2, {});
							this.SetSpeed_XY(-15.00000000 * this.direction, 8.00000000);
							this.stateLabel = function ()
							{
								this.Vec_Brake(0.50000000);
							};
						},
						function ()
						{
							this.D2_Change_Slave(null);
						}
					];
					this.stateLabel = function ()
					{
					};
				};
			};
		}
	};
}

function Slave_Usami_D2()
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

function D2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_D2_Usami(null);
	this.team.current.direction = -this.direction;
	this.Set_BossSpellBariaRate(10);
}

function Slave_Attack_D2_Usami( t )
{
	this.LabelReset();
	this.direction = this.x < 640 ? 1.00000000 : -1.00000000;
	this.SetMotion(4995, 0);
	this.flag1 = this.Vector3();
	this.flag1.x = 640 + 360 * this.direction - this.x;
	this.flag1.y = this.centerY - this.y;
	this.flag1.Normalize();
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count <= 10)
		{
			this.AddSpeed_XY(this.flag1.x, this.flag1.y);
		}

		if (this.direction == 1.00000000 && this.x > 900 || this.direction == -1.00000000 && this.x < 340)
		{
			this.SetMotion(4995, 3);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.33000001);
				this.keyAction = function ()
				{
					this.LabelReset();
					this.SetMotion(4922, 0);
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
					this.flag5 = {};
					this.flag5.shotCycle <- 5;
					this.flag5.shotCount <- 0;
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.lavelClearEvent = function ()
					{
						if (this.flag4)
						{
							this.flag4.func();
						}

						this.flag4 = null;
					};
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
							this.SetShot(640 + 1160 * this.direction, ::battle.scroll_bottom + 260, -this.direction, this.Boss_Shot_D2, {});
							this.SetSpeed_XY(-15.00000000 * this.direction, 8.00000000);
							this.stateLabel = function ()
							{
								this.Vec_Brake(0.50000000);
							};
						},
						function ()
						{
							this.Change_Master_D2_Usami(null);
						}
					];
					this.stateLabel = function ()
					{
					};
				};
			};
		}
	};
}

function Change_Master_D2_Usami( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_D2_Move();
}

