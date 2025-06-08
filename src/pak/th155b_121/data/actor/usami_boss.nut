function Master_Spell_D1()
{
	this.team.slave.Slave_Usami_D1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.com_flag3 = null;
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

					this.Master_Spell_D1_Start();
				}
			};
		}
	};
	return true;
}

function Slave_Doremy_1()
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

function Slave_Attack_Doremy( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4950, 0);
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, -10.00000000);
	this.flag1 = 0.00000000;
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
	this.flag5.charge <- 180;
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
		this.Vec_Brake(1.00000000, 0.25000000);
	};
	this.func = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.centerStop = -2;
			this.count = 0;
			this.team.master.shot_actor.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.stateLabel = function ()
			{
				this.Vec_Brake(1.00000000, 0.25000000);

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count > 120)
				{
					this.Change_Master_Doremy(null);
					return;
				}
			};
		}
	];
}

function Change_Master_Doremy( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Warp(this.target.x, ::battle.scroll_top - 200);
	this.team.current.MS1_Attack_Fall(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_Sinmyoumaru_1()
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

function Slave_Attack_Sinmyoumaru( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4950, 0);

	switch(this.owner.com_difficulty)
	{
	case 0:
	case 1:
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 2.00000000);

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count > 150)
				{
					this.Change_Master_Sinmyoumaru(null);
					return;
				}
			};
		};
		break;

	default:
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 2.00000000);

				if (this.count > 30)
				{
					this.Slave_Attack_Sinmyoumaru2(null);
					return;
				}
			};
		};
		break;
	}

	this.Slave_Attack_SinmyoumaruCommon(t);
}

function Slave_Attack_Sinmyoumaru2( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4951, 0);

	switch(this.owner.com_difficulty)
	{
	case 3:
	case 4:
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 2.00000000);

				if (this.count > 24)
				{
					this.Slave_Attack_Sinmyoumaru3(null);
					return;
				}
			};
		};
		break;

	default:
		this.func = function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0.05000000, 2.00000000);

				if (this.count == 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count > 150)
				{
					this.Change_Master_Sinmyoumaru(null);
					return;
				}
			};
		};
		break;
	}

	this.Slave_Attack_SinmyoumaruCommon(t);
}

function Slave_Attack_Sinmyoumaru3( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4952, 0);
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.CenterUpdate(0.05000000, 2.00000000);

			if (this.count == 60)
			{
				this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			}

			if (this.count > 150)
			{
				this.Change_Master_Sinmyoumaru(null);
				return;
			}
		};
	};
	this.Slave_Attack_SinmyoumaruCommon(t);
}

function Slave_Attack_SinmyoumaruCommon( t )
{
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag1 = 0.00000000;
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
	this.flag5.charge <- 180;
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
		this.flag5.charge = 90;
		this.flag5.wait = 150;
		break;
	}

	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3635);
			::camera.Shake(6.00000000);
			this.PlaySE.call(this.team.master, 3430);
			this.centerStop = -2;
			this.AjustCenterStop();
			this.count = 0;
			this.team.master.shot_actor.Foreach(function ()
			{
				this.func[2].call(this);
			});
			this.func();
		}
	];
}

function Change_Master_Sinmyoumaru( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Master_Spell_1C_Attack(null);
	this.Set_BossSpellBariaRate(1);
}

function Slave_Usami_D1()
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
	this.resist_baria = true;
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

function Master_Spell_D3_OD()
{
	this.team.slave.Slave_Usami_D3();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	::battle.enable_demo_talk = true;
	this.com_flag1 = 0;
	this.resist_baria = true;
	this.boss_spell_func = function ()
	{
	};
	this.boss_cpu = function ()
	{
		if (this.Cancel_Check(10))
		{
			if (this.DS3_Start())
			{
				if (this.team.shield == null)
				{
					this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
				}

				this.boss_cpu = function ()
				{
					if (this.Cancel_Check(10))
					{
						if (this.team.shield == null)
						{
							this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
						}

						this.DS3_Attack();
					}
				};
			}
		}
	};
	return true;
}

function DS3_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4960, 0);
	this.PlaySE(3643);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.flag5 = {};
	this.flag5.v <- 0.00000000;
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
		this.flag5.v += 0.50000000;
		this.SetSpeed_XY((640 - this.x) * 0.10000000, (this.centerY - 100 - this.y) * 0.10000000);

		if (this.va.Length() > this.flag5.v)
		{
			this.va.SetLength(this.flag5.v);
			this.ConvertTotalSpeed();
		}

		if (this.count == 120)
		{
			this.BossForceCall_Init();
		}

		if (this.count == 180)
		{
			this.DS3_Sprit();
			return;
		}
	};
	return true;
}

function DS3_Sprit()
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4960, 2);
	this.PlaySE(3643);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.slave <- null;
	this.flag5.spark <- null;
	this.count = 0;
	this.autoCamera = false;
	this.freeMap = true;
	::camera.Shake(12.00000000);
	::camera.auto_zoom_limit = 1.04999995;
	::camera.lock = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
		this.autoCamera = true;
		::camera.lock = false;
		::camera.auto_zoom_limit = 2.00000000;

		if (this.flag5.slave)
		{
			this.flag5.slave.func[0].call(this.flag5.slave);
		}
	};
	this.PlaySE(903);
	this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_Change, {}, this.weakref());
	this.flag5.slave = this.SetObject(this.x, this.y, -this.direction, this.Boss_Doppel_Start_D3, {}).weakref();
	this.SetSpeed_XY(30.00000000 * this.direction, 0.00000000);
	this.func = [
		function ()
		{
		}
	];
	this.subState = function ()
	{
		this.VX_Brake(2.00000000);

		if (this.count == 90)
		{
			this.SetMotion(4960, 0);

			if (this.flag5.slave)
			{
				this.flag5.slave.func[1].call(this.flag5.slave);
			}

			this.subState = function ()
			{
				if (this.count % 20 == 1)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_D3_Aura, {});
				}

				if (this.count >= 30)
				{
					this.AddSpeed_XY(0.00000000, -0.50000000);
				}
				else
				{
					this.AddSpeed_XY(0.00000000, -0.25000000, 0.00000000, -0.75000000);
				}

				if (this.y < ::battle.scroll_top - 256)
				{
					if (this.flag5.slave)
					{
						this.flag5.slave.func[0].call(this.flag5.slave);
					}

					this.SetMotion(4960, 6);
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.count = 0;
					this.subState = function ()
					{
						if (this.count == 60)
						{
							this.DS3_Attack_A(null);
						}

						return;
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.cameraPos.x = 640;
		this.cameraPos.y = this.y;
	};
}

function DS3_Attack()
{
	this.LabelReset();
	this.SetMotion(4911, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3624);
			this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
			this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.DS3_Attack_A(null);
				}
			};
		}
	];
	return true;
}

function DS3_Attack_A( t )
{
	this.LabelReset();
	this.SetMotion(4960, 0);
	this.autoCamera = false;
	this.freeMap = true;
	::camera.Shake(10.00000000);
	::camera.auto_zoom_limit = 1.04999995;
	::camera.lock = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
		this.autoCamera = true;
		::camera.lock = false;
		::camera.auto_zoom_limit = 2.00000000;

		if (this.flag5.slave)
		{
			this.flag5.slave.func[0].call(this.flag5.slave);
		}
	};

	if (this.rand() % 100 <= 49)
	{
		this.Warp(240, ::battle.scroll_top - 128);
		this.direction = -1.00000000;
	}
	else
	{
		this.Warp(1040, ::battle.scroll_top - 128);
		this.direction = 1.00000000;
	}

	this.flag4 = null;
	this.flag5 = {};
	this.PlaySE(3656);
	this.flag5.spark <- this.SetShot(this.x + 75 * this.direction, this.y, this.direction, this.Boss_Shot_D3_Spark, {}, this.weakref()).weakref();
	this.flag5.slave <- this.SetObject(1280 - this.x, this.y, -this.direction, this.Boss_DoppelA_D3, {}).weakref();
	this.SetSpeed_XY(0.00000000, 5.00000000);
	this.count = 0;
	this.subState = function ()
	{
		::camera.Shake(3.00000000);
		local r_ = (this.y - 360) / 360.00000000;
		this.SetSpeed_XY(4.00000000 * r_ * this.direction, this.va.y);

		if (this.count % 20 == 1)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_D3_Aura, {});
		}

		if (this.y > ::battle.scroll_bottom + 128)
		{
			if (this.flag5.slave)
			{
				this.flag5.slave.func[0].call(this.flag5.slave);
				this.flag5.slave = null;
			}

			if (this.flag5.spark)
			{
				this.flag5.spark.func[0].call(this.flag5.spark);
				this.flag5.spark = null;
			}

			this.SetMotion(4960, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 60)
				{
					this.DS3_Attack_B(null);
				}

				return;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.cameraPos.x = 640;
		this.cameraPos.y = this.y;
	};
}

function DS3_Attack_B( t )
{
	this.LabelReset();
	this.SetMotion(4961, 0);
	this.autoCamera = false;
	this.freeMap = true;
	::camera.Shake(10.00000000);
	::camera.auto_zoom_limit = 1.04999995;
	::camera.lock = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
		this.autoCamera = true;
		::camera.lock = false;
		::camera.auto_zoom_limit = 2.00000000;

		if (this.flag5.slave)
		{
			this.flag5.slave.func[0].call(this.flag5.slave);
		}
	};

	if (this.rand() % 100 <= 49)
	{
		this.Warp(740, ::battle.scroll_bottom + 128);
		this.direction = -1.00000000;
	}
	else
	{
		this.Warp(540, ::battle.scroll_bottom + 128);
		this.direction = 1.00000000;
	}

	this.flag4 = null;
	this.flag5 = {};
	this.flag5.slave <- this.SetObject(1280 - this.x, this.y, -this.direction, this.Boss_DoppelB_D3, {}).weakref();
	this.PlaySE(3656);
	local t_ = {};
	t_.target <- this.flag5.slave.weakref();
	this.flag5.spark <- this.SetShot(this.x + 75 * this.direction, this.y, this.direction, this.Boss_Shot_D3_SparkB, t_, this.weakref()).weakref();
	this.flag5.debri <- ::manbow.Actor2DProcGroup();
	this.SetSpeed_XY(0.00000000, -5.00000000);
	this.count = 0;
	this.subState = function ()
	{
		::camera.Shake(3.00000000);
		local r_ = (this.y - 360) / 360.00000000;
		this.SetSpeed_XY(-5.00000000 * r_ * this.direction, this.va.y);

		if (this.count % 20 == 1)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_D3_Aura, {});
		}

		if (this.count % 10 == 1)
		{
			this.flag5.debri.Add(this.SetShot(this.x + this.rand() % ((640 - this.x) * 2) * this.direction, this.y, this.direction, this.Boss_Shot_D3_DebriB, {}));
		}

		if (this.y < ::battle.scroll_top - 128)
		{
			if (this.flag5.slave)
			{
				this.flag5.slave.func[0].call(this.flag5.slave);
				this.flag5.slave = null;
			}

			if (this.flag5.spark)
			{
				this.flag5.spark.func[0].call(this.flag5.spark);
				this.flag5.spark = null;
			}

			this.SetMotion(4960, 6);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.count = 0;
			this.subState = function ()
			{
				if (this.count == 60)
				{
					this.DS3_Attack_C(null);
				}

				return;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.cameraPos.x = 640;
		this.cameraPos.y = this.y;
	};
}

function DS3_Attack_C( t )
{
	this.LabelReset();
	this.SetMotion(4960, 0);
	this.autoCamera = false;
	this.freeMap = true;
	::camera.Shake(6.00000000);
	::camera.auto_zoom_limit = 1.25000000;
	::camera.lock = true;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
		this.autoCamera = true;
		::camera.lock = false;
		::camera.auto_zoom_limit = 2.00000000;

		if (this.flag5.slave)
		{
			this.flag5.slave.func[0].call(this.flag5.slave);
		}
	};

	if (this.rand() % 100 <= 49)
	{
		this.Warp(490, ::battle.scroll_top - 128);
		this.direction = -1.00000000;
	}
	else
	{
		this.Warp(790, ::battle.scroll_top - 128);
		this.direction = 1.00000000;
	}

	this.flag1 = this.Vector3();
	this.flag2 = 0.00000000;
	this.flag3 = this.Vector3();
	this.flag4 = null;
	this.flag5 = {};
	this.flag5.spark <- null;
	this.flag5.slave <- this.SetObject(1280 - this.x, this.y, -this.direction, this.Boss_DoppelC_D3, {}).weakref();
	this.flag1.x = this.flag5.slave.x - this.x;
	this.flag1.y = this.flag5.slave.y - this.y;
	this.SetSpeed_XY(0.00000000, 15.00000000);
	this.count = 0;
	this.subState = function ()
	{
		if (this.flag5.slave)
		{
			this.flag5.slave.Warp(this.x + this.flag1.x, this.y + this.flag1.y);
		}

		if (this.y > this.centerY - 256)
		{
			if (this.VY_Brake(0.50000000) && this.count >= 90)
			{
				this.flag5.slave.SetMotion(this.motion, 2);
				this.SetMotion(this.motion, 2);
				this.flag1.x = this.x - 640;
				this.flag1.y = 0;
				this.flag3.x = 640;
				this.flag3.y = this.y;
				this.count = 0;
				this.subState = function ()
				{
					if (this.count > 16)
					{
						::camera.Shake(2.00000000);
					}

					if (this.count == 16)
					{
						::camera.Shake(10.00000000);
						this.PlaySE(3656);
						this.flag5.spark = this.SetShot(this.x + 75 * this.direction, this.y, this.direction, this.Boss_Shot_D3_SparkC, {}, this.weakref()).weakref();
						this.flag5.slave.func[1].call(this.flag5.slave);
					}

					this.flag2 += 0.15000001;

					if (this.flag2 >= 1.50000000)
					{
						this.flag2 = 1.50000000;
					}

					this.flag1.RotateByDegree(this.flag2 * this.direction);
					this.Warp(this.flag3.x + this.flag1.x, this.flag3.y + this.flag1.y * 0.50000000);
					this.flag5.slave.Warp(this.flag3.x - this.flag1.x, this.flag3.y - this.flag1.y * 0.50000000);

					if (this.flag5.spark)
					{
						this.flag5.spark.rz += this.flag2 * 0.01745329;
						this.flag5.spark.Warp(this.x + this.flag1.x * 0.75000000, this.y + this.flag1.y * 0.75000000);
						this.flag5.spark.SetCollisionRotation(0.00000000, 0.00000000, this.flag5.spark.rz);
					}

					if (this.flag5.slave && this.flag5.slave.flag5)
					{
						this.flag5.slave.flag5.rz -= this.flag2 * 0.01745329;
						this.flag5.slave.flag5.Warp(this.x - this.flag1.x * 0.75000000, this.y - this.flag1.y * 0.75000000);
						this.flag5.slave.flag5.SetCollisionRotation(0.00000000, 0.00000000, this.flag5.slave.flag5.rz);
					}

					if (this.count >= 360)
					{
						if (this.flag5.spark)
						{
							this.flag5.spark.func[0].call(this.flag5.spark);
						}

						if (this.flag5.slave)
						{
							this.flag5.slave.func[2].call(this.flag5.slave);
						}

						this.count = 0;
						this.subState = function ()
						{
							this.flag2 -= 0.25000000;

							if (this.flag2 <= 0.00000000)
							{
								this.flag2 = 0.00000000;
							}

							this.flag1.RotateByDegree(this.flag2 * this.direction);
							this.Warp(this.flag3.x + this.flag1.x, this.flag3.y + this.flag1.y * 0.50000000);
							this.flag5.slave.Warp(this.flag3.x - this.flag1.x, this.flag3.y - this.flag1.y * 0.50000000);

							if (this.count == 30)
							{
								if (this.flag5.slave)
								{
									this.flag5.slave.func[3].call(this.flag5.slave);
								}

								this.SetMotion(this.motion, 0);
								this.flag1.x = this.flag5.slave.x - this.x;
								this.flag1.y = this.flag5.slave.y - this.y;
								this.subState = function ()
								{
									this.AddSpeed_XY(0.00000000, -0.50000000, 0.00000000, -15.00000000);

									if (this.flag5.slave)
									{
										this.flag5.slave.Warp(this.x + this.flag1.x, this.y + this.flag1.y);
									}

									if (this.y < ::battle.scroll_top - 256)
									{
										if (this.flag5.slave)
										{
											this.flag5.slave.func[0].call(this.flag5.slave);
											this.flag5.slave = null;
										}

										this.SetMotion(4960, 6);
										this.SetSpeed_XY(0.00000000, 0.00000000);
										this.count = 0;
										this.subState = function ()
										{
											if (this.count == 60)
											{
												this.DS3_Attack_A(null);
											}

											return;
										};
									}
								};
							}
						};
					}
				};
			}
		}
	};
	this.stateLabel = function ()
	{
		this.subState();
		this.cameraPos.x = 640;
		this.cameraPos.y = this.y;
	};
}

function D3_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_D3_Usami(null);
	this.Set_BossSpellBariaRate(10);
	this.PlaySE(3624);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
	this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
}

function Slave_Usami_D3()
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

function Slave_Attack_D3_Usami( t )
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
							this.Change_Master_D3_Usami(null);
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

function Change_Master_D3_Usami( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.Set_BossSpellBariaRate(1);
	this.team.current.Master_Spell_D3_Move();
}

function Master_Spell_D4()
{
	this.team.slave.Slave_Dream_1();
	this.disableGuard = -1;
	this.armor = -1;
	this.cpuState = null;
	this.com_flag1 = -1.00000000;
	this.com_flag2 = 1;
	this.com_flag3 = null;
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

					this.Master_Spell_D4_Start();
				}
			};
		}
	};
	return true;
}

function Master_Spell_D4_Start()
{
	this.LabelClear();
	this.GetFront();
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.AjustCenterStop();
	this.SetMotion(4911, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(3624);
			this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
			this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
			this.count = 0;
			this.stateLabel = function ()
			{
				this.SetSpeed_XY((640 - this.x) * 0.20000000, (300 - this.y) * 0.20000000);

				if (this.count == 30)
				{
					this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
					this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.GetFront();
					this.SetMotion(this.motion, 3);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count == 20)
						{
							this.SetMotion(this.motion, 5);
							this.keyAction = function ()
							{
								this.Master_Spell_D4_Attack(null);
								return;
							};
						}
					};
				}
			};
		}
	];
}

function Master_Spell_D4_Attack( t )
{
	this.LabelClear();
	this.GetFront();
	this.SetMotion(4940, 0);
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.flag3 = null;
	this.flag4 = null;
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
	this.func = [
		function ()
		{
			this.PlaySE(3624);
			this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
			this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
			this.SetMotion(4940, 5);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
		},
		function ()
		{
			::camera.Shake(8.00000000);
		}
	];

	switch(this.com_difficulty)
	{
	case 0:
		this.flag5.shotCount = 420;
		break;

	case 1:
		this.flag5.shotCount = 480;
		break;

	case 2:
		this.flag5.shotCount = 540;
		break;

	case 3:
		this.flag5.shotCount = 540;
		break;

	case 4:
		this.flag5.shotCount = 540;
		break;
	}

	this.count = 0;
	this.keyAction = [
		null,
		function ()
		{
			if (this.flag3 == null)
			{
				this.PlaySE(3643);
				this.flag3 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_D4, {}).weakref();
			}

			this.stateLabel = function ()
			{
				if (this.count <= this.flag5.shotCount - 180 && this.count % 120 == 119)
				{
					this.func[0].call(this);
					return;
				}

				if (this.count == this.flag5.shotCount - 60)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1.00000000, this.Boss_SpellCharge, {}, this.weakref()).weakref();
				}

				if (this.count == this.flag5.shotCount)
				{
					if (this.flag3)
					{
						this.flag3.func[0].call(this.flag3);
					}

					this.D4_Change_Slave(null);
					return;
				}
			};
		},
		null,
		null,
		function ()
		{
			this.func[0].call(this);
		},
		function ()
		{
			this.Warp(640 - 240 + this.rand() % 480, 300 + 100 - this.rand() % 201);
			this.SetFreeObject(this.x, 0, this.direction, this.SPShot_A, {});
			this.SetFreeObject(this.x, this.y - 25, this.direction, this.SPShot_A2, {});
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.GetFront();
			this.SetMotion(this.motion, 1);
		}
	];
	this.stateLabel = function ()
	{
	};
}

function D4_Change_Slave( t )
{
	this.LabelClear();

	if (this.com_difficulty == 4)
	{
		this.shot_actor.Foreach(function ()
		{
			this.func[1].call(this);
		});
	}
	else
	{
		this.shot_actor.Foreach(function ()
		{
			this.func[0].call(this);
		});
	}

	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream_Middle(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.Master_Spell_D4_Attack(null);
		this.Set_BossSpellBariaRate(1);
	});
	this.Set_BossSpellBariaRate(10);
}

