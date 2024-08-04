function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 15)
	{
		this.BeginBattle_Doremy(null);
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

function BeginStory1_Stage1( t )
{
	this.LabelClear();
	this.demoObject = [
		this.SetFreeObject(this.x + 100, this.y + 30, this.direction, this.BeginStory1_Stage1_Object, {}).weakref(),
		this.SetFreeObject(this.x - 100, this.y + 30, this.direction, this.BeginStory1_Stage1_Object, {}).weakref()
	];
	this.stateLabel = function ()
	{
	};
}

function BeginStory2_Stage1( t )
{
	this.LabelClear();
	this.stateLabel = function ()
	{
	};

	foreach( a in this.demoObject )
	{
		a.func[0].call(a);
	}

	this.demoObject = [];
}

function BeginStory1_Stage1_Object( t )
{
	this.SetMotion(2509, 2);
	this.func = [
		function ()
		{
			this.SetMotion(2509, 11);
			this.keyAction = function ()
			{
				this.owner.demoObject.append(this.SetFreeObject(this.x, this.y, this.direction, this.owner.DeadUsu, {}).weakref());
				this.PlaySE(3877);
				this.SetSpeed_XY(0,00000000.0, -8,00000000.0);
				this.count = 0;
				this.stateLabel = function ()
				{
					this.VY_Brake(0,69999999.0);
				};
				this.keyAction = this.ReleaseActor;
			};
		}
	];
}

function BeginStory1_Stage3( t )
{
	this.LabelClear();
	this.SetMotion(10, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, -9,00000000.0);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,75000000.0, null);

				if (this.va.y > -2,00000000.0)
				{
					this.SetMotion(10, 3);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,75000000.0, null);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.SetMotion(10, 5);
							this.SetSpeed_XY(0,00000000.0, 3,00000000.0);
							this.stateLabel = function ()
							{
							};
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

function BeginBattle( t )
{
}

function BeginBattleA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9000, 0);
	this.demoObject = [];
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.PlaySE(3885);
		},
		null,
		null,
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 30)
				{
					this.CommonBegin();
					this.EndtoFreeMove();
				}
			};
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
	this.SetMotion(9003, 0);
	this.demoObject = [];
	this.Warp(640 - 360 * this.direction, this.centerY);
	this.freeMap = true;
	this.flag1 = ::battle.start_x[this.team.index];
	this.func = [
		function ()
		{
			this.PlaySE(3886);
			::camera.Shake(3,00000000.0);
			this.SetMotion(9003, 1);
			this.count = 0;
			this.SetEffect(this.x, this.y - 35, this.direction, this.EF_HitSmashB, {});
			this.demoObject = [
				this.SetFreeObject(640 - 320 * this.direction, this.y - 10, this.direction, this.BeginBattle_Object_Tewi3, {}, this.weakref()).weakref()
			];
			this.SetSpeed_XY(null, -6,00000000.0);
			this.subState = function ()
			{
				local x_ = (this.flag1 - this.x) * 0,10000000.0;

				if (this.direction == 1,00000000.0)
				{
					if (x_ > 15,00000000.0)
					{
						x_ = 15,00000000.0;
					}
				}
				else if (x_ < -15,00000000.0)
				{
					x_ = -15,00000000.0;
				}

				this.SetSpeed_XY(x_, this.va.y + 0,30000001.0);
			};
			this.stateLabel = function ()
			{
				this.subState();

				if (this.y >= this.centerY && this.va.y > 0,00000000.0)
				{
					this.freeMap = false;
					this.SetMotion(this.motion, 2);
					this.Warp(this.flag1, this.y);
					this.SetSpeed_XY(0,00000000.0, 3,00000000.0);
					this.centerStop = 1;
					this.stateLabel = null;
					this.keyAction = function ()
					{
						this.CommonBegin();
						this.EndtoFreeMove();
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.func[0].call(this);
		}
	};
}

function BeginBattle_Doremy( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9005, 0);
	this.DrawActorPriority();
	this.demoObject = [];
	this.team.slave.BeginBattle_Slave(t);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 180)
		{
			this.SetMotion(9005, 1);
		}
	};
}

function BeginBattle_Slave( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9005, 0);
	this.count = 0;
	this.Warp(this.x + 35 * this.direction, this.y);
	this.stateLabel = function ()
	{
		if (this.count == 180)
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	};
}

function BeginBattle_Object_Tewi2( t )
{
	this.SetMotion(9004, 0);
	this.DrawActorPriority(189);
	this.SetSpeed_XY(9,50000000.0 * this.direction, -6,00000000.0);
	this.stateLabel = function ()
	{
		local x_ = this.initTable.pare.va.x * 0,89999998.0;
		this.SetSpeed_XY(x_, this.va.y + 0,40000001.0);

		if (this.y > 720)
		{
			this.ReleaseActor();
		}
	};
}

function BeginBattle_Object_Tewi3( t )
{
	this.SetMotion(9004, 1);
	this.DrawActorPriority(189);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
	};
}

function WinA_Object( t )
{
	this.SetMotion(9010, 5);
	this.SetSpeed_XY(1,00000000.0 * this.direction, -6,00000000.0);
	this.stateLabel = function ()
	{
		this.rz -= 30 * 0,01745329.0;
		this.AddSpeed_XY(0,00000000.0, 0,20000000.0);

		if (this.y > 800)
		{
			this.ReleaseActor();
		}
	};
}

function WinA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.demoObject = [];
	this.PlaySE(3816);
	this.keyAction = [
		function ()
		{
			this.count = 0;

			if (this.rand() % 100 <= 10)
			{
				this.SetMotion(9010, 2);
				this.PlaySE(3893);
				this.stateLabel = function ()
				{
					if (this.count == 45)
					{
						this.SetMotion(9010, 3);
						this.demoObject = [
							this.SetFreeObject(this.point0_x, this.point0_y, -this.direction, this.WinA_Object, {}).weakref()
						];
					}

					if (this.count == 135)
					{
						this.CommonWin();
					}
				};
			}
			else
			{
				this.PlaySE(3892);
				this.stateLabel = function ()
				{
					if (this.count == 90)
					{
						this.CommonWin();
					}
				};
			}
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
			this.PlaySE(3894);

			if (this.rand() % 100 <= 49)
			{
				this.SetMotion(this.motion, 3);
			}

			this.demoObject = [
				this.SetFreeObject(this.point0_x, this.point0_y, 1,00000000.0, this.BattleWinObject_B, {}).weakref()
			];
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
		},
		null,
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

function BattleWinObject_B( t )
{
	this.SetMotion(9011, 5);
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.keyAction = this.ReleaseActor;
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
}

function BeginStory( t )
{
	this.LabelClear();
	this.SetMotion(19, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.centerStop = -2;
	this.y = ::battle.scroll_top - 200;
	this.isVisible = true;

	if (this.team == 2)
	{
		this.Warp(::battle.start_x[1], ::battle.scroll_top - 100);
		this.direction = -1,00000000.0;
	}
	else
	{
		this.Warp(::battle.start_x[0], ::battle.scroll_top - 100);
		this.direction = 1,00000000.0;
	}

	this.flag1 = true;
	this.count = 0;
	this.SetEndMotionCallbackFunction(function ()
	{
		this.func[0].call(this);
	});
	this.func = [
		function ()
		{
			this.stateLabel = null;
			this.SetMotion(9002, 0);
		},
		function ()
		{
			this.SetMotion(9002, 2);
			this.SetSpeed_XY(-7,00000000.0 * this.direction, 0,00000000.0);
			this.SetEndMotionCallbackFunction(this.EndtoFreeMove);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag1)
		{
			this.y = -200;
			this.centerStop = -2;
			this.flag1 = false;
			return;
		}

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(19, 2);
			this.stateLabel = null;
		}
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
	this.SetSpeed_XY(6,50000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-6,50000000.0 * this.direction, this.va.y);
}

function Guard_Stance( t )
{
	local t_ = {};
	t_.v <- 18,00000000.0;
	this.Guard_Stance_Common(t_);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 10,00000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- -18,00000000.0;
	t_.v2 <- -6,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 10,00000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- -18,00000000.0;
	t_.v2 <- -6,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 10,00000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- 18,00000000.0;
	t_.v2 <- 6,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 10,00000000.0;
	t_.front <- 7,00000000.0;
	t_.back <- -7,00000000.0;
	t_.front_rev <- 5,50000000.0;
	t_.back_rev <- -5,50000000.0;
	t_.v <- 18,00000000.0;
	t_.v2 <- 6,00000000.0;
	t_.v3 <- 18,00000000.0;
	this.C_SlideFall_Common(t_);
}

function Team_Change_AirMoveB( t_ )
{
	this.Team_Change_AirMoveCommon(null);
	this.flag5.vx = 7,00000000.0;
	this.flag5.vy = 8,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirBackB( t_ )
{
	this.Team_Change_AirBackCommon(null);
	this.flag5.vx = -7,00000000.0;
	this.flag5.vy = 8,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUpperB( t_ )
{
	this.Team_Change_AirSlideUpperCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = -9,50000000.0;
	this.flag5.g = this.baseGravity;
}

function Team_Change_AirSlideUnderB( t_ )
{
	this.Team_Change_AirSlideUnderCommon(null);
	this.flag5.vx = 0,00000000.0;
	this.flag5.vy = 9,50000000.0;
	this.flag5.g = this.baseGravity;
}

function GC_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 2,00000000.0;
	t_.front <- 2,00000000.0;
	t_.back <- -2,00000000.0;
	t_.front_rev <- 2,00000000.0;
	t_.back_rev <- -2,00000000.0;
	this.GC_SlideUp_Common(t_);
}

function GC_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 2,00000000.0;
	t_.front <- 2,00000000.0;
	t_.back <- -2,00000000.0;
	t_.front_rev <- 2,00000000.0;
	t_.back_rev <- -2,00000000.0;
	this.GC_SlideFall_Common(t_);
}

function DashFront_Init( t )
{
	this.flag1 = 6,75000000.0;
	this.flag2 = 8,50000000.0;
	this.flag3 = 0,50000000.0;
	this.flag4 = 150;
	this.flag5 = null;

	if (this.GetFront())
	{
		this.DashBack_Init(null);
	}
	else
	{
		this.LabelClear();
		this.SetMotion(40, 0);
		this.PlaySE(801);
		this.SetSpeed_XY(this.flag1 * this.direction, 0,00000000.0);
		this.SetEffect(this.x, this.y, this.direction, this.EF_Dash, {}, this.weakref());
		this.flag5 = this.SetEffect(this.x, this.y, this.direction, this.EF_DashLine, {}, this.weakref());
		this.count = 0;
		this.lavelClearEvent = function ()
		{
			if (this.flag5)
			{
				this.flag5.func();
				this.flag5 = null;
			}
		};
		this.subState = function ()
		{
		};
		this.stateLabel = function ()
		{
			if (this.masterAlpha == 0,00000000.0)
			{
				this.invin = 3;
				this.invinObject = 3;
			}

			if ((this.keyTake >= 1 && this.keyTake <= 4) && this.input.x * this.direction <= 0 || this.count >= this.flag4)
			{
				this.SetMotion(this.motion, 5);
				this.invin = 0;
				this.invinObject = 0;

				if (this.flag5)
				{
					this.flag5.func();
					this.flag5 = null;
				}

				this.lavelClearEvent = null;
				this.stateLabel = function ()
				{
					this.Vec_Brake(0,50000000.0);
				};
				return;
			}

			if (this.centerStop * this.centerStop <= 1)
			{
				if (this.input.y > 0)
				{
					this.SlideFall_Init(null);
					return;
				}
				else if (this.input.y < 0)
				{
					this.SlideUp_Init(null);
					return;
				}
			}

			this.AddSpeed_XY(this.flag3 * this.direction, 0,00000000.0);

			if (this.va.x * this.direction > this.flag2)
			{
				this.SetSpeed_XY(this.flag2 * this.direction, null);
			}

			this.subState();
		};
	}
}

function DashFrontB_Init( t )
{
	this.LabelClear();
	this.flag1 = 6,75000000.0;
	this.flag2 = 8,50000000.0;
	this.flag3 = 0,50000000.0;
	this.flag4 = 150;
	this.flag5 = null;
	this.SetMotion(40, 4);
	this.PlaySE(801);
	this.SetSpeed_XY(this.flag1 * this.direction, 0,00000000.0);
	this.SetEffect(this.x, this.y, this.direction, this.EF_Dash, {}, this.weakref());
	this.flag5 = this.SetEffect(this.x, this.y, this.direction, this.EF_DashLine, {}, this.weakref());
	this.count = 0;
	this.lavelClearEvent = function ()
	{
		if (this.flag5)
		{
			this.flag5.func();
			this.flag5 = null;
		}
	};
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		if ((this.keyTake >= 1 && this.keyTake <= 4) && this.input.x * this.direction <= 0 || this.count >= this.flag4)
		{
			this.SetMotion(this.motion, 5);

			if (this.flag5)
			{
				this.flag5.func();
				this.flag5 = null;
			}

			this.lavelClearEvent = null;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
			};
			return;
		}

		if (this.count >= 15 && this.centerStop * this.centerStop <= 1)
		{
			if (this.input.y > 0)
			{
				this.SlideFall_Init(null);
				return;
			}
			else if (this.input.y < 0)
			{
				this.SlideUp_Init(null);
				return;
			}
		}

		this.AddSpeed_XY(this.flag3 * this.direction, 0,00000000.0);

		if (this.va.x * this.direction > this.flag2)
		{
			this.SetSpeed_XY(this.flag2 * this.direction, null);
		}

		this.subState();
	};
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 8,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 12,00000000.0;
	this.DashFront_Air_Common(t_);
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.SetMotion(41, 0);
	this.PlaySE(801);
	this.SetFreeObject(this.x, this.y, this.direction, this.DashBack_Shasow, {});
	this.SetSpeed_XY(-12,00000000.0 * this.direction, 0,00000000.0);
	this.masterAlpha = 1,00000000.0;
	this.count = 0;
	this.keyAction = [
		null,
		null,
		null,
		this.EndtoFreeMove
	];
	this.stateLabel = function ()
	{
		if (this.count == 10)
		{
			this.SetMotion(41, 3);
			this.centerStop = 1;
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 2,50000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,80000001.0);
			};
		}
	};
}

function DashBack_Shasow( t )
{
	this.SetMotion(41, 4);
	this.SetSpeed_XY(-3,00000000.0 * this.direction, -6,00000000.0);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,02500000.0);
		this.alpha = this.green = this.blue -= 0,02500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function DashBack_Air_Init( t )
{
	local t_ = {};
	t_.speed <- -8,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 30;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 13,50000000.0;
	this.DashBack_Air_Common(t_);
}

function Flight_Assult_Init( t )
{
	this.Flight_Assult_Common(t);
	this.flag2 = 11,00000000.0;
	this.flag4 = 0,26179937.0;
}

function WarpBackDash_Init( t )
{
	this.LabelClear();
	this.SetMotion(1900, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.PlaySE(802);
	this.keyAction = [
		function ()
		{
			this.freeMap = true;
			this.SetSpeed_XY(-6,00000000.0 * this.direction, -2,00000000.0);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,05000000.0);

				if (this.va.y >= 0,00000000.0)
				{
					this.count = 0;
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.masterAlpha = 0,00000000.0;

					if (this.direction == 1,00000000.0)
					{
						this.Warp(::battle.scroll_right + 150,00000000.0, this.y);
					}
					else
					{
						this.Warp(::battle.scroll_left - 150,00000000.0, this.y);
					}

					this.stateLabel = function ()
					{
						if (this.count >= 30)
						{
							this.masterAlpha = 1,00000000.0;
							this.direction *= -1,00000000.0;
							this.SetSpeed_XY(6,00000000.0 * this.direction, 0,00000000.0);
							this.stateLabel = function ()
							{
								this.AddSpeed_XY(0,00000000.0, 0,05000000.0);

								if (this.va.y >= 2,00000000.0)
								{
									this.SetMotion(this.motion, 3);
									this.freeMap = false;
									this.stateLabel = function ()
									{
										this.VX_Brake(0,50000000.0);
									};
								}
							};
						}
					};
				}
			};
		}
	];
}

function Atk_RushA_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.SetSpeed_XY(8,00000000.0 * this.direction, null);
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3802);
		}
	];
	return true;
}

function Atk_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1;
	this.combo_func = this.Rush_AA;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1000, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3800);
		}
	];
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1600, 0);
	this.keyAction = [
		function ()
		{
			this.va.x = 5,00000000.0 * this.direction;
			this.PlaySE(3806);
		}
	];
	return true;
}

function Atk_Mid_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 2;
	this.combo_func = this.Rush_Far;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1100, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(8,00000000.0 * this.direction, null);
			this.PlaySE(3804);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,20000005.0);
			};
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
	this.keyAction = [
		function ()
		{
			this.PlaySE(3822);
		},
		null,
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
			this.GetFront();
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1710, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(10,00000000.0 * this.direction, -15,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, this.va.y > 0,50000000.0 ? 0,01000000.0 : 2,00000000.0);
				this.VX_Brake(0,50000000.0, 1,00000000.0 * this.direction);
			};
		},
		function ()
		{
			this.SetSpeed_XY(8,00000000.0 * this.direction, 12,00000000.0);
			this.PlaySE(3810);
			this.stateLabel = function ()
			{
				if (this.y > this.centerY)
				{
					this.centerStop = 2;
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(8,00000000.0 * this.direction, -15,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, this.va.y > 0,50000000.0 ? 0,01000000.0 : 2,00000000.0);
				this.VX_Brake(0,50000000.0, 1,00000000.0 * this.direction);
			};
		},
		function ()
		{
			this.SetSpeed_XY(6,00000000.0 * this.direction, 12,00000000.0);
			this.PlaySE(3808);
			this.stateLabel = function ()
			{
				if (this.y > this.centerY)
				{
					this.centerStop = 2;
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_RushB_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1741, 0);
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3828);
			this.count = 0;

			if (this.centerStop >= 2 && this.y > this.centerY)
			{
				this.SetSpeed_XY(null, this.va.y < 4,00000000.0 ? 4,00000000.0 : null);
			}

			this.stateLabel = function ()
			{
				this.CenterUpdate(this.baseGravity, 10,00000000.0);

				if (this.count == 3 || this.count == 6)
				{
					this.HitTargetReset();
					this.PlaySE(3828);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
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
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1211, 0);

	if (this.centerStop >= 2 && this.y > this.centerY)
	{
		this.SetSpeed_XY(null, this.va.y < 8,50000000.0 ? 8,50000000.0 : null);
	}

	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3828);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(this.baseGravity, 10,00000000.0);

				if (this.count == 3 || this.count == 6)
				{
					this.HitTargetReset();
					this.PlaySE(3828);
				}

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 3);
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
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.count = 0;
	this.SetMotion(1220, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3812);
			this.centerStop = -3;
			this.SetSpeed_XY(7,00000000.0 * this.direction, -7,00000000.0);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,75000000.0, 1,50000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,60000002.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
				{
					this.SetSpeed_XY(null, 3,00000000.0);
					this.centerStop = 1;
					this.SetMotion(1220, 4);
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
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.count = 0;
	this.SetMotion(1720, 0);
	this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3814);
			this.centerStop = -3;
			this.SetSpeed_XY(12,00000000.0 * this.direction, -7,00000000.0);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,75000000.0, 1,50000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,60000002.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
				{
					this.SetSpeed_XY(null, 3,00000000.0);
					this.centerStop = 1;
					this.SetMotion(1220, 4);
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
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;

	if (this.centerStop * this.centerStop >= 4 && this.y <= this.centerY)
	{
		this.SetMotion(1221, 0);
		this.keyAction = [
			function ()
			{
				this.centerStop = -3;
				this.SetSpeed_XY(5,00000000.0 * this.direction, -9,00000000.0);
				this.PlaySE(3824);
			},
			null,
			this.EndtoFallLoop
		];
		this.stateLabel = function ()
		{
			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetMotion(this.motion, 3);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,75000000.0);
				};
				return;
			}
		};
	}
	else
	{
		this.SetMotion(1222, 0);
		this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
		this.stateLabel = function ()
		{
			this.Vec_Brake(0,10000000.0);
			this.CenterUpdate(0,20000000.0, null);
		};
		this.keyAction = [
			function ()
			{
				this.SetSpeed_Vec(17,00000000.0, -60 * 0,01745329.0, this.direction);
				this.PlaySE(3824);
				this.centerStop = -3;
				this.count = 0;
				this.stateLabel = function ()
				{
					if (this.y + this.va.y <= this.centerY && this.count >= 4)
					{
						this.SetMotion(this.motion, 3);
						this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
						this.stateLabel = function ()
						{
							if (this.centerStop * this.centerStop <= 1)
							{
								this.SetMotion(this.motion, 4);
								this.stateLabel = function ()
								{
									this.VX_Brake(0,75000000.0);
								};
							}
						};
					}
				};
			},
			null,
			null,
			this.EndtoFallLoop
		];
	}

	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1700, 0);
	this.SetSpeed_XY(10,00000000.0 * this.direction, null);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3819);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(3820);
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1740, 0);
	this.atk_id = 2048;
	return true;
}

function Atk_HighFront_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetMotion(1230, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3816);
		},
		function ()
		{
			this.PlaySE(3817);
			this.HitTargetReset();
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1750, 0);
	this.atk_id = 16;
	this.stateLabel = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.GetFront();
			this.SetMotion(1110, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
			this.PlaySE(3828);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1231, 5);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(3828);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(3828);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1231, 5);
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
					this.SetMotion(1231, 5);
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
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	return true;
}

function Atk_HighFront_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetMotion(1231, 0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,25000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1231, 5);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(3828);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(3828);
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(3828);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1231, 5);
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
					this.SetMotion(1231, 5);
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
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		this.EndtoFreeMove
	];
	return true;
}

function Atk_LowDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1300, 0);
	this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
			this.PlaySE(3830);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
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

function Atk_LowDash_R_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1301, 0);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
			this.PlaySE(3830);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
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

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.centerStop = -2;
	this.SetSpeed_XY(15,00000000.0 * this.direction, -7,00000000.0);
	this.stateLabel = function ()
	{
		if (this.VY_Brake(0,50000000.0, -1,50000000.0))
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0, 10,00000000.0 * this.direction);
				this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
			};
		}

		this.VX_Brake(0,50000000.0, 10,00000000.0 * this.direction);
	};
	this.SetMotion(1310, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3832);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(3832);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(3832);
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,05000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	];
	return true;
}

function Atk_HighDash_R_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.count = 0;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,34999999.0);

		if (this.count == 14)
		{
			this.centerStop = -2;
			this.SetSpeed_XY(15,00000000.0 * this.direction, -7,00000000.0);
			this.stateLabel = function ()
			{
				if (this.VY_Brake(0,50000000.0, -1,50000000.0))
				{
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0, 10,00000000.0 * this.direction);
						this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
					};
				}

				this.VX_Brake(0,50000000.0, 10,00000000.0 * this.direction);
			};
		}
	};
	this.SetMotion(1311, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3832);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(3832);
			this.HitTargetReset();
		},
		function ()
		{
			this.PlaySE(3832);
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,05000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
			};
		}
	];
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
		this.target.Warp(this.initTable.pare.point0_x - (this.target.point0_x - this.target.x), this.target.y);
	};
}

function Grab_Actor2( t )
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
		this.initTable.pare.Warp(this.target.point0_x - (this.initTable.pare.point0_x - this.initTable.pare.x), this.target.point0_y - (this.initTable.pare.point0_y - this.initTable.pare.y));
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
	this.target.autoCamera = false;
	::battle.enableTimeUp = false;
	this.target.cameraPos.x = this.x;
	this.target.cameraPos.y = this.y;
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor, {}, this.weakref()).weakref();
	this.target.Warp(this.point0_x, this.y);
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
	this.HitReset();
	this.SetMotion(1802, 1);
	this.target.DamageGrab_Common(301, 2, -this.direction);
	this.target.autoCamera = false;
	this.target.cameraPos.x = this.target.x;
	this.target.cameraPos.y = this.target.y;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1.func[0].call(this.flag1);
	this.flag1 = this.SetFreeObject(this.x, this.y, this.direction, this.Grab_Actor2, {}, this.weakref()).weakref();
	this.flag2 = null;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.keyAction = [
		null,
		function ()
		{
			this.count = 0;
			this.PlaySE(3898);
			this.target.DamageGrab_Common(300, 2, -this.direction);
			this.flag2 = this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.Grab_Eye, {}).weakref();
			this.SetParent.call(this.flag2, this, this.flag2.x - this.x, this.flag2.y - this.y);
			this.stateLabel = function ()
			{
				if (!this.san_mode)
				{
					this.san += 83;

					if (this.san > 9988)
					{
						this.san = 9988;
					}

					if (this.san_gauge)
					{
						this.san_gauge.func[2].call(this.san_gauge, 1,00000000.0);
					}
				}

				if (this.count == 60)
				{
					this.func[0].call(this);
					return;
				}
			};
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

			this.PlaySE(3899);
			this.flag1.func[0].call(this.flag1);
			this.SetEffect(this.target.x, this.target.y, this.direction, this.EF_HitSmashC, {});
			this.target.autoCamera = true;
			this.KnockBackTarget(-this.direction);
			this.HitReset();
			this.hitResult = 1;
			this.SetSpeed_XY(-3,00000000.0 * this.direction, -5,00000000.0);
			this.centerStop = -3;
			this.Warp(this.target.x, this.centerY - 10);
			::battle.enableTimeUp = true;
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
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(this.motion, 6);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
}

function Shot_Normal_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2000, 0);
	this.count = 0;
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3834);
			this.count = 0;
			local t = {};
			t.san <- this.flag2;
			t.rot <- 0,00000000.0;
			t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.flag1--;
			this.stateLabel = function ()
			{
				if (this.flag1 > 0 && this.count % 4 == 0)
				{
					this.PlaySE(3834);
					local t = {};
					t.san <- this.flag2;
					t.rot <- 0,00000000.0;
					t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
					this.flag1--;
				}

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

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2003, 0);
	this.count = 0;
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.flag3 = this.y <= this.centerY ? -1 : 1;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3834);
			this.count = 0;
			local t = {};
			t.san <- this.flag2;
			t.rot <- 0,00000000.0;
			t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.flag1--;
			this.centerStop = 3 * this.flag3;
			this.stateLabel = function ()
			{
				if (this.flag1 > 0 && this.count % 4 == 0)
				{
					this.centerStop = 3 * this.flag3;
					this.PlaySE(3834);
					local t = {};
					t.san <- this.flag2;
					t.rot <- 0,00000000.0;
					t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
					this.flag1--;
				}

				this.CenterUpdate(0,20000000.0, null);
				this.subState();
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
		this.subState();
	};
	return true;
}

function Shot_Normal_Upper_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3834);
			this.count = 0;
			local t = {};
			t.san <- this.flag2;
			t.rot <- -40,00000000.0 * 0,01745329.0;
			t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.flag1--;
			this.stateLabel = function ()
			{
				if (this.flag1 > 0 && this.count % 4 == 0)
				{
					this.PlaySE(3834);
					local t = {};
					t.san <- this.flag2;
					t.rot <- -40 * 0,01745329.0;
					t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
					this.flag1--;
				}

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

function Shot_Normal_Upper_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2004, 0);
	this.count = 0;
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.flag3 = this.y <= this.centerY ? -1 : 1;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3834);
			this.count = 0;
			local t = {};
			t.san <- this.flag2;
			t.rot <- -40,00000000.0 * 0,01745329.0;
			t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.flag1--;
			this.stateLabel = function ()
			{
				if (this.flag1 > 0 && this.count % 4 == 0)
				{
					this.PlaySE(3834);
					local t = {};
					t.san <- this.flag2;
					t.rot <- -40,00000000.0 * 0,01745329.0;
					t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
					this.flag1--;
				}

				this.CenterUpdate(0,10000000.0, null);
				this.subState();
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
		this.subState();
	};
	return true;
}

function Shot_Normal_Under_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2002, 0);
	this.count = 0;
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3834);
			this.count = 0;
			local t = {};
			t.san <- this.flag2;
			t.rot <- 40,00000000.0 * 0,01745329.0;
			t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.flag1--;
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				if (this.flag1 > 0 && this.count % 4 == 0)
				{
					this.PlaySE(3834);
					local t = {};
					t.san <- this.flag2;
					t.rot <- 40,00000000.0 * 0,01745329.0;
					t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
					this.flag1--;
				}

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

function Shot_Normal_Under_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2005, 0);
	this.count = 0;
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.flag3 = this.y <= this.centerY ? -1 : 1;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,50000000.0);
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3834);
			this.count = 0;
			local t = {};
			t.san <- this.flag2;
			t.rot <- 40,00000000.0 * 0,01745329.0;
			t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
			this.flag1--;
			this.stateLabel = function ()
			{
				if (this.flag1 > 0 && this.count % 4 == 0)
				{
					local t = {};
					t.san <- this.flag2;
					this.PlaySE(3834);
					t.rot <- 40,00000000.0 * 0,01745329.0;
					t.addRot <- (36 - this.flag1 * 12) * 0,01745329.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
					this.flag1--;
				}

				this.CenterUpdate(0,10000000.0, null);
				this.subState();
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
		this.subState();
	};
	return true;
}

function Shot_Front_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2010, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.flag3 = 0,00000000.0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(3836);
			this.count = 0;
			this.SetSpeed_XY(-12,50000000.0 * this.direction, 0,00000000.0);

			if (this.target.centerStop * this.target.centerStop > 2)
			{
				this.flag3 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag3 = this.Math_MinMax(this.flag3, -0,26179937.0, 0,26179937.0);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0, -1,00000000.0 * this.direction);

				if (this.count % 2 == 1)
				{
					if (this.flag1 > 0)
					{
						this.hitResult = 1;
						local t_ = {};
						t_.rot <- this.flag3 + (this.flag1 - 3) * 7 * 0,01745329.0;
						t_.san <- this.flag2;
						t_.cancel <- this.flag1 == 3 ? 3 : 1;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t_);
						this.flag1--;
					}
					else
					{
						this.stateLabel = function ()
						{
							this.VX_Brake(0,30000001.0);
						};
					}
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,64999998.0);
	};
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2011, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.flag1 = 5;
	this.flag2 = this.san_mode;
	this.flag3 = 0,00000000.0;
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(-12,50000000.0 * this.direction, 0,00000000.0);
			this.team.AddMP(-200, 90);
			this.PlaySE(3836);
			this.flag3 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.flag3 = this.Math_MinMax(this.flag3, -0,26179937.0, 0,26179937.0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,20000000.0, 2,00000000.0);
				this.VX_Brake(0,75000000.0, -1,00000000.0 * this.direction);

				if (this.count % 2 == 1)
				{
					if (this.flag1 > 0)
					{
						this.hitResult = 1;
						local t_ = {};
						t_.rot <- this.flag3 + (this.flag1 - 3) * 7 * 0,01745329.0;
						t_.san <- this.flag2;
						t_.cancel <- this.flag1 == 3 ? 3 : 1;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t_);
						this.flag1--;
					}
					else
					{
						this.stateLabel = function ()
						{
							this.VX_Brake(0,75000000.0, -1,00000000.0 * this.direction);
							this.CenterUpdate(0,20000000.0, 2,00000000.0);
						};
					}
				}
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, null);

				if (this.subState())
				{
					return;
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
				else
				{
					this.VX_Brake(0,20000000.0);
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
			return true;
		}
	};
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,20000000.0, 2,00000000.0);
		this.VX_Brake(0,05000000.0);
	};
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 6,50000000.0;
	this.flag2.vy <- 4,00000000.0;
	this.subState = function ()
	{
	};
	return true;
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2020, 0);
	this.count = 0;
	this.flag1 = this.Vector3();
	this.flag2 = t.ky;

	if (t.charge)
	{
	}
	else
	{
		this.flag3 = [
			this.Vector3(),
			this.Vector3(),
			this.Vector3(),
			this.Vector3()
		];
		this.flag3[0].x = 200;
		this.flag3[0].y = 50;
		this.flag3[1].x = 275;
		this.flag3[1].y = -75;
		this.flag3[2].x = 325;
		this.flag3[2].y = 100;
		this.flag3[3].x = 400;
		this.flag3[3].y = -20;

		if (this.flag2 > 0)
		{
			foreach( a in this.flag3 )
			{
				a.RotateByDegree(20);
			}
		}

		if (this.flag2 < 0)
		{
			foreach( a in this.flag3 )
			{
				a.RotateByDegree(-20);
			}
		}
	}

	this.flag4 = t.charge;
	this.AjustCenterStop();
	this.PlaySE(3838);
	this.keyAction = [
		function ()
		{
			local t_ = {};
			t_.rot <- 0,00000000.0;
			t_.san <- this.san_mode;

			if (this.flag2 > 0)
			{
				t_.rot = 20 * 0,01745329.0;
			}

			if (this.flag2 < 0)
			{
				t_.rot = -20 * 0,01745329.0;
			}

			this.flag1.x = this.point0_x + this.cos(t_.rot) * 60 * this.direction;
			this.flag1.y = this.point0_y + this.sin(t_.rot) * 60;
			local core_;

			if (this.flag4)
			{
				core_ = this.SetShot(this.flag1.x, this.flag1.y, this.direction, this.Shot_FullChargeExpCore, t_, null).weakref();
			}
			else
			{
				core_ = this.SetShot(this.flag1.x, this.flag1.y, this.direction, this.Shot_ChargeExpCore, t_, null).weakref();
			}

			local b_;
			local t3_ = {};
			t3_.rot <- t_.rot + (-20 + this.rand() % 4) * 0,01745329.0;
			t3_.core <- core_.weakref();
			local a_ = this.SetShot(this.flag1.x, this.flag1.y, this.direction, this.Shot_ChargeBullet, t3_, null);

			for( local i = -15; i < 20; i = i + 5 )
			{
				local t3_ = {};
				t3_.rot <- t_.rot + (i + this.rand() % 4) * 0,01745329.0;
				t3_.core <- core_.weakref();
				b_ = this.SetShot(this.flag1.x, this.flag1.y, this.direction, this.Shot_ChargeBullet, t3_, null);
				b_.hitOwner = a_.weakref();
			}

			local t2_ = {};
			t2_.rot <- t_.rot;
			b_ = this.SetShot(this.flag1.x, this.flag1.y, this.direction, this.owner.Shot_Charge_FireFlash, t_, null);
			b_.hitOwner = a_.weakref();
			this.SetSpeed_XY(-7,50000000.0 * this.direction, 0,00000000.0);
			this.AjustCenterStop();
			this.PlaySE(3839);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, 2,50000000.0);

				if (this.centerStop == 0)
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
			this.count = 0;
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
		this.Vec_Brake(0,50000000.0);
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
	this.flag2.vx <- 6,50000000.0;
	this.flag2.vy <- 4,00000000.0;

	if (this.centerStop * this.centerStop <= 1 || this.centerStop * this.centerStop > 1 && this.y > this.centerY)
	{
		this.flag2.rot <- -42 * 0,01745329.0;
		this.flag2.cycle <- -0,06981317.0;
	}
	else
	{
		this.flag2.rot <- 0,05235988.0;
		this.flag2.cycle <- 0,06981317.0;
	}

	this.subState = function ()
	{
		if (this.team.mp > 0)
		{
			local c_ = this.count % 40;

			if (c_ == 7 || c_ == 11 || c_ == 15 || c_ == 19 || c_ == 23 || c_ == 27)
			{
				this.PlaySE(3904);
				local t_ = {};
				t_.v <- 15,00000000.0;
				t_.rot <- this.flag2.rot;
				this.SetShot(this.x + 100 * this.cos(t_.rot) * this.direction, this.y - 20 + 100 * this.sin(t_.rot), this.direction, this.Shot_Barrage, t_).weakref();
				local t_ = {};
				t_.v <- 15,00000000.0;
				t_.rot <- this.flag2.rot + 45 * 0,01745329.0;
				this.SetShot(this.x + 100 * this.cos(t_.rot) * this.direction, this.y - 20 + 100 * this.sin(t_.rot), this.direction, this.Shot_Barrage, t_).weakref();
				this.flag2.rot += this.flag2.cycle;

				if (c_ == 27)
				{
					if (this.flag2.cycle > 0)
					{
						this.flag2.rot = -42 * 0,01745329.0;
					}
					else
					{
						this.flag2.rot = 0,05235988.0;
					}

					this.flag2.cycle *= -1;
				}
			}
		}
	};
	return true;
}

function Okult_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		this.OkultAir_Init(t);
		return true;
	}

	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.atk_id = 524288;
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.flag1 = 10,00000000.0;
	this.flag2 = -10,00000000.0;
	this.flag3 = this.centerY;

	if (this.centerStop * this.centerStop != 0)
	{
		this.flag3 = this.y;
	}

	if (t.k * this.direction >= 1,00000000.0)
	{
		this.flag1 = 11,00000000.0;
		this.flag2 = -11,00000000.0;
	}

	if (t.k <= -1)
	{
		this.flag1 = 7,00000000.0;
		this.flag2 = -9,00000000.0;
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(3857);
			this.SetSpeed_XY(this.flag1 * this.direction, this.flag2);
			this.centerStop = -2;
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,00000000.0);

				if (this.va.y > 0,00000000.0 && this.y >= this.flag3)
				{
					this.PlaySE(3858);
					this.Warp(this.x, this.flag3);
					this.SetMotion(this.motion, 3);

					if (this.kune)
					{
						this.kune.func[0].call(this.kune);
					}

					local t_ = {};
					t_.type <- this.team.index;
					this.kune = this.SetObject(this.point0_x, this.point0_y, this.direction, this.Occult_Shot, t_).weakref();
					this.lavelClearEvent = function ()
					{
						if (this.kune)
						{
							this.kune.SetParent(null, 0, 0);
							this.kune.func[0].call(this.kune);
						}
					};
					this.SetParent.call(this.kune, this, this.kune.x - this.x, this.kune.y - this.y);
					this.centerStop = 1;
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(1,00000000.0);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.lavelClearEvent = null;
			this.PlaySE(3859);
			this.kune.func[1].call(this.kune, this.san_mode);

			if (this.san_mode)
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			}
			else
			{
				this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
			}

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

function OkultAir_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.atk_id = 524288;
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.count = 0;
	this.flag1 = 10,00000000.0;
	this.flag2 = -10,00000000.0;
	this.flag3 = this.y;

	if (t.k * this.direction >= 1,00000000.0)
	{
		this.flag1 = 11,00000000.0;
		this.flag2 = -11,00000000.0;
	}

	if (t.k <= -1)
	{
		this.flag1 = 7,00000000.0;
		this.flag2 = -9,00000000.0;
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(3857);
			this.SetSpeed_XY(this.flag1 * this.direction, this.flag2);
			this.centerStop = -2;
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,00000000.0);

				if (this.va.y > 0,00000000.0 && this.y >= this.flag3)
				{
					this.PlaySE(3858);
					this.Warp(this.x, this.flag3);
					this.SetMotion(this.motion, 3);

					if (this.kune)
					{
						this.kune.func[0].call(this.kune);
					}

					local t_ = {};
					t_.type <- this.team.index;
					this.kune = this.SetObject(this.point0_x, this.point0_y, this.direction, this.Occult_Shot, t_).weakref();
					this.lavelClearEvent = function ()
					{
						if (this.kune)
						{
							this.kune.SetParent(null, 0, 0);
							this.kune.func[0].call(this.kune);
						}
					};
					this.SetParent.call(this.kune, this, this.kune.x - this.x, this.kune.y - this.y);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(1,00000000.0);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.lavelClearEvent = null;
			this.PlaySE(3859);
			this.kune.func[1].call(this.kune, this.san_mode);

			if (this.san_mode)
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			}
			else
			{
				this.SetSpeed_XY(-15,00000000.0 * this.direction, 0,00000000.0);
			}

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

function SP_A_Init( t )
{
	if (this.centerStop * this.centerStop >= 2)
	{
		if (this.SP_A_Air_Init(t))
		{
			return true;
		}
	}
	else
	{
		this.LabelClear();
		this.HitReset();
		this.hitResult = 1;
		this.count = 0;
		this.flag1 = this.san_mode;
		this.flag2 = 0;
		this.SetMotion(3000, 0);
		this.PlaySE(3841);
		this.keyAction = [
			function ()
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
				this.team.AddMP(-200, 120);
				this.count = 0;
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0, -1,50000000.0 * this.direction);

					if (this.count % 4 == 1)
					{
						this.PlaySE(3842);
						local t_ = {};
						t_.san <- this.flag1;
						t_.rot <- this.skillA_table[this.flag2];
						t_.rot2 <- this.skillA_table2[this.flag2];
						this.flag2++;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A, t_);
					}

					if (this.count == 22)
					{
						this.SetMotion(this.motion, 2);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,15000001.0);
						};
					}
				};
			}
		];
		this.stateLabel = function ()
		{
			this.VX_Brake(0,50000000.0, -1,50000000.0 * this.direction);
		};
		return true;
	}
}

function SP_A_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 1048576;
	this.count = 0;
	this.flag1 = this.san_mode;
	this.flag2 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.AjustCenterStop();
	this.SetMotion(3001, 0);
	this.PlaySE(3841);
	this.keyAction = [
		function ()
		{
			if (this.y < this.centerY)
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, -3,00000000.0);
				this.centerStop = -2;
			}
			else
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, 3,00000000.0);
				this.centerStop = 2;
			}

			this.team.AddMP(-200, 120);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0, -1,50000000.0 * this.direction);
				this.CenterUpdate(0,34999999.0, 5,00000000.0);

				if (this.centerStop * this.centerStop <= 1 && this.keyTake == 2)
				{
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}

				if (this.count % 4 == 1)
				{
					this.PlaySE(3842);
					local t_ = {};
					t_.san <- this.flag1;
					t_.rot <- this.skillA_table[this.flag2];
					t_.rot2 <- this.skillA_table2[this.flag2];
					this.flag2++;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_A, t_);
				}

				if (this.count == 22)
				{
					this.SetMotion(this.motion, 2);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,34999999.0, 5,00000000.0);

						if (this.centerStop * this.centerStop <= 1)
						{
							this.VX_Brake(0,50000000.0);
						}
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,05000000.0);
		this.CenterUpdate(0,25000000.0, 3,00000000.0);
	};
	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3011, 0);
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.owner.hide = false;
	this.flag2 = 0;
	this.flag3 = false;
	this.func = [
		function ()
		{
			this.SetMotion(3011, 5);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0, -0,50000000.0 * this.direction);
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(-0,50000000.0 * this.direction, 0,00000000.0);
			};
		},
		null,
		function ()
		{
			this.PlaySE(3897);
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 2)
				{
					this.skillB_SE = true;
					this.PlaySE(3896);
					local t_ = {};
					t_.priority <- 189;
					this.SetShot(this.x, this.y - 140, this.direction, this.SPShot_B_Udon, t_);
					this.SetSpeed_XY(-12,50000000.0 * this.direction, 0,00000000.0);
				}

				if (this.count == 6)
				{
					local t_ = {};
					t_.priority <- 191;
					this.SetShot(this.x, this.y + 140, this.direction, this.SPShot_B_Udon, t_);
				}

				if (this.count == 10)
				{
					local t_ = {};
					t_.priority <- 188;
					this.SetShot(this.x, this.y - 70, this.direction, this.SPShot_B_Udon, t_);
				}

				if (this.count == 14)
				{
					local t_ = {};
					t_.priority <- 192;
					this.SetShot(this.x, this.y + 70, this.direction, this.SPShot_B_Udon, t_);
				}

				if (this.count == 18)
				{
					this.func[0].call(this);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;

			if (this.san_mode)
			{
				this.flag3 = true;
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0, -0,50000000.0 * this.direction);

				if (this.count >= 5 && this.count % 4 == 1)
				{
					if (this.flag2 <= 2)
					{
						this.PlaySE(3844);
						local t_ = {};
						t_.rot <- this.rz;
						t_.san <- this.flag3;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_B_Bullet, t_);
					}

					this.flag2++;
				}

				if (this.count >= 20)
				{
					this.SetMotion(this.motion, 7);
					this.stateLabel = function ()
					{
						this.VX_Brake(1,00000000.0, -0,15000001.0 * this.direction);
					};
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

function SP_B_Back_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3011, 5);
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.masterAlpha = 1,00000000.0;
	this.hide = false;
	return true;
}

function SP_B2_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(3011, 2);
	this.count = 0;
	this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
	};
	return true;
}

function SP_B_Air_Init( t )
{
	this.LabelClear();
	this.AjustCenterStop();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3011, 0);
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.owner.hide = false;
	this.flag2 = 0;
	this.flag3 = false;
	this.flag1 = -1,00000000.0;

	if (this.y < this.centerY)
	{
		this.flag1 = 1,00000000.0;
	}

	this.func = [
		function ()
		{
			this.SetMotion(3011, 5);
			this.AjustCenterStop();
			this.PlaySE(3846);
			this.SetSpeed_XY(-9,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0, -0,50000000.0 * this.direction);
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(-0,50000000.0 * this.direction, 0,00000000.0);
			};
		},
		null,
		function ()
		{
			this.PlaySE(3897);
		},
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(-12,50000000.0 * this.direction, 12,50000000.0 * this.flag1);
			this.stateLabel = function ()
			{
				if (this.count == 4)
				{
					this.PlaySE(3896);
					local t_ = {};
					t_.priority <- 185;
					this.SetShot(this.x, this.y, this.direction, this.SPShot_B_Udon, t_);
				}

				if (this.count == 8)
				{
					local t_ = {};
					t_.priority <- 186;
					this.SetShot(this.x, this.y, this.direction, this.SPShot_B_Udon, t_);
				}

				if (this.count == 12)
				{
					local t_ = {};
					t_.priority <- 187;
					this.SetShot(this.x, this.y, this.direction, this.SPShot_B_Udon, t_);
				}

				if (this.count == 16)
				{
					local t_ = {};
					t_.priority <- 188;
					this.SetShot(this.x, this.y, this.direction, this.SPShot_B_Udon, t_);
				}

				if (this.count == 20)
				{
					this.func[0].call(this);
				}
			};
		},
		null,
		function ()
		{
			this.count = 0;

			if (this.san_mode)
			{
				this.flag3 = true;
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0, -0,50000000.0 * this.direction);

				if (this.count >= 5 && this.count % 4 == 1)
				{
					if (this.flag2 <= 2)
					{
						this.PlaySE(3844);
						local t_ = {};
						t_.rot <- this.rz;
						t_.san <- this.flag3;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_B_Bullet, t_);
					}

					this.flag2++;
				}

				if (this.count >= 20)
				{
					this.SetMotion(this.motion, 7);
					this.stateLabel = function ()
					{
						this.VX_Brake(1,00000000.0, -0,50000000.0 * this.direction);
					};
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

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.atk_id = 4194304;
	this.flag1 = t.rush;
	this.count = 0;
	this.SetMotion(3020, 0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(3847);
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.v <- this.Vector3();
			t_.v.x = 17,00000000.0;
			t_.v.y = -17,00000000.0;
			t_.type <- 0;
			this.box = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_, null).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (::battle.state == 8 && this.box && this.count >= 10 && ((this.input.b2 > 0 || this.command.rsv_k2 > 0) || this.flag1 && (this.input.b0 > 0 || this.command.rsv_k0 > 0)))
				{
					this.SP_C2_Init(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);

				if (::battle.state == 8 && this.box && this.count >= 5 && ((this.input.b2 > 0 || this.command.rsv_k2 > 0) || this.flag1 && (this.input.b0 > 0 || this.command.rsv_k0 > 0)))
				{
					this.SP_C2_Init(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(1,00000000.0);

		if (this.count == 12)
		{
			this.SetSpeed_XY(8,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function SP_C2_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.hitResult = 1;
	this.atk_id = 4194304;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

	if (this.box)
	{
		local pos_ = this.Vector3();
		pos_.x = this.box.x - this.x;
		pos_.y = this.box.y - this.y;
		pos_.Normalize();

		if ((this.box.x - this.x) * this.direction < 0)
		{
			this.direction = -this.direction;
		}

		if (this.fabs(pos_.y) <= 0,50000000.0)
		{
			this.SetMotion(3023, 0);
		}
		else if (pos_.y < 0)
		{
			this.SetMotion(3022, 0);
		}
		else
		{
			this.SetMotion(3024, 0);
		}
	}
	else
	{
		this.SetMotion(3023, 0);
	}

	this.keyAction = [
		function ()
		{
			this.PlaySE(3850);
			local t_ = {};
			t_.rot <- 0,00000000.0;

			if (this.motion == 3024)
			{
				t_.rot = 45 * 0,01745329.0;
			}

			if (this.motion == 3022)
			{
				t_.rot = -45 * 0,01745329.0;
			}

			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C_Bullet, t_);
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0);
	};
	return true;
}

function SP_C_Air_Init( t )
{
	this.LabelClear();
	this.flag1 = t.rush;
	this.HitReset();
	this.count = 0;
	this.hitResult = 1;
	this.atk_id = 4194304;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.AjustCenterStop();
	this.SetMotion(3021, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(3847);
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.v <- this.Vector3();

			if (this.y < this.centerY)
			{
				t_.v.x = 17,00000000.0;
				t_.v.y = -12,50000000.0;
				t_.type <- 2;

				if (this.va.y < 0)
				{
					t_.v.y = -12,50000000.0;
				}
			}
			else
			{
				t_.v.x = 17,00000000.0;
				t_.v.y = -17,00000000.0;
				t_.type <- 0;
			}

			this.box = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_, null).weakref();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,25000000.0, 2,00000000.0);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}

				if (::battle.state == 8 && this.box && this.count >= 15 && this.count <= 30 && ((this.input.b2 > 0 || this.command.rsv_k2 > 0) || this.flag1 && (this.input.b0 > 0 || this.command.rsv_k0 > 0)))
				{
					this.SP_C2_Init(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}

				if (::battle.state == 8 && this.box && this.count >= 5 && ((this.input.b2 > 0 || this.command.rsv_k2 > 0) || this.flag1 && (this.input.b0 > 0 || this.command.rsv_k0 > 0)))
				{
					this.SP_C2_Init(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}

				if (this.box && this.count >= 15 && this.command.rsv_k2 > 0)
				{
					this.SP_C2_Init(null);
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,25000000.0, 2,00000000.0);
		this.VX_Brake(0,05000000.0);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,75000000.0);
		}
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 8388608;
	this.SetMotion(3030, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.flag1 = null;
	this.flag2 = this.san_mode;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(3852);
			this.count = 0;

			if (this.centerStop * this.centerStop <= 1)
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, -10,00000000.0);
			}
			else
			{
				this.SetSpeed_XY(-10,00000000.0 * this.direction, -6,00000000.0);
			}

			this.centerStop = -3;

			if (this.flag2)
			{
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D_San, {}).weakref();
			}
			else
			{
				this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_D, {}).weakref();
			}

			this.stateLabel = function ()
			{
				if (this.Vec_Brake(1,00000000.0, 3,00000000.0))
				{
					this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
						this.VX_Brake(0,10000000.0);
					};
				}
			};
		},
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func();
			}

			this.flag1 = null;
			this.AjustCenterStop();
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
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,50000000.0, null);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,05000000.0, 3,00000000.0);
	};
	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 16777216;
	this.AjustCenterStop();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(3040, 0);
	this.count = 0;
	this.flag1 = [];
	this.flag2 = null;
	this.flag3 = 0,00000000.0;
	this.flag4 = this.san_mode;
	this.flag5 = 0;
	this.skillE_air = true;
	this.keyAction = [
		function ()
		{
			if (this.flag4)
			{
				local t_ = {};
				t_.rot <- 0;
				local a_ = [];
				a_.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_E, t_, this.weakref()));
				a_.append(this.SetShot(this.x, this.y, -this.direction, this.SPShot_E, t_, this.weakref()));
				local t_ = {};
				t_.rot <- 45 * 0,01745329.0;
				a_.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_E, t_, this.weakref()));
				a_.append(this.SetShot(this.x, this.y, -this.direction, this.SPShot_E, t_, this.weakref()));
				local t_ = {};
				t_.rot <- -45 * 0,01745329.0;
				a_.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_E, t_, this.weakref()));
				a_.append(this.SetShot(this.x, this.y, -this.direction, this.SPShot_E, t_, this.weakref()));

				foreach( act_ in a_ )
				{
					act_.hitOwner = this.weakref();
				}

				this.flag1 = a_;
			}
			else
			{
				local t_ = {};
				t_.rot <- 0;
				local a_ = this.SetShot(this.x, this.y, this.direction, this.SPShot_E, t_, this.weakref());
				local b_ = this.SetShot(this.x, this.y, -this.direction, this.SPShot_E, t_, this.weakref());
				a_.hitOwner = b_.weakref();
				this.flag1 = [
					a_.weakref(),
					b_.weakref()
				];
			}

			this.team.AddMP(-200, 120);
			this.PlaySE(3854);
		},
		function ()
		{
			if (!this.flag4 && this.input.x && ::battle.state == 8)
			{
				this.flag3 = this.input.x > 0 ? 50 : -50;
			}

			this.SetSpeed_XY(this.flag3, 0);
			this.HitTargetReset();
			this.PlaySE(3855);
			local hit_ = this.flag4;

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.func(hit_);
				}
			}

			if (this.flag2)
			{
				this.flag2.func();
			}

			this.stateLabel = function ()
			{
				if (this.fabs(this.flag1[0].x - this.x) <= 45)
				{
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

					foreach( a in this.flag1 )
					{
						if (a)
						{
							this.ReleaseActor.call(a);
						}
					}

					local f_ = this.GetFront();
					this.hitResult = 1;

					if (this.flag3 == 0,00000000.0 || this.flag3 * this.direction > 0 && !f_)
					{
						this.SetMotion(this.motion, 5);
					}
					else
					{
						this.SetMotion(this.motion, 3);
					}

					this.stateLabel = function ()
					{
					};
				}
			};
		},
		null,
		null,
		this.EndtoFreeMove,
		null
	];
	this.stateLabel = function ()
	{
		if (this.count == 15)
		{
			this.flag2 = this.SetFreeObject(this.x, this.y - 50, this.direction, this.SPShot_E_Pulse, {}).weakref();
		}
	};
	return true;
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 67108864;
	this.SetMotion(4000, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag5 = null;
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.count = 0;
			this.flag1 = 0;
			::camera.SetTarget(640, 360, 1,00000000.0, false);
			this.lavelClearEvent = function ()
			{
				::camera.ResetTarget();
			};
			this.stateLabel = function ()
			{
				if (this.count % 4 == 1)
				{
					this.PlaySE(3862);
					local t_ = {};
					t_.rot <- (-55 + (this.keyTake - 2) * 25) * 0,01745329.0;
					t_.rate <- this.atkRate_Pat;
					t_.bound <- 3;

					if (this.keyTake == 5)
					{
						t_.rot <- (-55 + 25 + 10 - this.rand() % 21) * 0,01745329.0;
					}

					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_);
					local t_ = {};
					t_.rot <- (-55 + (this.keyTake - 2) * 25) * 0,01745329.0;
					t_.rate <- this.atkRate_Pat * 0,50000000.0;
					t_.bound <- 4;

					if (this.keyTake == 5)
					{
						t_.rot <- (-55 + 25 + 10 - this.rand() % 21) * 0,01745329.0;
					}

					this.SetShot(this.point1_x, this.point1_y, -this.direction, this.SpellShot_A, t_);
				}

				if (this.count >= 60)
				{
					this.SetMotion(this.motion, 3);
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
			::camera.ResetTarget();
			this.lavelClearEvent = null;
		}
	];
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 67108864;
	this.SetMotion(4010, 0);
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
		},
		function ()
		{
			this.invin = 4;
			this.invinObject = 4;
			this.count = 0;
			this.PlaySE(3865);
			this.stateLabel = function ()
			{
				if (this.count % 6 == 1)
				{
					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					local a_ = this.SetShot(this.point0_x - 10 * this.direction, this.point0_y, -this.direction, this.SpellShot_B, t_);
					local b_ = this.SetShot(this.point0_x + 10 * this.direction, this.point0_y, this.direction, this.SpellShot_B, t_);
					b_.hitOwner = a_.weakref();
				}

				if (this.count == 60)
				{
					this.SetMotion(this.motion, this.keyTake + 1);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		null,
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 67108864;
	this.SetMotion(4020, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.flag1 = -10,00000000.0;
	this.flag2 = null;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		function ()
		{
			this.PlaySE(3867);
			this.centerStop = -2;
			this.flag1 = -10,00000000.0;
			this.SetSpeed_Vec(this.flag1, 35 * 0,01745329.0, this.direction);
			this.count = 0;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.lavelClearEvent = function ()
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}
			};
			this.flag2 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_C_SonicCore, t_, this.weakref()).weakref();

			if (this.input.y > 0)
			{
				this.rz = 30,00000000.0 * 0,01745329.0;
			}

			if (this.input.y < 0)
			{
				this.rz = -20,00000000.0 * 0,01745329.0;
			}

			this.stateLabel = function ()
			{
				if (this.input.y > 0)
				{
					this.rz += 1,50000000.0 * 0,01745329.0;

					if (this.rz > 30 * 0,01745329.0)
					{
						this.rz = 30,00000000.0 * 0,01745329.0;
					}
				}

				if (this.input.y < 0)
				{
					this.rz -= 1,50000000.0 * 0,01745329.0;

					if (this.rz < -20 * 0,01745329.0)
					{
						this.rz = -20,00000000.0 * 0,01745329.0;
					}
				}

				this.flag1 *= 0,92000002.0;

				if (this.flag1 > -1,50000000.0)
				{
					this.flag1 = -1,50000000.0;
				}

				this.SetSpeed_Vec(this.flag1, this.rz + 35 * 0,01745329.0, this.direction);

				if (this.flag2)
				{
					this.flag2.Warp(this.point0_x, this.point0_y);
					local r_ = this.rz + 35 * 0,01745329.0 - this.flag2.rz;
					this.flag2.rz += r_;
					this.flag2.flag1.RotateByRadian(r_);
				}

				if (this.count >= 90)
				{
					this.lavelClearEvent = null;

					if (this.flag2)
					{
						this.flag2.func[0].call(this.flag2);
					}

					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
						this.CenterUpdate(0,05000000.0, 3,00000000.0);
					};
				}
			};
		},
		null,
		null,
		function ()
		{
			this.AjustCenterStop();
			this.rz = 0;
			this.SetCollisionRotation(0,00000000.0, 0,00000000.0, 0,00000000.0);
			this.stateLabel = function ()
			{
			};
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 134217728;
	this.SetMotion(4900, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = false;
	this.flag2 = null;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			::battle.enableTimeUp = false;
			this.UseClimaxSpell(60, "ÅñÇ‡Ç§Ç®ëOÇ\x2550ã∂Ç\x2534Ç\x2500Ç¢ÇÈÅIÅñ");
			this.lavelClearEvent = function ()
			{
				::battle.enableTimeUp = true;
				this.lastword.Deactivate();
			};
		},
		function ()
		{
			this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count == 1)
				{
					this.PlaySE(3869);
					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x + 500 * this.direction, this.y + 100, this.direction, this.Spell_Climax_GunShit, t_);
				}

				if (this.count == 5)
				{
					this.PlaySE(3869);
					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x + 200 * this.direction, this.y + 20, this.direction, this.Spell_Climax_GunShit, t_);
				}

				if (this.count == 9)
				{
					this.PlaySE(3869);
					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x - 100 * this.direction, this.y - 80, this.direction, this.Spell_Climax_GunShit, t_);
				}

				if (this.count == 13)
				{
					this.PlaySE(3869);
					local t_ = {};
					t_.rate <- this.atkRate_Pat;
					this.SetShot(this.x - 400 * this.direction, this.y - 160, this.direction, this.Spell_Climax_GunShit, t_);
				}

				if (this.flag2 == null && this.hitResult & 1)
				{
					this.flag2 = this.SetFreeObject(640, 360, 1,00000000.0, this.Spell_Climax_BreakGrass, {}, this).weakref();
					this.BackColorFilter(0,75000000.0, 0,00000000.0, 0,00000000.0, 0,00000000.0, 15);
					this.invin = this.invinObject = this.invinGrab = 60;
				}
			};
		},
		function ()
		{
			if (this.hitResult & 1)
			{
				if (this.flag2)
				{
					this.flag2.func[0].call(this.flag2);
				}

				this.Spell_Climax_Hit();
				return;
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

function Spell_Climax_GunShit( t )
{
	this.SetMotion(4905, 0);
	this.atkRate_Pat = t.rate;
	this.cancelCount = 3;
	this.atk_id = 134217728;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,80000001.0 + this.rand() % 5 * 0,10000000.0;
	this.flag1 = 0,05000000.0;
	this.stateLabel = function ()
	{
		if (this.hitResult & 1)
		{
			this.owner.hitResult = 1;
		}

		this.sx = this.sy += this.flag1;
		this.flag1 *= 0,50000000.0;
		this.alpha -= 0,01500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_Climax_BreakGrass( t )
{
	this.SetMotion(4905, 1);
	this.DrawScreenActorPriority(1000);
	this.func = [
		function ()
		{
			this.SetMotion(4905, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,05000000.0;
				this.alpha -= 0,01500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00050000.0;
	};
}

function Spell_Climax_Hit()
{
	this.LabelReset();
	this.ResetSpeed();
	::battle.enableTimeUp = false;
	this.flag3.Foreach(function ()
	{
		this.ReleaseActor();
	});
	this.SetMotion(4901, 0);
	this.Spell_Climax_Cut();
}

function Spell_Climax_BackB( t )
{
	this.DrawScreenActorPriority(10);
	this.SetMotion(4907, 6);
	this.anime.left = 0;
	this.anime.height = 360;
	this.anime.width = 640;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 2 == 1)
		{
			this.anime.center_x = (1 - this.rand() % 3) * 0,50000000.0;
			this.anime.center_y = (1 - this.rand() % 3) * 0,50000000.0;
		}

		if (this.count % 4 == 1)
		{
			this.alpha = this.rand() % 10 * 0,10000000.0;
		}
	};
}

function Spell_Climax_Back( t )
{
	this.DrawScreenActorPriority(10);
	this.SetMotion(4907, 0);
	this.sx = this.sy = 0,75000000.0;
	this.anime.left = 0;
	this.anime.height = 720;
	this.anime.width = 1280;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.flag5 = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.owner.Spell_Climax_BackB, {}).weakref();
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			if (this.flag5)
			{
				this.ReleaseActor.call(this.flag5);
			}

			this.stateLabel = function ()
			{
				if (this.sx > 2,00000000.0)
				{
					this.alpha -= 0,20000000.0;
				}

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return;
				}

				if (this.sx < 4,00000000.0)
				{
					this.sx = this.sy += 0,25000000.0;
				}
				else
				{
					this.sx = this.sy += 0,00100000.0;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.flag5)
		{
			this.flag5.sx = this.flag5.sy = this.sx;
		}

		this.count++;

		if (this.count % 2 == 1)
		{
			this.anime.center_x = (1 - this.rand() % 3) * 0,50000000.0;
			this.anime.center_y = (1 - this.rand() % 3) * 0,50000000.0;
		}
	};
}

function Spell_Climax_Light( t )
{
	this.DrawScreenActorPriority(30);
	this.SetMotion(4907, 4);
	this.alpha = 0,00000000.0;
	this.sx = this.sy = 3,00000000.0;
	this.flag2 = ::manbow.Actor2DProcGroup();
	this.func = [
		function ()
		{
			this.flag2.Foreach(function ()
			{
				this.ReleaseActor();
			});
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.flag1 += 0,01745329.0 * 0,10000000.0;
		this.rz -= this.flag1;
		this.alpha += 0,05000000.0;
		this.sx = this.sy *= 1,01999998.0;
		this.count++;

		if (this.count % 15 == 14)
		{
			local t_ = {};
			t_.scale <- this.sx;
			this.flag2.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.Spell_Climax_LightB, t_));
		}
	};
}

function Spell_Climax_LightB( t )
{
	this.SetMotion(4907, 5);
	this.DrawScreenActorPriority(30);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = t.scale * 0,50000000.0;
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 1,10000002.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}

		this.sx = this.sy *= 1,10000002.0;
	};
}

function Spell_Climax_FaceEye( t )
{
	this.DrawScreenActorPriority(10);
	this.SetMotion(4907, 3);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha += 0,10000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.alpha = 1,00000000.0;
				}
			};
		}
	];
}

function Spell_Climax_FaceEyeLight( t )
{
	this.DrawScreenActorPriority(9);
	this.SetMotion(4907, 7);
	this.alpha = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.alpha += 0,01000000.0;
	};
}

function Spell_Climax_Face( t )
{
	this.DrawScreenActorPriority(9);
	this.SetMotion(4907, 2);
	this.sx = this.sy = 0,25000000.0;
	this.flag4 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Spell_Climax_FaceEyeLight, {}).weakref();
	this.flag5 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Spell_Climax_FaceEye, {}).weakref();
	this.func = [
		function ()
		{
			this.flag5.func[0].call(this.flag5);
			this.flag2.func[0].call(this.flag2);
			this.flag2 = null;
			this.ReleaseActor();
		},
		function ()
		{
			this.flag5.func[1].call(this.flag5);
			this.stateLabel = function ()
			{
				this.flag1 += 0,01745329.0 * 0,20000000.0;

				if (this.sx < 27,00000000.0 - 12,50000000.0)
				{
					this.sx = this.sy += 0,89999998.0;
					this.rz -= this.flag1 + 10,00000000.0 * 0,01745329.0;
				}
				else
				{
					this.sx = this.sy += 0,20000000.0;
					this.alpha -= 0,05000000.0;

					if (this.alpha < 0,00000000.0)
					{
						this.alpha = 0,00000000.0;

						if (this.flag4)
						{
							this.ReleaseActor.call(this.flag4);
						}
					}

					this.rz -= this.flag1;
				}

				if (this.flag5)
				{
					this.flag5.sx = this.flag5.sy = this.sx * 0,06600000.0;
					this.flag5.rz = this.rz;
				}
			};
		},
		function ()
		{
			this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Spell_Climax_Light, {});
		}
	];
	this.stateLabel = function ()
	{
		this.count++;

		if (this.flag4)
		{
			this.flag4.sx = this.flag4.sy = this.sx;
		}

		if (this.count % 4 == 1)
		{
			this.anime.center_x = (1 - this.rand() % 3) * 1,00000000.0;
			this.anime.center_y = (1 - this.rand() % 3) * 1,00000000.0;
		}

		this.rz -= 0,05000000.0 * 0,01745329.0;

		if (this.sx < 1,33000004.0)
		{
			this.sx = this.sy += 0,10000000.0;
		}
		else
		{
			this.sx = this.sy += 0,00125000.0;
		}
	};
}

function Spell_Climax_Hole( t )
{
	this.DrawScreenActorPriority(20);
	this.SetMotion(4907, 1);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4907, 9);
			this.stateLabel = function ()
			{
				this.rz += 0,02500000.0 * 0,01745329.0;

				if (this.sx < 2,00000000.0)
				{
					this.sx = this.sy += 0,12500000.0;
				}
				else
				{
					this.sx = this.sy += 0,00200000.0;
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
					return;
				}

				this.sx = this.sy += 0,10000000.0;
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00085000.0;
	};
}

function Spell_Climax_Shatter( t )
{
	this.DrawScreenActorPriority(30);
	this.SetMotion(4907, 8);
	this.keyAction = this.ReleaseActor;
}

function Spell_Climax_Flagment( t )
{
	this.DrawScreenActorPriority(30);
	this.SetMotion(4906, t.type);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
		}
	];
	this.SetSpeed_XY(2,00000000.0 - this.rand() % 5, 2,00000000.0 - this.rand() % 5);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 1,00000000.0);

		if (this.y > ::camera.bottom + 360)
		{
			this.ReleaseActor();
		}
	};
}

function Spell_Climax_Cut()
{
	this.LabelReset();
	this.ResetSpeed();
	this.ClearColorFilterEffect();
	this.SetMotion(4901, 1);
	this.target.DamageGrab_Common.call(this.target, 308, 0, this.target.direction);
	this.count = 0;
	this.FadeOut(1,00000000.0, 0,00000000.0, 0,00000000.0, 10);
	this.BackFadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 10);
	this.flag5 = {};
	this.flag5.flagment <- ::manbow.Actor2DProcGroup();
	this.flag5.back <- null;
	this.flag5.hole <- null;
	this.flag5.udonge <- null;
	this.PlaySE(3871);
	this.PlaySE(3872);
	this.FadeIn(1,00000000.0, 0,00000000.0, 0,00000000.0, 10);
	this.flag5.back = this.SetFreeObjectDynamic(640, 360, 1,00000000.0, this.Spell_Climax_Back, {});
	this.flag5.hole = this.SetFreeObject(640, 360, 1,00000000.0, this.Spell_Climax_Hole, {});
	this.SetFreeObject(640, 360, 1,00000000.0, this.Spell_Climax_Shatter, {});
	this.stateLabel = function ()
	{
		if (this.count == 180 - 60)
		{
			this.PlaySE(3873);
			this.flag5.back.func[1].call(this.flag5.back);
			this.flag5.hole.func[1].call(this.flag5.hole);
			this.flag5.udonge = this.SetFreeObjectDynamic(640, 360, 1,00000000.0, this.Spell_Climax_Face, {});
		}

		if (this.count == 300 - 30)
		{
			this.PlaySE(3874);
			this.flag5.hole.func[2].call(this.flag5.hole);
			this.flag5.udonge.func[1].call(this.flag5.udonge);
		}

		if (this.count == 310 - 30)
		{
			this.flag5.udonge.func[2].call(this.flag5.udonge);
		}

		if (this.count == 560 - 60)
		{
			this.flag5.udonge.func[0].call(this.flag5.udonge);
			this.Climax_FinishB(null);
			return;
		}
	};
}

function Climax_FinishB( t )
{
	this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
	this.EraceBackGround(false);
	this.LabelReset();
	this.HitReset();
	this.count = 0;
	this.masterAlpha = 1,00000000.0;
	this.autoCamera = true;
	this.freeMap = false;
	::camera.ResetTarget();
	this.ReleaseTargetActor(this.flag4);
	this.Warp(640 - 120,00000000.0 * this.direction, this.centerY);
	this.target.Warp(this.x, this.centerY);
	this.centerStop = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.centerStop = -2;
	this.target.team.master.enableKO = true;

	if (this.target.team.slave)
	{
		this.target.team.slave.enableKO = true;
	}

	this.SetMotion(4901, 2);
	this.KnockBackTarget(-this.direction);
	this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 45);
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
		this.lastword.Deactivate();
	};

	if (!this.san_mode)
	{
		this.owner.san = 9988;

		if (this.san_gauge)
		{
			this.san_gauge.func[2].call(this.san_gauge, 1,00000000.0);
		}
	}

	this.stateLabel = function ()
	{
		this.AddSpeed_XY(null, 0,01000000.0);
	};
}

