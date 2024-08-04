function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 0)
	{
		this.BeginBattle_Reimu(null);
		return;
	}

	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.BeginBattleA(null);
		break;

	case 1:
		this.BeginBattleB(null);
		break;
	}
}

function Func_Win()
{
	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 0:
		this.WinA(null);
		break;

	case 1:
		this.WinB(null);
		break;
	}
}

function Func_Lose()
{
	this.Lose(null);
}

function BeginBattleA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	local r_ = this.rand() % 4;

	switch(r_)
	{
	case 0:
		this.demoObject = [];
		break;

	case 1:
		this.demoObject = [
			this.SetFreeObject(this.x - 90 * this.direction, this.y, this.direction, this.BeginBattle_Ran, {}).weakref()
		];
		break;

	case 2:
		this.demoObject = [
			this.SetFreeObject(this.x - 90 * this.direction, this.y, this.direction, this.BeginBattle_Ran, {}).weakref(),
			this.SetFreeObject(this.x + 90 * this.direction, this.y, this.direction, this.BeginBattle_ChenA, {}).weakref()
		];
		break;

	case 3:
		this.demoObject = [
			this.SetFreeObject(this.x - 90 * this.direction, this.y, this.direction, this.BeginBattle_Ran, {}).weakref(),
			this.SetFreeObject(this.x + 90 * this.direction, this.y, this.direction, this.BeginBattle_ChenB, {}).weakref()
		];
		break;
	}

	this.keyAction = [
		null,
		null,
		function ()
		{
			this.stateLabel = function ()
			{
			};
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			foreach( a in this.demoObject )
			{
				if (a)
				{
					a.func[1].call(a);
				}
			}

			this.SetMotion(9000, 1);
		}
	};
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9001, 0);
	this.keyAction = [
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.PlaySE(4450);
		}
	};
}

function BeginBattle_Reimu( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9002, 0);
	this.demoObject = [];
	this.team.slave.BeginBattle_SlaveYukari(null);
	this.team.slave.Warp(this.x + 90 * this.direction, this.y - 0);
	this.DrawActorPriority();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
			};
		},
		null,
		function ()
		{
			this.CommonBegin();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.PlaySE(4427);
		}

		if (this.count == 96)
		{
			this.team.slave.func();
		}
	};
}

function BeginBattle_Slave( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9002, 0);
	this.demoObject = [];
	this.Warp(this.x - 160 * this.direction, this.y);
	this.team.master.Warp(this.x + 90 * this.direction, this.y - 0);
	this.DrawActorPriority();
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.PlaySE(4427);
		}

		if (this.count == 120)
		{
			this.team.master.func();
		}
	};
}

function WinA_Sukima( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(9010, 3);
	this.rz = -20 * 0,01745329.0;
	this.sx = 0,10000000.0;
	this.SetSpeed_Vec(60, -110 * 0,01745329.0, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.flag1 = 1,00000000.0;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.flag1 += 0,00500000.0;
				this.sx *= this.flag1;
				this.count++;

				if (this.count >= 4)
				{
					this.Vec_Brake(8,00000000.0, 0,50000000.0);
				}

				if (this.count >= 60)
				{
					this.stateLabel = function ()
					{
						this.alpha -= 0,05000000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count >= 4)
		{
			this.Vec_Brake(8,00000000.0, 0,50000000.0);
		}

		if (this.count >= 15)
		{
			this.func[1].call(this);
		}
	};
}

function WinA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.demoObject = [
		null
	];
	this.keyAction = [
		function ()
		{
			this.PlaySE(4470);
			this.demoObject[0] = this.SetFreeObject(this.x + 192 * this.direction, 720, this.direction, this.WinA_Sukima, {}).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 75)
				{
					this.SetMotion(9010, 2);
				}

				if (this.count == 120)
				{
					this.CommonWin();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function WinB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9011, 0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 24)
				{
					this.PlaySE(4471);
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(4471);
			this.stateLabel = function ()
			{
				if (this.count % 24 == 0)
				{
					this.PlaySE(4471);
				}

				if (this.count == 150)
				{
					this.CommonWin();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Lose( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.CommonLose();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function StageIn_Special()
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9003, 0);
	this.PlaySE(4450);
	this.isVisible = true;
	this.Warp(::battle.start_x[this.team.index], ::battle.start_y[this.team.index]);
	this.keyAction = [
		function ()
		{
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Stand_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.Stand;
	this.SetMotion(0, 0);
}

function MoveFront_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveFront;
	this.SetMotion(1, 0);
	this.SetSpeed_XY(5,00000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5,00000000.0 * this.direction, this.va.y);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- 14,00000000.0;
	this.Guard_Stance_Common(t_);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 7,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- -this.baseSlideSpeed;
	t_.v2 <- -6,00000000.0;
	t_.v3 <- this.baseSlideSpeed;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 7,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- -this.baseSlideSpeed;
	t_.v2 <- -4,00000000.0;
	t_.v3 <- this.baseSlideSpeed;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 7,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- this.baseSlideSpeed;
	t_.v2 <- 4,00000000.0;
	t_.v3 <- this.baseSlideSpeed;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 7,00000000.0;
	t_.front <- 5,00000000.0;
	t_.back <- -5,00000000.0;
	t_.front_rev <- 4,00000000.0;
	t_.back_rev <- -4,00000000.0;
	t_.v <- this.baseSlideSpeed;
	t_.v2 <- 4,00000000.0;
	t_.v3 <- this.baseSlideSpeed;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 5,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -5,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = -7,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = 7,50000000.0;
	this.flag5.g = this.baseGravity;
}

function DashFront_Init( t )
{
	local t_ = {};
	t_.speed <- 5,00000000.0;
	t_.addSpeed <- 0,15000001.0;
	t_.maxSpeed <- 7,50000000.0;
	t_.wait <- 180;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 5,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 150;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 7,50000000.0;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-6,50000000.0 * this.direction, 0,00000000.0);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count >= 90 || this.count >= 15 && this.input.x * this.direction >= 0)
		{
			this.SetMotion(41, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	};
}

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -5,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 16;
	t_.wait <- 80;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 7,50000000.0;
	this.DashBack_Air_Common(t_);
}

function StandUp_Skima( t )
{
	this.SetMotion(35, 4);
	this.DrawActorPriority();
	this.keyAction = this.ReleaseActor;
	this.SetSpeed_XY(0,00000000.0, this.owner.va.y);
	this.stateLabel = function ()
	{
	};
}

function StandUp_Init( t )
{
	this.LabelClear();
	this.team.ResetCombo();
	this.centerStop = -2;
	this.count = 0;

	if (t == 0)
	{
		this.SetMotion(37, 0);
		this.centerStop = -2;
		this.SetSpeed_XY(0,00000000.0, -5,00000000.0);
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
		};
		this.keyAction = [
			function ()
			{
				this.stateLabel = function ()
				{
				};
			},
			function ()
			{
				this.GetFront();
			}
		];
	}
	else
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

		if (t * this.direction >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
			};
			this.SetMotion(35, 0);
			this.keyAction = [
				function ()
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.StandUp_Skima, {});
					this.SetSpeed_XY(90,00000000.0 * this.direction, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				},
				function ()
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.Warp(this.x, this.centerY);
					this.GetFront();
				},
				function ()
				{
					this.GetFront();
				},
				this.EndtoFreeMove
			];
		}
		else
		{
			this.stateLabel = function ()
			{
			};
			this.SetMotion(36, 0);
			this.keyAction = [
				function ()
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.StandUp_Skima, {});
					this.SetSpeed_XY(-90,00000000.0 * this.direction, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				},
				function ()
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.Warp(this.x, this.centerY);
					this.GetFront();
				},
				function ()
				{
					this.GetFront();
				},
				this.EndtoFreeMove
			];
		}
	}
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4400);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4400);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushB_Init( t )
{
	this.Atk_Mid_Init(t);
	this.SetMotion(this.motion + 500, 0);
	this.atk_id = 4;
	this.SetSpeed_XY(8,00000000.0 * this.direction, 0,00000000.0);
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.SetSpeed_XY(5,00000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.VX_Brake(0,40000001.0);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4402);
		}
	];
	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;
	this.SetMotion(1110, 0);
	this.hitCount = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4404);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.hitCount <= 2)
		{
			this.HitCycleUpdate(4);
		}

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_RushC_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1700, 0);
	this.keyAction = [
		function ()
		{
			this.AddSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
			this.PlaySE(1503);
		},
		function ()
		{
			this.HitTargetReset();
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,40000001.0);
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.Atk_HighUnder_Init(t);
	this.SetMotion(this.motion + 500, 0);
	this.atk_id = 128;
	this.flag1 = false;
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4408);
			this.SetSpeed_XY(7,50000000.0 * this.direction, null);
		}
	];
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1211, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4410);
		},
		function ()
		{
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.Atk_HighUpper_Init(t);
	this.SetMotion(1720, 0);
	this.atk_id = 64;
	this.flag1 = false;
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1220, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.PlaySE(4412);
			this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
		},
		function ()
		{
			this.PlaySE(4414);
			this.HitTargetReset();
		}
	];
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1221, 0);
	this.atk_id = 512;
	this.va.x *= 0,75000000.0;

	if (this.fabs(this.va.x) >= 6,00000000.0)
	{
		this.va.x = this.va.x < 0,00000000.0 ? -6,00000000.0 : 6,00000000.0;
	}

	this.va.y *= 0,50000000.0;

	if (this.fabs(this.va.y) >= 5,00000000.0)
	{
		this.va.y = this.va.y < 0,00000000.0 ? -5,00000000.0 : 5,00000000.0;
	}

	this.ConvertTotalSpeed();
	this.hitCount = 0;
	this.subState = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4418);
			this.subState = function ()
			{
				if (this.hitCount <= 3)
				{
					this.HitCycleUpdate(4);
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,20000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}

		this.subState();
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(this.motion + 500, 0);
	this.atk_id = 32;
	this.flag1 = false;
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1730, 0);
	this.atk_id = 2048;
	this.flag1 = false;
	return true;
}

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1230, 0);
	this.atk_id = 32;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4406);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1740, 0);
	this.atk_id = 16;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4406);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
					this.combo_func = null;
					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1110, 3);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_HighFront_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetMotion(1231, 0);
	this.keyAction = [
		function ()
		{
			this.va.x *= 0,75000000.0;

			if (this.fabs(this.va.x) >= 6,00000000.0)
			{
				this.va.x = this.va.y < 0,00000000.0 ? -6,00000000.0 : 6,00000000.0;
			}

			this.va.y *= 0,25000000.0;

			if (this.fabs(this.va.y) >= 3,00000000.0)
			{
				this.va.y = this.va.y < 0,00000000.0 ? -3,00000000.0 : 3,00000000.0;
			}

			this.ConvertTotalSpeed();
			this.PlaySE(4416);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_LowDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1300, 0);
	this.hitCount = 0;
	this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4420);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count >= 18)
		{
			this.VX_Brake(0,50000000.0);
		}

		this.HitCycleUpdate(4);
	};
	return true;
}

function Atk_HighDash_Foot( t )
{
	this.SetMotion(1311, 3);
	this.DrawActorPriority(189);
	this.func = [
		function ()
		{
			this.SetMotion(1311, 4);
			this.keyAction = this.ReleaseActor;
		},
		function ()
		{
			this.SetMotion(1311, 3);
			this.keyAction = this.ReleaseActor;
		}
	];
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.SetMotion(1310, 0);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Atk_HighDash_Foot, {});
	this.lavelClearEvent = function ()
	{
		if (this.flag1)
		{
			this.flag1.func[0].call(this.flag1);
			this.flag1 = null;
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(4476);
			this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.PlaySE(4476);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(4476);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(4476);
			this.HitTargetReset();
		},
		function ()
		{
			this.count = 0;
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,20000000.0, 3,00000000.0);

				if (this.count == 4)
				{
					this.PlaySE(4476);
				}

				this.VX_Brake(1,25000000.0);
			};
		},
		function ()
		{
			this.Atk_HighDash_End(null);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
}

function Atk_HighDash_End( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(1311, 0);
	this.atk_id = 8192;
	this.SetFreeObject(this.x, this.y, this.direction, this.Occult_Object_End_Upper, {}, this.weakref());

	if (this.flag1)
	{
		this.Warp(this.flag1.x, this.flag1.y);
		this.flag1.ReleaseActor();
		this.flag1 = null;
	}

	this.lavelClearEvent = null;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4474);
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
	};
}

function Grab_Actor( t )
{
	this.target = this.initTable.pare.target.weakref();
	this.func = [
		function ()
		{
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		this.target.Warp(this.initTable.pare.point0_x - (this.target.point0_x - this.target.x), this.initTable.pare.y);
	};
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);
	this.target.Warp(this.point0_x, this.y);

	if (this.x > ::battle.corner_right - 80 && this.direction == 1,00000000.0)
	{
		this.Warp(::battle.corner_right - 80, this.y);
	}

	if (this.x < ::battle.corner_left + 80 && this.direction == -1,00000000.0)
	{
		this.Warp(::battle.corner_left + 80, this.y);
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.target.DamageGrab_Common(300, 2, -this.direction);
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
	this.flag2 = null;
	this.stateLabel = function ()
	{
		if (this.Atk_Grab_Hit_Update())
		{
			this.flag1.func[0].call(this.flag1);
			this.target.autoCamera = true;
			this.Grab_Blocked(null);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
			this.Atk_Throw(null);
		}
	];
}

function Atk_Throw( t )
{
	this.LabelClear();
	this.SetMotion(1802, 1);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(4469);
			this.count = 0;
			this.target.autoCamera = true;
			this.flag1.func[0].call(this.flag1);
			this.SetFreeObject(this.x + 50 * this.direction, this.y, this.direction, this.GrabHit_Effect, {});
			this.hitStopTime = 10;
			::camera.shake_radius = 3,00000000.0;
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.KnockBackTarget(-this.direction);
			::battle.enableTimeUp = true;

			if (this.flag2)
			{
				this.flag2.func();
			}

			this.HitReset();
			this.hitResult = 1;
			this.target.team.regain_life -= ((this.target.team.regain_life - this.target.team.life) * 0,50000000.0).tointeger();
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
}

function Shot_Normal_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.flag2.x = 1,00000000.0;
	this.flag2.RotateByDegree(45);
	this.flag3 = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4425);
			this.team.AddMP(-200, 90);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (this.flag3 <= 4)
				{
					this.flag3++;
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2.x;
					t_.v.y = this.flag2.y;
					t_.rot <- 0,00000000.0;
					this.SetShot(this.point0_x + this.flag2.x * 25 * this.direction, this.point0_y + this.flag2.y * 25, this.direction, this.Shot_Normal, t_);
					this.flag2.RotateByDegree(-22,50000000.0);

					if (this.flag3 == 5)
					{
						this.hitResult = 1;
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.flag2.x = 1,00000000.0;
	this.flag2.RotateByDegree(45);
	this.flag3 = 0;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.PlaySE(4425);
			this.team.AddMP(-200, 90);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
				}

				if (this.flag3 <= 4)
				{
					this.flag3++;
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2.x;
					t_.v.y = this.flag2.y;
					t_.rot <- 0,00000000.0;
					this.SetShot(this.point0_x + this.flag2.x * 25 * this.direction, this.point0_y + this.flag2.y * 25, this.direction, this.Shot_Normal, t_);
					this.flag2.RotateByDegree(-22,50000000.0);

					if (this.flag3 == 5)
					{
						this.hitResult = 1;
					}
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.flag2.x = 1,00000000.0;
	this.flag2.RotateByDegree(0);
	this.flag3 = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(4425);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (this.flag3 <= 4)
				{
					this.flag3++;
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2.x;
					t_.v.y = this.flag2.y;
					t_.rot <- -45 * 0,01745329.0;
					this.SetShot(this.point0_x + this.flag2.x * 25 * this.direction, this.point0_y + this.flag2.y * 25, this.direction, this.Shot_Normal, t_);
					this.flag2.RotateByDegree(-22,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.flag2.x = 1,00000000.0;
	this.flag2.RotateByDegree(0);
	this.flag3 = 0;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.PlaySE(4425);
			this.team.AddMP(-200, 90);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
				}

				if (this.flag3 <= 4)
				{
					this.flag3++;
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2.x;
					t_.v.y = this.flag2.y;
					t_.rot <- -45 * 0,01745329.0;
					this.SetShot(this.point0_x + this.flag2.x * 25 * this.direction, this.point0_y + this.flag2.y * 25, this.direction, this.Shot_Normal, t_);
					this.flag2.RotateByDegree(-22,50000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.flag2.x = 1,00000000.0;
	this.flag2.RotateByDegree(90);
	this.flag3 = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(4425);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (this.flag3 <= 4)
				{
					this.flag3++;
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2.x;
					t_.v.y = this.flag2.y;
					t_.rot <- 45 * 0,01745329.0;
					this.SetShot(this.point0_x + this.flag2.x * 25 * this.direction, this.point0_y + this.flag2.y * 25, this.direction, this.Shot_Normal, t_);
					this.flag2.RotateByDegree(-22,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.Vector3();
	this.flag2.x = 1,00000000.0;
	this.flag2.RotateByDegree(90);
	this.flag3 = 0;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.PlaySE(4425);
			this.team.AddMP(-200, 90);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
				}

				if (this.flag3 <= 4)
				{
					this.flag3++;
					local t_ = {};
					t_.v <- this.Vector3();
					t_.v.x = this.flag2.x;
					t_.v.y = this.flag2.y;
					t_.rot <- 45 * 0,01745329.0;
					this.SetShot(this.point0_x + this.flag2.x * 25 * this.direction, this.point0_y + this.flag2.y * 25, this.direction, this.Shot_Normal, t_);
					this.flag2.RotateByDegree(-22,50000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2010, 0);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(4427);
			this.flag1 = this.SetShotStencil(this.point0_x, this.point0_y, this.direction, this.Shot_Front_Core, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
					this.flag1 = null;
				}
			};
		},
		function ()
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2011, 0);
	this.flag1 = null;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(4427);
			this.flag1 = this.SetShotStencil(this.point0_x, this.point0_y, this.direction, this.Shot_Front_Core, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
					this.flag1 = null;
				}
			};
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0, -2,50000000.0 * this.direction);
				this.CenterUpdate(0,05000000.0, null);
			};
		},
		function ()
		{
			if (this.lavelClearEvent)
			{
				this.lavelClearEvent();
			}

			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 4,40000010.0;
	this.flag2.vy <- 2,75000000.0;
	this.flag2.option <- this.SetShot(this.x, this.y, this.direction, this.Shot_Charge_Option, {}).weakref();
	local a_ = this.lavelClearEvent;
	this.lavelClearEvent = function ()
	{
		a_();

		if (this.flag2.option)
		{
			this.flag2.option.func[0].call(this.flag2.option);
		}
	};
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	this.LabelReset();
	this.HitReset();

	if (this.flag1)
	{
		this.flag1.func[0].call(this.flag1);
	}

	this.flag1 = null;
	this.SetMotion(2020, 0);
	this.AjustCenterStop();
	this.flag2.option.func[3].call(this.flag2.option);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.AjustCenterStop();
			this.PlaySE(4432);
			this.hitResult = 1;
			this.flag2.option.func[1].call(this.flag2.option);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,01000000.0, 2,00000000.0);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);
	};
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
	return true;
}

function Shot_Burrage_Init( t )
{
	this.Shot_Burrage_Common(t);
	this.flag2.rot <- 0,00000000.0;
	this.flag2.vx <- 4,40000010.0;
	this.flag2.vy <- 2,75000000.0;
	this.flag2.option <- this.SetShot(this.x, this.y, this.direction, this.Shot_Barrage_Option, {}).weakref();
	this.lavelClearEvent = function ()
	{
		if (this.flag2.option)
		{
			this.flag2.option.func[0].call(this.flag2.option);
		}
	};
	this.subState = function ()
	{
	};
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.lavelClearEvent = function ()
	{
		this.team.op_stop = 300;
		this.team.op_stop_max = 300;
	};
	this.GetFront();
	this.HitReset();
	this.SetMotion(2505, 0);
	this.atk_id = 524288;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.lavelClearEvent = function ()
			{
				this.team.op_stop = 300;
				this.team.op_stop_max = 300;

				if (this.occult_foot)
				{
					this.occult_foot.func[0].call(this.occult_foot);
					this.occult_foot = null;
				}
			};
			this.team.AddMP(-200, 120);
			this.occult_foot = this.SetFreeObject(this.x, this.y, this.direction, this.Occult_Object_Foot, {}, this.weakref()).weakref();
			this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.PlaySE(4472);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);

				if (this.hitResult && this.count >= 7)
				{
					if (this.command.rsv_k2 > 0)
					{
						if (this.command.rsv_x * this.direction >= 0)
						{
							this.Occult_End_Upper();
							return;
						}
						else
						{
							this.Occult_End_Under();
							return;
						}
					}

					if (this.input.y != 0)
					{
						if (this.input.x * this.direction >= 0)
						{
							this.Occult_End_Upper();
							return;
						}
						else
						{
							this.Occult_End_Under();
							return;
						}
					}
				}
			};
		},
		this.Occult_Wait
	];
	this.stateLabel = function ()
	{
	};
}

function Occult_Wait()
{
	this.LabelReset();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2500, 0);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,20000000.0, 3,00000000.0);
		this.GetFront();

		if (this.input.y != 0)
		{
			if (this.input.x * this.direction >= 0)
			{
				this.Occult_End_Upper();
				return;
			}
			else
			{
				this.Occult_End_Under();
				return;
			}
		}

		if (this.command.rsv_k2 > 0 || ::battle.state != 8)
		{
			if (this.command.rsv_x * this.direction >= 0)
			{
				this.Occult_End_Upper();
				return;
			}
			else
			{
				this.Occult_End_Under();
				return;
			}
		}

		if (this.command.rsv_k1 > 0)
		{
			if (this.command.rsv_x * this.direction <= 0)
			{
				this.Okult_Slash();
				return;
			}

			this.Occult_ClowB();
			return;
		}

		if (this.command.rsv_k0 > 0)
		{
			this.Occult_Clow();
			return;
		}

		if (this.input.x)
		{
			this.SetSpeed_XY(this.input.x > 0 ? 8,50000000.0 : -8,50000000.0, null);
		}
		else
		{
			this.VX_Brake(1,50000000.0);
		}
	};
	return true;
}

function Occult_Clow()
{
	this.LabelReset();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.atk_id = 524288;
	this.SetSpeed_XY(0,00000000.0, this.va.y);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.PlaySE(4479);
		},
		this.Occult_Wait
	];
	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,20000000.0, 3,00000000.0);

		if (this.hitResult)
		{
			if (this.input.y != 0)
			{
				if (this.input.x * this.direction >= 0)
				{
					this.Occult_End_Upper();
					return;
				}
				else
				{
					this.Occult_End_Under();
					return;
				}
			}

			if (this.command.rsv_k2 > 0)
			{
				if (this.command.rsv_x * this.direction >= 0)
				{
					this.Occult_End_Upper();
					return;
				}
				else
				{
					this.Occult_End_Under();
					return;
				}
			}

			if (this.command.rsv_k1 > 0)
			{
				if (this.command.rsv_x * this.direction <= 0)
				{
					this.Okult_Slash();
					return;
				}

				this.Occult_ClowB();
				return;
			}

			if (this.command.rsv_k0 > 0 && this.count <= 16)
			{
				this.Occult_Clow_Rush();
				return;
			}
		}

		this.VX_Brake(1,25000000.0);
	};
}

function Occult_Clow_Rush()
{
	this.LabelReset();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2506, 0);
	this.atk_id = 524288;
	this.SetSpeed_XY(0,00000000.0, this.va.y);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4479);
		},
		this.Occult_Wait
	];
	this.count = 0;
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,20000000.0, 3,00000000.0);

		if (this.hitResult)
		{
			if (this.input.y != 0)
			{
				if (this.input.x * this.direction >= 0)
				{
					this.Occult_End_Upper();
					return;
				}
				else
				{
					this.Occult_End_Under();
					return;
				}
			}

			if (this.command.rsv_k2 > 0)
			{
				if (this.command.rsv_x * this.direction >= 0)
				{
					this.Occult_End_Upper();
					return;
				}
				else
				{
					this.Occult_End_Under();
					return;
				}
			}

			if (this.command.rsv_k1 > 0)
			{
				if (this.command.rsv_x * this.direction <= 0)
				{
					this.Okult_Slash();
					return;
				}

				this.Occult_ClowB();
				return;
			}

			if (this.command.rsv_k0 > 0 && this.count <= 16)
			{
				this.Occult_Clow_Rush();
				return;
			}
		}

		this.VX_Brake(1,25000000.0);
	};
}

function Occult_ClowB()
{
	this.LabelReset();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2502, 0);
	this.atk_id = 524288;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4476);
			this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.PlaySE(4476);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(4476);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(4476);
			this.HitTargetReset();
		},
		function ()
		{
			this.count = 0;
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,20000000.0, 3,00000000.0);

				if (this.count == 4)
				{
					this.PlaySE(4476);
				}

				this.VX_Brake(1,25000000.0);

				if (this.input.y != 0)
				{
					if (this.input.x * this.direction >= 0)
					{
						this.Occult_End_Upper();
						return;
					}
					else
					{
						this.Occult_End_Under();
						return;
					}
				}

				if (this.command.rsv_k2 > 0)
				{
					if (this.command.rsv_x * this.direction >= 0)
					{
						this.Occult_End_Upper();
						return;
					}
					else
					{
						this.Occult_End_Under();
						return;
					}
				}
			};
		},
		this.Occult_Wait
	];
	this.stateLabel = function ()
	{
	};
}

function Okult_Slash()
{
	this.LabelReset();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2507, 1);
	this.atk_id = 524288;
	this.AjustCenterStop();
	this.SetSpeed_XY(8,00000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.PlaySE(4472);
			this.count = 0;
			this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);

				if (this.hitResult && this.count >= 7)
				{
					if (this.command.rsv_k2 > 0)
					{
						if (this.command.rsv_x * this.direction >= 0)
						{
							this.Occult_End_Upper();
							return;
						}
						else
						{
							this.Occult_End_Under();
							return;
						}
					}

					if (this.input.y != 0)
					{
						if (this.input.x * this.direction >= 0)
						{
							this.Occult_End_Upper();
							return;
						}
						else
						{
							this.Occult_End_Under();
							return;
						}
					}
				}
			};
		},
		this.Occult_Wait
	];
}

function Occult_End_Under()
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(2503, 0);
	this.atk_id = 524288;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.team.op_stop = 300;
	this.team.op_stop_max = 300;
	this.SetFreeObject(this.x, this.y, this.direction, this.Occult_Object_End_Upper, {}, this.weakref());
	this.Warp(this.occult_foot.x, this.occult_foot.y);

	if (this.abs(this.occult_foot.y - this.centerY) >= 10)
	{
		this.centerStop = 2;
	}
	else
	{
		this.centerStop = 0;
	}

	this.AjustCenterStop();
	this.GetFront();
	this.occult_foot.ReleaseActor();
	this.occult_foot = null;
	this.lavelClearEvent = null;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4474);
		},
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
	};
}

function Occult_End_Upper()
{
	this.LabelReset();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2504, 1);
	this.atk_id = 524288;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.team.op_stop = 300;
	this.team.op_stop_max = 300;
	this.occult_foot.func[1].call(this.occult_foot);
	this.occult_foot = null;
	this.lavelClearEvent = null;
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(4474);
		}
	];
	this.stateLabel = function ()
	{
	};
}

function SP_A_Init( t )
{
	this.LabelClear();

	if (this.IsAttack() && this.target.IsDamage())
	{
		this.HitReset();
		this.hitResult = 1;
		this.SetMotion(3000, 3);
	}
	else
	{
		this.HitReset();
		this.hitResult = 1;
		this.SetMotion(3000, 0);
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = 200,00000000.0;
	this.team.AddMP(-200, 120);
	this.keyAction = [
		function ()
		{
			this.PlaySE(4434);
		},
		function ()
		{
			local t_ = {};
			t_.k <- 1;
			this.SP_A_WarpAttack(t_);
		},
		null,
		function ()
		{
			this.PlaySE(4434);
		},
		function ()
		{
			local t_ = {};
			t_.k <- 1;
			this.SP_A_WarpAttack(t_);
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_A_WarpAttack( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.SP_A_WarpAttack_Air(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(3001, 0);
	this.atk_id = 1048576;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.Warp(this.target.x + 100 * this.direction + this.target.va.x * 15, this.centerY);
	this.AjustCenterStop();
	this.GetFront();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 12 && this.hitResult & 8)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
					};
				}
			};
			this.PlaySE(4435);
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_A_WarpAttack_Air( t )
{
	this.LabelClear();
	this.HitReset();
	this.PlaySE(4482);
	this.atk_id = 1048576;
	this.GetFront();
	this.keyAction = [
		null,
		null,
		null,
		this.EndtoFreeMove
	];

	if (this.y > this.centerY)
	{
		this.SetMotion(3002, 0);
		this.SetSpeed_XY(15,00000000.0 * this.direction, 15,00000000.0);
		this.Warp(this.x, ::battle.scroll_top - 128);
		this.centerStop = -2;
		this.stateLabel = function ()
		{
			if (this.y >= this.centerY)
			{
				if (this.hitResult & 8)
				{
					this.SetMotion(3002, 4);
					this.SetSpeed_XY(7,50000000.0 * this.direction, 7,50000000.0);
				}
				else
				{
					this.SetMotion(3002, 2);
					this.SetSpeed_XY(10,00000000.0 * this.direction, 10,00000000.0);
				}

				this.centerStop = 3;
				this.stateLabel = function ()
				{
					this.CenterUpdate(0,50000000.0, null);

					if (this.centerStop == 0)
					{
						this.VX_Brake(0,50000000.0);
					}
					else
					{
						this.VX_Brake(0,25000000.0, 3,00000000.0 * this.direction);
					}
				};
			}
		};
	}
	else
	{
		this.SetMotion(3002, 1);
		this.SetSpeed_XY(15,00000000.0 * this.direction, -15,00000000.0);
		this.Warp(this.x, ::battle.scroll_bottom + 128);
		this.centerStop = 2;
		this.stateLabel = function ()
		{
			if (this.y <= this.centerY)
			{
				if (this.hitResult & 8)
				{
					this.SetMotion(3002, 4);
					this.SetSpeed_XY(7,50000000.0 * this.direction, -7,50000000.0);
				}
				else
				{
					this.SetMotion(3002, 2);
					this.SetSpeed_XY(10,00000000.0 * this.direction, -10,00000000.0);
				}

				this.centerStop = -3;
				this.stateLabel = function ()
				{
					this.CenterUpdate(0,50000000.0, null);

					if (this.centerStop == 0)
					{
						this.VX_Brake(0,50000000.0);
					}
					else
					{
						this.VX_Brake(0,25000000.0, 3,00000000.0 * this.direction);
					}
				};
			}
		};
	}

	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2097152;
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(1,25000000.0, -1,50000000.0 * this.direction);

				if (this.count == 10)
				{
					this.PlaySE(4437);
					this.HitTargetReset();
					this.count = 0;
					this.SetMotion(3010, 3);
					this.hitCount = 0;
					this.stateLabel = function ()
					{
						if (this.hitCount < 4)
						{
							this.HitCycleUpdate(3);
						}

						if (this.count >= 25)
						{
							this.VX_Brake(0,50000000.0);
						}
						else
						{
							this.AddSpeed_XY(2,00000000.0 * this.direction, 0,00000000.0, 15,00000000.0 * this.direction, null);
						}

						if (this.count == 15)
						{
							this.flag1.func[2].call(this.flag1);
						}

						if (this.count >= 30)
						{
							this.SetSpeed_XY(5,00000000.0 * this.direction, 0,00000000.0);

							if (this.hitCount == 0)
							{
								this.hitResult = 1;
								this.flag1.func[1].call(this.flag1, this.direction);
							}
							else
							{
								this.flag1.func[0].call(this.flag1);
							}

							this.lavelClearEvent = null;
							this.SetMotion(3010, 4);
							this.stateLabel = function ()
							{
								this.VX_Brake(0,50000000.0);
							};
						}
					};
				}
			};
		},
		function ()
		{
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, 1,00000000.0, this.SPShot_B, {}, this.weakref()).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
		}
	];
	this.SetMotion(3010, 0);
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3020, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0;
	this.flag2 = null;
	this.keyAction = [
		function ()
		{
			this.PlaySE(4439);
			this.team.AddMP(-200, 120);
			this.flag2 = this.SetShot(this.x, this.y, this.direction, this.SPShot_C, {}).weakref();
		},
		function ()
		{
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag2 && this.flag2.hitResult & 1)
		{
			this.hitResult = 1;
		}
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = 0;
	this.AjustCenterStop();
	this.SetMotion(3030, 0);
	this.subState = function ()
	{
		this.CenterUpdate(0,25000000.0, 3,00000000.0);
		this.VX_Brake(0,50000000.0);
	};
	local pos_ = this.Vector3();
	pos_.y = -1600,00000000.0;

	for( local i = 0; i < 3; i++ )
	{
		local t_ = {};
		t_.se <- i == 0;
		this.SetShot(this.target.x + pos_.x * this.direction, this.target.y + pos_.y, this.direction, this.SPShot_D, t_);
		pos_.RotateByDegree(120);
	}

	this.keyAction = [
		function ()
		{
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashA, {});
			this.PlaySE(4444);
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag2 = 0;
	this.AjustCenterStop();
	this.SetMotion(3040, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.PlaySE(4441);
			this.hitResult = 1;
			this.team.AddMP(-200, 120);
			this.count = 0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_E, {});
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
				else
				{
					this.CenterUpdate(0,10000000.0, null);
					this.VX_Brake(0,50000000.0, -1,00000000.0 * this.direction);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(4458);
			::camera.SetTarget(640, 360, 1,00000000.0, false);
			this.lavelClearEvent = function ()
			{
				::camera.ResetTarget();
			};
			this.count = 0;
			this.flag1 = 0;
			this.stateLabel = function ()
			{
				if (this.count == 20)
				{
					local t_ = {};
					t_.type <- 0;
					this.SetShot(640 - 700 * this.direction, this.centerY - 80, this.direction, this.SpellShot_A, t_);
					this.hitResult = 1;
				}

				if (this.count >= 110)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4010, 0);
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
			this.PlaySE(4463);

			if (this.ran)
			{
				this.ran.func[0].call(this.ran);
			}

			if (this.chen)
			{
				this.chen.func[0].call(this.chen);
			}

			this.chen = this.SetShot(this.x + 80 * this.direction, this.y, this.direction, this.SpellShot_B_Chen, {}).weakref();
			this.ran = this.SetShot(this.x - 80 * this.direction, this.y, this.direction, this.SpellShot_B_Ran, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.ran)
				{
					this.ran.func[0].call(this.ran);
				}

				if (this.chen)
				{
					this.chen.func[0].call(this.chen);
				}
			};
		},
		function ()
		{
			this.PlaySE(4464);

			if (this.ran)
			{
				this.ran.func[1].call(this.ran);
			}

			if (this.chen)
			{
				this.chen.func[1].call(this.chen);
			}

			this.hitResult = 1;
			this.lavelClearEvent = null;
		}
	];
	return true;
}

function Spell_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4020, 0);
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
			this.PlaySE(4466);
			this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_C, {}).weakref();
			this.lavelClearEvent = function ()
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}
			};
		},
		function ()
		{
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.hitResult = 1;
		},
		function ()
		{
			this.lavelClearEvent = null;

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.stateLabel = function ()
			{
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = null;
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "ÅñÇ\x2557Ç\x2560„YóÌÇ\x255aë´ÇÇ≠ÇÍÅIÅñ");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
		},
		function ()
		{
			this.PlaySE(4451);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShotStencil(this.target.x, this.target.y, this.direction, this.Climax_Shot, t_).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag1 && this.flag1.hitResult & 1)
				{
					this.PlaySE(4453);
					this.Spell_Climax_Hit(null);
					return;
				}

				if (this.count == 60)
				{
					this.SetMotion(this.motion, 5);
					this.stateLabel = null;
					return;
				}
			};
		}
	];
	return true;
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.count = 0;
	this.SetMotion(4901, 0);
	this.target.DamageGrab_Common(301, 2, this.target.direction);
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.PlaySE(4454);
			this.flag2 = this.SetFreeObject(this.target.x, this.target.y, this.direction, this.Climax_Crack, {}).weakref();
		}

		if (this.count == 140)
		{
			this.Spell_Climax_SceneA(null);
			return;
			this.flag2 = this.SetFreeObject(this.target.x, this.target.y, this.direction, this.Climax_Crack, {}).weakref();
		}

		return;

		if (this.count == 300)
		{
			this.FadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 20);
			this.BackFadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 30);
		}

		if (this.count == 60)
		{
			this.SetMotion(4901, 1);
			this.target.DamageGrab_Common(308, 0, this.target.direction);
		}

		if (this.count == 75)
		{
			this.Spell_Climax_Cut(null);
		}
	};
}

function Spell_Climax_SceneA( t )
{
	this.LabelReset();
	this.EraceBackGround();
	this.count = 0;
	this.SetMotion(4901, 3);
	this.DrawActorPriority(1010);
	this.target.DrawActorPriority(1010);
	this.Warp(640 - 120 * this.direction, this.centerY);
	this.PlaySE(4457);
	this.target.DamageGrab_Common(300, 2, this.target.direction);
	this.target.direction = -this.direction;
	this.target.Warp(640 - 60 * this.target.direction, this.centerY);
	this.target.masterRed = this.target.masterGreen = this.target.masterBlue = 0,00000000.0;
	this.flag2.func[0].call(this.flag2);
	this.flag2 = [
		null,
		null,
		null,
		null,
		null
	];
	this.flag2[0] = this.SetFreeObject(this.target.x, this.target.y, this.direction, this.Climax_CrackRed, {}).weakref();
	this.flag2[1] = this.SetFreeObject(this.target.x + 32 * this.direction, this.target.y, this.direction, this.Climax_Grab, {}).weakref();
	this.flag2[3] = this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_Back, {}).weakref();
	this.flag3 = 3,00000000.0;
	::camera.SetTarget(640, 360, this.flag3, true);
	this.func = [
		function ()
		{
			this.SetMotion(4901, 4);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.Spell_Climax_SceneB(null);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.target.masterRed = this.target.masterGreen = this.target.masterBlue = 0,00000000.0;
		this.flag3 += (2,00000000.0 - this.flag3) * 0,10000000.0;
		::camera.SetTarget(640, 360, this.flag3, true);

		if (this.count == 30)
		{
			this.flag2[3].func[1].call(this.flag2[3]);
		}

		if (this.count == 90)
		{
			this.func[0].call(this);
		}
	};
}

function Spell_Climax_SceneB( t )
{
	this.LabelReset();
	this.flag2[3].func[2].call(this.flag2[3]);
	this.count = 0;
	this.flag2[2] = this.SetFreeObject(640, 360, this.direction, this.Climax_Cut, {}).weakref();
	this.flag5 = 0,00000000.0;
	this.flag4 = this.Vector3();
	this.PlaySE(4481);
	this.func = [
		function ()
		{
			this.count = 0;
			this.SetMotion(4901, 7);
			this.flag2[1].func[0].call(this.flag2[1]);
			this.masterRed = this.masterGreen = this.masterBlue = this.red = this.green = this.blue = 0,00000000.0;
			this.stateLabel = function ()
			{
				this.masterRed = this.masterGreen = this.masterBlue = this.target.masterRed = this.target.masterGreen = this.target.masterBlue += (1,00000000.0 - this.masterRed) * 0,15000001.0;

				if (this.count == 5)
				{
					this.flag2[2] = this.SetFreeObject(this.x, this.y, this.direction, this.Climax_Slash, {}).weakref();
				}

				if (this.count == 8 - 3)
				{
					::camera.SetTarget(640 + 120 * this.direction, 360, 3,00000000.0, false);
				}

				if (this.count == 12 - 7)
				{
					this.func[1].call(this);
				}
			};
		},
		function ()
		{
			::sound.PauseBGM(true);
			this.PlaySE(4455);
			this.target.DamageGrab_Common(301, 0, this.target.direction);
			::camera.shake_radius = 20,00000000.0;
			this.flag5 = -20,00000000.0;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.target.Warp(this.target.x + this.flag5 * this.target.direction, this.target.y);
				this.flag5 += 2,00000000.0;

				if (this.flag5 > 0)
				{
					this.flag5 = 0;
				}

				if (this.count == 90)
				{
					this.func[2].call(this);
				}
			};
		},
		function ()
		{
			::sound.PauseBGM(false);
			this.count = 0;
			this.PlaySE(4456);
			this.flag2[2].func[1].call(this.flag2[2]);
			this.flag2[3].func[3].call(this.flag2[3]);
			this.flag4.x = 640 + 40 * this.direction;
			this.flag4.y = 360;
			::camera.SetTarget(this.flag4.x, this.flag4.y, 1,75000000.0, false);
			this.KnockBackTarget(-this.direction);
			this.target.Damage_Slice(null);
			this.masterRed = this.masterGreen = this.masterBlue = 0,00000000.0;
			this.target.team.master.masterRed = this.target.team.master.masterGreen = this.target.team.master.masterBlue = 0,00000000.0;

			if (this.target.team.slave)
			{
				this.target.team.slave.masterRed = this.target.team.slave.masterGreen = this.target.team.slave.masterBlue = 0,00000000.0;
			}

			::camera.shake_radius = 20,00000000.0;
			this.SetFreeObject(this.target.x, this.target.y, this.target.direction, this.Climax_SlashEnemy, {}, this.target.weakref());
			this.SetFreeObject(this.target.x, this.target.y, this.target.direction, this.Climax_SlashEnemy, {}, this.target.flag1.weakref());
			this.stateLabel = function ()
			{
				this.flag4.x += 0,10000000.0 * this.direction;
				this.flag4.y -= 0,10000000.0;
				::camera.SetTarget(this.flag4.x, this.flag4.y, 1,75000000.0, false);
				this.masterRed = this.masterGreen = this.masterBlue = 0,00000000.0;
				this.target.team.master.masterRed = this.target.team.master.masterGreen = this.target.team.master.masterBlue = 0,00000000.0;

				if (this.target.team.slave)
				{
					this.target.team.slave.masterRed = this.target.team.slave.masterGreen = this.target.team.slave.masterBlue = 0,00000000.0;
				}

				if (this.count == 90)
				{
					this.func[3].call(this);
				}
			};
		},
		function ()
		{
			this.DrawActorPriority(180);
			this.DrawActorPriority.call(this.target, 180);
			this.EraceBackGround(false);
			::battle.enableTimeUp = true;
			::camera.ResetTarget();
			this.count = 0;
			this.masterRed = this.masterGreen = this.masterBlue = 1,00000000.0;
			this.target.team.master.masterRed = this.target.team.master.masterGreen = this.target.team.master.masterBlue = 1,00000000.0;

			if (this.target.team.slave)
			{
				this.target.team.slave.masterRed = this.target.team.slave.masterGreen = this.target.team.slave.masterBlue = 1,00000000.0;
			}

			this.target.func[0].call(this.target);

			foreach( a in this.flag2 )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.stateLabel = function ()
			{
				if (this.count == 40)
				{
					this.SetMotion(this.motion, 9);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.flag2[2].func[1].call(this.flag2[2]);
		}

		if (this.count == 80)
		{
			this.func[0].call(this);
		}
	};
}

function Spell_Climax_Cut( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 1);
	this.FadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 1);
	this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 1);
	this.EraceBackGround();
	::battle.enableTimeUp = false;
	this.count = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.flag3 = null;
	this.flag5 = {};
	this.flag5.back <- null;
	this.flag5.cut <- null;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag5.back = this.SetFreeObject(640 + (190 - 640) * this.direction, 610, this.direction, this.owner.Climax_Back, t_).weakref();
	this.flag5.cut = this.SetFreeObject(640 - 640 * this.direction, 0, this.direction, this.Climax_Cut, t_).weakref();
	this.stateLabel = function ()
	{
		if (this.count == 40)
		{
			this.PlaySE(1522);
			this.flag5.cut.func[1].call(this.flag5.cut);
		}

		if (this.count == 100)
		{
			this.PlaySE(1523);
			this.flag5.back.func[1].call(this.flag5.back);
			this.flag5.cut.func[2].call(this.flag5.cut);
		}

		if (this.count == 190)
		{
			this.flag5.back.func[0].call(this.flag5.back);
			this.flag5.cut.func[0].call(this.flag5.cut);
			this.Spell_Climax_InitB(null);
			return;
		}
	};
}

function Spell_Climax_InitB( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4902, 0);
	this.KnockBackTarget(this.target.direction);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.PlaySE(1524);
	this.flag1 = null;
	this.flag2 = null;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag3 = this.SetFreeObject(640 + (190 - 640) * this.direction, 610, this.direction, this.owner.Climax_BackB, {}).weakref();
	this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_).weakref();
	this.flag1.SetParent(this, this.flag1.x - this.x, this.flag1.y - this.y);
	this.flag2 = this.SetShot(this.x + 50 * this.direction, this.y - 75, this.direction, this.Climax_Option, {}).weakref();
	this.flag2.SetParent(this, this.flag2.x - this.x, this.flag2.y - this.y);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count < 180)
		{
			this.HitCycleUpdate(16);
		}

		if (this.count == 180)
		{
			this.EraceBackGround(false);

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			if (this.flag2 && this.flag2.func[1])
			{
				this.flag2.func[1].call(this.flag2);
			}

			if (this.flag3)
			{
				this.flag3.func[0].call(this.flag3);
			}
		}

		if (this.count == 210)
		{
			::battle.enableTimeUp = true;
			this.SetMotion(4900, 5);
			this.stateLabel = null;
		}
	};
	return true;
}

