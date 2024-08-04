function Master_Tutorial_1()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.boss_cpu = function ()
	{
		if (this.Cancel_Check(10))
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				if (this.com_flag2 == 1)
				{
					this.com_flag2 = 0;
					this.Master_Tutorial_1_BackStep(null);
				}
				else
				{
					local r_ = this.rand() % 3;

					switch(r_)
					{
					case 1:
						this.Master_Tutorial_1_SlideUpper(null);
						break;

					case 2:
						this.Master_Tutorial_1_SlideUnder(null);
						break;

					default:
						this.Master_Tutorial_1_BackStep(null);
						break;
					}
				}
			}
			else
			{
				this.Master_Tutorial_1_BackStep(null);
			}
		}
	};
	return true;
}

function Master_Tutorial_1_Com()
{
	if (this.Cancel_Check(10))
	{
		this.Master_Tutorial_1_SlideUpper(null);
	}
}

function Master_Tutorial_1_BackStep( t )
{
	this.GetFront();

	if (this.direction == 1,00000000.0 && this.x <= ::battle.corner_left + 400 || this.direction == -1,00000000.0 && this.x >= ::battle.corner_right - 400)
	{
		this.Master_Tutorial_1_WideShot(t);
		return;
	}

	this.LabelClear();
	this.SetMotion(4986, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.armor = -1;
	this.keyAction = [
		function ()
		{
			this.PlaySE(800);
			this.count = 0;
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 3,00000000.0);

				if (this.count >= 10)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Tutorial_1_WideShot(t);
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Master_Tutorial_1_SlideUpper( t )
{
	this.LabelClear();
	this.SetMotion(4983, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.GetFront();
	this.armor = -1;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.centerStop = -2;

			if (this.direction == 1,00000000.0 && this.x <= ::battle.corner_left + 200 || this.direction == -1,00000000.0 && this.x >= ::battle.corner_right - 200)
			{
				this.SetSpeed_XY(7,00000000.0 * this.direction, -15,50000000.0);
			}
			else
			{
				this.SetSpeed_XY(-5,00000000.0 * this.direction, -15,50000000.0);
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,60000002.0 : 0,25000000.0);
				this.Boss_SlideMotionUpdate(-1,00000000.0);
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Tutorial_1_UnderShot(t);
		}
	];
	return true;
}

function Master_Tutorial_1_SlideUnder( t )
{
	this.LabelClear();
	this.SetMotion(4984, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.GetFront();
	this.armor = -1;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.centerStop = 2;

			if (this.direction == 1,00000000.0 && this.x <= ::battle.corner_left + 200 || this.direction == -1,00000000.0 && this.x >= ::battle.corner_right - 200)
			{
				this.SetSpeed_XY(7,00000000.0 * this.direction, 15,50000000.0);
			}
			else
			{
				this.SetSpeed_XY(-5,00000000.0 * this.direction, 15,50000000.0);
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, this.va.y > 0,00000000.0 ? -0,60000002.0 : -0,25000000.0);
				this.Boss_SlideMotionUpdate(1,00000000.0);
			};
		},
		null,
		null,
		function ()
		{
			this.Master_Tutorial_1_UpperShot(t);
		}
	];
	return true;
}

function Master_Tutorial_1_WideShot( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.flag1 = -5;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.charge <- 120;
	this.flag5.shotNum <- 1;
	this.flag5.shotRot <- 0,00000000.0;

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
		this.flag5.charge = 60;
		this.flag5.shotNum = 20;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0, -2,00000000.0 * this.direction);
		this.CenterUpdate(0,10000000.0, 3,00000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
				this.CenterUpdate(0,10000000.0, 3,00000000.0);

				if (this.count == this.flag5.charge)
				{
					this.SetMotion(4910, 2);

					if (this.flag2)
					{
						this.flag2.func();
					}

					this.flag2 = null;
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					if (this.flag5.shotNum > 0)
					{
						this.PlaySE(1250);

						for( local i = 0; i < 360; i = i + 40 )
						{
							local t_ = {};
							t_.rot <- (i + this.flag5.shotRot) * 0,01745329.0;
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_Tutorial, t_);
						}

						this.flag5.shotRot += 5;
						this.flag5.shotNum--;
					}
					else
					{
						this.armor = 0;
						this.SetMotion(4910, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 3,00000000.0);
			};
		},
		function ()
		{
			if (this.com_flag1 == -1,00000000.0)
			{
				this.Master_Tutorial_1_SlideUpper(null);
			}
			else
			{
				this.Master_Tutorial_1_SlideUnder(null);
			}

			this.com_flag1 *= -1,00000000.0;
		}
	];
	return true;
}

function Master_Tutorial_1_UnderShot( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.armor = -1;
	this.flag1 = -5;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.charge <- 120;
	this.flag5.shotNum <- 1;
	this.flag5.shotRot <- 0,00000000.0;

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
		this.flag5.charge = 60;
		this.flag5.shotNum = 20;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};
	this.GetFront();
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					if (this.flag2)
					{
						this.flag2.func();
					}

					this.flag2 = null;
					this.SetMotion(4910, 2);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					if (this.flag5.shotNum > 0)
					{
						this.PlaySE(1250);

						for( local i = 0; i < 360; i = i + 40 )
						{
							local t_ = {};
							t_.rot <- (i + this.flag5.shotRot) * 0,01745329.0;
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_Tutorial, t_);
						}

						this.flag5.shotRot += 5;
						this.flag5.shotNum--;
					}
					else
					{
						this.armor = 0;
						this.SetMotion(4910, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, 10,00000000.0);
			};
		},
		function ()
		{
			this.LabelClear();
			this.SetMotion(4983, 3);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, 10,00000000.0);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,50000000.0, null);
						this.VX_Brake(0,50000000.0);
					};
					this.keyAction = function ()
					{
						this.LabelClear();
						this.count = 0;
						this.SetMotion(4980, 0);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0,50000000.0, null);
							this.VX_Brake(0,50000000.0);

							if (this.count == 30)
							{
								this.Master_Tutorial_1_BackStep(null);
							}
						};
					};
				}
			};
		}
	];
	return true;
}

function Master_Tutorial_1_UpperShot( t )
{
	this.LabelClear();
	this.SetMotion(4910, 0);
	this.GetFront();
	this.armor = -1;
	this.flag1 = 5;
	this.flag2 = null;
	this.flag5 = {};
	this.flag5.charge <- 120;
	this.flag5.shotNum <- 1;
	this.flag5.shotRot <- 0,00000000.0;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotNum = 4;
		this.flag5.charge = 90;
		break;

	case 2:
		this.flag5.charge = 60;
		this.flag5.shotNum = 10;
		break;

	case 3:
		this.flag5.charge = 60;
		this.flag5.shotNum = 20;
		break;
	}

	this.lavelClearEvent = function ()
	{
		if (this.flag2)
		{
			this.flag2.func();
		}

		this.flag2 = null;
	};
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.flag2 = this.SetEffect(this.x, this.y - 25, 1,00000000.0, this.Boss_SpellCharge, {}, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					if (this.flag2)
					{
						this.flag2.func();
					}

					this.flag2 = null;
					this.SetMotion(4910, 2);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					if (this.flag5.shotNum > 0)
					{
						this.PlaySE(1250);

						for( local i = 0; i < 360; i = i + 40 )
						{
							local t_ = {};
							t_.rot <- (i + this.flag5.shotRot) * 0,01745329.0;
							this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_Tutorial, t_);
						}

						this.flag5.shotRot += 5;
						this.flag5.shotNum--;
					}
					else
					{
						this.armor = 0;
						this.SetMotion(4910, 5);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, 10,00000000.0);
			};
		},
		function ()
		{
			this.LabelClear();
			this.SetMotion(4984, 3);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, 10,00000000.0);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,50000000.0, null);
						this.VX_Brake(0,50000000.0);
					};
					this.keyAction = function ()
					{
						this.LabelClear();
						this.count = 0;
						this.SetMotion(4980, 0);
						this.stateLabel = function ()
						{
							this.CenterUpdate(0,50000000.0, null);
							this.VX_Brake(0,50000000.0);

							if (this.count == 30)
							{
								this.Master_Tutorial_1_BackStep(null);
							}
						};
					};
				}
			};
		}
	];
	return true;
}

function Master_Tutorial_2()
{
	this.team.slave.Slave_Tutorial_2();
	this.disableGuard = -1;
	this.cpuState = null;
	this.com_flag1 = -1,00000000.0;
	this.com_flag2 = 1;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
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

					this.MT2_Position_Change(null);
				}
			};
		}
	};
}

function MT2_Position_Change( t )
{
	this.LabelClear();
	this.SetMotion(4992, 0);
	this.armor = -1;
	this.flag1 = this.Vector3();
	this.flag2 = 0,00000000.0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.GetFront();
	this.centerStop = -2;

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
	{
		this.flag1.x = ::battle.corner_right - 200;
		this.flag1.y = this.centerY - 250;
	}
	else
	{
		this.flag1.x = ::battle.corner_left + 200;
		this.flag1.y = this.centerY - 250;
	}

	this.flag3 = this.flag1.x - this.x;
	this.stateLabel = function ()
	{
		this.Boss_WalkMotionUpdate(this.flag3);
		this.flag2 += 0,33000001.0;

		if (this.flag2 >= 12,50000000.0)
		{
			this.flag2 = 12,50000000.0;
		}

		this.SetSpeed_XY((this.flag1.x - this.x) * 0,10000000.0, (this.flag1.y - this.y) * 0,10000000.0);
		local v_ = this.va.Length();

		if (v_ >= this.flag2)
		{
			this.va.SetLength(this.flag2);
			this.ConvertTotalSpeed();
		}

		if (v_ <= 7,00000000.0)
		{
			this.flag3 = 0,00000000.0;
		}

		if (v_ <= 2,00000000.0)
		{
			this.MT2_Attack(null);
			return;
		}
	};
}

function MT2_Attack( t )
{
	this.LabelClear();
	this.SetMotion(4921, 0);
	this.GetFront();
	this.armor = -1;
	this.count = 0;
	this.flag1 = -400,00000000.0;
	this.flag2 = 0,10000000.0;
	this.flag5 = {};
	this.flag5.vec <- this.Vector3();
	this.flag5.vec.x = 16,00000000.0;
	this.flag5.vec.RotateByDegree(72);
	this.flag5.shotNum <- 4;
	this.flag5.pos <- this.Vector3();
	this.flag5.pos.y = -150;
	this.flag5.shotCycle <- 30;
	this.flag5.shotTimes <- 1;

	switch(this.com_difficulty)
	{
	case 0:
		break;

	case 1:
		this.flag5.shotTimes = 2;
		this.flag5.shotCycle = 30;
		break;

	case 2:
		this.flag5.shotTimes = 3;
		this.flag5.shotCycle = 20;
		break;

	case 3:
		this.flag5.shotTimes = 4;
		this.flag5.shotCycle = 15;
		break;
	}

	if (this.x < (::battle.corner_left + ::battle.corner_right) * 0,50000000.0)
	{
		this.direction = 1,00000000.0;
	}
	else
	{
		this.direction = -1,00000000.0;
	}

	this.AjustCenterStop();
	this.func = function ()
	{
		this.PlaySE(1308);

		for( local i = 0; i < 5; i++ )
		{
			for( local j = 0; j < this.flag5.shotNum; j++ )
			{
				local t_ = {};
				t_.vx <- this.flag5.pos.x * 0,02500000.0;
				t_.vy <- -2 + this.flag5.pos.y * 0,02500000.0;
				this.SetShot(this.x + this.flag5.pos.x, this.y + this.flag5.pos.y, this.direction, this.Boss_Shot_T_StarFall, t_);
				this.flag5.pos += this.flag5.vec;
			}

			this.flag5.vec.RotateByDegree(-72);

			for( local k = 0; k < this.flag5.shotNum; k++ )
			{
				local t_ = {};
				t_.vx <- this.flag5.pos.x * 0,02500000.0;
				t_.vy <- -2 + this.flag5.pos.y * 0,02500000.0;
				this.SetShot(this.x + this.flag5.pos.x, this.y + this.flag5.pos.y, this.direction, this.Boss_Shot_T_StarFall, t_);
				this.flag5.pos += this.flag5.vec;
			}

			this.flag5.vec.RotateByDegree(144);
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count % this.flag5.shotCycle == 1 && this.flag5.shotTimes > 0)
				{
					this.func();
					this.flag5.shotTimes--;
				}

				this.CenterUpdate(0,05000000.0, 0,50000000.0);

				if (this.count >= 180)
				{
					this.SetMotion(this.motion, 4);
					this.count = 0;
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,05000000.0, 0,50000000.0);

						if (this.count == 60)
						{
							this.SetMotion(this.motion, 5);
							this.stateLabel = function ()
							{
								this.CenterUpdate(0,10000000.0, 1,00000000.0);
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
			this.SetMotion(4990, 0);
			this.stateLabel = function ()
			{
				this.MT2_Change_Slave(null);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0, 0,50000000.0);
	};
}

function MT2_Change_Slave( t )
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.ST2_PositionChange(null);
	this.Set_BossSpellBariaRate(20);
}

function Master_A()
{
	this.disableGuard = -1;
	this.cpuState = null;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.boss_cpu = function ()
			{
			};
		}
	};
}

function Master_B_koishi()
{
	this.disableGuard = -1;
	this.boss_spell_func = function ()
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	};
	this.pEvent_getDamage = this.BossDamageFunc;
	this.boss_cpu = function ()
	{
		if (this.BossCall_Init())
		{
			this.boss_cpu = function ()
			{
				if (this.Cancel_Check(10))
				{
					this.Master_B_Wait();
				}
			};
		}
	};
}

function Master_B_Wait()
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(90, 0);

	if (this.team.shield == null)
	{
		this.Set_Boss_Shield(::battle.boss_spell[0].slave_life);
	}

	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.Master_B_Koishi_Change();
			return;
		}
	};
	return true;
}

function Master_B_Koishi_Change()
{
	this.LabelClear();
	this.Boss_ChangeCurrent();
	this.team.current.Slave_B_marisa();
}

