function Master_Spell_1()
{
	this.team.slave.Slave_Hijiri_1();
	this.disableGuard = -1;
	this.cpuState = null;
	this.resist_baria = true;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
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
	this.SetMotion(4930, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
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
	this.flag5.shotNum <- 2;
	this.flag5.charge <- 120;
	this.flag5.rotSpeed <- 0,00000000.0;
	this.flag5.wait <- 45;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotNum = 3;
		this.flag5.shotCount = 25;
		this.flag5.charge = 90;
		this.flag5.rotSpeed = 0,01745329.0;
		this.flag5.wait = 20;
		break;

	case 2:
		this.flag5.shotNum = 4;
		this.flag5.shotCount = 25;
		this.flag5.charge = 60;
		this.flag5.rotSpeed = 0,03490658.0;
		this.flag5.wait = 0;
		break;

	case 3:
		this.flag5.shotNum = 5;
		this.flag5.shotCount = 25;
		this.flag5.charge = 45;
		this.flag5.rotSpeed = 0,05235988.0;
		this.flag5.wait = 0;
		break;

	case 4:
		this.SetMotion(4931, 0);
		this.flag5.shotNum = 6;
		this.flag5.shotCount = 20;
		this.flag5.charge = 45;
		this.flag5.rotSpeed = 0,05235988.0;
		this.flag5.wait = 0;
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
				if (this.count >= this.flag5.shotCount)
				{
					this.rz = 0,00000000.0;
					this.SetMotion(this.motion, 5);
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
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 2,00000000.0);

				if (this.count >= this.flag5.wait)
				{
					if (this.flag5.shotNum > 0)
					{
						this.GetFront();
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
						};
						return;
					}
					else
					{
						this.M1_Change_Slave(null);
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);

		if (this.count == this.flag5.charge)
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function M1_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Hijiri(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_2()
{
	this.team.slave.Slave_Hijiri_2();
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

					this.MS2_First(null);
				}
			};
		}
	};
}

function MS2_First( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4941, 0);
	this.SetSpeed_XY(-5,00000000.0 * this.direction, 0,00000000.0);
	this.count = 0;
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func();
		}

		this.flag1 = null;
	};
	this.flag1 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, 1,00000000.0);
		this.VX_Brake(0,25000000.0);

		if (this.count >= 75)
		{
			this.MS2_Attack(null);
			this.func[0].call(this);
			return;
		}
	};
}

function MS2_Attack( t )
{
	this.com_flag1++;

	if (this.com_flag1 >= 3)
	{
		this.com_flag1 = 0;
		this.MS2_AttackB(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(4990, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 0,00000000.0;
	this.flag2 = 0;
	this.GetFront();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.Vec_Brake(0,50000000.0, 1,00000000.0))
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 1,00000000.0);

				if (this.centerStop * this.centerStop <= 0)
				{
					this.VX_Brake(0,15000001.0);
				}

				if (this.count >= 60)
				{
					if (this.target.team.life > 0 || ::story.stock > 0)
					{
						this.func[0].call(this);
						return;
					}
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.GetFront();
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(4940, 0);
			this.flag1 = this.rand() % 100 <= 49 ? 1,00000000.0 : -1,00000000.0;
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,33000001.0, this.va.y * 0,33000001.0);
			this.SetMotion(4940, 4);
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0,50000000.0, 1,00000000.0))
				{
					this.AjustCenterStop();
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,10000000.0, null);
					};
				}
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1708);
			this.rz = 45 * this.flag1 * 0,01745329.0;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			this.count = 0;
			this.SetSpeed_Vec(45,00000000.0, this.rz, this.direction);

			if (this.va.y < 0,00000000.0)
			{
				this.centerStop = -2;
			}
			else
			{
				this.centerStop = 2;
			}

			this.stateLabel = function ()
			{
				if (this.va.y < 0,00000000.0 && this.y < this.centerY - 300 || this.va.y > 0,00000000.0 && this.y > this.centerY + 300)
				{
					this.PlaySE(1708);
					this.flag2++;
					this.rz = -this.rz;
					this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
					this.SetSpeed_XY(null, -this.va.y);

					if (this.va.y < 0)
					{
						switch(this.com_difficulty)
						{
						case 0:
							for( local i = 0; i < 2; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 40) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 1:
							for( local i = 0; i < 3; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 20) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 2:
							for( local i = 0; i < 4; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 13,30000019.0) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 3:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 4:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;
						}
					}
					else
					{
						switch(this.com_difficulty)
						{
						case 0:
							for( local i = 0; i < 2; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 40) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 1:
							for( local i = 0; i < 3; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 20) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 2:
							for( local i = 0; i < 4; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 13,30000019.0) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 3:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 4:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;
						}
					}
				}

				if (this.va.x < 0,00000000.0 && this.x < ::battle.corner_left + 100 || this.va.x > 0,00000000.0 && this.x > ::battle.corner_right - 100)
				{
					this.PlaySE(1708);
					this.direction *= -1,00000000.0;
					this.SetSpeed_XY(-this.va.x, null);
				}

				if (this.flag2 >= 2)
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count >= 10)
						{
							this.func[1].call(this);
							return;
						}
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.rz = 0,00000000.0;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.target.team.life > 0 || ::story.stock > 0)
				{
					this.MS2_Attack(null);
					return;
				}

				this.CenterUpdate(0,15000001.0, 2,00000000.0);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,15000001.0);
				}
			};
		}
	];
	return true;
}

function MS2_AttackB( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4990, 0);
	this.AjustCenterStop();
	this.count = 0;
	this.flag1 = 0,00000000.0;
	this.flag2 = 0;
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
	};
	this.GetFront();
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.Vec_Brake(0,50000000.0, 1,00000000.0))
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 1,00000000.0);

				if (this.centerStop * this.centerStop <= 0)
				{
					this.VX_Brake(0,15000001.0);
				}

				if (this.count >= 120)
				{
					if (this.target.team.life > 0 || ::story.stock > 0)
					{
						this.func[0].call(this);
						return;
					}
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.GetFront();
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(4940, 0);
			this.flag1 = this.rand() % 100 <= 49 ? 1,00000000.0 : -1,00000000.0;
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,33000001.0, this.va.y * 0,33000001.0);
			this.SetMotion(4940, 4);
			this.stateLabel = function ()
			{
				if (this.Vec_Brake(0,50000000.0, 1,00000000.0))
				{
					this.AjustCenterStop();
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,10000000.0, null);
					};
				}
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1708);
			this.rz = 45 * this.flag1 * 0,01745329.0;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
			this.count = 0;
			this.SetSpeed_Vec(45,00000000.0, this.rz, this.direction);

			if (this.va.y < 0,00000000.0)
			{
				this.centerStop = -2;
			}
			else
			{
				this.centerStop = 2;
			}

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
			this.stateLabel = function ()
			{
				if (this.va.y < 0,00000000.0 && this.y < this.centerY - 300 || this.va.y > 0,00000000.0 && this.y > this.centerY + 300)
				{
					this.PlaySE(1708);
					this.flag2++;
					this.rz = -this.rz;
					this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
					this.SetSpeed_XY(null, -this.va.y);

					if (this.va.y < 0)
					{
						switch(this.com_difficulty)
						{
						case 0:
							for( local i = 0; i < 2; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 40) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 1:
							for( local i = 0; i < 3; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 20) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 2:
							for( local i = 0; i < 4; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 13,30000019.0) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 3:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 4:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (-50 - i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;
						}
					}
					else
					{
						switch(this.com_difficulty)
						{
						case 0:
							for( local i = 0; i < 2; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 40) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 1:
							for( local i = 0; i < 3; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 20) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 2:
							for( local i = 0; i < 4; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 13,30000019.0) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 3:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;

						case 4:
							for( local i = 0; i < 5; i++ )
							{
								local t_ = {};
								t_.rot <- (50 + i * 10) * 0,01745329.0;
								t_.wait <- 40 + 10 * i;
								t_.rot2 <- (15 - i * 15) * 0,01745329.0;
								this.SetShot(this.x, this.y, this.direction, this.Shot_Boss_MS2, t_, this);
							}

							break;
						}
					}
				}

				if (this.va.x < 0,00000000.0 && this.x < ::battle.corner_left + 100 || this.va.x > 0,00000000.0 && this.x > ::battle.corner_right - 100)
				{
					this.PlaySE(1708);
					this.direction *= -1,00000000.0;
					this.SetSpeed_XY(-this.va.x, null);
				}

				if (this.flag2 >= 6)
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count >= 10)
						{
							this.M2_Change_Slave(null);
							return;
						}
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.rz = 0,00000000.0;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.target.team.life > 0 || ::story.stock > 0)
				{
					this.MS2_Attack(null);
					return;
				}

				this.CenterUpdate(0,15000001.0, 2,00000000.0);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,15000001.0);
				}
			};
		}
	];
	return true;
}

function M2_Change_Slave( t )
{
	this.LabelClear();
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Hijiri2(v_);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_3()
{
	this.team.slave.Slave_Hijiri_3();
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

					this.Master_Spell_3_Attack(null);
				}
			};
		}
	};
}

function Master_Spell_3_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4930, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
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
	this.flag5.shotNum <- 2;
	this.flag5.charge <- 60;
	this.flag5.rotSpeed <- 0,00000000.0;
	this.flag5.wait <- 45;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotNum = 2;
		this.flag5.shotCount = 25;
		this.flag5.charge = 60;
		this.flag5.rotSpeed = 0,01745329.0;
		this.flag5.wait = 20;
		break;

	case 2:
		this.flag5.shotNum = 3;
		this.flag5.shotCount = 25;
		this.flag5.charge = 60;
		this.flag5.rotSpeed = 0,03490658.0;
		this.flag5.wait = 0;
		break;

	case 3:
		this.flag5.shotNum = 4;
		this.flag5.shotCount = 25;
		this.flag5.charge = 60;
		this.flag5.rotSpeed = 0,05235988.0;
		this.flag5.wait = 0;
		break;

	case 4:
		this.SetMotion(4931, 0);
		this.flag5.shotNum = 6;
		this.flag5.shotCount = 20;
		this.flag5.charge = 45;
		this.flag5.rotSpeed = 0,05235988.0;
		this.flag5.wait = 0;
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
			this.count = 0;

			if (this.flag5.shotNum <= 0)
			{
				this.M3_Change_Slave(null);
				return;
			}

			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 2,00000000.0);

				if (this.count >= this.flag5.wait)
				{
					if (this.flag5.shotNum > 0)
					{
						this.GetFront();
						this.SetMotion(4930, 3);
						this.stateLabel = function ()
						{
						};
						return;
					}
					else
					{
						this.M3_Change_Slave(null);
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);

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

function M3_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Hijiri3();
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_4()
{
	this.team.slave.Slave_Hijiri_5();
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

					this.MS4_Attack_Under(null);
				}
			};
		}
	};
}

function MS4_Attack_Under( t )
{
	this.LabelClear();
	this.SetMotion(4922, 0);
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.GetFront();
	this.com_flag1++;
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag1 = 60;
	this.flag3 = 12,50000000.0;
	this.flag5 = 0;

	if (this.com_flag1 == 4)
	{
		this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	}

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
		this.flag1 = 40;
		this.flag3 = 15,00000000.0;
		this.flag5 = 3;
		break;

	case 2:
		this.flag1 = 30;
		this.flag3 = 18,00000000.0;
		this.flag5 = 5;
		break;

	case 3:
		this.flag1 = 20;
		this.flag3 = 21,00000000.0;
		this.flag5 = 7;
		break;

	case 4:
		this.flag1 = 20;
		this.flag3 = 21,00000000.0;
		this.flag5 = 9;
		break;
	}

	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.PlaySE(1713);
			this.SetSpeed_XY(this.flag3 * this.direction, this.flag3);
			this.centerStop = 2;
			this.SetMotion(this.motion, 3);
			local r_ = 0,26179937.0;
			local i = 0;

			while (i < this.flag5)
			{
				local t_ = {};
				t_.v <- 10,50000000.0 - i;
				t_.rot <- 0,78539813.0 - r_;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS4, t_);
				local t_ = {};
				t_.v <- 10,50000000.0 - i;
				t_.rot <- 0,78539813.0 + r_;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS4, t_);
				i++;
				r_ = r_ + 0,17453292.0;
			}

			this.stateLabel = function ()
			{
				if (this.y > this.centerY + 150)
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
					this.MS4_Attack_Upper(null);
					return;
				}
			};
		},
		function ()
		{
			this.MS4_Attack_Upper(null);
		}
	];
}

function MS4_Attack_Upper( t )
{
	this.LabelClear();
	this.SetMotion(4923, 0);
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.GetFront();
	this.com_flag1++;
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.flag1 = 60;
	this.flag5 = 0;

	if (this.com_flag1 == 4)
	{
		this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	}

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
		this.flag1 = 40;
		this.flag3 = 15,00000000.0;
		this.flag5 = 3;
		break;

	case 2:
		this.flag1 = 30;
		this.flag3 = 18,00000000.0;
		this.flag5 = 5;
		break;

	case 3:
		this.flag1 = 20;
		this.flag3 = 21,00000000.0;
		this.flag5 = 7;
		break;

	case 4:
		this.flag1 = 20;
		this.flag3 = 21,00000000.0;
		this.flag5 = 9;
		break;
	}

	this.flag2 = this.Vector3();
	this.func = [
		function ()
		{
			this.PlaySE(1713);
			this.SetSpeed_XY(this.flag3 * this.direction, -this.flag3);
			this.centerStop = 2;
			this.SetMotion(this.motion, 3);
			local r_ = 0,26179937.0;
			local i = 0;

			while (i < this.flag5)
			{
				local t_ = {};
				t_.v <- 10,50000000.0 - i;
				t_.rot <- -0,78539813.0 - r_;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS4, t_);
				local t_ = {};
				t_.v <- 10,50000000.0 - i;
				t_.rot <- -0,78539813.0 + r_;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_MS4, t_);
				i++;
				r_ = r_ + 0,17453292.0;
			}

			this.stateLabel = function ()
			{
				if (this.y < this.centerY - 150)
				{
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(this.va.x * 0,34999999.0, this.va.y * 0,34999999.0);
					this.stateLabel = function ()
					{
						this.Vec_Brake(0,50000000.0, 2,00000000.0);
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
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
			this.SetSpeed_XY(0,00000000.0, 10,00000000.0);
			this.centerStop = -2;
			this.flag2.x = this.target.x - (this.target.y + 200) * this.direction;
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
					this.MS4_Attack_Under(null);
					return;
				}
			};
		},
		function ()
		{
			if (this.com_flag1 >= 4)
			{
				this.com_flag1 = this.rand() % 2;
				this.M4_Change_Slave(null);
			}
			else
			{
				this.MS4_Attack_Under(null);
			}
		}
	];
}

function M4_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Hijiri4(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_5_OD()
{
	this.team.slave.Slave_Hijiri_5();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = 0;
	this.com_flag2 = 0;
	this.resist_baria = true;
	::battle.enable_demo_talk = true;
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

					this.MS5_Attack(null);
				}
			};
		}
	};
}

function MS5_Attack( t )
{
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.LabelClear();
	this.SetMotion(4970, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag4 = null;
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;

		if (this.flag5.back)
		{
			this.flag5.back.func[0].call(this.flag5.back);
		}

		this.flag5.bit.Foreach(function ()
		{
			this.func[0].call(this);
		});
	};
	this.flag5 = {};
	this.flag5.shotCycle <- 6;
	this.flag5.shotCount <- 25;
	this.flag5.shotNum <- 2;
	this.flag5.charge <- 120;
	this.flag5.rotSpeed <- 0,00000000.0;
	this.flag5.wait <- 45;
	this.flag5.bit <- ::manbow.Actor2DProcGroup();
	this.flag5.back <- null;
	this.flag5.moveCount <- 0;
	this.flag5.pos <- this.Vector3();
	this.flag5.v <- 0,00000000.0;

	switch(this.com_difficulty)
	{
	case 1:
		break;

	case 2:
		break;

	case 3:
		break;

	case 4:
		break;
	}

	this.func = [
		function ()
		{
			this.GetFront();
			this.SetMotion(4970, 0);
			local r_ = this.rand() % 360 * 0,01745329.0;

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- r_ + (22,50000000.0 + 45 * i) * 0,01745329.0;
				this.flag5.bit.Add(this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_MS5, t_));
			}

			this.count = 0;
			this.subState[1] = function ()
			{
				if (this.count == 50)
				{
					this.PlaySE(849);
					this.flag5.bit.Foreach(function ()
					{
						this.func[1].call(this);
					});
				}

				if (this.count >= 50 && this.count <= 300 && this.count % this.flag5.shotCycle == 1 && this.count % 50 <= 15)
				{
					this.PlaySE(870);
					this.flag5.bit.Foreach(function ()
					{
						this.func[5].call(this);
					});
				}

				if (this.count == 300)
				{
					this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
					this.flag5.bit.Foreach(function ()
					{
						this.func[2].call(this);
					});
					this.flag5.bit.Foreach(function ()
					{
						this.func[4].call(this);
					});
				}

				if (this.count == 390)
				{
					this.subState[0] = function ()
					{
						this.Vec_Brake(0,75000000.0);
					};
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

						if (this.flag5.back)
						{
							this.flag5.back.func[0].call(this.flag5.back);
						}

						::camera.lock = false;
						::camera.auto_zoom_limit = 2,00000000.0;
					};
					this.PlaySE(1740);
					this.SetMotion(4972, 0);
					this.flag5.bit.Foreach(function ()
					{
						this.func[3].call(this);
					});
				}

				if (this.count == 450)
				{
					this.com_flag1 = 0;
					this.M5_Change_Slave(null);
				}
			};
		},
		function ()
		{
			this.SetSpeed_Vec(0,50000000.0, this.rand() % 21 * 0,01745329.0, 1,00000000.0);

			if (this.x > (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
			{
				this.va.x *= -1,00000000.0;
			}

			if (this.y > this.centerY - 50)
			{
				this.va.y *= -1,00000000.0;
			}

			this.ConvertTotalSpeed();
			this.flag5.moveCount = 0;
			this.subState[0] = function ()
			{
				this.flag5.moveCount++;
				this.AddSpeed_Vec(0,10000000.0, null, 2,00000000.0, this.direction);

				if (this.flag5.moveCount >= 90)
				{
					this.subState[0] = function ()
					{
						this.flag5.moveCount++;
						this.Vec_Brake(0,05000000.0);

						if (this.flag5.moveCount >= 150)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.subState = [
		function ()
		{
			this.Vec_Brake(0,50000000.0);
		},
		function ()
		{
		}
	];
	this.func[0].call(this);
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.subState[0].call(this);
		this.subState[1].call(this);
	};
}

function M5_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Hijiri5(null);
	this.Set_BossSpellBariaRate(10);
}

function Master_Spell_D1()
{
	this.team.slave.Slave_Dream_1();
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

					this.DS1_Attack(null);
				}
			};
		}
	};
}

function DS1_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4931, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
	this.com_flag1 = 0;
	this.flag3 = 0;
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
	this.flag5.shotCount <- 15;
	this.flag5.shotNum <- 1;
	this.flag5.charge <- 120;
	this.flag5.rotSpeed <- 0,00000000.0;
	this.flag5.wait <- 30;

	switch(this.com_difficulty)
	{
	case 1:
		this.flag5.shotNum = 2;
		this.flag5.charge = 90;
		this.flag5.rotSpeed = 0,01745329.0;
		this.flag5.wait = 15;
		break;

	case 2:
		this.flag5.charge = 60;
		this.flag5.shotNum = 3;
		this.flag5.rotSpeed = 0,03490658.0;
		this.flag5.wait = 15;
		break;

	case 3:
	case 4:
		this.flag5.shotNum = 4;
		this.flag5.charge = 45;
		this.flag5.rotSpeed = 0,05235988.0;
		this.flag5.wait = 10;
		break;
	}

	this.AjustCenterStop();
	this.func = [
		function ()
		{
		}
	];
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
			this.flag3++;
			this.GetFront();
			this.rz = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.rz = this.Math_MinMax(this.rz, -1,57079601.0, 1,57079601.0);
			this.SetSpeed_Vec(20,00000000.0, this.rz, this.direction);
			this.count = 0;
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0, 15,00000000.0);

				if (this.count >= this.flag5.shotCount)
				{
					this.rz = 0,00000000.0;
					this.SetMotion(this.motion, 5);
					this.AjustCenterStop();
					this.stateLabel = function ()
					{
						if (this.count >= this.flag5.wait)
						{
							this.keyAction[5].call(this);
							return;
						}

						if (this.Vec_Brake(2,00000000.0, 2,00000000.0))
						{
							this.stateLabel = function ()
							{
								this.CenterUpdate(0,10000000.0, 2,00000000.0);

								if (this.count >= this.flag5.wait)
								{
									this.keyAction[5].call(this);
									return;
								}
							};
						}
					};
					return;
				}

				local t_ = {};
				t_.rot <- this.rz;
				this.SetShot(this.x + 100 - this.rand() % 201, this.y - 100 + this.rand() % 201, this.direction, this.Boss_Shot_DS1, t_);
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.GetFront();
			this.stateLabel = function ()
			{
				this.Vec_Brake(2,00000000.0, 2,00000000.0);
				this.CenterUpdate(0,10000000.0, 2,00000000.0);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}

				if (this.count >= this.flag5.wait)
				{
					if (::battle.state == 8)
					{
						if (this.flag5.shotNum > this.flag3)
						{
							if (this.flag5.shotNum - 1 == this.flag3 && this.com_flag1 == 1 && this.com_difficulty <= 3)
							{
								this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
							}

							this.SetMotion(this.motion, 3);
							this.stateLabel = function ()
							{
							};
							return;
						}
						else if (this.count >= 60)
						{
							if (this.com_flag1 <= 0)
							{
								this.flag3 = 0;
								this.com_flag1++;
								this.SetMotion(this.motion, 3);
								this.stateLabel = function ()
								{
								};
								return;
							}
							else
							{
								this.com_flag1 = 0;

								if (this.com_difficulty == 4)
								{
									this.DS1_AttackB(null);
								}
								else
								{
									this.DS1_Change_Slave(null);
								}
							}
						}
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);

		if (this.count == 75)
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function DS1_AttackB( t )
{
	this.LabelClear();
	this.SetMotion(4932, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.centerStop = -2;
	this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
	this.AjustCenterStop();
	this.flag4 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag4)
		{
			this.flag4.func();
		}

		this.flag4 = null;
		this.autoCamera = true;
		this.freeMap = false;
	};
	this.flag5 = {};
	this.flag5.shotCycle <- 15;
	this.flag5.shotCount <- 30;
	this.flag5.shotNum <- 9;
	this.flag5.stop <- false;
	this.flag5.rotSpeed <- 0,00000000.0;
	this.flag5.wait <- 0;
	this.func = [
		function ()
		{
			this.count = 0;
			::battle.SetSlow(60);
			this.PlaySE(1762);
			this.SetSpeed_Vec(30,00000000.0, this.rz, this.direction);
			this.freeMap = true;
			this.stateLabel = function ()
			{
				this.Vec_Brake(12,50000000.0, 1,00000000.0);

				if (this.count == 30)
				{
					this.SetSpeed_Vec(50,00000000.0, this.rz, this.direction);
					this.autoCamera = false;
					this.count = 0;
					::camera.Shake(15,00000000.0);
					this.stateLabel = function ()
					{
						this.cameraPos.x = this.target.x + (this.x - this.target.x) * 0,20000000.0;
						this.cameraPos.y = this.target.y + (this.y - this.target.y) * 0,20000000.0;

						if (this.count >= this.flag5.shotCount)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		},
		function ()
		{
			this.SetMotion(4932, 6);
			this.count = 0;

			if (this.flag5.shotNum < 8)
			{
				this.flag5.shotCycle = 6;
				this.flag5.shotCount -= 3;
			}

			this.stateLabel = function ()
			{
				this.Vec_Brake(6,00000000.0, 3,00000000.0);

				if (this.count >= this.flag5.shotCycle)
				{
					this.keyAction[6].call(this);
					return;
				}
			};
		}
	];
	this.keyAction = [
		null,
		null,
		null,
		function ()
		{
			this.func[0].call(this);
		},
		null,
		null,
		function ()
		{
			if (this.flag5.shotNum <= 0)
			{
				this.team.slave.shot_actor.Foreach(function ()
				{
					this.func[0].call(this);
				});
				this.DS1_Change_Slave(null);
				return;
			}

			this.GetFront();
			this.rz = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			local t_ = {};
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.Boss_Shot_DS1_Line, t_);
			this.stateLabel = function ()
			{
				this.Vec_Brake(6,00000000.0, 0,00000000.0);
			};
		},
		function ()
		{
			this.PlaySE(1762);
			this.flag5.shotNum--;
			this.flag5.stop = false;
			this.count = 0;
			this.SetSpeed_Vec(20,00000000.0, this.rz, this.direction);
			this.stateLabel = function ()
			{
				local t_ = {};
				t_.rot <- this.rz;
				this.SetShot(this.x + 25 - this.rand() % 51, this.y - 25 + this.rand() % 51, this.direction, this.Boss_Shot_DS1_B, t_);

				if (!this.IsScreen(200))
				{
					this.flag5.stop = true;
				}

				if (this.IsScreen(300) && this.flag5.stop)
				{
					this.Vec_Brake(50,00000000.0, 3,00000000.0);
				}
				else
				{
					this.AddSpeed_Vec(2,00000000.0, this.rz, 50,00000000.0, this.direction);
				}

				this.cameraPos.x = this.target.x + (this.x - this.target.x) * 0,20000000.0;
				this.cameraPos.y = this.target.y + (this.y - this.target.y) * 0,20000000.0;

				if (this.count >= this.flag5.shotCount)
				{
					this.func[1].call(this);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,50000000.0, -1,00000000.0 * this.direction);
		}

		this.CenterUpdate(0,05000000.0, 3,00000000.0);

		if (this.count >= 75)
		{
			if (this.flag4)
			{
				this.flag4.func();
			}

			this.flag4 = null;
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function DS1_Change_Slave( t )
{
	this.LabelClear();
	local v_ = this.Vector3();
	v_.x = this.va.x;
	v_.y = this.va.y;
	this.shot_actor.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.Boss_ChangeCurrent();
	this.team.current.Slave_Attack_Dream_Hijiri(function ()
	{
		this.LabelClear();
		this.Boss_ChangeCurrent();
		this.team.current.DS1_Attack(null);
		this.Set_BossSpellBariaRate(1);
	});
	this.team.slave.SetSpeed_XY(this.va.x * 0,10000000.0, this.va.y * 0,10000000.0);
	this.Set_BossSpellBariaRate(10);
}

function Slave_Miko_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.resist_baria = true;
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
	case 4:
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
	this.resist_baria = true;
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
	};
}

function Slave_Attack_Jyoon3()
{
	this.LabelClear();

	if (this.com_difficulty == 4)
	{
		this.SetMotion(4931, 0);
	}
	else
	{
		this.SetMotion(4930, 0);
	}

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

	case 4:
		this.flag5.shotNum = 8;
		this.flag5.shotCount = 20;
		this.flag5.charge = 30;
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
					this.SetMotion(this.motion, 5);
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
				this.SetMotion(this.motion, 3);
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
			this.SetMotion(this.motion, 3);
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

