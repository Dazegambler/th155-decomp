function Func_BeginBattle()
{
	if (this.team.master == this && this.team.slave && this.team.slave.type == 10)
	{
		this.BeginBattle_Kasen(null);
		return;
	}

	this.BeginBattle(null);
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
			this.PlaySE(1090);
		},
		function ()
		{
			this.PlaySE(1090);
		},
		function ()
		{
			this.PlaySE(1090);
		},
		function ()
		{
			this.PlaySE(1095);
			local t_ = {};
			this.demoObject.append(this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BeginBattle_Bou, t_).weakref());
			this.stateLabel = function ()
			{
				if (this.demoObject[0].y >= this.y - 125,00000000.0 && this.demoObject[0].va.y > 0)
				{
					this.PlaySE(1091);
					this.demoObject[0].func.call(this.demoObject[0]);
					this.flag1 = null;
					this.SetMotion(9000, 6);
					this.stateLabel = null;
				}
			};
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

function Story_ReimuShock( t )
{
	this.LabelClear();
	this.SetMotion(9002, 0);
}

function BeginBattle_Kasen( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9004, 0);
	this.demoObject = [];
	this.team.slave.BeginBattle_Slave(null);
	this.keyAction = [
		null,
		function ()
		{
			this.CommonBegin();
		}
	];
}

function BeginBattle_Slave( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9004, 0);
	this.Warp(this.x - 45 * this.direction, this.y - 5);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	];
}

function WinA( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1092);
		},
		function ()
		{
			this.PlaySE(1092);
		},
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
			this.PlaySE(1093);
			this.flag1 = this.SetFreeObject(this.point0_x, this.point0_y, 1,00000000.0, this.BattleWinObject_B, {}).weakref();
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

function TalkActionA1( t )
{
	this.LabelClear();
	this.SetMotion(9002, 2);
	this.SetSpeed_XY(-7,00000000.0 * this.direction, 0,00000000.0);
	this.keyAction = this.EndtoFreeMove;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
}

function TalkActionA2( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(40, 0);
	this.PlaySE(801);
	this.SetSpeed_XY(12,00000000.0 * this.direction, 0,00000000.0);
	this.SetEffect(this.x, this.y, this.direction, this.EF_Dash, {}, this.weakref());
	this.DrawActorPriority();
	this.stateLabel = function ()
	{
		if (this.count == 9)
		{
			this.SetMotion(9002, 3);
			this.SetMotion.call(this.target, 9002, 0);
			this.target.keyAction = function ()
			{
				::camera.Shake(5,00000000.0);
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BeginStoryFlash, {});
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.BeginStoryFlash2, {});
				this.SetMotion.call(this.target, 9003, 0);
				this.SetSpeed_XY.call(this.target, -17,00000000.0, 0,00000000.0);
				this.FadeOut(0, 0, 0, 180);
				this.target.stateLabel = function ()
				{
					if (this.count == 30)
					{
						::trophy.Trophy_PreStoryClear();
					}

					this.VX_Brake(this.va.x * this.direction < -1,50000000.0 ? 1,75000000.0 : 0,02500000.0);

					if (this.count == 40)
					{
						this.ActorTimeStop(600);
					}
				};
			};
			this.stateLabel = function ()
			{
			};
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
	this.SetSpeed_XY(5,50000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5,50000000.0 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- -17,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 17,00000000.0;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- -17,00000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 17,00000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- 17,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 17,00000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 9,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- 17,00000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 17,00000000.0;
	this.C_SlideFall_Common(t_);
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
	t_.speed <- 5,00000000.0;
	t_.addSpeed <- 0,33000001.0;
	t_.maxSpeed <- 15,00000000.0;
	t_.wait <- 120;
	this.DashFront_Common(t_);
}

function DashFront_Air_Init( t )
{
	local t_ = {};
	t_.speed <- 7,00000000.0;
	t_.g <- 0,10000000.0;
	t_.minWait <- 12;
	t_.wait <- 60;
	t_.addSpeed <- 0,10000000.0;
	t_.maxSpeed <- 13,00000000.0;
	this.DashFront_Air_Common(t_);
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
	this.flag2 = 10,00000000.0;
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
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.SetMotion(1500, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1060);
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
			this.PlaySE(1050);
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
			this.SetSpeed_XY(5,00000000.0 * this.direction, null);
			this.PlaySE(1061);
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
			this.SetSpeed_XY(7,00000000.0 * this.direction, null);
			this.PlaySE(1051);
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
			this.PlaySE(1052);
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
	this.SetSpeed_XY(9,00000000.0 * this.direction, -12,00000000.0);
	this.centerStop = -3;
	this.keyAction = [
		function ()
		{
			this.centerStop = 2;
			this.SetSpeed_XY(7,00000000.0 * this.direction, 15,00000000.0);
			this.PlaySE(1053);
			this.stateLabel = function ()
			{
				if (this.y >= this.centerY)
				{
					this.SetMotion(this.motion, 3);
					this.centerStop = 1;
					this.SetSpeed_XY(null, this.va.y * 0,25000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,25000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
		this.VY_Brake(0,80000001.0);
	};
	return true;
}

function Atk_HighUnder_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.flag1 = false;
	this.subState = function ()
	{
		if (this.input.b1 <= 0)
		{
			this.flag1 = false;
		}
	};
	this.SetMotion(1210, 0);
	this.SetSpeed_XY(9,00000000.0 * this.direction, -12,00000000.0);
	this.centerStop = -3;
	this.keyAction = [
		function ()
		{
			this.centerStop = 2;
			this.SetSpeed_XY(4,00000000.0 * this.direction, 15,00000000.0);
			this.PlaySE(1053);
			this.stateLabel = function ()
			{
				if (this.y >= this.centerY)
				{
					this.SetMotion(1210, 3);
					this.centerStop = 1;
					this.SetSpeed_XY(null, this.va.y * 0,25000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,25000000.0);
					};
				}
			};
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.subState();
		this.VX_Brake(0,25000000.0);
		this.VY_Brake(0,80000001.0);
	};
	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;

	if (this.centerStop * this.centerStop >= 4 && this.y < this.centerY)
	{
		this.combo_func = this.Rush_Under_HighAir;
		this.stateLabel = function ()
		{
		};
		this.SetMotion(1211, 0);
		this.SetSpeed_XY(9,00000000.0 * this.direction, -7,50000000.0);
		this.centerStop = -2;
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.keyAction = [
			function ()
			{
				this.centerStop = 2;
				this.SetSpeed_XY(8,00000000.0 * this.direction, 16,00000000.0);
				this.PlaySE(1053);
				this.stateLabel = function ()
				{
					if (this.y > this.centerY)
					{
						this.centerStop = 1;
						this.va.SetLength(5,00000000.0);
						this.SetSpeed_XY(null, null);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,25000000.0);
						};
						this.SetMotion(1211, 2);
					}
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,25000000.0);
				};
			},
			null,
			function ()
			{
				this.SetChargeAuraB(null);
				this.centerStop = 3;
				this.SetSpeed_XY(10,00000000.0 * this.direction, 20,00000000.0);
				this.PlaySE(1053);
				this.stateLabel = function ()
				{
					this.Vec_Brake(0,75000000.0);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,25000000.0);
				};
			}
		];
	}
	else
	{
		this.combo_func = this.Rush_Under;
		this.centerStop = -2;
		this.SetSpeed_XY(9,00000000.0 * this.direction, -12,00000000.0);
		this.stateLabel = function ()
		{
			this.VX_Brake(0,25000000.0);
			this.VY_Brake(0,80000001.0);
		};
		this.SetMotion(1212, 0);
		this.keyAction = [
			function ()
			{
				this.PlaySE(1053);
				this.centerStop = 2;
				this.SetSpeed_XY(7,00000000.0 * this.direction, 12,00000000.0);
				this.PlaySE(1053);
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,25000000.0);
				};
			},
			null,
			function ()
			{
				this.SetChargeAuraB(null);
				this.centerStop = 2;
				this.SetSpeed_XY(11,50000000.0 * this.direction, 22,00000000.0);
				this.PlaySE(1053);
				this.stateLabel = function ()
				{
					this.Vec_Brake(0,75000000.0);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(0,25000000.0);

					if (this.centerStop * this.centerStop <= 1)
					{
						this.VX_Brake(0,75000000.0);
					}
				};
			}
		];
	}

	return true;
}

function Atk_HighUpper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.atk_id = 64;
	this.SetEndMotionCallbackFunction(function ()
	{
		this.EndtoFallLoop();
	});
	this.SetMotion(1220, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1054);
			this.centerStop = -3;
			this.SetSpeed_XY(12,50000000.0 * this.direction, -7,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 5,00000000.0 ? 0,75000000.0 : 0,02500000.0);
				this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,02500000.0);
				this.AddSpeed_XY(0,00000000.0, 0,60000002.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
				{
					this.SetMotion(1220, 3);
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
				this.VX_Brake(0,02500000.0);
				this.AddSpeed_XY(0,00000000.0, 0,60000002.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
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
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.atk_id = 64;
	this.SetEndMotionCallbackFunction(function ()
	{
		this.EndtoFallLoop();
	});
	this.SetSpeed_XY(7,50000000.0 * this.direction, null);
	this.SetMotion(1720, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1054);
			this.centerStop = -3;
			this.SetSpeed_XY(12,50000000.0 * this.direction, -7,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 5,00000000.0 ? 0,75000000.0 : 0,02500000.0);
				this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,02500000.0);
				this.AddSpeed_XY(0,00000000.0, 0,60000002.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
				{
					this.SetMotion(this.motion, 3);
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
				this.VX_Brake(0,02500000.0);
				this.AddSpeed_XY(0,00000000.0, 0,60000002.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
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
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);

	if (this.centerStop * this.centerStop >= 4 && this.y < this.centerY)
	{
		this.SetMotion(1221, 0);
		this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
		this.keyAction = [
			null,
			function ()
			{
				this.PlaySE(1054);
				this.centerStop = -3;
				this.SetSpeed_XY(12,50000000.0 * this.direction, -7,50000000.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(this.va.x * this.direction > 5,00000000.0 ? 0,75000000.0 : 0,02500000.0);
					this.AddSpeed_XY(0,00000000.0, 0,44999999.0);
				};
			},
			function ()
			{
				this.stateLabel = function ()
				{
				};
			}
		];
	}
	else
	{
		this.SetMotion(1222, 0);
		this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
		this.keyAction = [
			function ()
			{
			},
			function ()
			{
				this.centerStop = -3;
				this.SetSpeed_XY(10,00000000.0 * this.direction, -15,00000000.0);
				this.PlaySE(1054);
				this.count = 0;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(-0,10000000.0 * this.direction, 0,50000000.0);

					if (this.count >= 5 && this.y < this.centerY)
					{
						this.centerStop = -2;
						this.SetMotion(1222, 3);
						this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
						this.stateLabel = function ()
						{
							if (this.y >= this.centerY)
							{
								this.SetSpeed_XY(null, 3,00000000.0);
								this.SetMotion(1222, 4);
								this.centerStop = 1;
								this.stateLabel = function ()
								{
									this.VX_Brake(0,20000000.0);
								};
								return;
							}

							this.VX_Brake(0,20000000.0);
							this.AddSpeed_XY(0,00000000.0, 0,89999998.0);
						};
					}
				};
			},
			function ()
			{
				this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,20000000.0);
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
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
			this.VX_Brake(0,10000000.0);
			this.CenterUpdate(0,15000001.0, null);
		};
	}

	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1700, 0);
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
	this.atk_id = 32;
	this.SetMotion(1230, 0);
	this.flag1 = true;
	this.subState = function ()
	{
		if (this.input.b1 <= 0)
		{
			this.flag1 = false;
		}
	};
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(12,50000000.0 * this.direction, null);
			this.PlaySE(1055);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0 + 0,50000000.0);
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
	this.stateLabel = function ()
	{
		this.subState();
		this.VX_Brake(0,40000001.0 + 0,60000002.0);
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
			this.PlaySE(1057);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.combo_func = null;
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
			this.SetMotion(1110, 4);
			this.GetFront();
			this.combo_func = null;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0);
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
	this.flag1 = 0,20500000.0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(1057);
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1231, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
			this.flag1 = 0,50000000.0;
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
			this.SetMotion(1231, 3);
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
	this.SetSpeed_XY(10,00000000.0 * this.direction, null);
	this.keyAction = [
		function ()
		{
			this.SetSpeed_XY(10,00000000.0 * this.direction, 0,00000000.0);
			this.PlaySE(1056);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
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
	};
	return true;
}

function Atk_HighDash_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 8192;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.SetMotion(1310, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(14,00000000.0 * this.direction, -5,00000000.0);
			this.PlaySE(1057);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
				this.AddSpeed_XY(null, 0,50000000.0);

				if (this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetMotion(1310, 2);
					this.SetSpeed_XY(this.va.x * 0,50000000.0, 3,00000000.0);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		},
		function ()
		{
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);
			};
		}
	];
	return true;
}

function Atk_RushD_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.SetMotion(1730, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -3;
			this.SetSpeed_XY(18,00000000.0 * this.direction, -5,00000000.0);
			this.PlaySE(1057);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,34999999.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
				this.AddSpeed_XY(null, 0,34999999.0);
			};
		},
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);
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
		this.target.Warp(this.initTable.pare.point0_x, this.initTable.pare.y);
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
	this.HitReset();
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(1079);
			this.count = 0;
			this.target.autoCamera = true;
			this.target.DamageGrab_Common(312, 0, -this.direction);
			this.flag1.func[0].call(this.flag1);
			this.target.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.target.stateLabel = function ()
			{
				this.VX_Brake(0,75000000.0, -0,20000000.0 * this.direction);
			};
			this.SetFreeObject(this.target.point0_x, this.target.point0_y - 20, this.direction, this.Grab_Spark, {});
			this.flag2 = this.SetFreeObject(this.target.point0_x, this.target.point0_y - 20, this.direction, this.Grab_Ofuda, {}, this.target.weakref()).weakref();
		},
		function ()
		{
			this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
			this.PlaySE(1080);
			this.PlaySE(1057);
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
			local t_ = {};
			t_.num <- 10;
			this.target.SetFreeObject(this.target.x, this.target.y, 1,00000000.0, this.target.Occult_PowerCreatePoint, t_);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		},
		function ()
		{
			this.SetSpeed_XY(-7,00000000.0 * this.direction, -6,00000000.0);
			this.centerStop = -3;
			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0, -2,00000000.0 * this.direction);
				this.CenterUpdate(this.va.y < 0,00000000.0 ? 0,64999998.0 : 0,30000001.0, null);

				if (this.centerStop * this.centerStop == 1)
				{
					this.SetMotion(this.motion, 7);
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
				this.CenterUpdate(0,50000000.0, null);

				if (this.centerStop * this.centerStop == 1)
				{
					this.SetMotion(this.motion, 7);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,75000000.0);
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
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,75000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(1071);

			for( local i = -2; i <= 2; i++ )
			{
				if (i == 0)
				{
					local t = {};
					t.rot <- 0,00000000.0;
					t.flag1 <- 1,00000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}
				else
				{
					local t = {};
					t.rot <- 20 * i * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					t.motion <- 2007;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalMini, t);
				}
			}

			this.SetSpeed_XY(-9,00000000.0 * this.direction, 0,00000000.0);
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
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(2003, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 60);
			this.PlaySE(1071);

			for( local i = -2; i <= 2; i++ )
			{
				if (i == 0)
				{
					local t = {};
					t.rot <- 0,00000000.0;
					t.flag1 <- 1,00000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t);
				}
				else
				{
					local t = {};
					t.rot <- 20 * i * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					t.motion <- 2007;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalMini, t);
				}
			}

			if (this.flag2 == -1,00000000.0)
			{
				this.SetSpeed_XY(-6,00000000.0 * this.direction, -3,00000000.0);
				this.centerStop = -2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,25000000.0);
				};
			}
			else
			{
				this.SetSpeed_XY(-6,00000000.0 * this.direction, 3,00000000.0);
				this.centerStop = 2;
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
				};
			}
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

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
		else
		{
			this.VX_Brake(0,10000000.0);
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
	this.SetMotion(2001, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,75000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 60);
			this.PlaySE(1071);

			for( local i = -3; i <= 3; i++ )
			{
				if (i == 0)
				{
					local t = {};
					t.rot <- -50,00000000.0 * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalV, t);
				}
				else
				{
					local t = {};
					t.rot <- (-50 + 20 * i) * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					t.motion <- 2008;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalMiniB, t);
				}
			}
		},
		function ()
		{
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
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,75000000.0);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(2004, 3);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 60);
			this.PlaySE(1071);

			for( local i = -3; i <= 3; i++ )
			{
				if (i == 0)
				{
					local t = {};
					t.rot <- -50,00000000.0 * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalV, t);
				}
				else
				{
					local t = {};
					t.rot <- (-50 + 20 * i) * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					t.motion <- 2008;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalMiniB, t);
				}
			}
		},
		function ()
		{
			this.stateLabel = function ()
			{
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
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,40000001.0, 1,00000000.0);
		this.VX_Brake(0,10000000.0);
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
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,75000000.0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -3;
			this.SetSpeed_XY(-5,50000000.0 * this.direction, -10,50000000.0);
			this.team.AddMP(-200, 60);
			this.PlaySE(1071);

			for( local i = -3; i <= 3; i++ )
			{
				if (i == 0)
				{
					local t = {};
					t.rot <- 50,00000000.0 * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalV, t);
				}
				else
				{
					local t = {};
					t.rot <- (50 + 20 * i) * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					t.motion <- 2009;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalMiniB, t);
				}
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0,10000000.0);
			};
		},
		function ()
		{
			this.stateLabel = null;
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
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,75000000.0);
	this.AjustCenterStop();
	this.subState = function ()
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(2005, 0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
			return true;
		}
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 60);
			this.PlaySE(1071);
			this.centerStop = -3;
			this.SetSpeed_XY(-4,00000000.0 * this.direction, -6,50000000.0);

			for( local i = -3; i <= 3; i++ )
			{
				if (i == 0)
				{
					local t = {};
					t.rot <- 50,00000000.0 * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalV, t);
				}
				else
				{
					local t = {};
					t.rot <- (50 + 20 * i) * 0,01745329.0;
					t.flag1 <- 1,00000000.0;
					t.motion <- 2009;
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_NormalMiniB, t);
				}
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
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
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,40000001.0, 1,00000000.0);
		this.VX_Brake(0,10000000.0);
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
	this.flag1 = 4;
	this.flag2 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 60);
			this.count = 0;
			this.SetSpeed_XY(-9,00000000.0 * this.direction, null);

			if (this.target.centerStop * this.target.centerStop <= 1)
			{
				this.flag2 = 0;
			}
			else
			{
				this.flag2 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
				this.flag2 = this.Math_MinMax(this.flag2, -0,26179937.0, 0,26179937.0);
			}

			this.stateLabel = function ()
			{
				this.VX_Brake(0,25000000.0, -3,00000000.0 * this.direction);

				if (this.count % 5 == 1)
				{
					if (this.flag1 <= 0)
					{
						this.count = 0;
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,25000000.0, -3,00000000.0 * this.direction);
						};
						return;
					}
					else
					{
						this.hitResult = 1;
						this.PlaySE(1070);
						local t_ = {};
						t_.rot <- this.flag2;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t_);
						this.flag1--;
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
	this.count = 0;
	this.flag1 = 4;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.team.AddMP(-200, 60);
			this.SetSpeed_XY(-9,00000000.0 * this.direction, null);
			this.flag2 = this.atan2(this.target.y - this.y, (this.target.x - this.x) * this.direction);
			this.flag2 = this.Math_MinMax(this.flag2, -0,26179937.0, 0,26179937.0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,20000000.0, 2,00000000.0);
				this.VX_Brake(0,25000000.0, -3,00000000.0 * this.direction);

				if (this.count % 5 == 1)
				{
					if (this.flag1 <= 0)
					{
						this.count = 0;
						this.SetMotion(this.motion, 3);
						this.stateLabel = function ()
						{
							this.VX_Brake(0,25000000.0, -3,00000000.0 * this.direction);
							this.CenterUpdate(0,20000000.0, 2,00000000.0);
						};
						return;
					}
					else
					{
						this.hitResult = 1;
						this.PlaySE(1070);
						local t_ = {};
						t_.rot <- this.flag2;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t_);
						this.flag1--;
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
			this.SetMotion(this.motion, 5);
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
	};
	return true;
}

function Shot_Front_GC_Init( t )
{
	this.Shot_Front_Init(t);
	this.SetMotion(2030, 0);
	this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_GuardCancel, {});
	this.PlaySE(818);
	::battle.SetTimeStop(15);
	return true;
}

function Shot_Front_Air_GC_Init( t )
{
	this.Shot_Front_Air_Init(t);
	this.SetMotion(2031, 0);
	this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_GuardCancel, {});
	this.PlaySE(818);
	::battle.SetTimeStop(15);
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 6,50000000.0;
	this.flag2.vy <- 4,00000000.0;
	this.flag2.rot <- 0,00000000.0;
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
	this.flag1 = null;
	this.flag2 = t.ky;
	this.flag3 = false;
	this.flag4 = t.charge;
	this.keyAction = [
		function ()
		{
			local t_ = {};
			t_.rot <- 0,00000000.0;

			if (this.flag2 > 0)
			{
				t_.rot = 60 * 0,01745329.0;
			}

			if (this.flag2 < 0)
			{
				t_.rot = -60 * 0,01745329.0;
			}

			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_).weakref();
			this.PlaySE(1106);
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 1,50000000.0);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,15000001.0);
				}

				if (this.count == 1 && this.flag3)
				{
					this.PlaySE(828);
				}

				if (!this.flag3)
				{
					this.stateLabel = function ()
					{
						this.Vec_Brake(1,00000000.0);
						this.CenterUpdate(0,10000000.0, 1,50000000.0);
					};
					this.SetMotion(this.motion, 4);
					this.keyAction[3].call(this);
					return;
				}
			};
		},
		null,
		function ()
		{
			if (this.flag1 && this.flag1.func[0])
			{
				if (this.flag4)
				{
					this.flag1.func[2].call(this.flag1);
				}
				else
				{
					this.flag1.func[0].call(this.flag1);
				}
			}

			this.PlaySE(1107);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, 1,50000000.0);

				if (this.centerStop == 0)
				{
					this.VX_Brake(0,34999999.0);
				}
				else
				{
					this.VX_Brake(0,25000000.0, -3,00000000.0 * this.direction);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0);
		this.CenterUpdate(0,10000000.0, 1,50000000.0);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,15000001.0);
		}
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
	this.flag2.rot <- 0,00000000.0;
	this.subState = function ()
	{
		if (this.count > 10 && this.team.mp > 0)
		{
			local c_ = this.count % 40;

			if (c_ == 11 || c_ == 16 || c_ == 21)
			{
				this.PlaySE(1073);
				this.flag2.rot = this.atan2(this.team.target.y - this.y, (this.team.target.x - this.x) * this.direction);
				local t_ = {};
				this.vec.x = this.x + 50 * this.cos(this.flag2.rot) * this.direction;
				this.vec.y = this.y - 20 + 50 * this.sin(this.flag2.rot);
				this.SetFreeObject(this.vec.x, this.vec.y, this.direction, this.Shot_Barrage_Fire, {});

				for( local i = -40; i <= 40; i = i + 20 )
				{
					t_.rot <- i * 0,01745329.0 + this.flag2.rot;
					this.SetShot(this.vec.x, this.vec.y, this.direction, this.Shot_Barrage, t_).weakref();
				}
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
	this.hitResult = 1;
	this.atk_id = 524288;
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(this.va.x * 0,25000000.0, this.va.y * 0,25000000.0);
	this.count = 0;
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_ChargeO, {});
			this.PlaySE(1074);

			if (this.skima)
			{
				this.skima.func[0].call(this.skima);
			}

			this.skima = this.SetFreeObjectStencil(this.x + 100 * this.direction, this.y, this.direction, this.Shot_Okult, {}).weakref();
		},
		function ()
		{
			this.count = 0;
			this.centerStop = -2;
			this.SetSpeed_XY(-11,00000000.0 * this.direction, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction < -1,00000000.0 ? 0,50000000.0 : 0,01000000.0);
				this.AddSpeed_XY(0,00000000.0, this.va.y < -1,00000000.0 ? 0,50000000.0 : 0,10000000.0);
			};
		},
		null,
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
		this.CenterUpdate(0,05000000.0, null);

		if (this.centerStop == 0)
		{
			this.VX_Brake(0,50000000.0);
		}
	};
	return true;
}

function Okult_Side_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2502, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(1074);
			this.team.op_stop = 300;
			this.team.op_stop_max = 300;

			if (this.skima)
			{
				this.skima.func[0].call(this.skima);
			}

			this.team.AddMP(-200, 120);
			this.hitResult = 1;
			this.skima = this.SetShotStencil(this.point0_x, this.point0_y, this.direction, this.Shot_SideOccult, {}).weakref();
		}
	];
	return true;
}

function SP_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 1048576;
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
	this.AjustCenterStop();
	this.SetMotion(3000, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1100);

			for( local i = 0; i <= 3; i++ )
			{
				local t_ = {};
				t_.rot <- (-6,00000000.0 + 4,00000000.0 * i) * 0,01745329.0;
				t_.take <- 0;
				this.SetShot(this.point0_x + (i * 20 - 50) * this.cos(t_.rot + 3,14159203.0 * 0,50000000.0) * this.direction, this.point0_y + (20 * i - 50) * this.sin(t_.rot + 3,14159203.0 * 0,50000000.0), this.direction, this.SPShot_A, t_);
			}

			this.stateLabel = function ()
			{
				this.CenterUpdate(0,15000001.0, 2,00000000.0);
				this.VX_Brake(0,25000000.0);
			};
		},
		null,
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
		this.CenterUpdate(0,25000000.0, 2,00000000.0);
		this.VX_Brake(0,25000000.0);
	};
	return true;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.atk_id = 2097152;
	this.SetMotion(3010, 0);
	this.count = 0;
	this.SetSpeed_XY(null, this.va.y * 0,50000000.0);
	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1101);
			this.count = 0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.SPShot_B, {});
		}
	];
	this.stateLabel = function ()
	{
		if (this.keyTake <= 2)
		{
			this.Vec_Brake(1,00000000.0);
		}
	};
	return true;
}

function SP_C_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.atk_id = 4194304;
	this.SetMotion(3020, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1103);

			if (this.centerStop <= -2 && this.y < this.centerY)
			{
				this.SetSpeed_XY(3,00000000.0 * this.direction, -10,00000000.0);
			}
			else
			{
				this.SetSpeed_XY(3,00000000.0 * this.direction, -20,00000000.0);
			}

			this.centerStop = -2;
			this.flag2 = this.y;
			this.stateLabel = function ()
			{
				if (this.va.y < 0,00000000.0)
				{
					if (this.y < this.centerY + 170)
					{
						this.AddSpeed_XY(null, 1,00000000.0);
					}
				}
				else
				{
					this.AddSpeed_XY(null, this.va.y < 15,00000000.0 ? 0,85000002.0 : 0,00000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, this.va.y < 15,00000000.0 ? 0,85000002.0 : 0,00000000.0);
			};
		},
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, this.va.y < 15,00000000.0 ? 0,85000002.0 : 0,00000000.0);

				if (this.count >= 8)
				{
					if (this.y > this.centerY)
					{
						this.SetMotion(3020, 4);
						this.centerStop = 1;
						this.SetSpeed_XY(0,00000000.0, 3,00000000.0);
						this.stateLabel = function ()
						{
						};
					}
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0);
	};
	return true;
}

function SP_C_Low_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = this.y;
	this.atk_id = 4194304;
	this.SetEndMotionCallbackFunction(function ()
	{
		this.EndtoFallLoop();
	});
	this.SetMotion(3021, 0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(1103);
			this.SetSpeed_XY(3,00000000.0 * this.direction, -20,00000000.0);
			this.centerStop = -2;
		},
		function ()
		{
			this.HitTargetReset();
			this.SetSpeed_XY(8,00000000.0 * this.direction, -10,00000000.0);
			this.centerStop = -2;
		},
		function ()
		{
			this.PlaySE(1103);
			this.SetSpeed_XY(8,00000000.0 * this.direction, 20,00000000.0);
			this.centerStop = 2;
		}
	];
	this.stateLabel = function ()
	{
		if (this.keyTake == 0)
		{
			this.Vec_Brake(1,00000000.0);
		}

		if (this.keyTake == 1)
		{
			if (this.va.y < 0,00000000.0)
			{
				this.AddSpeed_XY(null, 1,00000000.0);
			}
			else
			{
				this.AddSpeed_XY(null, 0,50000000.0);
			}
		}

		if (this.keyTake == 2)
		{
			this.AddSpeed_XY(null, 0,50000000.0);
		}

		if (this.keyTake == 3)
		{
			this.Vec_Brake(0,75000000.0);
		}
	};
	return true;
}

function SP_D_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3030, 0);
	this.atk_id = 8388608;
	this.count = 0;
	this.flag1 = this.command.rsv_x * this.direction;
	this.SetSpeed_XY(-3,00000000.0 * this.direction, -2,00000000.0);
	this.centerStop = -2;
	this.SetEndMotionCallbackFunction(this.EndtoUpLoop);
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.PlaySE(1104);
			this.team.AddMP(-200, 120);
			this.stateLabel = function ()
			{
				if (this.masterAlpha > 0,20000000.0)
				{
					this.masterAlpha -= 0,20000000.0;
				}
				else
				{
					this.masterAlpha = 0,00000000.0;
				}

				if (this.count >= 5)
				{
					this.SetMotion(this.motion, 2);
					local x_ = 0;

					if (this.flag1 < 0)
					{
						x_ = this.x;
					}
					else
					{
						if (this.flag1 == 0)
						{
							x_ = this.x + 200 * this.direction;
						}
						else
						{
							x_ = this.x + 400 * this.direction;
						}

						x_ = this.Math_MinMax(x_, ::battle.corner_left + 1, ::battle.corner_right - 1);
					}

					if (this.target.y > this.centerY)
					{
						this.Warp(x_, this.target.y - 150);
					}
					else
					{
						this.Warp(x_, this.centerY - 150);
					}

					this.masterAlpha = 0,00000000.0;
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

					if (this.GetFront())
					{
						this.SetMotion(3037, 2);
					}

					this.stateLabel = function ()
					{
					};
				}
			};
		},
		null,
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(3,00000000.0 * this.direction, -10,00000000.0);
			this.count = 0;
			this.lavelClearEvent = function ()
			{
				this.masterAlpha = 1,00000000.0;
			};
			this.stateLabel = function ()
			{
				if (this.masterAlpha <= 0,89999998.0)
				{
					this.masterAlpha += 0,10000000.0;
				}
				else
				{
					this.masterAlpha = 1,00000000.0;
				}

				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
			};
		},
		function ()
		{
			this.lavelClearEvent = null;
			this.centerStop = 2;
			this.PlaySE(1105);
			this.SetSpeed_XY(8,00000000.0 * this.direction, 20,00000000.0);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.hitResult & (8 | 4))
				{
					this.SP_D_Hit(null);
					return;
				}

				this.HitCycleUpdate(3);

				if (this.count == 15 || this.y >= 550)
				{
					this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
					this.SetMotion(this.motion, 7);
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, -0,60000002.0);
					};
					return;
				}
			};
		}
	];
	return true;
}

function SP_D_Hit( t )
{
	this.LabelClear();
	this.SetMotion(3031, 0);
	this.atk_id = 8388608;
	this.SetSpeed_XY(-10,00000000.0 * this.direction, -8,00000000.0);
	this.centerStop = -2;
	this.stateLabel = function ()
	{
		this.VX_Brake(this.va.x * this.direction < -3,00000000.0 ? 0,50000000.0 : 0,02500000.0);
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
}

function SP_G_Init( t )
{
	if (this.centerStop * this.centerStop >= 4)
	{
		this.SP_G_Air_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,44999999.0);
	};
	this.option = [];
	this.atk_id = 16777216;
	this.SetSpeed_XY(-6,00000000.0 * this.direction, 0,00000000.0);
	this.SetMotion(3064, 0);
	this.flag5 = [
		-45 * 0,01745329.0,
		45 * 0,01745329.0
	];
	this.keyAction = [
		function ()
		{
			local t_ = {};
			t_.rot <- this.flag5[0];
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G, t_, this.weakref());
		},
		function ()
		{
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.rot <- this.flag5[0];
			this.SetSpeed_Vec(25,00000000.0, t_.rot, this.direction);
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Head, t_, this.weakref()).weakref());
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Trail, t_, this.weakref()).weakref());
			this.count = 0;

			if (this.va.y > 0,00000000.0)
			{
				this.centerStop = 2;
			}
			else
			{
				this.centerStop = -2;
			}

			this.PlaySE(1113);
			this.stateLabel = function ()
			{
				if (this.va.y < 0,00000000.0 && this.y < ::battle.scroll_top + 100 || this.va.y > 0,00000000.0 && this.y > ::battle.scroll_bottom - 100)
				{
					foreach( a in this.option )
					{
						a.func();
					}

					this.option = [];
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.Vec_Brake(10,00000000.0);
					};
				}
			};
		},
		null,
		function ()
		{
			this.HitReset();
			this.PlaySE(1114);
			local t_ = {};
			t_.rot <- this.flag5[1];
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G, t_);
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Head, t_, this.weakref()).weakref());
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Trail, t_, this.weakref()).weakref());
			this.SetSpeed_Vec(25,00000000.0, t_.rot, this.direction);

			if (this.va.y > 0,00000000.0)
			{
				this.centerStop = 2;
			}
			else
			{
				this.centerStop = -2;
			}

			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.hitResult & (8 | 4))
				{
					foreach( a in this.option )
					{
						a.func();
					}

					this.option = [];
					local t_ = {};
					t_.y <- 1,00000000.0;

					if (this.centerStop == 2)
					{
						t_.y = -1,00000000.0;
					}

					this.SP_G_GuardInit(t_);
					return;
				}

				if ((this.va.y > 0,00000000.0 && this.y > this.centerY || this.va.y < 0,00000000.0 && this.y < this.centerY) || this.hitTarget.len() > 0 && this.count >= 15)
				{
					foreach( a in this.option )
					{
						a.func();
					}

					this.option = [];
					this.SetMotion(this.motion, 6);
					this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
					this.stateLabel = function ()
					{
						this.Vec_Brake(1,50000000.0);
					};
					return;
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = null;
		}
	];
	return true;
}

function SP_G_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.GetFront();
	this.atk_id = 16777216;
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,44999999.0);
	};
	this.option = [];

	if (this.y <= this.centerY)
	{
		this.centerStop = 2;
		this.SetSpeed_XY(-10,00000000.0 * this.direction, 6,00000000.0);
		this.SetMotion(3060, 0);
		this.flag5 = [
			-45 * 0,01745329.0,
			45 * 0,01745329.0
		];
	}
	else
	{
		this.SetSpeed_XY(-10,00000000.0 * this.direction, -6,00000000.0);
		this.centerStop = -2;
		this.SetMotion(3062, 0);
		this.flag5 = [
			45 * 0,01745329.0,
			-45 * 0,01745329.0
		];
	}

	this.keyAction = [
		function ()
		{
			local t_ = {};
			t_.rot <- this.flag5[0];
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G, t_, this.weakref());
		},
		function ()
		{
			this.team.AddMP(-200, 120);
			local t_ = {};
			t_.rot <- this.flag5[0];
			this.SetSpeed_Vec(25,00000000.0, t_.rot, this.direction);
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Head, t_, this.weakref()).weakref());
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Trail, t_, this.weakref()).weakref());
			this.count = 0;

			if (this.va.y > 0,00000000.0)
			{
				this.centerStop = 2;
			}
			else
			{
				this.centerStop = -2;
			}

			this.PlaySE(1113);
			this.stateLabel = function ()
			{
				if (this.va.y < 0,00000000.0 && this.y < ::battle.scroll_top + 100 || this.va.y > 0,00000000.0 && this.y > ::battle.scroll_bottom - 100)
				{
					foreach( a in this.option )
					{
						a.func();
					}

					this.option = [];
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.Vec_Brake(10,00000000.0);
					};
				}
			};
		},
		null,
		function ()
		{
			this.HitReset();
			this.PlaySE(1114);
			local t_ = {};
			t_.rot <- this.flag5[1];
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_G, t_);
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Head, t_, this.weakref()).weakref());
			this.option.append(this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.SPShot_G_Trail, t_, this.weakref()).weakref());
			this.SetSpeed_Vec(25,00000000.0, t_.rot, this.direction);

			if (this.va.y > 0,00000000.0)
			{
				this.centerStop = 2;
			}
			else
			{
				this.centerStop = -2;
			}

			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.hitResult & (8 | 4))
				{
					foreach( a in this.option )
					{
						a.func();
					}

					this.option = [];
					local t_ = {};
					t_.y <- 1,00000000.0;

					if (this.centerStop == 2)
					{
						t_.y = -1,00000000.0;
					}

					this.SP_G_GuardInit(t_);
					return;
				}

				if ((this.va.y > 0,00000000.0 && this.y > this.centerY || this.va.y < 0,00000000.0 && this.y < this.centerY) || this.hitTarget.len() > 0 && this.count >= 15)
				{
					foreach( a in this.option )
					{
						a.func();
					}

					this.option = [];
					this.SetMotion(this.motion, 6);
					this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,50000000.0);
					this.stateLabel = function ()
					{
						this.Vec_Brake(1,50000000.0);
					};
					return;
				}
			};
		},
		null,
		null,
		function ()
		{
			this.stateLabel = null;
		}
	];
	return true;
}

function SP_G_GuardInit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3065, 0);

	if (t.y == -1,00000000.0)
	{
		this.SetSpeed_XY(-6,50000000.0 * this.direction, -3,00000000.0);
		this.centerStop = -2;
	}
	else
	{
		this.SetSpeed_XY(-6,50000000.0 * this.direction, 3,00000000.0);
		this.centerStop = 2;
	}

	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0, -3,00000000.0 * this.direction);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(3065, 2);
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
		this.VX_Brake(0,20000000.0, -3,00000000.0 * this.direction);
	};
}

function Spell_A_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
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
			this.PlaySE(1155);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- i * 45 * 0,01745329.0;
				t_.motion <- 4007 + i % 3;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SpellShot_A, t_);
			}

			this.flag5 = this.SetFreeObject(this.point2_x, this.point2_y, this.direction, this.SpellShot_A_Bou, {}).weakref();
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.count = 0;
			this.flag1 = 0;
			this.stateLabel = function ()
			{
				if (this.count % 6 == 1 && this.flag1 <= 6)
				{
					local t_ = {};
					t_.rot <- (-45 + this.flag1 * 30 % 110) * 0,01745329.0 * 2,00000000.0;
					t_.motion <- 4007 + this.flag1 % 3;
					t_.rate <- this.atkRate_Pat;
					this.PlaySE(1156);
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A_Bullet, t_);
					this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_A_Flash, t_);
					local f_ = this.flag1 % 1;
					this.flag1++;
				}

				if (this.count >= 60)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
					this.flag5.func();
				}
			};
		},
		function ()
		{
			this.count = 0;
		},
		null,
		function ()
		{
			this.ReleaseActor.call(this.flag5);
		}
	];
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
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
			this.PlaySE(1174);

			for( local i = 0; i < 8; i++ )
			{
				local t_ = {};
				t_.rot <- 0,00000000.0;
				t_.tagRot <- i * -45 * 0,01745329.0;
				this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_B, t_);
			}
		},
		null,
		function ()
		{
			this.PlaySE(1175);
			this.count = 0;
			this.SetFreeObjectDynamic(this.x, ::battle.scroll_top - 64, this.direction, this.SpellShot_B_Tower, {}, this.weakref());
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.x, this.y, this.direction, this.SpellShot_B_Hit, t_);
			this.SetFreeObject(this.x, 360, this.direction, this.SpellShot_B_OutTower, {});
			this.stateLabel = function ()
			{
				if (this.count >= 55)
				{
					this.stateLabel = function ()
					{
					};
					this.SetMotion(this.motion, 5);
				}
			};
		},
		null,
		function ()
		{
			this.PlaySE(1176);
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
	this.SetMotion(4020, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
	};
	this.subState = function ()
	{
		if (this.Vec_Brake(1,00000000.0, 1,00000000.0))
		{
			this.subState = function ()
			{
				this.AddSpeed_XY(null, this.va.y < 1,50000000.0 ? 0,02500000.0 : null);
			};
		}
	};
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.count = 0;
			this.flag1 = 0;
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag5 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.SpellShot_C, t_).weakref();
			this.SetSpeed_Vec(10,00000000.0, -120 * 0,01745329.0, this.direction);
			this.centerStop = -2;
			this.PlaySE(1160);
			this.stateLabel = function ()
			{
				if (this.flag5)
				{
					this.flag5.Warp(this.point0_x, this.point0_y);
				}

				this.subState();

				if ((this.input.b0 > 0 || this.input.b1 > 0 || this.input.b2 > 0 || this.input.b3 > 0) && ::battle.state == 8)
				{
					this.Spell_C_Kick(null);
					return;
				}

				if (this.count >= 90)
				{
					this.count = 0;
					this.SetMotion(this.motion, 5);

					if (this.flag5)
					{
						this.flag5.func[0].call(this.flag5);
						this.flag5 = null;
					}

					this.stateLabel = function ()
					{
						this.subState();

						if (this.count >= 15)
						{
							this.SetMotion(this.motion, 6);
							this.stateLabel = function ()
							{
							};
						}
					};
				}
			};
		}
	];
	return true;
}

function Spell_C_Kick( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(4021, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetTimeStop(60);
	this.PlaySE(820);
	this.SetEffect(this.point1_x, this.point1_y, this.direction, this.EF_SpellFlash, {});

	if (this.flag5)
	{
		this.flag5.func[2].call(this.flag5);
	}

	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);

		if (this.flag5)
		{
			this.Warp.call(this.flag5, this.point0_x, this.point0_y);
		}
	};
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			this.team.spell_enable_end = false;
			this.PlaySE(1163);
			this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashC, {});

			if (this.flag5)
			{
				this.flag5.func[1].call(this.flag5);
				this.flag5 = null;
			}

			this.SetSpeed_XY(-15,00000000.0 * this.direction, -8,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0, 0,75000000.0);
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	return true;
}

function Spell_Climax_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4902, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.flag1 = false;
	this.flag2 = false;
	this.flag3 = ::manbow.Actor2DProcGroup();
	this.keyAction = [
		function ()
		{
			this.UseClimaxSpell(60, "–‚ ‚ñ‚\x255aŒ„ŠÔ‚\x2554›Þ—‚ª‚¢‚é‚\x255a‚ñ‚\x2500I–");
			::battle.enableTimeUp = false;
			this.lavelClearEvent = function ()
			{
				this.lastword.Deactivate();
				::battle.enableTimeUp = true;
			};
		},
		function ()
		{
			this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
			this.SetSpeed_XY(15,00000000.0 * this.direction, -10,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 3,00000000.0 ? 0,60000002.0 : 0,01000000.0);
				this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,01000000.0);
			};
		},
		function ()
		{
			this.PlaySE(1115);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.x + 192 * this.direction, 720, this.direction, this.Climax_Shot, t_).weakref();
			this.stateLabel = function ()
			{
				this.VX_Brake(this.va.x * this.direction > 3,00000000.0 ? 0,60000002.0 : 0,01000000.0);
				this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,01000000.0);

				if (this.flag1 && this.flag1.hitResult & 1)
				{
					this.invin = 600;
					this.invinObject = 600;
					this.flag2 = true;
					this.target.DamageGrab_Common(300, 0, this.target.direction);
					this.flag1.func[1].call(this.flag1);
					this.BackFadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 30);
					this.stateLabel = function ()
					{
						this.VX_Brake(this.va.x * this.direction > 3,00000000.0 ? 0,60000002.0 : 0,01000000.0);
						this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,01000000.0);
						this.masterAlpha -= 0,05000000.0;

						if (this.masterAlpha <= 0,00000000.0)
						{
							this.masterAlpha = 0,00000000.0;
						}
					};
				}
			};
		},
		function ()
		{
			if (this.flag2)
			{
				if (this.flag1)
				{
					this.flag1.func[0].call(this.flag1);
				}

				this.Spell_Climax_Hit();
			}
			else
			{
				this.count = 0;
				this.stateLabel = function ()
				{
					this.VX_Brake(this.va.x * this.direction > 3,00000000.0 ? 0,60000002.0 : 0,01000000.0);
					this.AddSpeed_XY(0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,01000000.0);

					if (this.count >= 10)
					{
						this.SetMotion(this.motion, 5);
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0,00000000.0, 0,34999999.0);
						};
					}
				};
			}
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function Spell_Climax_Hit()
{
	this.LabelReset();
	this.ResetSpeed();
	this.PlaySE(1116);
	::battle.enableTimeUp = false;
	this.flag3.Foreach(function ()
	{
		this.ReleaseActor();
	});
	this.SetMotion(4903, 0);
	this.FadeIn(1,00000000.0, 0,00000000.0, 0,00000000.0, 30);
	this.BackFadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 1);
	this.EraceBackGround();
	this.target.DamageGrab_Common(308, 0, this.target.direction);
	this.target.x = this.x = 640;
	this.target.y = this.y = 360;
	this.count = 0;
	this.flag1 = ::manbow.Actor2DProcGroup();
	::camera.SetTarget(640, 360, 3,00000000.0, true);
	this.flag5 = {};
	this.flag5.zoom <- 3,00000000.0;
	local t_ = {};
	t_.motion <- 301;
	t_.keyTake <- 2;
	this.flag5.enemy <- this.SetFreeObject.call(this.target, 640, 360, -1,00000000.0, this.target.DummyPlayer, t_).weakref();
	this.flag5.subCount <- 0;
	this.flag5.Line <- ::manbow.Actor2DProcGroup();
	this.SetFreeObject(640, 360, this.direction, this.Climax_Back, {}, this.weakref());
	local t_ = {};
	t_.rot <- 60 * 0,01745329.0;
	t_.scale <- 2,50000000.0;
	t_.priority <- 505;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x - 60, this.flag5.enemy.y + 50, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	local t_ = {};
	t_.rot <- -10 * 0,01745329.0;
	t_.scale <- 1,50000000.0;
	t_.priority <- 503;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x - 60, this.flag5.enemy.y - 50, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	local t_ = {};
	t_.rot <- 12 * 0,01745329.0;
	t_.scale <- 1,75000000.0;
	t_.priority <- 504;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x + 75, this.flag5.enemy.y - 100, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	local t_ = {};
	t_.rot <- -35 * 0,01745329.0;
	t_.scale <- 2,59999990.0;
	t_.priority <- 504;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x + 55, this.flag5.enemy.y + 40, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	local t_ = {};
	t_.rot <- 20 * 0,01745329.0;
	t_.scale <- 1,50000000.0;
	t_.priority <- 495;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x - 60, this.flag5.enemy.y, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	local t_ = {};
	t_.rot <- -25 * 0,01745329.0;
	t_.scale <- 1,00000000.0;
	t_.priority <- 496;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x, this.flag5.enemy.y + 50, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	local t_ = {};
	t_.rot <- 50 * 0,01745329.0;
	t_.scale <- 0,75000000.0;
	t_.priority <- 497;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x + 75, this.flag5.enemy.y - 100, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	local t_ = {};
	t_.rot <- -40 * 0,01745329.0;
	t_.scale <- 1,20000005.0;
	t_.priority <- 498;
	this.flag5.Line.Add(this.SetFreeObject(this.flag5.enemy.x + 55, this.flag5.enemy.y + 40, 1,00000000.0, this.Climax_LineA, t_, this.weakref()));
	this.stateLabel = function ()
	{
		if (this.count == 60)
		{
			this.PlaySE(1117);
			this.flag5.Line.Foreach(function ()
			{
				this.func[1].call(this);
			});
		}

		if (this.count == 90)
		{
			this.PlaySE(1118);
			this.flag5.Line.Foreach(function ()
			{
				this.func[2].call(this);
			});
			this.flag5.subCount = 0;
			this.flag1.Add(this.SetFreeObject(this.flag5.enemy.x, this.flag5.enemy.y, 1,00000000.0, this.Climax_LineFlash, {}, this.weakref()));
			this.flag1.Add(this.SetFreeObjectDynamic(this.flag5.enemy.x, this.flag5.enemy.y, 1,00000000.0, this.Climax_LineSpark, {}, this.weakref()));
			this.subState = function ()
			{
				this.flag5.zoom += (1,50000000.0 - this.flag5.zoom) * 0,10000000.0;
				::camera.shake_radius = 3,00000000.0;
				this.flag5.subCount++;

				if (this.count % 6 == 1)
				{
					this.PlaySE(1119);
					this.KnockBackTarget(-this.direction);
				}
			};
		}

		if (this.count == 150)
		{
			this.SetFreeObject(640, 360, 1,00000000.0, this.Climax_Slash, {}, this.weakref());
			this.PlaySE(1120);
		}

		if (this.count == 180)
		{
			this.PlaySE(1121);
			this.Spell_Climax_Finish();
			return;
		}

		if (this.subState)
		{
			this.subState();
		}

		::camera.SetTarget(640, 360, this.flag5.zoom, true);
	};
	this.subState = function ()
	{
		this.flag5.zoom -= 0,00500000.0;
	};
}

function Spell_Climax_Finish()
{
	this.LabelReset();
	this.SetMotion(4903, 1);
	this.flag2 = this.SetFreeObjectStencil(640, 360, 1,00000000.0, this.Climax_FaceA, {}, this.weakref()).weakref();
	this.flag1.Add(this.flag2);
	this.count = 0;
	::camera.Shake(20,00000000.0);
	this.KnockBackTarget(-this.direction);
	this.stateLabel = function ()
	{
		if (this.count == 90)
		{
			this.flag5.enemy.func[0].call(this.flag5.enemy);
			this.Climax_FinishB(null);
			return;
			this.stateLabel = function ()
			{
				if (this.count == 90)
				{
					this.count = 0;
					this.flag2.func[0].call(this.flag2);
					this.flag3.func[0].call(this.flag3);
					this.stateLabel = function ()
					{
						if (this.count == 60)
						{
							this.flag2.func[1].call(this.flag2);
							this.Climax_FinishB(null);
						}
					};
				}
			};
		}
	};
}

function Climax_FinishB( t )
{
	this.BackFadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 0);
	this.EraceBackGround(false);
	this.flag1.Foreach(function ()
	{
		this.func[0].call(this);
	});
	this.LabelReset();
	this.HitReset();
	this.count = 0;
	this.masterAlpha = 1,00000000.0;
	this.autoCamera = true;
	this.freeMap = false;
	::camera.ResetTarget();
	this.ReleaseTargetActor(this.flag4);
	this.Warp(640 - 120,00000000.0 * this.direction, this.centerY - 128,00000000.0);
	this.target.Warp(640 + 120,00000000.0 * this.direction, this.centerY - 64,00000000.0);
	this.SetSpeed_XY(-2,00000000.0 * this.direction, 1,00000000.0);
	this.centerStop = -2;
	this.target.team.master.enableKO = true;

	if (this.target.team.slave)
	{
		this.target.team.slave.enableKO = true;
	}

	this.SetMotion(4901, 7);
	this.KnockBackTarget(-this.direction);
	this.FadeIn(1,00000000.0, 1,00000000.0, 1,00000000.0, 45);
	this.lavelClearEvent = function ()
	{
		::battle.enableTimeUp = true;
		this.lastword.Deactivate();
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(null, 0,01000000.0);
	};
}

