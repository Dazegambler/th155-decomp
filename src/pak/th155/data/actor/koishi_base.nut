function SenceObject( t )
{
	this.SetMotion(3899, t.take);
	this.EnableTimeStop(false);
	this.alpha = 0.00000000;
	this.rx = 60 * 0.01745329;
	this.ry = 30 * 0.01745329;
	this.rz = t.rot;
	this.sx = this.sy = 1.50000000;
	this.func = [
		function ()
		{
			this.subState = function ()
			{
				this.sx = this.sy += (3.50000000 - this.sx) * 0.15000001;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.alpha = 0.00000000;
				}
			};
		},
		function ()
		{
			this.sx = this.sy = 2.00000000;
			this.subState = function ()
			{
				this.alpha += 0.10000000;
				this.sx = this.sy -= 0.05000000;

				if (this.sx < 1.50000000)
				{
					this.sx = this.sy = 1.50000000;
				}

				if (this.alpha >= 1.00000000)
				{
					this.alpha = 1.00000000;
				}
			};
		}
	];
	this.func[0].call(this);
	this.stateLabel = function ()
	{
		this.Warp(this.team.current.x, this.team.current.y);
		this.rz -= 2.00000000 * 0.01745329;
		this.subState();
	};
}

function SetSkillReset()
{
	if (this.skillE_line)
	{
		this.skillE_line.func();
		this.skillE_line = null;
	}

	foreach( a in this.roseF )
	{
		if (a)
		{
			a.func[1].call(a);
		}
	}
}

function KoishiColor()
{
	if (this.team.life > 0)
	{
		if (this.hide)
		{
			if (this.motion != 40)
			{
				this.hide = false;
			}
			else
			{
				this.masterAlpha -= 0.05000000;

				if (this.masterAlpha <= 0.33000001)
				{
					this.masterAlpha = 0.33000001;
				}
			}
		}
		else
		{
			this.masterAlpha += 0.05000000;

			if (this.masterAlpha > 1.00000000)
			{
				this.masterAlpha = 1.00000000;
			}
		}
	}

	this.CommonColorUpdate();
}

function AutoAttackCheck()
{
	for( local i = 0; i < this.autoCount.len(); i++ )
	{
		if (this.preAutoCount[i] > 0)
		{
			this.preAutoCount[i]--;
		}
		else if (this.autoCount[i] > 0)
		{
			this.autoCount[i]--;
		}
	}

	for( local i = 0; i < this.autoAttack.len(); i++ )
	{
		if (this.autoAttack[i])
		{
			if (this.autoAttack[i].call(this, this.autoTable[i]) && this.preAutoCount[i] <= 0)
			{
				if (this.Cancel_Check(this.autoCancelLevel[i], 0, 0))
				{
					if (this.autoFunc[i].call(this, this.autoTable[i]))
					{
						this.CommonAutoAttackReset(i);
						this.autoAttackTimes[i]++;
						return true;
					}
				}
			}

			if (this.autoCount[i] == 0)
			{
				if (this.Cancel_Check(this.autoCancelLevel[i], 0, 0))
				{
					if (this.timeFunc[i].call(this, this.autoTable[i]))
					{
						this.CommonAutoAttackReset(i);
						this.autoAttackTimes[i]++;
						return true;
					}
				}
			}
		}
	}

	return false;
}

function CommonAutoAttackSet( t, i )
{
	if (t.attackType != 0 && this.attackType[i] == t.attackType)
	{
		this.CommonAutoAttackReset(i);
		return;
	}

	this.autoCount[i] = t.autoCount;
	this.preAutoCount[i] = t.preAutoCount;
	this.autoAttack[i] = t.autoAttack;
	this.attackType[i] = t.attackType;
	this.autoTable[i] = t.autoTable;
	this.autoFunc[i] = t.autoFunc;
	this.timeFunc[i] = t.timeFunc;
	this.autoCancelLevel[i] = t.autoCancelLevel;
	this.sence[i].func[1].call(this.sence[i]);
}

function CommonAutoAttackReset( i )
{
	this.autoCount[i] = 0;
	this.preAutoCount[i] = 0;
	this.autoAttack[i] = null;
	this.attackType[i] = 0;
	this.autoTable[i] = {};
	this.autoFunc[i] = null;
	this.timeFunc[i] = null;
	this.autoCancelLevel[i] = 0;
	this.sence[i].func[0].call(this.sence[i]);
}

function AutoAttackSet( t )
{
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(1390, 0);
	this.flag2 = t;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2450);

			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.keyTake <- 0;
				t_.rot <- (i + 45 + this.rand() % 5) * 0.01745329;
				this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
			}

			this.CommonAutoAttackSet(this.flag2, 0);
			this.autoAttackTimes[0] = 0;
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1.25000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState)
		{
			this.subState();
		}

		this.CenterUpdate(0.10000000, 2.00000000);
		this.VX_Brake(1.25000000);
	};
}

function AutoAttackSet_Charge( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(1391, 0);
	this.SetChargeAura(null);
	this.flag2 = t;
	this.keyAction = [
		function ()
		{
			this.SetChargeAuraB(null);
			this.PlaySE(2450);
			this.CommonAutoAttackSet(this.flag2, 0);

			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.keyTake <- 0;
				t_.rot <- (i + 45 + this.rand() % 5) * 0.01745329;
				this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
			}

			this.autoAttackTimes[0] = 0;
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0.50000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 2.00000000);
		this.VX_Brake(0.50000000);
	};
}

function AutoShotSet( t )
{
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2590, 0);
	this.flag1 = t;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2451);
			this.CommonAutoAttackSet(this.flag1, 1);

			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.keyTake <- 1;
				t_.rot <- (i + 45 + this.rand() % 5) * 0.01745329;
				this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
			}

			this.autoAttackTimes[1] = 0;
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1.25000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 2.00000000);
		this.VX_Brake(1.25000000);
	};
}

function AutoSkillSet( t )
{
	this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
	this.LabelClear();
	this.AjustCenterStop();
	this.HitReset();
	this.hitResult = 1;

	if (t.invin)
	{
		this.SetMotion(3981, 0);
	}
	else
	{
		this.SetMotion(3980, 0);
	}

	this.flag1 = t;
	this.func = null;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2452);
			this.CommonAutoAttackSet(this.flag1, 2);

			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.keyTake <- 2;
				t_.rot <- (i + 45 + this.rand() % 5) * 0.01745329;
				this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
			}

			this.autoAttackTimes[2] = 0;

			if (this.func)
			{
				this.func();
			}
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1.25000000);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0.10000000, 2.00000000);
		this.VX_Brake(1.25000000);
	};
}

function Update_Normal()
{
	if (!this.MainLoopFirst())
	{
		if (this.IsDamage())
		{
			if (this.stateLabel)
			{
				this.stateLabel.call(this);
			}

			return true;
		}
		else
		{
			return false;
		}
	}

	if (::battle.state == 8)
	{
		if (this.IsDamage())
		{
			if (this.attackType[2] == 100 || this.attackType[2] == 102 || this.attackType[2] == 150 || this.attackType[2] == 160 || this.attackType[2] == 161 || this.attackType[2] == 162)
			{
				this.autoCount[2] = 0;
				this.preAutoCount[2] = 0;
				this.autoAttack[2] = null;
				this.autoFunc[2] = null;
				this.timeFunc[2] = null;
				this.attackType[2] = 0;
				this.autoCancelLevel[2] = 0;
				this.autoAttackTimes[2] = 0;
				this.autoTable[2] = {};
				this.sence[2].func[0].call(this.sence[2]);
			}
		}

		if (this.occultCycle > 0)
		{
			if (this.occultRange > 0)
			{
				this.occultCycle--;

				if (this.occultCycle <= 0)
				{
					this.occultCycle = 180;

					if (this.IsAttack() <= 3)
					{
						local r_ = 1.00000000;
						this.occultRange += r_;

						if (this.occultRange >= 12.00000000)
						{
							this.occultRange = 12.00000000;
						}

						local t_ = {};
						t_.scale <- this.occultRange;
						this.SetFreeObject(this.x, this.y - 100, this.direction, this.Occult_AutoPhone, t_);
					}
				}
			}
			else
			{
				this.occultCycle = -1;
			}
		}

		if (this.cpuState)
		{
			this.cpuState();
		}

		if (this.input && this.team.current == this)
		{
			this.Update_Input();
		}
	}
	else
	{
		this.occultCycle = -1;
	}

	if (this.team.combo_stun >= 100 || this.IsDamage() >= 2 || this.team.life <= 0)
	{
		this.autoCount = [
			0,
			0,
			0
		];
		this.preAutoCount = [
			0,
			0,
			0
		];
		this.autoAttack = [
			null,
			null,
			null
		];
		this.autoFunc = [
			null,
			null,
			null
		];
		this.timeFunc = [
			null,
			null,
			null
		];
		this.attackType = [
			0,
			0,
			0
		];
		this.autoCancelLevel = [
			0,
			0,
			0
		];
		this.autoAttackTimes = [
			0,
			0,
			0
		];
		this.autoTable = [
			{},
			{},
			{}
		];
		this.sence[0].func[0].call(this.sence[0]);
		this.sence[1].func[0].call(this.sence[1]);
		this.sence[2].func[0].call(this.sence[2]);
	}

	this.MainLoop();
	this.sneeze--;
	return true;
}

function Update_Input()
{
	if (this.AutoAttackCheck())
	{
		return;
	}

	if (this.command_change())
	{
		return true;
	}

	if (this.team.op >= 1000 && this.team.op_stop == 0 && this.team.master == this && this.command.rsv_k01 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			this.Okult_Init(null);
			this.command.ResetReserve();
			return true;
		}
	}

	if (this.command.rsv_k2 > 0)
	{
		if (this.Cancel_Check(60, 200, 0, false))
		{
			if (this.command.rsv_y < 0)
			{
				this.SP_B_First_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y > 0)
			{
				this.SP_F_Init(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction < 0)
			{
				this.SP_E_Set(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				local t_ = {};
				t_.force <- false;
				this.SP_D2_Init(t_);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x == 0)
			{
				this.SP_G_Init(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k0)
	{
		if (this.motion >= 1200 && this.motion <= 1299 && this.Cancel_Check(40))
		{
			if (this.command.rsv_y > 0)
			{
				this.Atk_HighUnder_Set(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_y < 0)
			{
				this.Atk_HighUpper_Set(null);
				this.command.ResetReserve();
				return true;
			}

			if (this.command.rsv_x * this.direction > 0)
			{
				this.Atk_HighFront_Set(null);
				this.command.ResetReserve();
				return true;
			}
		}
	}

	if (this.command.rsv_k0 && this.command.rsv_y == 0 && this.command.rsv_x * this.direction > 0 && this.centerStop * this.centerStop <= 1 && this.target.centerStop * this.target.centerStop <= 1 && this.abs(this.target.x - this.x) <= 90)
	{
		if (this.team.current.target.invinGrab == 0 && !(this.target.flagState & 8192) && !this.target.IsDamage())
		{
			if (this.Cancel_Check(1))
			{
				this.Atk_Grab_Init(null);
				return true;
			}
		}
	}

	if (this.Input_CommonAttack())
	{
		return true;
	}

	this.InputMove();
}

function TeamSkillChain_Input( input_ )
{
	if (input_.command.rsv_y < 0)
	{
		this.SP_B_First_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_y > 0)
	{
		this.SP_F_Init(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction < 0)
	{
		this.SP_E_Set(null);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x * this.direction > 0)
	{
		local t_ = {};
		t_.force <- false;
		this.SP_D2_Init(t_);
		this.command.ResetReserve();
		return true;
	}

	if (input_.command.rsv_x == 0)
	{
		this.SP_G_Init(null);
		this.command.ResetReserve();
		return true;
	}

	return false;
}

