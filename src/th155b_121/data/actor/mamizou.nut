function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 11)
	{
		this.BeginBattle_Mokou(null);
		return;
	}

	local r_ = this.rand() % 2;

	switch(r_)
	{
	case 1:
		this.BeginBattleB(null);
		break;

	case 0:
		this.BeginBattle(null);
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

function BeginBattle( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
			this.PlaySE(2690);
			this.demoObject.append(this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.CommonSmoke_Demo, {}).weakref());
		},
		null,
		null,
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9001, 7);
	this.demoObject = [];
	local st_ = function ( t_ )
	{
		this.SetMotion(9001, 0);
		this.func = function ()
		{
			this.owner.demoObject.append(this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.CommonSmoke_Demo, {}).weakref());
			this.SetMotion(5996, this.rand() % 5);
			this.SetSpeed_XY(5,00000000.0 * this.direction, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.rz += 15,00000000.0 * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

				if (this.IsScreen(300))
				{
					this.ReleaseActor();
				}
			};
		};
		this.keyAction = [
			null,
			function ()
			{
				this.PlaySE(2691);
			},
			function ()
			{
				this.PlaySE(2692);
			}
		];
	};
	this.option = this.SetFreeObject(this.x + 64,00000000.0 * this.direction, this.y, this.direction, st_, {}).weakref();
	this.demoObject.append(this.option.weakref());
	this.Warp(this.x - 300 * this.direction, this.y);
	this.flag1 = this.Vector3();

	if (this.team.index == 0)
	{
		this.flag1.x = ::battle.start_x[0];
		this.flag1.y = ::battle.start_y[0];
	}
	else
	{
		this.flag1.x = ::battle.start_x[1];
		this.flag1.y = ::battle.start_y[1];
	}

	this.keyAction = [
		null,
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 390)
		{
			this.SetMotion(9001, 5);
			this.stateLabel = function ()
			{
				this.SetSpeed_XY((this.flag1.x - this.x) * 0,20000000.0 + 10 * this.direction, 0,00000000.0);

				if (this.direction == 1,00000000.0 && this.x + this.va.x > this.flag1.x || this.direction == -1,00000000.0 && this.x + this.va.x < this.flag1.x)
				{
					this.Warp(this.flag1.x, this.flag1.y);

					if (this.option)
					{
						this.option.func();
					}

					this.SetMotion(9001, 6);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});
					this.PlaySE(2693);
					this.stateLabel = null;
				}
			};
		}
	};
}

function BeginBattle_Mokou( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9002, 0);
	this.demoObject = [];
	this.team.slave.BeginBattle_Slave(null);
	this.freeMap = true;
	this.Warp(640 - 960 * this.direction, this.y);
	this.team.slave.Warp(this.x - 20 * this.direction, this.y);
	this.DrawActorPriority();
	this.flag1 = this.Vector3();
	this.flag1.x = ::battle.start_x[this.team.index];
	this.flag1.y = ::battle.start_y[this.team.index];
	this.func = [
		function ()
		{
			this.PlaySE(2716);
			this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.direction = -this.direction;
			this.team.slave.direction = this.direction;
			this.PlaySE(2716);
			this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
			this.Warp(this.direction == 1,00000000.0 ? ::camera.camera2d.left - 128 : ::camera.camera2d.right + 128, this.y);
		},
		function ()
		{
			this.direction = -this.direction;
			this.team.slave.func();
			this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.PlaySE(2718);
			this.Warp(this.direction == 1,00000000.0 ? ::camera.camera2d.left - 128 : ::camera.camera2d.right + 128, this.y);
			this.count = 0;
			this.SetMotion(this.motion, 4);
			this.stateLabel = function ()
			{
				if (this.abs(this.flag1.x - this.x) <= 100)
				{
					this.PlaySE(2717);
					this.SetMotion(this.motion, 1);
					this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);

						if (this.direction == 1,00000000.0 && this.x > this.flag1.x || this.direction == -1,00000000.0 && this.x < this.flag1.x)
						{
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
							this.Warp(this.flag1.x, this.y);
							this.count = 0;
							this.stateLabel = function ()
							{
								if (this.count == 120)
								{
									this.SetMotion(this.motion, 3);
									this.keyAction = function ()
									{
										this.freeMap = false;
										this.EndtoFreeMove();
										this.CommonBegin();
									};
								}
							};
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.team.slave.Warp(this.x - 20 * this.direction, this.y - 76);

		if (this.count == 30)
		{
			this.func[0].call(this);
		}

		if (this.count == 150)
		{
			this.func[1].call(this);
		}

		if (this.count == 240)
		{
			this.func[2].call(this);
		}
	};
}

function BeginBattle_Slave( t )
{
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9002, 0);
	this.demoObject = [];
	this.freeMap = true;
	this.Warp(640 - 960 * this.direction, this.y);
	this.team.master.Warp(this.x - 20 * this.direction, this.y);
	this.DrawActorPriority();
	this.flag1 = this.Vector3();
	this.flag1.x = ::battle.start_x[this.team.index];
	this.flag1.y = ::battle.start_y[this.team.index];
	this.func = [
		function ()
		{
			this.PlaySE(2716);
			this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
		},
		function ()
		{
			this.direction = -this.direction;
			this.team.master.direction = this.direction;
			this.PlaySE(2716);
			this.SetSpeed_XY(20,00000000.0 * this.direction, 0,00000000.0);
			this.Warp(this.direction == 1,00000000.0 ? ::camera.camera2d.left - 128 : ::camera.camera2d.right + 128, this.y);
		},
		function ()
		{
			this.direction = -this.direction;
			this.team.master.direction = this.direction;
			this.PlaySE(2716);
			this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.Warp(this.direction == 1,00000000.0 ? ::camera.camera2d.left - 128 : ::camera.camera2d.right + 128, this.y);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.team.master.Warp(this.x - 20 * this.direction, this.y - 76);

				if (this.abs(this.flag1.x - this.x) <= 20,00000000.0)
				{
					this.team.master.func();
					this.freeMap = false;
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.team.master.Warp(this.x - 20 * this.direction, this.y - 76);

		if (this.count == 30)
		{
			this.func[0].call(this);
		}

		if (this.count == 150)
		{
			this.func[1].call(this);
		}

		if (this.count == 240)
		{
			this.func[2].call(this);
		}
	};
}

function BeginStory( t )
{
	this.demoObject = [];

	if (this.team.index == 2)
	{
		this.Warp(::battle.start_x[1], this.centerY - 50);
		this.direction = -1,00000000.0;
	}
	else
	{
		this.Warp(::battle.start_x[0], this.centerY - 50);
		this.direction = 1,00000000.0;
	}

	this.demoObject.append(this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Demo, {}).weakref());
	this.isVisible = true;
	this.SetSpeed_XY(0,00000000.0, -8,00000000.0);
	this.LabelClear();
	this.centerStop = -2;
	this.SetMotion(9009, 0);
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.stateLabel = function ()
	{
	};
}

function WinA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					this.CommonWin();
				}
			};
		}
	];
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
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 60)
				{
					this.CommonWin();
				}
			};
		}
	];
}

function Lose( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9020, 0);
	this.stateLabel = function ()
	{
		if (this.keyTake == 0)
		{
			this.count = 0;
		}
		else if (this.count == 60)
		{
			this.CommonLose();
		}
	};
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
				if (this.count == 60)
				{
					this.CommonLose();
				}
			};
		}
	];
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
	this.SetSpeed_XY(4,00000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-4,00000000.0 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 5,50000000.0;
	t_.back <- -5,50000000.0;
	t_.front_rev <- 4,25000000.0;
	t_.back_rev <- -4,25000000.0;
	t_.v <- -13,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 13,00000000.0;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 5,50000000.0;
	t_.back <- -5,50000000.0;
	t_.front_rev <- 4,25000000.0;
	t_.back_rev <- -4,25000000.0;
	t_.v <- -13,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 13,00000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 5,50000000.0;
	t_.back <- -5,50000000.0;
	t_.front_rev <- 4,25000000.0;
	t_.back_rev <- -4,25000000.0;
	t_.v <- 13,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 13,00000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 5,50000000.0;
	t_.back <- -5,50000000.0;
	t_.front_rev <- 4,25000000.0;
	t_.back_rev <- -4,25000000.0;
	t_.v <- 13,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 13,00000000.0;
	this.C_SlideFall_Common(t_);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- this.baseSlideSpeed;
	this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
	this.Guard_Stance_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 7,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7,00000000.0;
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
	t_.speed <- 6,50000000.0;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 9,00000000.0;
	t_.wait <- 150;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 6,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 10;
	t_.wait <- 120;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 11,00000000.0;
	this.DashFront_Air_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 7,00000000.0;
	this.flag5.vy = 6,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7,00000000.0;
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
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = 7,50000000.0;
	this.flag5.g = this.baseGravity;
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(-10,00000000.0 * this.direction, -5,00000000.0);
	this.centerStop = -3;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

		if (this.y > this.centerY && this.va.y > 0,00000000.0)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(null, 2,50000000.0);
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
	t_.speed <- -6,50000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 30;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 12,00000000.0;
	this.DashBack_Air_Common(t_);
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
			this.HitTargetReset();
			this.PlaySE(2600);
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
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2602);
			this.SetSpeed_XY(12,50000000.0 * this.direction, null);
		}
	];
	this.stateLabel = function ()
	{
		if (this.va.x * this.direction > 12,50000000.0)
		{
			this.VX_Brake(1,00000000.0);
		}
		else
		{
			this.VX_Brake(0,75000000.0);
		}
	};
	return true;
}

function Atk_RushB_Init( t )
{
	this.atk_id = 4;
	this.SetMotion(1600, 0);
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.AddSpeed_XY(12,00000000.0 * this.direction, null);
			this.PlaySE(2604);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,85000002.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,14999998.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_Mid_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8;
	this.combo_func = this.Rush_Air;
	this.SetMotion(1110, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2602);
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
			this.SetMotion(1110, 3);
			this.GetFront();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
}

function Atk_RushC_Init( t )
{
	this.Atk_Mid_Init(t);
	this.SetMotion(1700, 0);
	this.stateLabel = function ()
	{
		this.VX_Brake(1,50000000.0);
	};
	return true;
}

function Atk_High_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1200, 0);
	this.keyAction = [
		function ()
		{
			this.AddSpeed_XY(12,00000000.0 * this.direction, null);
			this.PlaySE(2604);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	if (this.raccoon <= 0)
	{
		this.Atk_RushC_Init(t);
		return;
	}

	this.Atk_HighUnder_Init(t);
	this.atk_id = 128;
	this.flag1 = false;
	this.SetMotion(1710, 0);
	return true;
}

function Atk_HighUnder_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.PlaySE(2606);
	this.stateLabel = function ()
	{
		this.subState();
		this.VX_Brake(0,25000000.0);
		this.VY_Brake(0,80000001.0);
	};
	this.SetMotion(1210, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag3 = 0;
	this.flag2 = false;
	this.flag1 = true;
	this.subState = function ()
	{
		this.HitCycleUpdate(5);
	};
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(10,00000000.0 * this.direction, -12,00000000.0);
			this.stateLabel = function ()
			{
				this.subState();
				this.AddSpeed_XY(null, 0,89999998.0);
				this.VX_Brake(0,25000000.0);

				if (this.va.y > -1,00000000.0)
				{
					this.SetSpeed_XY(null, -1,00000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.flag2)
				{
					this.subState();
				}

				this.AddSpeed_XY(null, 0,89999998.0);

				if (this.ground)
				{
					this.PlaySE(2607);
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					::camera.shake_radius = 6,00000000.0;
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.flag2 = true;
		},
		function ()
		{
		},
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-6,00000000.0 * this.direction, -15,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,75000000.0);
			};
		}
	];
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.PlaySE(2606);
	this.stateLabel = function ()
	{
		this.subState();
		this.VX_Brake(0,25000000.0);
		this.VY_Brake(0,80000001.0);
	};
	this.SetMotion(1211, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag3 = 0;
	this.flag2 = false;
	this.flag1 = true;
	this.subState = function ()
	{
		this.HitCycleUpdate(5);
	};
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(10,00000000.0 * this.direction, -6,00000000.0);
			this.stateLabel = function ()
			{
				this.subState();
				this.AddSpeed_XY(null, 0,89999998.0);
				this.VX_Brake(0,25000000.0);

				if (this.va.y > -1,00000000.0)
				{
					this.SetSpeed_XY(null, -1,00000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.flag2)
				{
					this.subState();
				}

				this.AddSpeed_XY(null, 0,89999998.0);

				if (this.ground)
				{
					this.PlaySE(2607);
					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					::camera.shake_radius = 6,00000000.0;
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.flag2 = true;
		},
		function ()
		{
			this.SetMotion(this.motion, 5);
			this.centerStop = -2;
			this.SetSpeed_XY(-4,00000000.0 * this.direction, -15,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,50000000.0);
			};
		},
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-6,00000000.0 * this.direction, -15,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,75000000.0);
			};
		}
	];
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	if (this.raccoon <= 0)
	{
		this.Atk_RushC_Init(t);
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.flag1 = false;
	this.SetMotion(1720, 0);
	this.SetSpeed_XY(12,00000000.0 * this.direction, null);
	this.keyAction = [
		null,
		function ()
		{
			this.SetSpeed_XY(-10,00000000.0 * this.direction, null);
			this.PlaySE(2609);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_HighUpper_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1220, 0);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.SetSpeed_XY(-10,00000000.0 * this.direction, null);
			this.PlaySE(2609);
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

function Atk_HighUpper_Air_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.PlaySE(2609);
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

function Atk_RushC_Front_Init( t )
{
	if (this.raccoon <= 0)
	{
		this.Atk_RushC_Init(t);
		return;
	}

	this.Atk_HighFront_Init(t);
	this.atk_id = 32;
	this.flag1 = false;
	this.SetMotion(1730, 0);
	return true;
}

function Atk_RushA_Far_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.Atk_HighFront_Init(t);
	this.SetMotion(1730, 0);
	this.atk_id = 2048;
	this.flag1 = false;
	return true;
}

function Atk_HighFront_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1230, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, null);
			this.PlaySE(2611);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(2612);
			this.SetSpeed_XY(-6,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,34999999.0);
			};
		}
	];
	return true;
}

function Atk_RushA_Air_Init( t )
{
	if (this.raccoon <= 0)
	{
		this.Atk_RushC_Air_Init(t);
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 16;
	this.SetMotion(1750, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(2611);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(2612);
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	return true;
}

function Atk_RushB_Air_Init( t )
{
	if (this.raccoon <= 0)
	{
		this.Atk_RushC_Air_Init(t);
		return;
	}

	this.Atk_HighUpper_Air_Init(t);
	this.SetMotion(1741, 0);
	this.atk_id = 16;
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.LabelClear();
			this.SetMotion(1741, 3);
			this.GetFront();
			this.combo_func = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_RushC_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 16;
	this.SetMotion(1760, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2604);
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

function Atk_HighFront_Air_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetMotion(1231, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(2611);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(2612);
		},
		function ()
		{
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	return true;
}

function Atk_LowDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetSpeed_XY(10,00000000.0 * this.direction, null);
	this.SetMotion(1300, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2615);
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		if (this.keyTake == 1)
		{
			this.VX_Brake(0,25000000.0);
		}

		if (this.keyTake >= 2)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Atk_RushD_Init( t )
{
	if (this.raccoon <= 0)
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
		this.CenterUpdate(this.baseGravity, 3,00000000.0);
	};
	this.SetMotion(1740, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(10,00000000.0 * this.direction, null);
		},
		function ()
		{
			this.PlaySE(2612);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.CenterUpdate(this.baseGravity, 3,00000000.0);
			};
		}
	];
	return true;
}

function Atk_HighDash_Init( t )
{
	if (this.raccoon <= 0)
	{
		return;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
	};
	this.SetMotion(1310, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2617);
			this.count = 0;
			this.flag1 = 0;
			this.SetSpeed_XY(15,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.graze = 3;
			this.count = 0;
			this.SetSpeed_XY(7,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count >= 15)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
					return;
				}

				this.HitCycleUpdate(5);
			};
		}
	];
	return true;
}

function Atk_HighDash()
{
	if (this.keyTake == 0)
	{
		this.Vec_Brake(0,50000000.0);
	}

	if (this.keyTake == 1 || this.keyTake == 2)
	{
		this.VX_Brake(0,25000000.0);
		this.AddSpeed_XY(null, 0,34999999.0);
	}

	if (this.keyTake == 3)
	{
		this.VX_Brake(0,40000001.0);
	}

	return true;
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
		this.target.Warp(this.initTable.pare.point0_x - (this.owner.target.point0_x - this.owner.target.x), this.initTable.pare.y);
	};
}

function Atk_Grab_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1802, 0);
	this.PlaySE(806);

	if (this.x > ::battle.corner_right - 80 && this.direction == 1,00000000.0)
	{
		this.Warp(::battle.corner_right - 80, this.y);
	}

	if (this.x < ::battle.corner_left + 80 && this.direction == -1,00000000.0)
	{
		this.Warp(::battle.corner_left + 80, this.y);
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.target.DamageGrab_Common(301, 2, -this.direction);
	this.target.Warp(this.point0_x - (this.target.point0_x - this.target.x), this.y);
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
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
	this.target.DamageGrab_Common(301, 1, -this.direction);
	this.keyAction = [
		null,
		function ()
		{
			this.flag1.stateLabel = function ()
			{
				this.owner.target.Warp(this.initTable.pare.point0_x - (this.owner.target.point0_x - this.owner.target.x), this.initTable.pare.point0_y - (this.owner.target.point0_y - this.owner.target.y));
			};
			this.target.autoCamera = true;
			this.target.DamageGrab_Common(304, 1, this.direction);
		},
		function ()
		{
			this.target.DamageGrab_Common(302, 1, this.direction);
		},
		function ()
		{
			this.PlaySE(2715);
			this.flag1.func[0].call(this.flag1);
			this.target.DamageGrab_Common(311, 0, -this.direction);
			this.target.SetSpeed_XY(-4,00000000.0 * this.target.direction, -15,00000000.0);
			this.target.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,66000003.0);
			};
		},
		null,
		function ()
		{
			this.PlaySE(2713);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
			this.target.Warp(this.point0_x, this.point0_y);
			this.target.DamageGrab_Common(311, 0, -this.direction);
			this.target.SetSpeed_XY(0,00000000.0 * this.target.direction, -7,50000000.0);
			this.target.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			};
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 100)
				{
					this.SetMotion(this.motion, 7);
					this.target.Warp(this.point0_x, this.point0_y);
					this.hitStopTime = 20;
					::camera.shake_radius = 3,00000000.0;
					this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
					this.KnockBackTarget(-this.direction);
					::battle.enableTimeUp = true;
					this.PlaySE(2714);
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
					};
					return;
				}

				if (this.count % 25 == 0)
				{
					this.PlaySE(2713);
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB, {});
					this.target.Warp(this.point0_x, this.point0_y);
					this.target.DamageGrab_Common(311, 0, -this.direction);
					this.target.SetSpeed_XY(0,00000000.0 * this.target.direction, -7,50000000.0);
					this.target.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
					};
				}
			};
		}
	];
}

function Shot_Normal_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.LabelClear();
	this.event_getAttack = null;
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.subState = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 90);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count % 3 == 1 && this.flag1 <= 2)
				{
					if (this.flag1 == 0)
					{
						this.PlaySE(2619);
					}

					local t = {};
					t.shotRot <- 0,00000000.0;
					t.rot <- (15,00000000.0 + this.flag1 * 25,00000000.0) * 0,01745329.0 + t.shotRot;
					t.count <- 20 + this.flag1 * 1;
					this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
					local t = {};
					t.shotRot <- 0,00000000.0;
					t.rot <- (-15,00000000.0 - this.flag1 * 25,00000000.0) * 0,01745329.0 + t.shotRot;
					t.count <- 20 + this.flag1 * 1;
					this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
					this.flag1++;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.subState();
			};
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.Shot_Normal_Init.call(this, t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.team.AddMP(-200, 90);
		this.stateLabel = function ()
		{
			this.subState();

			if (this.count % 3 == 1 && this.flag1 <= 2)
			{
				if (this.flag1 == 0)
				{
					this.PlaySE(2619);
				}

				local t = {};
				t.shotRot <- -30,00000000.0 * 0,01745329.0;
				t.rot <- (15,00000000.0 + this.flag1 * 25,00000000.0 - 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				local t = {};
				t.shotRot <- -30,00000000.0 * 0,01745329.0;
				t.rot <- (-15,00000000.0 - this.flag1 * 25,00000000.0 - 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				this.flag1++;
			}
		};
	};
	return true;
}

function Shot_Normal_Under_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.Shot_Normal_Init.call(this, t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.team.AddMP(-200, 90);
		this.stateLabel = function ()
		{
			this.subState();

			if (this.count % 3 == 1 && this.flag1 <= 2)
			{
				if (this.flag1 == 0)
				{
					this.PlaySE(2619);
				}

				local t = {};
				t.shotRot <- 30,00000000.0 * 0,01745329.0;
				t.rot <- (15,00000000.0 + this.flag1 * 25,00000000.0 + 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				local t = {};
				t.shotRot <- 30,00000000.0 * 0,01745329.0;
				t.rot <- (-15,00000000.0 - this.flag1 * 25,00000000.0 + 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				this.flag1++;
			}
		};
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.LabelClear();
	this.event_getAttack = null;
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.subState = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,05000000.0);
		}
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 90);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, this.va.y * 0,50000000.0);
			this.stateLabel = function ()
			{
				this.subState();

				if (this.count % 3 == 1 && this.flag1 <= 2)
				{
					if (this.flag1 == 0)
					{
						this.PlaySE(2619);
					}

					local t = {};
					t.shotRot <- 0,00000000.0;
					t.rot <- (15,00000000.0 + this.flag1 * 25,00000000.0) * 0,01745329.0 + t.shotRot;
					t.count <- 20 + this.flag1 * 1;
					this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
					local t = {};
					t.shotRot <- 0,00000000.0;
					t.rot <- (-15,00000000.0 - this.flag1 * 25,00000000.0) * 0,01745329.0 + t.shotRot;
					t.count <- 20 + this.flag1 * 1;
					this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
					this.flag1++;
				}
			};
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
		this.subState();
	};
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.Shot_Normal_Air_Init.call(this, t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.team.AddMP(-200, 90);

		if (this.y > this.centerY)
		{
			this.centerStop = -2;
			this.SetSpeed_XY(-3,00000000.0 * this.direction, 5,00000000.0);
		}

		this.subState = function ()
		{
			this.CenterUpdate(0,20000000.0, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.VX_Brake(0,50000000.0);
			}
			else
			{
				this.VX_Brake(0,05000000.0);
			}
		};
		this.stateLabel = function ()
		{
			this.subState();

			if (this.count % 3 == 1 && this.flag1 <= 2)
			{
				if (this.flag1 == 0)
				{
					this.PlaySE(2619);
				}

				local t = {};
				t.shotRot <- -30,00000000.0 * 0,01745329.0;
				t.rot <- (15,00000000.0 + this.flag1 * 25,00000000.0 - 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				local t = {};
				t.shotRot <- -30,00000000.0 * 0,01745329.0;
				t.rot <- (-15,00000000.0 - this.flag1 * 25,00000000.0 - 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				this.flag1++;
			}
		};
	};
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.Shot_Normal_Air_Init.call(this, t);
	this.keyAction[0] = function ()
	{
		this.count = 0;
		this.team.AddMP(-200, 90);

		if (this.y < this.centerY)
		{
			this.centerStop = 2;
			this.SetSpeed_XY(-3,00000000.0 * this.direction, -5,00000000.0);
		}

		this.subState = function ()
		{
			this.CenterUpdate(0,20000000.0, null);

			if (this.centerStop * this.centerStop <= 1)
			{
				this.VX_Brake(0,50000000.0);
			}
			else
			{
				this.VX_Brake(0,05000000.0);
			}
		};
		this.stateLabel = function ()
		{
			this.subState();

			if (this.count % 3 == 1 && this.flag1 <= 2)
			{
				if (this.flag1 == 0)
				{
					this.PlaySE(2619);
				}

				local t = {};
				t.shotRot <- 30,00000000.0 * 0,01745329.0;
				t.rot <- (15,00000000.0 + this.flag1 * 25,00000000.0 + 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				local t = {};
				t.shotRot <- 30,00000000.0 * 0,01745329.0;
				t.rot <- (-15,00000000.0 - this.flag1 * 25,00000000.0 + 30,00000000.0) * 0,01745329.0 + t.shotRot;
				t.count <- 20 + this.flag1 * 1;
				this.SetShot(this.point0_x + 40 * this.cos(t.rot) * this.direction, this.point0_y + 40 * this.sin(t.rot), this.direction, this.NormalShot, t);
				this.flag1++;
			}
		};
	};
	return true;
}

function Shot_Front_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.LabelClear();
	this.event_getAttack = null;
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag3 = t;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2625);
			local a_ = [];

			for( local i = 0,00000000.0; i < 360,00000000.0; i = i + 36,00000000.0 )
			{
				local t = {};
				t.rot <- i * 0,01745329.0;
				t.flag1 <- 1,00000000.0;
				t.shotRot <- 0,00000000.0;

				if (this.flag3 > 0)
				{
					t.shotRot <- 90,00000000.0 * 0,01745329.0;
				}

				if (this.flag3 < 0)
				{
					t.shotRot <- -90,00000000.0 * 0,01745329.0;
				}

				a_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t).weakref());
			}

			foreach( a in a_ )
			{
				a.flag3 = a_;
			}
		}
	];
	return true;
}

function Shot_Front_Air_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.LabelClear();
	this.event_getAttack = null;
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2011, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag3 = t;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2625);
			local a_ = [];

			for( local i = 0,00000000.0; i < 360,00000000.0; i = i + 36,00000000.0 )
			{
				local t = {};
				t.rot <- i * 0,01745329.0;
				t.flag1 <- 1,00000000.0;
				t.shotRot <- 0,00000000.0;

				if (this.flag3 > 0)
				{
					t.shotRot <- 90,00000000.0 * 0,01745329.0;
				}

				if (this.flag3 < 0)
				{
					t.shotRot <- -90,00000000.0 * 0,01745329.0;
				}

				a_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t).weakref());
			}

			foreach( a in a_ )
			{
				a.flag3 = a_;
			}
		}
	];
	return true;
}

function Shot_Charge_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.Shot_Charge_Common(t);
	this.flag2.vx <- 4,50000000.0;
	this.flag2.vy <- 2,75000000.0;
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2020, 0);
	this.flag1 = 0;
	this.flag2 = this.input.y;
	this.flag4 = t.charge;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2633);

			if (this.flag4)
			{
				local t_ = {};
				t_.rot <- -45 * 0,01745329.0;

				if (this.flag2 > 0)
				{
					t_.rot = 45 * 0,01745329.0;
				}

				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFull, t_);
			}
			else
			{
				local t_ = {};
				t_.v <- 6,00000000.0;
				t_.rot <- 0,00000000.0;
				t_.type <- 0;

				if (this.flag2 < 0)
				{
					t_.type = 8;
				}

				if (this.flag2 > 0)
				{
					t_.type = 2;
				}

				this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_);
			}
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 1,50000000.0);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,34999999.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);
		this.CenterUpdate(0,10000000.0, 1,50000000.0);
	};
	return true;
}

function Shot_Charge_Air_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.Shot_Charge_Init(t);
	return true;
}

function Shot_Burrage_Init( t )
{
	if (this.target.debuff_animal.time > 0)
	{
		return false;
	}

	this.Shot_Burrage_Common(t);
	this.flag2.vx <- 6,50000000.0;
	this.flag2.vy <- 4,00000000.0;
	this.flag2.rot <- 0,00000000.0;
	this.flag2.pos <- this.Vector3();
	this.flag2.pos.x = 100,00000000.0;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			if (this.count % 40 == 11)
			{
				this.PlaySE(2625);

				for( local i = 0; i < 20; i++ )
				{
					local t_ = {};
					t_.rot <- this.flag2.rot + i * 18 * 0,01745329.0;
					this.SetShot(this.x + this.flag2.pos.x * this.direction, this.y + this.flag2.pos.y, this.direction, this.Shot_Barrage, t_);
					this.flag2.pos.RotateByDegree(18);
				}

				this.flag2.rot += 0,17453292.0;
				this.flag2.pos.RotateByRadian(0,17453292.0);
			}
		}
	};
	return true;
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	local type_ = this.space % 3;

	switch(type_)
	{
	case 1:
		this.SetMotion(2500, 0);
		break;

	case 2:
		this.SetMotion(2500, 6);
		break;

	default:
		this.SetMotion(2500, 9);
		break;
	}

	this.PlaySE(2694);
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.CommonSmoke_Core, {});
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.count = 0;

	if (this.centerStop * this.centerStop <= 1)
	{
		this.flag2 = 0;
	}
	else if (this.y <= this.centerY)
	{
		this.flag2 = 1;
	}
	else
	{
		this.flag2 = 2;
	}

	this.flag3 = 0;

	if (this.command.rsv_y > 0)
	{
		this.flag3 = 1;
	}

	if (this.command.rsv_y < 0)
	{
		this.flag3 = -1;
	}

	this.keyAction = [
		null,
		function ()
		{
			this.centerStop = -2;

			if (this.flag2 == 1)
			{
				this.SetSpeed_XY(-4,00000000.0 * this.direction, -6,00000000.0);
			}
			else
			{
				this.SetSpeed_XY(-4,00000000.0 * this.direction, -9,00000000.0);
			}

			this.flag1 = this.y;
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction >= 0,50000000.0 ? 0,30000001.0 : 0,01000000.0);
				this.AddSpeed_XY(0,00000000.0, this.va.y > -1,00000000.0 ? 0,25000000.0 : 0,10000000.0);
			};
		},
		function ()
		{
			this.PlaySE(2695);
			this.team.AddMP(-200, 120);
			this.count = 0;
			local t_ = {};
			t_.rot <- 0;
			t_.type <- this.space % 3;
			t_.ground <- this.flag2 == 2 && this.flag3 >= 0;
			this.space++;

			switch(this.flag3)
			{
			case 1:
				t_.rot = 45 * 0,01745329.0;
				break;

			case -1:
				t_.rot = -45 * 0,01745329.0;
				break;
			}

			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Okult, t_);
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,64999998.0);

				if (this.va.y > 0 && this.y >= this.centerY && (this.flag1 <= this.centerY || this.flag1 >= this.centerY && this.count >= 30))
				{
					this.SetMotion(2500, 5);
					this.centerStop = 2;
					this.SetSpeed_XY(this.va.x, this.va.y > 2,00000000.0 ? 2,00000000.0 : this.va.y);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
					};
				}
			};
		},
		null,
		null,
		this.EndtoFreeMove,
		null,
		function ()
		{
			this.keyAction[1].call(this);
		},
		function ()
		{
			this.SetMotion(2500, 3);
			this.keyAction[2].call(this);
		},
		null,
		function ()
		{
			this.keyAction[1].call(this);
		},
		function ()
		{
			this.SetMotion(2500, 3);
			this.keyAction[2].call(this);
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function OkultB_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2501, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.PlaySE(2698);
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.CommonSmoke_Core, {});
	this.keyAction = [
		function ()
		{
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ChargeO, {});
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.PlaySE(2699);
			this.hitResult = 1;

			foreach( a in this.alien )
			{
				if (a)
				{
					a.func[2].call(a);
				}
			}

			this.alien = [];
		},
		null,
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function OkultB_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2502, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.PlaySE(2698);
	this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.CommonSmoke_Core, {});
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ChargeO, {});
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.PlaySE(2699);
			this.hitResult = 1;

			foreach( a in this.alien )
			{
				if (a)
				{
					a.func[2].call(a);
				}
			}

			this.alien = [];
		},
		null,
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
		}
	];
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function SP_A_Init( t )
{
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1048576;

	if (this.raccoon <= 0)
	{
		this.SetMotion(3001, 0);
	}
	else
	{
		switch(1)
		{
		case 4:
			this.SetMotion(3002, 0);
			break;

		case 6:
			this.SetMotion(3001, 0);
			break;

		default:
			this.SetMotion(3000, 0);
			break;
		}
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.func = function ()
	{
		this.PlaySE(2627);
		this.SetFreeObject(this.x, this.y, this.direction, this.owner.Common_SmokeBurstB, {});
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.stateLabel = function ()
			{
				if (this.hitResult & (16 | 256))
				{
					for( local i = 0,00000000.0; i < 360,00000000.0; i = i + 36,00000000.0 )
					{
						local t = {};
						t.rot <- i * 0,01745329.0;
						t.flag1 <- 1,00000000.0;
						t.shotRot <- 0,00000000.0;

						if (this.flag3 > 0)
						{
							t.shotRot <- 90,00000000.0 * 0,01745329.0;
						}

						if (this.flag3 < 0)
						{
							t.shotRot <- -90,00000000.0 * 0,01745329.0;
						}

						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A_Shot, t);
					}

					this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.FallRaccoon, {});
					this.Lost_Raccoon(1);
					this.stateLabel = null;
					this.SetMotion(this.motion, 2);
					this.func();
					return;
				}
			};
		},
		function ()
		{
			this.keyAction = null;
			this.stateLabel = function ()
			{
			};
			this.SetMotion(3006, 2);
		},
		function ()
		{
			this.Warp(this.target.x, ::battle.scroll_top - 100,00000000.0);
			this.centerStop = -2;
			this.SetSpeed_XY(0,00000000.0, 15,00000000.0);
			this.PlaySE(2628);
			this.HitReset();
			this.atk_id = 1048576;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);

				if (this.y + 50,00000000.0 >= ::battle.corner_bottom)
				{
					this.Warp(this.x, ::battle.corner_bottom - 50,00000000.0);
					this.count = 0;
					this.SetMotion(this.motion, 4);
					::camera.shake_radius = 5,00000000.0;
					this.PlaySE(2629);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.count++;

						if (this.count >= 30)
						{
							this.PlaySE(2627);
							this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
							this.SetMotion(this.motion, 5);
							this.centerStop = 2;
							this.SetSpeed_XY(-5,00000000.0 * this.direction, -12,50000000.0);
							this.stateLabel = function ()
							{
								this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
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
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	return true;
}

function SP_B_Init( t )
{
	this.event_getAttack = this.DamageLostRaccoon;
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3010, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.count = 0;
			local t_ = {};
			t_.vx <- 5,00000000.0;
			t_.vy <- -15,00000000.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
				this.CenterUpdate(0,10000000.0, null);

				if (this.count >= 4 && this.flag1 < 2)
				{
					this.count = 0;
					this.flag1++;
					this.PlaySE(2631);
					this.SetMotion(3010, 1);
					local t_ = {};
					t_.vx <- 4,00000000.0 + this.rand() % 25 * 0,10000000.0;
					t_.vy <- -15,00000000.0 - this.rand() % 35 * 0,10000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
				}
			};
		},
		function ()
		{
			this.AjustCenterStop();
			this.event_getAttack = null;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, 2,00000000.0);
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,10000000.0);
		this.CenterUpdate(0,10000000.0, null);
	};
	return true;
}

function SP_C_Init( t )
{
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3020, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2633);
			local t_ = {};
			t_.v <- 6,00000000.0;
			t_.rot <- 0,00000000.0;
			t_.type <- 0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function SP_D_Init( t )
{
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4194304;
	this.flag1 = 0;

	if (this.centerStop * this.centerStop >= 4 && this.y < this.centerY)
	{
		this.SetMotion(3030, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.PlaySE(2637);
				this.SetSpeed_XY(-9,00000000.0 * this.direction, -15,00000000.0);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				};
			},
			function ()
			{
				this.PlaySE(2671);
				this.event_getAttack = this.DamageLostRaccoon;
				this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
				this.count = 0;
				this.stateLabel = function ()
				{
					this.Vec_Brake(3,00000000.0);
				};
			},
			null,
			function ()
			{
				this.SetSpeed_XY(15,00000000.0 * this.direction, 22,50000000.0);
				this.PlaySE(2638);
				this.subState = function ()
				{
					if (this.va.y <= 5,00000000.0 && this.keyTake == 4)
					{
						this.SetMotion(this.motion, 5);
					}

					if (this.va.y <= 0,00000000.0 && this.keyTake == 5)
					{
						this.SetMotion(this.motion, 6);
						this.subState = null;
					}
				};
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(-0,10000000.0 * this.direction, null);

					if (this.y >= this.centerY - 100)
					{
						this.AddSpeed_XY(null, -1,00000000.0);
					}

					if (this.subState)
					{
						this.subState();
					}

					if (this.va.y < 0,00000000.0 && this.y < this.centerY)
					{
						this.PlaySE(2671);
						this.event_getAttack = null;
						this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
						this.SetMotion(this.motion, 7);
						this.SetSpeed_XY(this.va.x * 0,50000000.0, -13,00000000.0);
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
						};
					}
				};
			}
		];
	}
	else
	{
		this.SetMotion(3031, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.PlaySE(2637);
				this.SetSpeed_XY(-9,00000000.0 * this.direction, -8,00000000.0);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,89999998.0);
				};
			},
			function ()
			{
				this.PlaySE(2671);
				this.event_getAttack = this.DamageLostRaccoon;
				this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
				this.count = 0;
				this.stateLabel = function ()
				{
					this.Vec_Brake(3,00000000.0);
				};
			},
			null,
			function ()
			{
				this.SetSpeed_XY(15,00000000.0 * this.direction, -22,50000000.0);
				this.PlaySE(2638);
				this.subState = function ()
				{
					if (this.va.y >= -5,00000000.0 && this.keyTake == 4)
					{
						this.SetMotion(this.motion, 5);
					}

					if (this.va.y >= 0,00000000.0 && this.keyTake == 5)
					{
						this.SetMotion(this.motion, 6);
						this.subState = null;
					}
				};
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(-0,10000000.0 * this.direction, null);

					if (this.y <= this.centerY + 100)
					{
						this.AddSpeed_XY(null, 1,00000000.0);
					}

					if (this.subState)
					{
						this.subState();
					}

					if (this.va.y > 0,00000000.0 && this.y > this.centerY)
					{
						this.PlaySE(2671);
						this.event_getAttack = null;
						this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
						this.SetMotion(this.motion, 7);
						this.SetSpeed_XY(this.va.x * 0,50000000.0, 13,00000000.0);
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0,00000000.0, -0,50000000.0);
						};
					}
				};
			}
		];
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(1,50000000.0);
	};
	return true;
}

function SP_E_Init( t )
{
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 8388608;
	this.SetSpeed_XY(this.va.x * 0,00000000.0, this.va.y * 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = 5;

	if (this.command.rsv_x * this.direction > 0)
	{
		this.flag1 = 6;
	}

	if (this.command.rsv_x * this.direction < 0)
	{
		this.flag1 = 4;
	}

	switch(4)
	{
	case 6:
		this.SetMotion(3040, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.count = 0;
				this.karasaka = this.SetObject(this.x + 480 * this.direction, 760,00000000.0, -this.direction, this.SPShot_E, {}).weakref();
				this.stateLabel = function ()
				{
					this.CenterUpdate(0,50000000.0, 2,00000000.0);
					this.VX_Brake(0,50000000.0);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		];
		break;

	case 4:
		this.SetMotion(3040, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.count = 0;
				local x_ = this.x + 210 * this.direction;
				this.karasaka = this.SetObject(x_, 760,00000000.0, this.direction, this.SPShot_E, {}).weakref();
				this.stateLabel = function ()
				{
					this.CenterUpdate(0,50000000.0, 2,00000000.0);
					this.VX_Brake(0,50000000.0);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		];
		break;

	default:
		this.SetMotion(3040, 0);
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.count = 0;
				local x_ = this.x + 420 * this.direction;
				this.karasaka = this.SetObject(x_, 760,00000000.0, this.direction, this.SPShot_E, {}).weakref();
				this.stateLabel = function ()
				{
					this.CenterUpdate(0,50000000.0, 2,00000000.0);
					this.VX_Brake(0,50000000.0);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		];
		break;
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0,50000000.0, 2,00000000.0);
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function SP_F_Init( t )
{
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.atk_id = 16777216;
	this.AjustCenterStop();

	switch(6)
	{
	case 8:
	case 2:
		this.SetMotion(3051, 0);
		this.keyAction = [
			function ()
			{
				this.SetObject(this.x + 100 * this.direction, ::battle.scroll_top - 100, this.direction, this.SPShot_E3, {});
				this.PlaySE(2643);
			},
			null,
			null,
			this.EndtoFreeMove
		];
		break;

	case 6:
		this.SetMotion(3050, 0);
		this.func = function ()
		{
			if (this.motion == 3050 && this.keyTake != 4)
			{
				this.SetMotion(3050, 4);
			}
		};
		this.keyAction = [
			function ()
			{
				this.team.AddMP(-200, 120);
				this.SetObject(this.x + 225 * this.direction, 0,00000000.0, this.direction, this.SPShot_E2, {});
				this.PlaySE(2643);
			},
			null,
			null,
			this.EndtoFreeMove
		];
		break;

	case 4:
		this.SetMotion(3050, 0);
		this.func = function ()
		{
			if (this.motion == 3050 && this.keyTake != 4)
			{
				this.SetMotion(3050, 4);
			}
		};
		this.keyAction = [
			function ()
			{
				this.SetObject(this.x + 225,00000000.0 * this.direction, 0,00000000.0, this.direction, this.SPShot_E2, {});
				this.PlaySE(2643);
			},
			null,
			null,
			this.EndtoFreeMove
		];
		break;
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0,50000000.0, 2,00000000.0);
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function SP_Taiko_Init( t )
{
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.atk_id = 33554432;
	this.AjustCenterStop();
	this.SetMotion(3070, 0);
	this.flag1 = null;
	this.flag2 = this.centerStop;
	this.flag3 = 0;
	this.flag4 = 40;
	this.keyAction = [
		null,
		function ()
		{
			this.GetFront();
			this.team.AddMP(-200, 120);
			this.PlaySE(2627);
			this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});
			this.flag1 = this.SetShot(this.x, this.y, this.direction, this.SPShot_Taiko, {}).weakref();

			if (this.flag2 <= 0)
			{
				this.centerStop = -3;
				this.SetSpeed_XY(-5,00000000.0 * this.direction, -4,50000000.0);
				this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			}
			else
			{
				this.centerStop = 3;
				this.SetSpeed_XY(-5,00000000.0 * this.direction, 4,50000000.0);
				this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0, -3,00000000.0 * this.direction);
				this.CenterUpdate(0,20000000.0, 2,00000000.0);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		},
		function ()
		{
			this.count = 0;
			this.PlaySE(2711);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB2, {});

			if (this.flag1)
			{
				this.flag1.func[1].call(this.flag1);
			}

			this.SetFreeObject(this.flag1.point0_x, this.flag1.point0_y, this.direction, this.SPShot_TaikoBeat, {});
			local t_ = {};
			t_.rot <- (this.flag4 + this.rand() % 25) * 0,01745329.0;
			this.SetShot(this.flag1.point0_x, this.flag1.point0_y, this.direction, this.SPShot_TaikoShot, t_);
			this.flag3++;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0, -3,00000000.0 * this.direction);
				this.CenterUpdate(0,20000000.0, 2,00000000.0);

				if (this.count % 10 == 0)
				{
					this.PlaySE(2711);
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashB2, {});
					this.SetFreeObject(this.flag1.point0_x, this.flag1.point0_y, this.direction, this.SPShot_TaikoBeat, {});
					local t_ = {};
					t_.rot <- (this.flag4 + this.rand() % 25) * 0,01745329.0;
					this.SetShot(this.flag1.point0_x, this.flag1.point0_y, this.direction, this.SPShot_TaikoShot, t_);
					this.flag3++;

					if (this.flag3 == 3)
					{
						this.hitResult = 1;
					}
				}

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}

				if (this.count == 60)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.CommonSmoke_Core, {});

					if (this.flag1)
					{
						this.flag1.func[0].call(this.flag1);
					}

					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,05000000.0, 2,00000000.0);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Spell_A_Init( t )
{
	this.Shapeshift(false);
	this.event_getAttack = null;
	this.LabelClear();
	this.atk_id = 67108864;
	this.HitReset();
	this.SetMotion(4000, 0);
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.event_getAttack = this.DamageLostRaccoon;
			this.PlaySE(2654);
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellA_SmokeCore, {});
		},
		function ()
		{
		},
		function ()
		{
			this.PlaySE(2655);
			this.count = 0;
			::camera.shake_radius = 10,00000000.0;
			this.SetSpeed_XY(0,00000000.0, -12,50000000.0);
			this.centerStop = -2;

			for( local i = 0; i < 360; i = i + 40 )
			{
				local t_ = {};
				t_.rot <- (i + this.rand() % 20) * 0,01745329.0;
				t_.v <- 10,00000000.0 + this.rand() % 12;
				this.SetFreeObject(this.x, this.y, this.direction, this.SpellA_SmokeB, t_);
			}

			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.x, this.y, this.direction, this.SpellA_Steam, t_);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,75000000.0);

				if (this.va.y > 0,25000000.0)
				{
					this.SetSpeed_XY(0,00000000.0, 0,25000000.0);
				}

				if (this.rand() % 100 <= 10)
				{
					local t_ = {};
					t_.rot <- this.rand() % 360 * 0,01745329.0;
					t_.v <- 25,00000000.0 + this.rand() % 7;
					this.SetFreeObject(this.x, this.y, this.direction, this.SpellA_SmokeB, t_);
				}

				if (this.count > 90)
				{
					this.event_getAttack = null;
					this.SetFreeObject(this.x, this.y, this.direction, this.SpellA_SmokeCore, {});
					this.SetMotion(4000, 6);
					this.SetSpeed_XY(0,00000000.0, -12,50000000.0);
					this.centerStop = -2;
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.va.y > 0,00000000.0)
						{
							this.AddSpeed_XY(0,00000000.0, 0,02500000.0);
						}
						else
						{
							this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
						}
					};
				}
			};
		},
		function ()
		{
			this.event_getAttack = null;
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			if (this.y > this.centerY)
			{
				this.SetSpeed_XY(0,00000000.0, 4,50000000.0);
			}
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_B_Init( t )
{
	this.Shapeshift(false);
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(4010, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
			this.SetSpeed_XY(-7,00000000.0 * this.direction, -15,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.PlaySE(2649);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag5 = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellShot_B_Torii, t_).weakref();
			this.stateLabel = null;
		},
		function ()
		{
			this.count = 0;
			this.flag5.func[1].call(this.flag5);
			this.stateLabel = function ()
			{
				if (this.count >= 120)
				{
					this.flag5.func[2].call(this.flag5);
					this.SetMotion(this.motion, this.keyTake + 1);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count >= 30)
						{
							this.flag5.func[0].call(this.flag5);
							this.flag5 = null;
							this.SetSpeed_XY(-3,00000000.0 * this.direction, -9,00000000.0);
							this.centerStop = -2;
							this.SetMotion(this.motion, this.keyTake + 1);
							this.stateLabel = function ()
							{
								this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
							};
						}
					};
				}
			};
		}
	];
	return true;
}

function Spell_C_Func( t )
{
	this.spellEndFunc = this.Spell_C_End;
}

function Spell_C_End()
{
	if (this.target.debuff_animal.time > 1)
	{
		this.target.debuff_animal.time = 1;
	}

	this.spellC_Hit = false;
}

function Spell_C_Init( t )
{
	this.Shapeshift(false);
	this.event_getAttack = null;
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4020, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 5);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
		}
	];
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.PlaySE(2652);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_C, t_).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count == 6)
				{
					this.hitResult = 1;
				}

				if (this.flag1)
				{
					if (this.flag1.hitResult & 1 && this.target.motion != 49 && this.target.motion != 289)
					{
						this.HitReset();
						this.team.spell_enable_end = false;
						this.Spell_C_Hit();
						return;
					}
				}
				else
				{
					this.func[0].call(this);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_C_Hit()
{
	this.LabelReset();
	this.HitReset();
	this.team.spell_enable_end = false;
	this.SetMotion(4021, 0);
	this.PlaySE(2658);
	this.target.DamageGrab_Common(301, 1, this.target.direction);
	this.flag1 = this.SetFreeObject(this.target.x, this.target.y, this.direction, this.SpellShot_C_SmokeCore, {}).weakref();
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2659);
			this.count = 0;

			if (this.flag1)
			{
				this.flag1.func();
			}

			this.target.isVisible = true;
			local time = 120 + 160 * this.atkRate_Pat;
			this.target.DebuffSet_Animal(time);
			this.spellC_Hit = true;
			this.stateLabel = function ()
			{
				if (this.target.centerStop * this.target.centerStop <= 1)
				{
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.count == 21)
						{
							this.SetMotion(this.motion, 3);
						}
					};
				}
			};
		}
	];
}

function Spell_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4040, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -1000);
		},
		function ()
		{
			this.PlaySE(2654);
		},
		function ()
		{
			this.count = 0;
			this.HitReset();
			this.PlaySE(2655);
			this.stateLabel = function ()
			{
				if (this.hitResult)
				{
					if (this.hitResult & 32)
					{
						this.HitReset();
					}
					else
					{
						this.flag1++;

						if (this.flag1 >= 8)
						{
							this.HitReset();
							this.flag1 = 0;
						}
					}
				}

				if (this.count >= 60)
				{
					this.HitReset();
					this.SetMotion(this.motion, this.keyTake + 1);
					this.stateLabel = null;
				}
			};
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.event_getAttack = null;
	this.HitReset();
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–‰F’ˆ‹@–§˜R‰kI’\x255d‚\x2510‚\x2554ˆ’u‚\x2563‚æ–");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
		},
		function ()
		{
			this.PlaySE(2660);
			this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
			this.count = 0;
			this.SetSpeed_XY(12,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.hitResult & 1)
				{
					if (this.target.team.life > 0 && this.target.motion != 49 && this.target.motion != 289)
					{
						this.Climax_Hit(null);
						return;
					}
					else
					{
						this.PlaySE(2661);
						this.SetMotion(this.motion, 4);
						::camera.shake_radius = 5,00000000.0;
						this.SetSpeed_XY(-8,00000000.0 * this.direction, -12,00000000.0);
						this.centerStop = -2;
						this.stateLabel = function ()
						{
							this.VX_Brake(0,20000000.0);
							this.AddSpeed_XY(0,00000000.0, 0,34999999.0);
						};
					}
				}
				else if (this.wall == this.direction || this.hitResult & 8 || this.hitResult & 4 || this.count >= 120 && ::battle.state != 8)
				{
					this.PlaySE(2661);
					this.SetMotion(this.motion, 4);
					::camera.shake_radius = 5,00000000.0;
					this.SetSpeed_XY(-8,00000000.0 * this.direction, -12,00000000.0);
					this.centerStop = -2;
					this.stateLabel = function ()
					{
						this.VX_Brake(0,20000000.0);
						this.AddSpeed_XY(0,00000000.0, 0,34999999.0);
					};
				}
			};
		}
	];
	return true;
}

function Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.flag1 = true;
	this.target.team.master.enableKO = false;

	if (this.target.team.slave)
	{
		this.target.team.slave.enableKO = false;
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.demoObject = [
		this.SetFreeObject(this.x, this.y, this.direction, this.Climax_SmokeCore, {}).weakref()
	];
	this.SetMotion(4901, 0);
	this.target.freeMap = true;
	::battle.enableTimeUp = false;
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.target.Warp(this.point0_x, this.point0_y);
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
		}

		if (this.count == 150)
		{
			this.BackFadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 60);
			this.demoObject[0].func[2].call(this.demoObject[0]);
		}

		if (this.count == 210)
		{
			this.demoObject[0].func[0].call(this.demoObject[0]);
			this.Climax_CutScene(null);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
			::camera.shake_radius = 3,00000000.0;

			if (this.flag1)
			{
				this.flag1 = false;
				this.PlaySE(2663);
				this.PlaySE(2673);
			}

			this.KnockBackTarget(-this.direction);
			this.SetEffect(this.point0_x + 40 - this.rand() % 81, this.point0_y + 40 - this.rand() % 81, this.direction, this.EF_HitSmashC, {});
			this.target.DamageGrab_Common(300, 0, -this.direction);
		},
		null,
		function ()
		{
			::camera.shake_radius = 3,00000000.0;
			this.KnockBackTarget(-this.direction);
			this.SetEffect(this.point0_x + 40 - this.rand() % 81, this.point0_y + 40 - this.rand() % 81, this.direction, this.EF_HitSmashC, {});
			this.target.DamageGrab_Common(301, 0, -this.direction);
		},
		function ()
		{
			this.SetMotion(4901, 0);
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
			};
		}
	];
}

function Climax_Finish( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.SetMotion(4902, 0);
	this.target.team.master.enableKO = true;

	if (this.target.team.slave)
	{
		this.target.team.slave.enableKO = true;
	}

	this.target.freeMap = true;
	this.target.x = this.x + 128 * this.direction;
	this.target.y = this.centerY;
	this.target.centerStop = 0;
	this.KnockBackTarget(-this.direction);
	::camera.ResetTarget();
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
		this.lastword.Deactivate();
	};
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.SetMotion(4902, 1);
			this.stateLabel = null;
		}
	};
}

