function Func_BeginBattle()
{
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
	this.demoObject = [];
	this.masterAlpha = 0,00000000.0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2590);
			this.stateLabel = function ()
			{
				this.masterAlpha += 0,02500000.0;

				if (this.masterAlpha > 1,00000000.0)
				{
					this.masterAlpha = 1,00000000.0;
				}
			};
		},
		null,
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		this.masterAlpha = 0,00000000.0;
	};
}

function BeginBattleB( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.count = 0;
	this.SetMotion(9001, 0);
	this.demoObject = [];
	this.keyAction = [
		null,
		function ()
		{
			this.CommonBegin();
			this.EndtoFreeMove();
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 29)
		{
			this.PlaySE(2594);
		}

		if (this.count >= 130)
		{
			this.SetMotion(this.motion, 1);
			this.stateLabel = null;
		}
	};
}

function BeginBattle_Marisa( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9002, 1);
	this.count = 0;
	this.Warp(this.x - 60 * this.direction, this.y - 25);
	this.keyAction = [
		null,
		null,
		null,
		null,
		function ()
		{
			this.PlaySE(900);
			this.SetEffect(this.x, this.y - 20, this.direction, this.EF_Team_ChangeB, {}, this.weakref());
			this.SetMotion(3910, 2);
			this.LabelClear();
		}
	];
}

function BeginBattle_MarisaSlave( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9002, 0);
	this.count = 0;
	this.keyAction = [
		null,
		null,
		null,
		null,
		null,
		function ()
		{
			this.CommonBegin();
		}
	];
}

function WinA( t )
{
	this.count = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.LabelClear();
	this.SetMotion(9010, 0);
	this.SetEndMotionCallbackFunction(function ()
	{
		if (::battle.state == 32)
		{
			this.PlaySE(2591);
		}

		this.SetMotion(9010, 1);
	});
	this.keyAction = [
		function ()
		{
			if (::battle.state == 32)
			{
				this.PlaySE(2591);
			}
		},
		function ()
		{
			if (::battle.state == 32)
			{
				this.PlaySE(2591);
			}
		},
		function ()
		{
			if (::battle.state == 32)
			{
				this.PlaySE(2591);
			}
		},
		null,
		function ()
		{
			if (::battle.state == 32)
			{
				this.PlaySE(2591);
			}
		},
		function ()
		{
			if (::battle.state == 32)
			{
				this.PlaySE(2591);
			}
		},
		function ()
		{
			if (::battle.state == 32)
			{
				this.PlaySE(2591);
			}
		}
	];
	this.stateLabel = function ()
	{
		if (this.count == 150)
		{
			this.CommonWin();
		}
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
			this.PlaySE(2595);
			this.demoObject = [
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, function ( t_ )
				{
					this.SetMotion(9011, 3);
					this.SetSpeed_XY(-2,00000000.0 * this.direction, -6,50000000.0);
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,15000001.0);
						this.rz -= 5 * 0,01745329.0;
					};
				}, {}).weakref()
			];
			this.stateLabel = function ()
			{
				if (this.count == 120)
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
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.count == 120)
		{
			this.CommonLose();
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
	this.SetSpeed_XY(5,00000000.0 * this.direction, this.va.y);
}

function MoveBack_Init( t )
{
	this.LabelClear();
	this.stateLabel = this.MoveBack;
	this.SetMotion(2, 0);
	this.SetSpeed_XY(-5,00000000.0 * this.direction, this.va.y);
}

function SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- -12,50000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 12,50000000.0;
	this.SlideUp_Common(t_);
}

function C_SlideUp_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- -12,50000000.0;
	t_.v2 <- -8,00000000.0;
	t_.v3 <- 12,50000000.0;
	this.C_SlideUp_Common(t_);
}

function SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- 12,50000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 12,50000000.0;
	this.SlideFall_Common(t_);
}

function C_SlideFall_Init( t )
{
	local t_ = {};
	t_.dash <- 6,00000000.0;
	t_.front <- 6,00000000.0;
	t_.back <- -6,00000000.0;
	t_.front_rev <- 4,50000000.0;
	t_.back_rev <- -4,50000000.0;
	t_.v <- 12,50000000.0;
	t_.v2 <- 8,00000000.0;
	t_.v3 <- 12,50000000.0;
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
	if (t == null && this.GetFront())
	{
		this.DashBack_Init(null);
	}
	else
	{
		this.LabelClear();
		this.HitReset();
		this.SetMotion(40, 0);
		this.SetSpeed_XY(5,00000000.0 * this.direction, 0,00000000.0);
		this.count = 0;
		this.flag1 = false;
		this.keyAction = [
			null,
			function ()
			{
				this.PlaySE(2593);
				this.lavelClearEvent = function ()
				{
					this.masterAlpha = 1,00000000.0;
				};
				this.stateLabel = function ()
				{
					if (this.count % 24 == 10)
					{
						this.PlaySE(2592);
					}

					this.masterAlpha -= 0,11250000.0;

					if (this.masterAlpha <= 0,00000000.0)
					{
						this.hitResult = 1;
						this.flag1 = true;

						if ((this.target.x - this.x) * this.direction > 0,00000000.0)
						{
							this.x = this.target.x + 5 * this.direction;
						}

						this.stateLabel = function ()
						{
							this.masterAlpha += 0,03300000.0;

							if (this.masterAlpha > 1,00000000.0)
							{
								this.lavelClearEvent = null;
								this.masterAlpha = 1,00000000.0;
							}

							if ((this.keyTake == 1 || this.keyTake == 2) && this.input.x * this.direction <= 0 || this.count >= 150)
							{
								this.GetFront();
								this.SetMotion(this.motion, 5);
								this.stateLabel = function ()
								{
									this.masterAlpha += 0,03300000.0;

									if (this.masterAlpha > 1,00000000.0)
									{
										this.lavelClearEvent = null;
										this.masterAlpha = 1,00000000.0;
									}

									this.VX_Brake(0,25000000.0);
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

							if (this.count % 24 == 10)
							{
								this.PlaySE(2592);
							}
						};
					}

					return;
				};
			},
			null,
			null,
			this.EndtoFreeMove
		];
		this.stateLabel = function ()
		{
			if (this.count >= 12 && this.input.x * this.direction <= 0)
			{
				this.SetMotion(this.motion, 4);
				this.stateLabel = function ()
				{
					this.VX_Brake(0,25000000.0);
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

			if (this.count % 24 == 10)
			{
				this.PlaySE(2592);
			}
		};
	}
}

function DashFront_Air_Init( t )
{
	this.LabelClear();
	this.SetMotion(42, 0);
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.dashCount++;
	this.count = 0;
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.SetSpeed_XY(5,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				if (this.count % 24 == 1)
				{
					this.PlaySE(2592);
				}

				if (this.input.x * this.direction <= 0 && this.count >= 20 || this.count >= 150)
				{
					this.SetMotion(42, 3);
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
				else if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(42, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(0,50000000.0);
					};
				}
			};
		}
	];
}

function DashBack_Init( t )
{
	this.LabelClear();
	this.HitReset();
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
	this.DashBack_Air_Common(t_);
	this.HitReset();
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
			this.PlaySE(2400);
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
			this.PlaySE(2400);
		}
	];
	return true;
}

function Atk_RushB_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1600, 0);
	this.atk_id = 4;
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);
			};
			this.SetSpeed_XY(15,00000000.0 * this.direction, null);
		},
		function ()
		{
			this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
			this.sneeze = 120;
			this.PlaySE(2402);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
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

	if (this.sneeze <= 0)
	{
		this.SetMotion(1100, 0);
		this.keyAction = [
			function ()
			{
				this.stateLabel = function ()
				{
					this.VX_Brake(1,00000000.0);
				};
				this.SetSpeed_XY(15,00000000.0 * this.direction, null);
			},
			function ()
			{
				this.count = 0;
				this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
				this.sneeze = 120;
				this.PlaySE(2402);
			}
		];
	}
	else
	{
		this.sneeze = 0;
		this.SetMotion(1101, 0);
		this.SetSpeed_XY(null, this.va.y * 0,50000000.0);
		this.keyAction = [
			function ()
			{
				this.sneeze = 0;
				this.PlaySE(2403);
				this.count = 0;
				this.stateLabel = function ()
				{
					this.VX_Brake(0,50000000.0);
				};
			}
		];
	}

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
			this.PlaySE(2425);
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
					return;
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.PlaySE(2405);

			for( local i = 0; i < 360; i = i + 90 )
			{
				local t_ = {};
				t_.rot <- (i + this.rand() % 60) * 0,01745329.0;
				this.SetFreeObject(this.point1_x, this.point1_y, this.direction, this.AtkHigh_Petal, t_);
			}

			for( local i = 0; i < 360; i = i + 90 )
			{
				local t_ = {};
				t_.rot <- (i + this.rand() % 60) * 0,01745329.0;
				this.SetFreeObject(this.point2_x, this.point2_y, this.direction, this.AtkHigh_Petal, t_);
			}

			this.PlaySE(2405);
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

function Atk_RushC_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1700, 0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2425);
			this.centerStop = -2;
			this.SetSpeed_XY(12,00000000.0 * this.direction, -6,00000000.0);
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(5);
				this.VX_Brake(0,50000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
				local t_ = {};
				t_.rot <- this.rand() % 360 * 0,01745329.0;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.AtkHigh_Petal, t_);
			};
		},
		function ()
		{
			this.HitTargetReset();

			for( local i = 0; i < 360; i = i + 20 )
			{
				local t_ = {};
				t_.rot <- (i + this.rand() % 10) * 0,01745329.0;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.AtkHigh_Petal, t_);
			}

			this.PlaySE(2405);
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,20000000.0);
			};
			this.flag1 = 0;
			this.subState = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,10000000.0);
	};
	return true;
}

function Atk_RushC_Under_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.SetMotion(1710, 0);
	this.SetSpeed_XY(12,50000000.0 * this.direction, -10,00000000.0);
	this.centerStop = -2;
	this.PlaySE(2407);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
			this.HitReset();
			this.PlaySE(2408);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				this.VX_Brake(0,25000000.0);

				if (this.hitResult & 13 || this.ground == 1)
				{
					if (this.ground == 1)
					{
						this.PlaySE(2410);
						::camera.shake_radius = 6,00000000.0;
						this.hitStopTime = 10;
						this.flag1 = true;
					}

					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.PlaySE(2410);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.centerStop = -2;

			if (this.flag1)
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -15,50000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
			else
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -10,00000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
	return true;
}

function Atk_HighUnder_Set( t )
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if ((this.motion == 40 || this.motion == 42) && (this.keyTake == 1 || this.keyTake == 2))
		{
			local pos_ = this.Vector3();
			pos_.x = this.target.x - this.x;
			pos_.y = this.target.y - this.y;
			pos_.Normalize();

			if (pos_.y <= 0,86600000.0 && pos_.y >= 0 && this.targetHeight >= 0 && this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 175,00000000.0)
			{
				return true;
			}
		}
		else if (this.va.x * this.direction >= 1,00000000.0 && this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 100,00000000.0 && this.targetHeight >= 50,00000000.0)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 2;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.Atk_HighUnderAuto_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.AutoAttackSet(t_);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2450);
			this.CommonAutoAttackReset(0);
			this.CommonAutoAttackSet(this.flag2, 0);
			this.autoAttackTimes[0] = 0;

			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.keyTake <- 0;
				t_.rot <- (i + 45 + this.rand() % 5) * 0,01745329.0;
				this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
			}
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,25000000.0, 2,00000000.0);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,75000000.0);
		}
	};
	return true;
}

function Atk_HighUnder_SetB()
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if ((this.motion == 40 || this.motion == 42) && (this.keyTake == 1 || this.keyTake == 2))
		{
			local pos_ = this.Vector3();
			pos_.x = this.target.x - this.x;
			pos_.y = this.target.y - this.y;
			pos_.Normalize();

			if (pos_.y <= 0,86600000.0 && pos_.y >= 0 && this.targetHeight >= 0 && this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 175,00000000.0)
			{
				return true;
			}
		}
		else if (this.va.x * this.direction >= 1,00000000.0 && this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 100,00000000.0 && this.targetHeight >= 50,00000000.0)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 2;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.Atk_HighUnderAuto_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.PlaySE(2450);
	this.CommonAutoAttackSet(t_, 0);
	this.autoAttackTimes[0] = 180;

	for( local i = 0; i < 360; i = i + 45 )
	{
		local t_ = {};
		t_.keyTake <- 0;
		t_.rot <- (i + 45 + this.rand() % 5) * 0,01745329.0;
		this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
	}

	return true;
}

function Atk_HighUnder_Init( t )
{
	if (this.attackType[0] == 2)
	{
		this.CommonAutoAttackReset(0);
	}
	else
	{
		this.Atk_HighUnder_SetB();
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.centerStop = -2;
	this.PlaySE(2407);
	this.flag1 = false;
	this.flag2 = false;

	if (this.motion == 40 || this.motion == 42)
	{
		this.flag2 = true;
		this.SetSpeed_XY(10,00000000.0 * this.direction, -12,50000000.0);
	}
	else
	{
		this.SetSpeed_XY(7,50000000.0 * this.direction, -12,50000000.0);
	}

	this.SetMotion(1211, 0);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,25000000.0);
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
			this.HitReset();
			this.PlaySE(2408);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(1,50000000.0, 90 * 0,01745329.0, 25,00000000.0, this.direction);
				this.VX_Brake(0,50000000.0);

				if (this.hitResult & 13 || this.ground == 1)
				{
					if (this.ground == 1)
					{
						this.PlaySE(2410);
						::camera.shake_radius = 6,00000000.0;
						this.flag1 = true;
					}

					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.PlaySE(2410);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.centerStop = -2;

			if (this.flag1)
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -15,50000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
			else
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -10,00000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
	return true;
}

function Atk_HighUnderAuto_Init( t )
{
	this.CommonAutoAttackReset(0);
	this.LabelClear();
	this.HitReset();
	this.atk_id = 128;
	this.centerStop = -2;
	this.PlaySE(2407);
	this.flag1 = false;
	this.flag2 = false;

	if (this.motion == 40 || this.motion == 42)
	{
		this.flag2 = true;
		this.SetSpeed_XY(10,00000000.0 * this.direction, -12,50000000.0);
	}
	else
	{
		this.SetSpeed_XY(7,50000000.0 * this.direction, -12,50000000.0);
	}

	this.SetMotion(1210, 0);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,25000000.0);
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
			this.HitReset();
			this.PlaySE(2408);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(1,50000000.0, 90 * 0,01745329.0, 25,00000000.0, this.direction);
				this.VX_Brake(0,50000000.0);

				if (this.hitResult & 13 || this.ground == 1)
				{
					if (this.ground == 1)
					{
						this.PlaySE(2410);
						::camera.shake_radius = 6,00000000.0;
						this.flag1 = true;
					}

					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.PlaySE(2410);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.centerStop = -2;

			if (this.flag1)
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -15,50000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
			else
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -10,00000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
	return true;
}

function Atk_HighUnder_Air_SetB()
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if ((this.motion == 40 || this.motion == 42) && (this.keyTake == 1 || this.keyTake == 2))
		{
			local pos_ = this.Vector3();
			pos_.x = this.target.x - this.x;
			pos_.y = this.target.y - this.y;
			pos_.Normalize();

			if (pos_.y <= 0,86600000.0 && pos_.y >= 0 && this.targetHeight >= 0 && this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 175,00000000.0)
			{
				return true;
			}
		}
		else if (this.va.x * this.direction >= 1,00000000.0 && this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 100,00000000.0 && this.targetHeight >= 50,00000000.0)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 2;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.Atk_HighUnderAuto_Air_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.PlaySE(2450);
	this.CommonAutoAttackSet(t_, 0);
	this.autoAttackTimes[0] = 180;

	for( local i = 0; i < 360; i = i + 45 )
	{
		local t_ = {};
		t_.keyTake <- 0;
		t_.rot <- (i + 45 + this.rand() % 5) * 0,01745329.0;
		this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
	}

	return true;
}

function Atk_HighUnder_Air_Init( t )
{
	if (this.attackType[0] == 2)
	{
		this.CommonAutoAttackReset(0);
	}
	else
	{
		this.Atk_HighUnder_Air_SetB();
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1211, 0);
	this.SetSpeed_XY(7,50000000.0 * this.direction, -12,50000000.0);
	this.centerStop = -2;
	this.PlaySE(2407);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,25000000.0);
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
			this.HitReset();
			this.PlaySE(2408);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(1,50000000.0, 90 * 0,01745329.0, 25,00000000.0, this.direction);
				this.VX_Brake(0,50000000.0);

				if (this.hitResult & 13 || this.ground == 1)
				{
					if (this.ground == 1)
					{
						this.PlaySE(2410);
						::camera.shake_radius = 6,00000000.0;
					}

					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.PlaySE(2410);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.centerStop = -2;

			if (this.flag1)
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -10,50000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
			else
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -10,00000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
	return true;
}

function Atk_HighUnderAuto_Air_Init( t )
{
	this.CommonAutoAttackReset(0);
	this.LabelClear();
	this.HitReset();
	this.atk_id = 1024;
	this.SetMotion(1210, 0);
	this.SetSpeed_XY(7,50000000.0 * this.direction, -12,50000000.0);
	this.centerStop = -2;
	this.PlaySE(2407);
	this.keyAction = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 1,25000000.0);
				this.VX_Brake(0,25000000.0);
			};
		},
		function ()
		{
			this.HitReset();
			this.PlaySE(2408);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(1,50000000.0, 90 * 0,01745329.0, 25,00000000.0, this.direction);
				this.VX_Brake(0,50000000.0);

				if (this.hitResult & 13 || this.ground == 1)
				{
					if (this.ground == 1)
					{
						this.PlaySE(2410);
						::camera.shake_radius = 6,00000000.0;
					}

					this.SetMotion(this.motion, 4);
					this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
					this.stateLabel = function ()
					{
					};
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.PlaySE(2410);
			this.stateLabel = function ()
			{
			};
		},
		function ()
		{
			this.centerStop = -2;

			if (this.flag1)
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -10,50000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
			else
			{
				this.SetSpeed_XY(9,00000000.0 * this.direction, -10,00000000.0);
				this.stateLabel = function ()
				{
					this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
					this.VX_Brake(0,15000001.0);
				};
			}
		},
		function ()
		{
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, 0,50000000.0);
	};
	return true;
}

function Atk_HighUpper_Set( t )
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if (this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 75,00000000.0 && this.targetHeight <= -125,00000000.0)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 8;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.Atk_HighUpperAuto_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.AutoAttackSet(t_);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2450);
			this.CommonAutoAttackReset(0);
			this.CommonAutoAttackSet(this.flag2, 0);
			this.autoAttackTimes[0] = 0;

			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.keyTake <- 0;
				t_.rot <- (i + 45 + this.rand() % 5) * 0,01745329.0;
				this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
			}
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,25000000.0, 2,00000000.0);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,75000000.0);
		}
	};
	return true;
}

function Atk_HighUpper_SetB()
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if (this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 75,00000000.0 && this.targetHeight <= -125,00000000.0)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 8;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.Atk_HighUpperAuto_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.CommonAutoAttackSet(t_, 0);
	return true;
}

function Atk_HighUpper_Init( t )
{
	if (this.attackType[0] == 8)
	{
		this.CommonAutoAttackReset(0);
	}
	else
	{
		this.Atk_HighUpper_SetB();
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1223, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.PlaySE(2411);
			this.SetSpeed_XY(9,00000000.0 * this.direction, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,44999999.0);
				this.AddSpeed_XY(null, 0,94999999.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetSpeed_XY(null, 3,00000000.0);
					this.SetMotion(1223, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(1,00000000.0);
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
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function Atk_HighUpperAuto_Init( t )
{
	if (this.attackType[0] == 8)
	{
		this.CommonAutoAttackReset(0);
	}
	else
	{
		this.Atk_HighUpper_SetB();
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1220, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.PlaySE(2411);
			this.SetSpeed_XY(null, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,44999999.0);
				this.AddSpeed_XY(null, 0,94999999.0);

				if (this.va.y > 0,00000000.0 && this.y > this.centerY)
				{
					this.centerStop = 1;
					this.SetSpeed_XY(null, 3,00000000.0);
					this.SetMotion(this.motion, 3);
					this.stateLabel = function ()
					{
						this.VX_Brake(1,00000000.0);
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
		this.VX_Brake(1,00000000.0);
	};
	return true;
}

function Atk_HighUpper_Air_SetB()
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if (this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 75,00000000.0 && this.targetHeight <= -125,00000000.0)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 8;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.Atk_HighUpperAuto_Air_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.CommonAutoAttackSet(t_, 0);
	return true;
}

function Atk_HighUpper_Air_Init( t )
{
	if (this.attackType[0] == 8)
	{
		this.CommonAutoAttackReset(0);
	}
	else
	{
		this.Atk_HighUpper_Air_SetB();
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1224, 0);
	this.keyAction = [
		function ()
		{
			this.flag1 = this.y;
			this.centerStop = -2;
			this.PlaySE(2411);
			this.SetSpeed_XY(0,00000000.0, -6,00000000.0);
			this.stateLabel = function ()
			{
				if (this.va.y < 0,00000000.0)
				{
					this.AddSpeed_XY(null, 0,50000000.0);
				}
				else
				{
					this.AddSpeed_XY(null, 0,25000000.0);
				}

				this.VX_Brake(0,50000000.0);
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
	};
	return true;
}

function Atk_HighUpperAuto_Air_Init( t )
{
	this.CommonAutoAttackReset(0);
	this.LabelClear();
	this.HitReset();
	this.atk_id = 512;
	this.SetMotion(1221, 0);
	this.keyAction = [
		function ()
		{
			this.flag1 = this.y;
			this.centerStop = -2;
			this.PlaySE(2411);
			this.SetSpeed_XY(null, -10,00000000.0);
			this.stateLabel = function ()
			{
				if (this.va.y < 0,00000000.0)
				{
					this.AddSpeed_XY(null, 0,75000000.0);
				}
				else
				{
					this.AddSpeed_XY(null, 0,34999999.0);
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
		this.Vec_Brake(1,00000000.0);
	};
	return true;
}

function Atk_RushC_Upper_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 64;
	this.SetMotion(1720, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.PlaySE(2411);
			this.SetSpeed_XY(12,50000000.0 * this.direction, -10,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
				this.AddSpeed_XY(null, 0,75000000.0);

				if (this.va.y >= 2,00000000.0)
				{
					this.SetSpeed_XY(null, 2,00000000.0);
				}
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(1,00000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.Vec_Brake(1,00000000.0);
	};
	return true;
}

function Atk_HighFront_Set( t )
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if (this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 300,00000000.0)
		{
			if (this.abs(this.targetHeight) <= 20,00000000.0 || this.centerStop * this.centerStop >= 4 && this.abs(this.targetHeight) <= 50,00000000.0)
			{
				return true;
			}
		}

		return false;
	};
	t_.attackType <- 6;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.Atk_HighFrontAuto_Init(null))
			{
				return true;
			}
		}
		else if (this.Atk_HighFront_Air_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.AutoAttackSet(t_);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2450);
			this.CommonAutoAttackReset(0);
			this.CommonAutoAttackSet(this.flag2, 0);
			this.autoAttackTimes[0] = 0;

			for( local i = 0; i < 360; i = i + 45 )
			{
				local t_ = {};
				t_.keyTake <- 0;
				t_.rot <- (i + 45 + this.rand() % 5) * 0,01745329.0;
				this.SetFreeObject(this.x, this.y, this.direction, this.SetEffect_Koishi, t_);
			}
		},
		function ()
		{
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.VX_Brake(0,75000000.0);
				}
				else
				{
					this.VX_Brake(0,10000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,25000000.0, 2,00000000.0);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,75000000.0);
		}
	};
	return true;
}

function Atk_HighFront_SetB()
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if (this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 300,00000000.0)
		{
			if (this.abs(this.targetHeight) <= 20,00000000.0 || this.centerStop * this.centerStop >= 4 && this.abs(this.targetHeight) <= 50,00000000.0)
			{
				return true;
			}
		}

		return false;
	};
	t_.attackType <- 6;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.Atk_HighFrontAuto_Init(null))
			{
				return true;
			}
		}
		else if (this.Atk_HighFrontAuto_Air_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.AutoAttackSet(t_);
	this.CommonAutoAttackSet(t_, 0);
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
	if (this.attackType[0] == 6)
	{
		this.CommonAutoAttackReset(0);
	}
	else
	{
		this.Atk_HighFront_SetB();
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
	this.SetMotion(1233, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2413);
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_HighFrontAuto_Init( t )
{
	this.CommonAutoAttackReset(0);
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, null);
	this.SetMotion(1230, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2413);
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,50000000.0);
	};
	return true;
}

function Atk_RushC_Front_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 32;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.SetMotion(1730, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2413);
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(0,25000000.0);
	};
	return true;
}

function Atk_RushA_Far_Init( t )
{
	this.Atk_HighFront_Init(t);
	this.SetMotion(1740, 0);
	this.atk_id = 2048;
	this.flag1 = false;
	return true;
}

function Atk_HighFront_Air_SetB()
{
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 120;
	t_.autoAttack <- function ( table_ )
	{
		if (this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 300,00000000.0)
		{
			if (this.abs(this.targetHeight) <= 20,00000000.0 || this.centerStop * this.centerStop >= 4 && this.abs(this.targetHeight) <= 50,00000000.0)
			{
				return true;
			}
		}

		return false;
	};
	t_.attackType <- 6;
	t_.autoTable <- {};
	t_.autoFunc <- function ( init_ )
	{
		if (this.centerStop * this.centerStop <= 1)
		{
			if (this.Atk_HighFrontAuto_Init(null))
			{
				return true;
			}
		}
		else if (this.Atk_HighFrontAuto_Air_Init(null))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		return true;
	};
	t_.autoCancelLevel <- 30;
	this.CommonAutoAttackSet(t_, 0);
	return true;
}

function Atk_RushA_Air_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(1750, 0);
	this.atk_id = 16;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2413);
			this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.combo_func = null;
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
	if (this.attackType[0] == 6)
	{
		this.CommonAutoAttackReset(0);
	}
	else
	{
		this.Atk_HighFront_Air_SetB();
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.SetMotion(1234, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2413);
			this.stateLabel = function ()
			{
				this.CenterUpdate(0,10000000.0, null);

				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1234, 4);
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
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1234, 4);
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
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.SetMotion(1234, 4);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	};
	return true;
}

function Atk_HighFrontAuto_Air_Init( t )
{
	this.CommonAutoAttackReset(0);
	this.LabelClear();
	this.HitReset();
	this.atk_id = 256;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.SetMotion(1231, 0);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2413);
		},
		function ()
		{
			this.HitTargetReset();
			this.AjustCenterStop();
			this.stateLabel = function ()
			{
				if (this.centerStop * this.centerStop <= 1)
				{
					this.SetMotion(1234, 4);
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
		}
	];
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);
		this.VX_Brake(0,25000000.0);

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
	if (this.target.x > this.x && this.direction == -1,00000000.0 || this.target.x < this.x && this.direction == 1,00000000.0)
	{
		this.Atk_LowDashBack_Init(t);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1300, 0);
	this.count = 0;
	this.SetSpeed_XY(8,00000000.0 * this.direction, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.flag1 += 10 * 0,01745329.0;
		local t_ = {};
		t_.rot <- this.flag1;
		this.SetFreeObject(this.point0_x + 100 * this.cos(this.flag1) * this.direction, this.point0_y + 20 * this.sin(this.flag1), this.direction, this.AtkLow_DashHeart, t_);
	};
	this.flag1 = -90,00000000.0 * 0,01745329.0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2415);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,30000001.0);
				this.flag1 += 30 * 0,01745329.0;
				local t_ = {};
				t_.rot <- this.flag1;
				this.SetFreeObject(this.point0_x + 100 * this.cos(this.flag1) * this.direction, this.point0_y + 20 * this.sin(this.flag1), this.direction, this.AtkLow_DashHeart, t_);
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

function Atk_LowDashBack_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.atk_id = 4096;
	this.SetMotion(1301, 0);
	this.count = 0;
	this.stateLabel = function ()
	{
		this.flag1 += 10 * 0,01745329.0;
		local t_ = {};
		t_.rot <- this.flag1;
		this.SetFreeObject(this.point0_x + 100 * this.cos(this.flag1) * this.direction, this.point0_y + 20 * this.sin(this.flag1), this.direction, this.AtkLow_DashHeart, t_);
	};
	this.flag1 = -90,00000000.0 * 0,01745329.0;
	this.keyAction = [
		function ()
		{
			this.PlaySE(2415);
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,30000001.0);
				this.flag1 += 30 * 0,01745329.0;
				local t_ = {};
				t_.rot <- this.flag1;
				this.SetFreeObject(this.point0_x + 100 * this.cos(this.flag1) * this.direction, this.point0_y + 20 * this.sin(this.flag1), this.direction, this.AtkLow_DashHeart, t_);
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

function Atk_RushD_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
	};
	this.SetMotion(1740, 0);
	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(20,00000000.0 * this.direction, -6,00000000.0);
			this.PlaySE(2417);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,34999999.0);
				this.AddSpeed_XY(0,00000000.0, 0,40000001.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
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

	if (this.motion == 40 && this.flag1)
	{
		if (this.GetFront())
		{
			this.SetMotion(1312, 0);
		}
		else
		{
			this.SetMotion(1310, 0);
		}
	}
	else
	{
		this.SetMotion(1310, 0);
	}

	this.keyAction = [
		function ()
		{
			this.centerStop = -2;
			this.SetSpeed_XY(12,00000000.0 * this.direction, -6,00000000.0);
			this.PlaySE(2417);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,40000001.0);
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
				this.AddSpeed_XY(0,00000000.0, 0,20000000.0);
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
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2440);
			this.flag1.func[0].call(this.flag1);
			this.target.autoCamera = true;

			for( local i = 0; i < 360; i = i + 12 )
			{
				local t_ = {};
				t_.rot <- (i + this.rand() % 10) * 0,01745329.0;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.AtkHigh_Petal, t_);
			}

			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 60)
				{
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashFront, {});

					for( local i = 0; i < 360; i = i + 20 )
					{
						local t_ = {};
						t_.rot <- (i + this.rand() % 10) * 0,01745329.0;
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_D_Petal, t_);
					}

					::battle.enableTimeUp = true;
					this.PlaySE(2441);
					this.SetSpeed_XY(-12,00000000.0 * this.direction, 0,00000000.0);
					this.SetMotion(this.motion, 3);
					this.target.freeMap = false;
					this.KnockBackTarget(-this.direction);
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
						this.VX_Brake(0,69999999.0);
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
	this.SetMotion(2000, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(2420);
			local g_ = [];
			local t = {};
			t.rot <- -40 * 0,01745329.0;
			t.keyTake <- 0;
			t.shotRot <- 0,00000000.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			local t = {};
			t.rot <- 40 * 0,01745329.0;
			t.keyTake <- 1;
			t.shotRot <- 0,00000000.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			g_[0].flag1 = g_[1].weakref();
			g_[1].flag1 = g_[0].weakref();
			this.SetSpeed_XY(-10,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Shot_Normal_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2001, 0);
	this.count = 0;
	this.va.y = this.Math_MinMax(this.va.y, -12,50000000.0, 12,50000000.0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(2420);
			local g_ = [];
			local t = {};
			t.rot <- -40 * 0,01745329.0;
			t.keyTake <- 0;
			t.shotRot <- 0,00000000.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			local t = {};
			t.rot <- 40 * 0,01745329.0;
			t.keyTake <- 1;
			t.shotRot <- 0,00000000.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			g_[0].flag1 = g_[1].weakref();
			g_[1].flag1 = g_[0].weakref();

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
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);

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
	this.SetMotion(2000, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(2420);
			local g_ = [];
			local t = {};
			t.rot <- -40 * 0,01745329.0;
			t.keyTake <- 0;
			t.shotRot <- -30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			local t = {};
			t.rot <- 40 * 0,01745329.0;
			t.keyTake <- 1;
			t.shotRot <- -30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			g_[0].flag1 = g_[1].weakref();
			g_[1].flag1 = g_[0].weakref();
			this.SetSpeed_XY(-10,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Shot_Normal_Upper_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2001, 0);
	this.count = 0;
	this.va.y = this.Math_MinMax(this.va.y, -12,50000000.0, 12,50000000.0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(2420);
			local g_ = [];
			local t = {};
			t.rot <- -40 * 0,01745329.0;
			t.keyTake <- 0;
			t.shotRot <- -30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			local t = {};
			t.rot <- 40 * 0,01745329.0;
			t.keyTake <- 1;
			t.shotRot <- -30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			g_[0].flag1 = g_[1].weakref();
			g_[1].flag1 = g_[0].weakref();

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
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);

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
	this.SetMotion(2000, 0);
	this.count = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(2420);
			local g_ = [];
			local t = {};
			t.rot <- -40 * 0,01745329.0;
			t.keyTake <- 0;
			t.shotRot <- 30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			local t = {};
			t.rot <- 40 * 0,01745329.0;
			t.keyTake <- 1;
			t.shotRot <- 30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			g_[0].flag1 = g_[1].weakref();
			g_[1].flag1 = g_[0].weakref();
			this.SetSpeed_XY(-10,00000000.0 * this.direction, null);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,50000000.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
	return true;
}

function Shot_Normal_Under_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.SetMotion(2001, 0);
	this.count = 0;
	this.va.y = this.Math_MinMax(this.va.y, -12,50000000.0, 12,50000000.0);
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);

	if (this.y <= this.centerY)
	{
		this.flag2 = -1;
	}
	else
	{
		this.flag2 = 1;
	}

	this.AjustCenterStop();
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.team.AddMP(-200, 90);
			this.PlaySE(2420);
			local g_ = [];
			local t = {};
			t.rot <- -40 * 0,01745329.0;
			t.keyTake <- 0;
			t.shotRot <- 30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			local t = {};
			t.rot <- 40 * 0,01745329.0;
			t.keyTake <- 1;
			t.shotRot <- 30,00000000.0 * 0,01745329.0;
			g_.append(this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Normal, t).weakref());
			g_[0].flag1 = g_[1].weakref();
			g_[1].flag1 = g_[0].weakref();

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
		null,
		function ()
		{
			this.stateLabel = function ()
			{
				this.VX_Brake(0,20000000.0);

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
	this.hitResult = 1;
	this.SetMotion(2010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.func = function ()
	{
		local t_ = {};
		t_.preAutoCount <- 120;
		t_.autoCount <- 90;
		t_.autoAttack <- function ( table_ )
		{
			if (this.target.IsDamage() == 2 && this.target.recover <= 0 || this.target.invin > 0 || this.target.invinObject > 0 || this.target.baria || this.target.motion >= 30 && this.target.motion <= 39)
			{
				return false;
			}

			if (this.abs(this.targetHeight) <= 50,00000000.0)
			{
				return true;
			}

			return false;
		};
		t_.attackType <- 50;
		t_.autoTable <- {};
		t_.autoFunc <- function ( init_ )
		{
			if (this.Shot_FrontB_Init(null))
			{
			}

			return true;
		};
		t_.timeFunc <- function ( init_ )
		{
			return true;
		};
		t_.autoCancelLevel <- 40;
		this.CommonAutoAttackSet(t_, 1);
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(2422);
			this.func();
			local t = {};
			t.rot <- this.GetTargetAngle(this.target, this.direction);
			t.rot = 0,00000000.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t);
			t.rot += 3,14159203.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,34999999.0);
			};
		}
	];
	return true;
}

function Shot_FrontB_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2011, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.func = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(2422);
			this.team.AddMP(-200, 90);
			local t = {};
			t.rot <- this.GetTargetAngle(this.target, this.direction);
			t.rot = 0,00000000.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_AutoFront, t);
			this.SetShot(this.point0_x, this.point0_y, -this.direction, this.Shot_AutoFront, t);
			this.func();
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,34999999.0);
			};
		}
	];
	return true;
}

function Shot_Front_Air_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2012, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.func = function ()
	{
		local t_ = {};
		t_.preAutoCount <- 120;
		t_.autoCount <- 90;
		t_.autoAttack <- function ( table_ )
		{
			if (this.target.IsDamage() == 2 && this.target.recover <= 0 || this.target.invin > 0 || this.target.invinObject > 0 || this.target.baria || this.target.motion >= 30 && this.target.motion <= 39)
			{
				return false;
			}

			if (this.abs(this.targetHeight) <= 50,00000000.0)
			{
				return true;
			}

			return false;
		};
		t_.attackType <- 50;
		t_.autoTable <- {};
		t_.autoFunc <- function ( init_ )
		{
			if (this.Shot_FrontB_Init(null))
			{
				return true;
			}
		};
		t_.timeFunc <- function ( init_ )
		{
			return true;
		};
		t_.autoCancelLevel <- 40;
		this.CommonAutoAttackSet(t_, 1);
	};
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 90);
			this.PlaySE(2422);
			this.func();
			local t = {};
			t.rot <- this.GetTargetAngle(this.target, this.direction);
			t.rot = 0,00000000.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t);
			t.rot += 3,14159203.0;
			this.SetShot(this.point0_x, this.point0_y, this.direction, this.Shot_Front, t);
			this.SetSpeed_XY(-10,00000000.0 * this.direction, 0,00000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,34999999.0);
			};
		}
	];
	return true;
}

function Shot_Charge_Init( t )
{
	this.Shot_Charge_Common(t);
	this.flag2.vx <- 5,00000000.0;
	this.flag2.vy <- 3,00000000.0;
	this.flag2.chargeCount <- 36;
	this.subState = function ()
	{
		this.flag2.chargeCount++;
	};
}

function Shot_Charge_Fire( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(2020, 0);
	this.flag1 = true;
	this.flag2.rot <- 0,00000000.0;
	this.flag2.charge <- t.charge;

	if (this.input.y < 0)
	{
		this.flag2.rot <- (-40 + 10 - this.rand() % 21) * 0,01745329.0;
	}

	if (this.input.y > 0)
	{
		this.flag2.rot <- (40 + 10 - this.rand() % 21) * 0,01745329.0;
	}

	this.keyAction = [
		null,
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(2435);
			local t_ = {};
			t_.num <- 0;
			t_.limit <- 2 + this.flag2.chargeCount / 10;

			if (t_.limit > 20)
			{
				t_.limit = 20;
			}

			if (this.flag2.charge)
			{
				t_.limit = 30;
			}

			t_.rot <- this.flag2.rot;
			t_.charge <- this.flag2.charge;

			if (this.flag2.charge)
			{
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_ChargeFull, t_, this.weakref());
			}
			else
			{
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Shot_Charge, t_, this.weakref());
			}

			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 60)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	return true;
}

function Shot_Charge_Air_Init( t )
{
	this.Shot_Charge_Init(t);
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
			if (this.count % 20 == 11)
			{
				this.SetShot(this.x + 50 - this.rand() % 101, this.y + 50 - this.rand() % 101, this.direction, this.Shot_Barrage_Rose, {});
			}
		}
	};
	return true;
}

function Occult_Call( t )
{
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = this.y - this.owner.y;
	this.flag2 = 0,00000000.0;
	this.sx = this.sy = 0,10000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ( s_ )
		{
			this.SetMotion(2508, 2);
			this.count = 0;
			this.flag2 = s_;
			this.SetSpeed_XY(0,00000000.0, -12,50000000.0);
			this.stateLabel = function ()
			{
				if (this.count == 6)
				{
					this.PlaySE(2596);
				}

				if (this.count % 7 == 6)
				{
					local t_ = {};
					t_.scale <- this.flag2;
					this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Occult_Wave, t_);
				}

				this.sx = this.sy += (1,00000000.0 - this.sx) * 0,20000000.0;
				this.rz = 10,00000000.0 * this.sin(this.count * 57 * 0,01745329.0) * 0,01745329.0;
				this.AddSpeed_XY(0,00000000.0, 1,50000000.0);

				if (this.va.y > -0,20000000.0)
				{
					this.SetSpeed_XY(0,00000000.0, -0,20000000.0);
				}

				this.count++;

				if (this.count >= 40)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.rz = 0,00000000.0;
			this.SetMotion(2508, 0);
			this.stateLabel = function ()
			{
			};
		}
	];
	this.func[1].call(this, this.owner.occultRange);
}

function Okult_Init( t )
{
	this.LabelClear();
	this.GetFront();
	this.HitReset();
	this.hitResult = 1;
	this.SetMotion(2500, 0);
	this.SetSpeed_XY(0, 0);
	this.AjustCenterStop();
	this.flag1 = 1,00000000.0;
	this.flag2 = true;
	this.flag3 = null;
	this.flag5 = {};
	this.flag5.phone <- null;
	this.flag5.wave <- null;
	this.flag5.mana <- true;
	this.flag5.g <- 0;
	this.lavelClearEvent = function ()
	{
		if (this.flag5.phone)
		{
			this.flag5.phone.func[0].call(this.flag5.phone);
		}
	};
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.flag5.g > 0)
				{
					this.CenterUpdate(this.flag5.g, 3,00000000.0);
				}

				if (this.input.b0 == 0 && this.input.b1 == 0)
				{
					this.flag2 = false;
				}

				if (this.count == 3)
				{
					if (this.flag5.mana)
					{
						this.team.AddMP(-200, 120);
						this.flag5.mana = false;
						this.team.op_stop = 300;
						this.team.op_stop_max = 300;
					}

					local r_ = 1,00000000.0;
					this.occultRange += r_;

					if (this.occultRange >= 12,00000000.0)
					{
						this.occultRange = 12,00000000.0;
					}

					if (this.flag5.phone)
					{
						this.flag5.phone.func[1].call(this.flag5.phone, this.occultRange);
					}
					else
					{
						this.flag5.phone = this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.Occult_Phone, {}).weakref();
					}

					this.occultCycle = 180;
				}

				if (this.flag5.wave)
				{
					if (this.flag5.wave.hitResult & 1)
					{
						this.Okult_Hit(null);
						this.occultRange = 0,00000000.0;
						return;
					}

					if (this.flag5.wave.hitCount > 0)
					{
						this.hitResult = 8;
						this.occultRange = 0,00000000.0;
						this.flag2 = false;
					}
				}

				if (this.count >= 40 && (!this.flag2 || this.flag5.wave && this.flag5.wave.hitResult != 0))
				{
					this.lavelClearEvent = null;
					this.hitResult = 1;

					if (this.flag5.phone)
					{
						this.flag5.phone.func[0].call(this.flag5.phone);
					}

					if (this.flag5.wave && this.flag5.wave.hitResult != 0)
					{
						this.occultRange = 0,00000000.0;
					}

					this.SetMotion(2500, 3);
					this.stateLabel = function ()
					{
					};
				}

				if (this.count >= 60)
				{
					if (!this.flag2 || this.flag5.wave && this.flag5.wave.hitResult != 0)
					{
						this.lavelClearEvent = null;
						this.hitResult = 1;

						if (this.flag5.phone)
						{
							this.flag5.phone.func[0].call(this.flag5.phone);
						}

						if (this.flag5.wave && this.flag5.wave.hitResult != 0)
						{
							this.occultRange = 0,00000000.0;
						}

						this.SetMotion(2500, 3);
						this.stateLabel = function ()
						{
						};
					}
					else
					{
						this.flag5.g = 0,07500000.0;
						this.count = 0;
					}
				}
			};
		}
	];
	return true;
}

function Okult_Hit( t )
{
	this.SetMotion(2501, 0);
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = this.Vector3();
	this.flag5 = null;
	this.flag5 = this.SetFreeObject(this.x, this.y, this.direction, this.Occult_TelLine, {}).weakref();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

	if (this.target.damageStopTime > 0 && this.target.IsDamage())
	{
		this.target.damageStopTime = 90;
		this.target.attackTarget = this.weakref();
	}

	this.stateLabel = function ()
	{
		if (this.count == 15)
		{
			this.sx = this.sy = 2,00000000.0;
			this.SetFreeObject(this.x, this.y, this.direction, this.Occult_HitEffect, {});
			this.SetMotion(2501, 1);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (0,50000000.0 - this.sx) * 0,10000000.0;

				if (this.count == 20)
				{
					this.count = 0;
					this.flag1.x = this.target.x - this.x;
					this.flag1.y = this.target.y - this.y;
					this.PlaySE(2598);
					this.stateLabel = function ()
					{
						this.flag1.x = this.target.x - this.x;
						this.flag1.y = this.target.y - this.y;

						if (this.flag1.LengthXY() <= 20,00000000.0)
						{
							this.count = 0;
							this.x = this.target.x;
							this.y = this.target.y;
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

							if (this.flag5)
							{
								this.flag5.func[0].call(this.flag5);
							}

							this.Okult_Attack(null);
							return;
						}

						this.flag1.SetLength(40,00000000.0);
						this.SetSpeed_XY(this.flag1.x, this.flag1.y);
					};
				}
			};
		}
	};
}

function Okult_AnyHit( t )
{
	this.SetMotion(2501, 0);
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = this.Vector3();
	this.flag5 = null;
	this.flag5 = this.SetFreeObject(this.x, this.y, this.direction, this.Occult_TelLine, {}).weakref();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

	if (this.target.damageStopTime > 0 && this.target.IsDamage())
	{
		this.target.damageStopTime = 90;
		this.target.attackTarget = this.weakref();
	}

	this.stateLabel = function ()
	{
		if (this.count == 1)
		{
			this.sx = this.sy = 2,00000000.0;
			this.SetFreeObject(this.x, this.y, this.direction, this.Occult_HitEffect, {});
			this.SetMotion(2501, 1);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += (0,50000000.0 - this.sx) * 0,10000000.0;

				if (this.count == 15)
				{
					this.count = 0;
					this.flag1.x = this.target.x - this.x;
					this.flag1.y = this.target.y - this.y;
					this.PlaySE(2598);
					this.stateLabel = function ()
					{
						this.flag1.x = this.target.x - this.x;
						this.flag1.y = this.target.y - this.y;

						if (this.flag1.LengthXY() <= 20,00000000.0)
						{
							this.count = 0;
							this.x = this.target.x;
							this.y = this.target.y;
							this.SetSpeed_XY(0,00000000.0, 0,00000000.0);

							if (this.flag5)
							{
								this.flag5.func[0].call(this.flag5);
							}

							this.Okult_Attack(null);
							return;
						}

						this.flag1.SetLength(40,00000000.0);
						this.SetSpeed_XY(this.flag1.x, this.flag1.y);
					};
				}
			};
		}
	};
}

function Okult_Attack( t )
{
	this.LabelClear();
	this.atk_id = 524288;
	this.SetMotion(2502, 1);
	this.SetFreeObject(this.x, this.y, this.direction, this.Occult_HitEffect, {});
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.sx = this.sy = 1,00000000.0;
	this.SetSpeed_XY(12,50000000.0 * this.direction, 0,00000000.0);
	this.HitReset();
	this.count = 0;
	this.flag1 = this.Vector3();
	this.direction = -this.direction;

	if (this.y <= this.centerY)
	{
		this.centerStop = -2;
	}
	else
	{
		this.centerStop = 2;
	}

	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2599);
			this.target.attackTarget = null;
		}
	];
	this.stateLabel = function ()
	{
		this.VX_Brake(0,75000000.0);
	};
}

function SP_B_Set( t )
{
	this.SetSkillReset();
	local t_ = {};
	t_.autoCount <- 300;
	t_.preAutoCount <- 150;
	t_.autoAttack <- function ( table_ )
	{
		if (this.target.centerStop * this.target.centerStop >= 4 && this.targetDist * this.direction >= 0,00000000.0 && this.targetDist * this.direction <= 150,00000000.0 && this.targetHeight <= -10,00000000.0)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 0;
	t_.autoTable <- t;
	t_.autoFunc <- function ( init_ )
	{
		if (this.SP_B_Init(init_))
		{
			return true;
		}
	};
	t_.invin <- false;
	t_.timeFunc <- t_.autoFunc;
	t_.autoCancelLevel <- 60;
	this.CommonAutoAttackSet(t_, 2);
	return true;
}

function SP_B_First_Init( t )
{
	this.SP_B_Init(null);
	this.SP_B_Set(null);
	return;
}

function SP_B_Init( t )
{
	this.LabelClear();
	this.atk_id = 2097152;
	this.HitReset();
	this.SetMotion(3010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.team.AddMP(-200, 120);
			this.PlaySE(2433);
			local t_ = {};
			t_.rot <- 0,00000000.0;
			t_.keyTake <- 0;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			local t_ = {};
			t_.rot <- 3,14159203.0;
			t_.keyTake <- 1;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			this.centerStop = -2;
			this.SetSpeed_XY(10,00000000.0 * this.direction, -17,50000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);

				if (this.va.x * this.direction <= 2,00000000.0)
				{
					this.SetSpeed_XY(2,00000000.0 * this.direction, null);
				}

				if (this.y < this.centerY)
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				}

				if (this.va.y >= 0,00000000.0)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,44999999.0);
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(4);
				this.VX_Brake(0,40000001.0);

				if (this.va.x * this.direction <= 2,00000000.0)
				{
					this.SetSpeed_XY(2,00000000.0 * this.direction, null);
				}

				if (this.y < this.centerY)
				{
					this.AddSpeed_XY(0,00000000.0, 0,75000000.0);
				}

				if (this.va.y >= 0,00000000.0)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,30000001.0);

						if (this.y > this.centerY)
						{
							this.SetMotion(this.motion, 5);
							this.centerStop = 1;
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
		if (this.keyTake <= 2)
		{
			this.Vec_Brake(1,00000000.0);
		}
	};
	return true;
}

function SP_B2_Init( t )
{
	if (!this.Cancel_Check(t.cancel, 0, t.sp))
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(3010, 0);
	this.atk_id = 2097152;
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetEndMotionCallbackFunction(this.EndtoFallLoop);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2433);
			local t_ = {};
			t_.rot <- 0,00000000.0;
			t_.keyTake <- 0;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			local t_ = {};
			t_.rot <- 3,14159203.0;
			t_.keyTake <- 1;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			this.centerStop = -2;
			this.SetSpeed_XY(0,00000000.0, -22,50000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

				if (this.va.y >= 0,00000000.0)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,44999999.0);
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(4);
				this.AddSpeed_XY(0,00000000.0, 0,75000000.0);

				if (this.va.y >= 0,00000000.0)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, 0,44999999.0);
					};
				}
			};
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

function SP_B3_Init( t )
{
	if (!this.Cancel_Check(t.cancel, 0, t.sp))
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.SetMotion(3011, 0);
	this.atk_id = 2097152;
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.keyAction = [
		function ()
		{
			this.PlaySE(2433);
			local t_ = {};
			t_.rot <- 0,00000000.0;
			t_.keyTake <- 0;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			local t_ = {};
			t_.rot <- 3,14159203.0;
			t_.keyTake <- 1;
			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_B, t_);
			this.centerStop = 2;
			this.SetSpeed_XY(10,00000000.0 * this.direction, 17,50000000.0);
			this.stateLabel = function ()
			{
				this.VX_Brake(0,40000001.0);

				if (this.va.x * this.direction <= 2,00000000.0)
				{
					this.SetSpeed_XY(2,00000000.0 * this.direction, null);
				}

				this.AddSpeed_XY(0,00000000.0, -0,75000000.0);

				if (this.va.y <= 0,00000000.0)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, -0,44999999.0);
					};
				}
			};
		},
		function ()
		{
			this.HitTargetReset();
			this.stateLabel = function ()
			{
				this.HitCycleUpdate(4);
				this.VX_Brake(0,40000001.0);

				if (this.va.x * this.direction <= 2,00000000.0)
				{
					this.SetSpeed_XY(2,00000000.0 * this.direction, null);
				}

				this.AddSpeed_XY(0,00000000.0, -0,75000000.0);

				if (this.va.y <= 0,00000000.0)
				{
					this.stateLabel = function ()
					{
						this.AddSpeed_XY(0,00000000.0, -0,30000001.0);
					};
				}
			};
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

function SP_C_Set( t )
{
	if (!this.Cancel_Check(t.cancel, 1, t.sp))
	{
		return false;
	}

	this.team.AddMP(-t.mana, 60);
	this.SetSkillReset();
	local t_ = {};
	t_.autoCount <- 60;
	t_.preAutoCount <- 90;
	t_.autoAttack <- function ( table_ )
	{
		return false;
	};
	t_.attackType <- 102;
	t_.autoTable <- t;
	t_.autoFunc <- function ( init_ )
	{
		if (this.SP_C_Init(init_))
		{
			return true;
		}
	};
	t_.timeFunc <- t_.autoFunc;
	t_.autoCancelLevel <- 60;
	t_.invin <- false;
	this.AutoSkillSet(t_);
	return true;
}

function SP_C_Init( t )
{
	if (!this.Cancel_Check(t.cancel, 0, t.sp))
	{
		return false;
	}

	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(3020, 0);
	this.team.AddMP(-100, 60);
	this.flag1 = true;
	this.flag2 = t.k;
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2435);
			local t_ = {};
			t_.num <- 0;
			t_.limit <- 2 + 2 * this.autoAttackTimes[2];

			if (t_.limit > 20)
			{
				t_.limit = 20;
			}

			t_.name <- this.name;

			switch(this.flag2)
			{
			case 2:
				t_.rot <- (40 + 10 - this.rand() % 21) * 0,01745329.0;
				break;

			case 8:
				t_.rot <- (-40 + 10 - this.rand() % 21) * 0,01745329.0;
				break;

			default:
				t_.rot <- (10 - this.rand() % 21) * 0,01745329.0;
				break;
			}

			this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.SPShot_C, t_);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 60)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
				}
			};
			this.SetSkillReset();
			local t_ = {};
			t_.autoCount <- 60;
			t_.preAutoCount <- 90 + this.autoAttackTimes[2] * 45;
			t_.autoAttack <- function ( table_ )
			{
				return false;
			};
			t_.attackType <- 102;
			t_.autoTable <- t;
			t_.autoFunc <- function ( init_ )
			{
				if (this.SP_C_Init(init_))
				{
					return true;
				}
			};
			t_.timeFunc <- t_.autoFunc;
			t_.autoCancelLevel <- 60;
			this.CommonAutoAttackSet(t_, 2);
		}
	];
	return true;
}

function SP_D_Set( t )
{
	this.team.AddMP(-200, 120);
	this.SetSkillReset();
	local t_ = {};
	t_.preAutoCount <- 120;
	t_.autoCount <- -10;
	t_.autoAttack <- function ( table_ )
	{
		if (this.target.IsDamage() || this.target.IsAttack() >= 2)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 130;
	t_.autoTable <- t;
	t_.autoFunc <- function ( init_ )
	{
		if (this.SP_D2_Init(init_))
		{
			return true;
		}
	};
	t_.timeFunc <- t_.autoFunc;
	t_.autoCancelLevel <- 60;
	t_.invin <- false;
	this.AutoSkillSet(t_);
	return true;
}

function SP_D_Init( t )
{
	if (this.attackType[2] != 130)
	{
		this.SP_D_Set(null);
		return true;
	}
	else
	{
		this.CommonAutoAttackReset(2);
	}

	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(3030, 0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
		if (this.hitResult & 1)
		{
			local t_ = {};
			t_.fast <- false;
			this.SP_D_Hit(t_);
			return;
		}
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(2438);
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	return true;
}

function SP_D_Hit( t )
{
	this.SetMotion(3035, 0);
	this.count = 0;

	if (t.fast)
	{
		this.flag1 = 2;
	}
	else
	{
		this.flag1 = 20;
	}

	this.target.freeMap = true;
	this.target.DamageGrab_Common(301, 0, -this.direction);
	this.target.Warp(this.point0_x, this.point0_y);
	this.stateLabel = function ()
	{
		this.target.Warp(this.point0_x, this.point0_y);

		if (this.count == this.flag1)
		{
			this.SetMotion(3035, 1);
		}
	};
	this.keyAction = [
		null,
		function ()
		{
			this.PlaySE(2440);

			for( local i = 0; i < 360; i = i + 12 )
			{
				local t_ = {};
				t_.rot <- (i + this.rand() % 10) * 0,01745329.0;
				this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.AtkHigh_Petal, t_);
			}

			this.target.DamageGrab_Common(308, 0, -this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.count >= 60)
				{
					this.SetEffect(this.point0_x, this.point0_y, this.direction, this.EF_HitSmashFront, {});

					for( local i = 0; i < 360; i = i + 20 )
					{
						local t_ = {};
						t_.rot <- (i + this.rand() % 10) * 0,01745329.0;
						this.SetFreeObject(this.point0_x, this.point0_y, this.direction, this.owner.SPShot_D_Petal, t_);
					}

					this.PlaySE(2441);
					this.SetSpeed_XY(-12,00000000.0 * this.direction, 0,00000000.0);
					this.SetMotion(this.motion, this.keyTake + 1);
					this.target.freeMap = false;
					this.KnockBackTarget(-this.direction);
					this.HitReset();
					this.hitResult = 1;
					this.stateLabel = function ()
					{
						this.VX_Brake(0,69999999.0);
					};
				}
			};
		}
	];
	return true;
}

function SP_D2_Init( t )
{
	this.LabelClear();
	this.HitReset();

	if (this.attackType[2] != 130 && !t.force)
	{
		this.SP_D_Set(null);
		return true;
	}
	else
	{
		this.SetSkillReset();
		this.CommonAutoAttackReset(2);
		this.team.AddMP(-200, 120);
	}

	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.SetMotion(3031, 0);
	this.flag4 = this.Vector3();
	this.flag5 = {};
	this.flag5.range <- 0;
	this.flag5.arm <- null;
	this.flag5.armRange <- 20;
	this.flag5.armSpeed <- 30,00000000.0;
	this.flag5.wireA <- null;
	this.flag5.wireB <- null;
	this.subState = function ()
	{
		if (this.flag5.arm.hitResult & 1)
		{
			this.SetMotion(3036, 0);
			this.target.freeMap = true;
			this.target.DamageGrab_Common(301, 0, -this.direction);
			this.target.Warp(this.flag5.arm.point0_x, this.flag5.arm.point0_y);
			return true;
		}
	};
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.PlaySE(2438);
			this.flag5.wireA = this.SetShot(this.point1_x, this.y, this.direction, this.SPShot_D_WireA, {}).weakref();
			this.flag5.wireB = this.SetShot(this.point2_x, this.y, this.direction, this.SPShot_D_WireB, {}).weakref();
			this.flag5.arm = this.SetShot(this.x + 20 * this.direction, this.y, this.direction, this.SPShot_D_Arm, {}).weakref();
			this.stateLabel = function ()
			{
				this.flag5.armRange += this.flag5.armSpeed;
				this.flag5.arm.Warp(this.x + this.flag5.armRange * this.direction, this.y);
				this.flag5.wireA.Warp(this.point1_x, this.y);
				this.flag5.wireB.Warp(this.point2_x, this.y);
				this.flag5.wireA.sx = this.abs(this.flag5.arm.point1_x - this.flag5.wireA.x) / 37,00000000.0;
				this.flag5.wireB.sx = this.abs(this.flag5.arm.point2_x - this.flag5.wireB.x) / 37,00000000.0;

				if (this.target.x - this.flag5.arm.x <= 130 && this.direction == 1,00000000.0 || this.target.x - this.flag5.arm.x >= -130 && this.direction == -1,00000000.0)
				{
					this.count = 0;
					this.SetMotion.call(this.flag5.arm, 3039, 1);
					this.stateLabel = function ()
					{
						if (this.subState())
						{
							this.SP_D2_Hit(null);
							return;
						}

						if (this.flag5.armSpeed >= 20,00000000.0)
						{
							this.flag5.armSpeed -= 20,00000000.0;
						}
						else
						{
							this.flag5.armSpeed = 0;
						}

						this.flag5.armRange += this.flag5.armSpeed;
						this.flag5.arm.Warp(this.x + this.flag5.armRange * this.direction, this.y);
						this.flag5.wireA.Warp(this.point1_x, this.y);
						this.flag5.wireB.Warp(this.point2_x, this.y);
						this.flag5.wireA.sx = this.abs(this.flag5.arm.point1_x - this.flag5.wireA.x) / 37,00000000.0;
						this.flag5.wireB.sx = this.abs(this.flag5.arm.point2_x - this.flag5.wireB.x) / 37,00000000.0;
						this.flag5.wireA.sx = this.abs(this.flag5.arm.point1_x - this.flag5.wireA.point1_x) / 37,00000000.0;

						if (this.count >= 10)
						{
							this.stateLabel = function ()
							{
								if (this.flag5.armRange >= 50,00000000.0)
								{
									this.flag5.armRange -= 50,00000000.0;
									this.flag5.arm.Warp(this.x + this.flag5.armRange * this.direction, this.y);
									this.flag5.wireA.Warp(this.point1_x, this.y);
									this.flag5.wireB.Warp(this.point2_x, this.y);
									this.flag5.wireA.sx = this.abs(this.flag5.arm.point1_x - this.flag5.wireA.x) / 37,00000000.0;
									this.flag5.wireB.sx = this.abs(this.flag5.arm.point2_x - this.flag5.wireB.x) / 37,00000000.0;

									if (this.flag5.wireA.sx <= 0,00000000.0)
									{
										this.flag5.wireA.func();
										this.flag5.wireA = null;
									}

									if (this.flag5.wireB.sx <= 0,00000000.0)
									{
										this.flag5.wireB.func();
										this.flag5.wireB = null;
									}
								}
								else
								{
									this.flag5.arm.func();

									if (this.flag5.wireA)
									{
										this.flag5.wireA.func();
									}

									if (this.flag5.wireB)
									{
										this.flag5.wireB.func();
									}

									this.SetMotion(3031, 2);
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
	];
	return true;
}

function SP_D2_Hit( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(3036, 0);
	::camera.shake_radius = 4,00000000.0;
	this.count = 0;
	this.stateLabel = function ()
	{
		if (this.flag5.armSpeed >= 10,00000000.0)
		{
			this.flag5.armSpeed -= 10,00000000.0;
		}

		this.flag5.armRange += this.flag5.armSpeed;
		this.flag5.arm.Warp(this.x + this.flag5.armRange * this.direction, this.y);
		this.target.Warp(this.flag5.arm.point0_x, this.flag5.arm.point0_y);
		this.flag5.wireA.Warp(this.point1_x, this.y);
		this.flag5.wireB.Warp(this.point2_x, this.y);
		this.flag5.wireA.sx = this.abs(this.flag5.arm.point1_x - this.flag5.wireA.x) / 37,00000000.0;
		this.flag5.wireB.sx = this.abs(this.flag5.arm.point2_x - this.flag5.wireB.x) / 37,00000000.0;

		if (this.count >= 30)
		{
			this.stateLabel = function ()
			{
				if (this.flag5.armRange >= 50,00000000.0)
				{
					this.flag5.armRange -= 50,00000000.0;
					this.flag5.arm.Warp(this.x + this.flag5.armRange * this.direction, this.y);
					this.target.Warp(this.flag5.arm.point0_x, this.flag5.arm.point0_y);
					this.flag5.wireA.Warp(this.point1_x, this.y);
					this.flag5.wireB.Warp(this.point2_x, this.y);
					this.flag5.wireA.sx = this.abs(this.flag5.arm.point1_x - this.flag5.wireA.x) / 37,00000000.0;
					this.flag5.wireB.sx = this.abs(this.flag5.arm.point2_x - this.flag5.wireB.x) / 37,00000000.0;

					if (this.flag5.wireA.sx <= 0,00000000.0)
					{
						this.flag5.wireA.func();
						this.flag5.wireA = null;
					}

					if (this.flag5.wireB.sx <= 0,00000000.0)
					{
						this.flag5.wireB.func();
						this.flag5.wireB = null;
					}
				}
				else
				{
					this.flag5.arm.func();

					if (this.flag5.wireA)
					{
						this.flag5.wireA.func();
					}

					if (this.flag5.wireB)
					{
						this.flag5.wireB.func();
					}

					local t_ = {};
					t_.fast <- true;
					this.SP_D_Hit(t_);
					return;
				}
			};
		}
	};
	return true;
}

function SP_E_Set( t )
{
	this.team.AddMP(-200, 120);
	this.SetSkillReset();
	local t_ = {};
	this.skillE_react = false;
	t_.preAutoCount <- 0;
	t_.autoCount <- -10;
	t_.autoAttack <- function ( table_ )
	{
		if (this.skillE_react)
		{
			return true;
		}

		return false;
	};
	t_.attackType <- 0;
	t_.autoTable <- t;
	t_.autoFunc <- function ( init_ )
	{
		if (this.SP_E_Init(init_))
		{
			return true;
		}
	};
	t_.timeFunc <- function ( init_ )
	{
		if (this.skillE_line)
		{
			this.skillE_line.func();
			this.skillE_line = null;
		}

		return true;
	};
	t_.invin <- false;
	t_.autoCancelLevel <- 100;
	this.AutoSkillSet(t_);

	if (this.centerStop * this.centerStop <= 1)
	{
		this.PlaySE(2442);
		local t2_ = {};
		t2_.rot <- 3,14159203.0;
		t2_.rotSpeed <- -0,01745329.0;
		this.skillE_line = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E, t2_).weakref();
	}
	else if (this.y <= this.centerY)
	{
		this.PlaySE(2442);
		local t2_ = {};
		t2_.rot <- 3,14159203.0;
		t2_.rotSpeed <- -0,01745329.0;
		this.skillE_line = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E, t2_).weakref();
	}
	else
	{
		this.PlaySE(2442);
		local t2_ = {};
		t2_.rot <- -3,14159203.0;
		t2_.rotSpeed <- 0,01745329.0;
		this.skillE_line = this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E, t2_).weakref();
	}

	return true;
}

function SP_E_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.SetMotion(3040, 0);
	this.flag1 = 0;
	this.keyAction = [
		function ()
		{
			this.count = 0;
		},
		function ()
		{
		}
	];
	return true;
}

function SP_F_Init( t )
{
	if (this.attackType[2] == 150)
	{
		this.CommonAutoAttackReset(2);
		local t_ = false;

		foreach( a in this.roseF )
		{
			if (a)
			{
				t_ = true;
				break;
			}
		}

		if (!t_)
		{
			return true;
		}

		this.SP_F_Bloom_Init(null);
		return true;
	}

	this.LabelClear();
	this.HitReset();
	this.hitResult = 1;
	this.team.AddMP(-200, 120);
	this.SetSkillReset();
	local t_ = {};
	t_.preAutoCount <- 0;
	t_.autoCount <- 300;
	t_.autoAttack <- function ( table_ )
	{
		return false;
	};
	t_.attackType <- 150;
	t_.autoTable <- t;
	t_.autoFunc <- function ( init_ )
	{
		return false;
	};
	t_.timeFunc <- function ( init_ )
	{
		if (this.SP_F_AutoBloom_Init(init_))
		{
			return true;
		}
	};
	t_.invin <- false;
	t_.autoCancelLevel <- 60;
	this.AutoSkillSet(t_);
	this.roseF = [];
	local g_ = [];
	local a_;

	for( local i = 0; i < 360; i = i + 15 )
	{
		local t_ = {};
		t_.rot <- i * 0,01745329.0;
		t_.vec <- 15,00000000.0;
		t_.ax <- 0,00000000.0;
		t_.ay <- 0,00000000.0;

		if (a_ == null)
		{
			a_ = this.SetShot(this.x, this.y, this.direction, this.SPShot_F, t_);
			local c_ = a_;
			this.roseF.append(c_.weakref());
		}
		else
		{
			local c_ = this.SetShot(this.x, this.y, this.direction, this.SPShot_F, t_);
			c_.hitOwner = a_;
			this.roseF.append(c_.weakref());
		}
	}

	return true;
}

function SP_F_Bloom_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3051, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(2446);

			foreach( a in this.roseF )
			{
				if (a != null)
				{
					a.func[0].call(a);
				}
			}

			this.roseF = [];
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
	this.stateLabel = function ()
	{
		this.CenterUpdate(0,10000000.0, null);

		if (this.centerStop * this.centerStop <= 1)
		{
			this.VX_Brake(0,20000000.0);
		}
	};
	return true;
}

function SP_F_AutoBloom_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(3052, 0);
	this.count = 0;
	this.flag1 = 0;
	this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
	this.keyAction = [
		function ()
		{
			this.hitResult = 1;
			this.PlaySE(2446);

			foreach( a in this.roseF )
			{
				if (a != null)
				{
					a.func[2].call(a);
				}
			}

			this.roseF = [];
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
			this.VX_Brake(0,20000000.0);
		}
	};
	return true;
}

function SP_G_Init( t )
{
	this.SetSkillReset();
	this.SP_G_Base(t);
	this.team.AddMP(-200, 120);
	this.SetMotion(3060, 0);
	return true;
}

function SP_G_Base( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag1 = 0;
	this.flag2 = false;
	this.flag3 = [];
	this.SetSpeed_XY(this.va.x * 0,00000000.0, this.va.y * 0,00000000.0);
	this.SetMotion(3060, 0);
	this.keyAction = [
		function ()
		{
			this.flag1 = this.y;
			this.SetSpeed_XY(12,50000000.0 * this.direction, -7,00000000.0);
			this.centerStop = -2;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(this.va.x * this.direction > 3,00000000.0 ? -0,40000001.0 * this.direction : 0,00000000.0, this.va.y < 0,00000000.0 ? 0,64999998.0 : 0,05000000.0);

				if (this.flag2 || !::battle.state == 8)
				{
					this.SetSkillReset();
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
					this.flag2 = false;
				}
			};
			local t_ = {};
			t_.autoCount <- 300;
			t_.autoAttack <- function ( table_ )
			{
				if (this.targetDist * this.direction >= 0,00000000.0 && this.abs(this.targetHeight) < 30,00000000.0)
				{
					return true;
				}

				return false;
			};
			t_.attackType <- 160;
			t_.preAutoCount <- 0;
			t_.autoTable <- t;
			t_.autoFunc <- function ( init_ )
			{
				this.SP_G_Loop(init_);
			};
			t_.timeFunc <- function ( init_ )
			{
				return true;
			};
			t_.autoCancelLevel <- 60;
			this.CommonAutoAttackSet(t_, 2);
		},
		function ()
		{
			local t_ = {};
			t_.keyTake <- 0;
			this.flag3.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_G, t_).weakref());
			this.PlaySE(2453);
		},
		function ()
		{
			local t_ = {};
			t_.keyTake <- 2;
			this.flag3.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_G, t_).weakref());
			this.PlaySE(2454);
			this.hitResult = 1;
		},
		function ()
		{
			if (this.flag3)
			{
				foreach( a in this.flag3 )
				{
					a.func();
				}

				this.flag3 = null;
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,40000001.0);

				if (this.y >= this.flag1 && this.keyTake >= 5)
				{
					this.Warp(this.x, this.flag1);

					if (this.y > this.centerY)
					{
						this.SetSpeed_XY(null, this.va.y * 0,25000000.0);
					}

					this.AjustCenterStop();
					this.EndtoFallLoop();
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
	};
	return true;
}

function SP_G_Loop( t )
{
	this.LabelClear();
	this.HitReset();
	this.count = 0;
	this.flag2 = false;
	this.flag3 = [];
	this.flag1 = this.y;
	this.SetSpeed_XY(12,50000000.0 * this.direction, -8,00000000.0);
	this.centerStop = -2;
	this.SetMotion(3061, 1);
	this.keyAction = [
		function ()
		{
		},
		function ()
		{
			local t_ = {};
			t_.keyTake <- 0;
			this.flag3.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_G, t_).weakref());
			this.PlaySE(2453);
		},
		function ()
		{
			local t_ = {};
			t_.keyTake <- 2;
			this.flag3.append(this.SetShot(this.x, this.y, this.direction, this.SPShot_G, t_).weakref());
			this.PlaySE(2454);
			this.hitResult = 1;
		},
		function ()
		{
			if (this.flag3)
			{
				foreach( a in this.flag3 )
				{
					a.func();
				}

				this.flag3 = null;
			}

			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,40000001.0);

				if (this.y >= this.flag1 && this.keyTake >= 5)
				{
					this.Warp(this.x, this.flag1);

					if (this.y > this.centerY)
					{
						this.SetSpeed_XY(null, this.va.y * 0,25000000.0);
					}

					this.AjustCenterStop();
					this.EndtoFallLoop();
					return;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(this.va.x * this.direction > 3,00000000.0 ? -0,40000001.0 * this.direction : 0,00000000.0, this.va.y < 0,00000000.0 ? 0,50000000.0 : 0,10000000.0);

		if (this.flag2 || !::battle.state == 8)
		{
			this.SetSkillReset();
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
			this.flag2 = false;
		}
	};

	if (this.autoCount[2] > 0)
	{
		local t_ = {};
		t_.autoCount <- this.autoCount[2];
		t_.autoAttack <- function ( table_ )
		{
			if (this.targetDist * this.direction >= 0,00000000.0 && this.abs(this.targetHeight) < 30,00000000.0 && this.autoCount[2])
			{
				return true;
			}

			return false;
		};
		t_.attackType <- 161;

		if (this.attackType[2] == 161)
		{
			t_.attackType <- 162;
		}

		t_.preAutoCount <- 0;
		t_.autoTable <- t;
		t_.autoFunc <- function ( init_ )
		{
			if (this.SP_G_Loop(init_))
			{
				return false;
			}
		};
		t_.timeFunc <- function ( init_ )
		{
			return true;
		};
		t_.autoCancelLevel <- 60;
		this.CommonAutoAttackSet(t_, 2);
	}

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
			this.PlaySE(2500);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.x, this.y, this.direction, this.SpellShot_A, t_);
			this.count = 0;
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				if (this.abs(this.targetDist) >= 50 && this.abs(this.targetDist) <= 600)
				{
					this.target.vf.x = (600 - this.abs(this.targetDist)) * (this.x > this.target.x ? 0,04000000.0 : -0,04000000.0);
				}
				else if (this.abs(this.targetDist) <= 75)
				{
					this.target.vf.x = 0,00000000.0;
				}

				if (this.count >= 150)
				{
					this.count = 0;
					this.SetMotion(this.motion, this.keyTake + 1);
					this.target.vf.x *= 0,25000000.0;
					this.stateLabel = function ()
					{
						if (this.count >= 30)
						{
							this.SetMotion(this.motion, this.keyTake + 1);
							this.stateLabel = null;
						}
					};
				}
			};
		}
	];
	return true;
}

function Spell_B_Init( t )
{
	this.LabelClear();
	this.HitReset();
	this.SetMotion(4010, 0);
	this.count = 0;
	this.flag1 = 0;
	this.flag5 = 0;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.AjustCenterStop();
	this.stateLabel = function ()
	{
	};
	this.keyAction = [
		function ()
		{
			this.UseSpellCard(60, -this.team.sp_max);
		},
		null,
		function ()
		{
			this.PlaySE(2502);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.SetFreeObject(this.x, this.y, this.direction, this.SpellShot_B, t_);
			this.count = 0;
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				if (this.abs(this.targetDist) <= 500)
				{
					this.target.vf.x = (500 - this.abs(this.targetDist)) * 0,10000000.0 * (this.targetDist >= 0,00000000.0 ? 1,00000000.0 : -1,00000000.0);
				}

				if (this.count >= 150)
				{
					this.count = 0;
					this.SetMotion(this.motion, this.keyTake + 1);
					this.stateLabel = function ()
					{
					};
				}
			};
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
			if (this.spellC_List.len() >= 2)
			{
				this.PlaySE(2506);
				this.team.spell_enable_end = false;

				foreach( a in this.spellC_List )
				{
					if (a)
					{
						a.func[1].call(a, this.atkRate_Pat);
					}
				}

				this.spellC_List = [];
			}
		},
		function ()
		{
			this.count = 0;
			this.hitResult = 1;
			this.stateLabel = function ()
			{
				if (this.count % 18 == 11)
				{
					this.PlaySE(2505);
				}

				if (this.count >= -18 + 36 * 2)
				{
					this.SetMotion(this.motion, 4);
					this.stateLabel = function ()
					{
					};
				}
			};
		}
	];
	return true;
}

function Spell_C_Func()
{
	if (this.spellC_List.len() > 0)
	{
		foreach( a in this.spellC_List )
		{
			a.func[0].call(a);
		}
	}

	this.spellC_List = [];
	this.PlaySE(2504);
	local t_ = {};
	t_.scale <- 1,00000000.0;
	t_.wait <- 0;
	this.spellC_List.append(this.SetShot(340, ::battle.scroll_bottom, 1,00000000.0, this.SpellShot_C, t_).weakref());
	local t_ = {};
	t_.scale <- 1,00000000.0;
	t_.wait <- 0;
	this.spellC_List.append(this.SetShot(940, ::battle.scroll_bottom, -1,00000000.0, this.SpellShot_C, t_).weakref());
	local t_ = {};
	t_.scale <- 1,20000005.0;
	t_.wait <- 15;
	this.spellC_List.append(this.SetShot(240, ::battle.scroll_bottom + 25, 1,00000000.0, this.SpellShot_C, t_).weakref());
	local t_ = {};
	t_.scale <- 1,20000005.0;
	t_.wait <- 15;
	this.spellC_List.append(this.SetShot(1040, ::battle.scroll_bottom + 25, -1,00000000.0, this.SpellShot_C, t_).weakref());
	local t_ = {};
	t_.scale <- 1,39999998.0;
	t_.wait <- 30;
	this.spellC_List.append(this.SetShot(110, ::battle.scroll_bottom + 50, 1,00000000.0, this.SpellShot_C, t_).weakref());
	local t_ = {};
	t_.scale <- 1,39999998.0;
	t_.wait <- 30;
	this.spellC_List.append(this.SetShot(1170, ::battle.scroll_bottom + 50, -1,00000000.0, this.SpellShot_C, t_).weakref());
	this.spellEndFunc = function ()
	{
		if (this.spellC_List.len() > 0)
		{
			foreach( a in this.spellC_List )
			{
				a.func[0].call(a);
			}
		}

		this.spellC_List = [];
	};
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
			this.UseClimaxSpell(60, "Åñç°Ç©ÇÁìdòbÇÇ∑ÇÈÇ©ÇÁèoÇ\x2500Ç\x2566Åñ");
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
			this.count = 0;
			this.PlaySE(2457);
			local t_ = {};
			t_.rate <- this.atkRate_Pat;
			this.flag1 = this.SetShot(this.point0_x, this.point0_y, this.direction, this.Climax_Shot, t_).weakref();
			this.flag1.SetParent(this, this.flag1.x - this.x, this.flag1.y - this.y);
			this.stateLabel = function ()
			{
				if (this.flag1 && this.flag1.hitResult & 1)
				{
					this.Spell_Climax_Hit(null);
					return;
				}
			};
		},
		function ()
		{
			this.stateLabel = null;
		}
	];
	return true;
}

function Spell_Climax_Hit( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 0);
	this.target.DamageGrab_Common(300, 0, this.target.direction);
	this.BackFadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 30);
	this.count = 0;
	::battle.enableTimeUp = false;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.stateLabel = function ()
	{
		if (this.count == 30)
		{
			this.FadeOut(0,00000000.0, 0,00000000.0, 0,00000000.0, 30);
		}

		if (this.count == 60)
		{
			this.target.DamageGrab_Common(308, 0, this.target.direction);
			this.SetMotion(4901, 1);
			this.x = 640;
			this.y = 360;
			this.target.x = this.x;
			this.target.y = this.y;
			this.EraceBackGround();
			::camera.SetTarget(this.x, this.y, 2,00000000.0, true);
		}

		if (this.count == 90)
		{
			this.FadeIn(0,00000000.0, 0,00000000.0, 0,00000000.0, 30);
			this.Spell_Climax_Hit2(null);
			return;
		}
	};
}

function Spell_Climax_Hit2( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4901, 1);
	this.count = 0;
	this.PlaySE(2459);
	this.flag5 = {};
	this.flag5.aura <- null;
	this.flag5.font <- null;
	this.flag5.shadow <- null;
	this.flag5.face <- null;
	this.flag5.black <- this.SetEffect(0, 0, 1,00000000.0, function ( t_ )
	{
		this.ConnectRenderSlot(::graphics.slot.info, 98);
		this.SetMotion(1101, 0);
		this.red = 0,00000000.0;
		this.blue = 0,00000000.0;
		this.green = 0,00000000.0;
		this.func = [
			function ()
			{
				this.Release();
			}
		];
	}, {}).weakref();
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = null;
	this.count = 45;
	this.stateLabel = function ()
	{
		if (this.count == 55)
		{
			this.PlaySE(2460);
			local t_ = {};
			t_.take <- 1;
			this.flag5.font = this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_Font, t_).weakref();
		}

		if (this.count == 100)
		{
			this.flag5.font.func[0].call(this.flag5.font);
			this.flag5.font = null;
			local t_ = {};
			t_.scale <- 1,00000000.0;
			this.flag5.shadow = this.SetFreeObject(640, 420, 1,00000000.0, this.Climax_Walk, t_).weakref();
			this.flag5.aura = this.SetCommonObjectDynamic(640, 360, 1,00000000.0, this.EF_Climax_MerryAura, {}).weakref();
		}

		if (this.count == 145)
		{
			this.PlaySE(2460);
			this.flag5.shadow.func[0].call(this.flag5.shadow);
			local t_ = {};
			t_.take <- 2;
			this.flag5.font = this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_Font, t_).weakref();
			this.flag5.aura.func[1].call(this.flag5.aura);
		}

		if (this.count == 190)
		{
			this.flag5.font.func[0].call(this.flag5.font);
			local t_ = {};
			t_.scale <- 2,00000000.0;
			this.flag5.shadow = this.SetFreeObject(640, 540, 1,00000000.0, this.Climax_Walk, t_).weakref();
			this.flag5.aura.func[2].call(this.flag5.aura, 1,20000005.0);
		}

		if (this.count == 235)
		{
			this.PlaySE(2460);
			this.flag5.shadow.func[0].call(this.flag5.shadow);
			local t_ = {};
			t_.take <- 3;
			this.flag5.font = this.SetFreeObject(0, 0, 1,00000000.0, this.Climax_Font, t_).weakref();
			this.flag5.aura.func[1].call(this.flag5.aura);
		}

		if (this.count == 280)
		{
			this.PlaySE(2461);
			this.flag5.font.func[2].call(this.flag5.font);
			this.flag5.face = this.SetFreeObject(1280, 0, 1,00000000.0, this.Climax_Face, {}).weakref();
			this.flag5.aura.func[0].call(this.flag5.aura);
		}

		if (this.count == 340)
		{
			this.FadeOut(1,00000000.0, 0,00000000.0, 0,00000000.0, 20);
		}

		if (this.count == 360)
		{
			this.flag5.black.func[0].call(this.flag5.black);
			this.flag5.face.func[0].call(this.flag5.face);
			this.Spell_Climax_Finish(null);
		}
	};
}

function EF_Climax_MerryAura( t )
{
	this.SetMotion(191, 10);
	this.alpha = 0,00000000.0;
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.DrawScreenActorPriority(99);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 128;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 256;
	this.anime.vertex_alpha0 = 0,00000000.0;
	this.anime.vertex_alpha1 = 1,00000000.0;
	this.anime.vertex_green0 = 0,00000000.0;
	this.anime.vertex_blue1 = 0,00000000.0;
	this.anime.vertex_red1 = 0,50000000.0;
	this.anime.vertex_green1 = 0,00000000.0;
	this.sx = this.sy = 1,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.isVisible = false;
		},
		function ( s_ )
		{
			this.sx = this.sy = s_;
			this.isVisible = true;
		}
	];
	this.stateLabel = function ()
	{
		this.alpha += 0,05000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		this.anime.top -= 1,00000000.0;
		this.anime.left += 0,10000000.0;
	};
}

function Spell_Climax_Finish( t )
{
	this.LabelReset();
	this.HitReset();
	this.SetMotion(4902, 0);
	this.KnockBackTarget(-this.direction);
	this.BackFadeIn(1,00000000.0, 0,00000000.0, 0,00000000.0, 15);
	this.FadeIn(1,00000000.0, 0,00000000.0, 0,00000000.0, 15);
	this.EraceBackGround(false);
	this.PlaySE(2463);
	this.x = 640;
	this.y = 360;
	this.target.x = this.x;
	this.target.y = this.y;
	::camera.SetTarget(640, 360, 2,00000000.0, true);
	::camera.ResetTarget();
	::graphics.ShowBackground(true);
	this.SetSpeed_XY(12,50000000.0 * this.direction, -6,00000000.0);
	this.centerStop = -3;
	this.count = 0;
	local t_ = {};
	t_.rate <- this.atkRate_Pat;
	this.flag1 = this.SetShot(this.target.x, this.target.y, this.direction, this.Climax_ShotB, t_).weakref();
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,25000000.0, 0,25000000.0);

		if (this.count >= 45)
		{
			this.SetMotion(4902, 2);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0,00000000.0, 0,25000000.0);

				if (this.y > this.centerY)
				{
					::battle.enableTimeUp = true;
					this.SetMotion(4902, 4);
					this.SetSpeed_XY(this.va.x * 0,50000000.0, this.va.y * 0,25000000.0);
					this.centerStop = 2;
					this.stateLabel = function ()
					{
						this.VX_Brake(0,25000000.0);
					};
				}
			};
		}
	};
}

