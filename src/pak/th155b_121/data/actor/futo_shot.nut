function Dish_Guage_Back( t )
{
	this.SetMotion(9041, 0);
	this.EnableTimeStop(false);
	this.ConnectRenderSlot(::graphics.slot.status, 100);
	this.flag1 = this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Dish_Guage_Line, {});
	this.flag4 = this.Vector3();
	this.flag5 = this.Vector3();
	this.flag5.x = this.x;
	this.flag5.y = this.y;
	::battle.gauge.mat_left_bottom.GetTranslation(this.flag4);
	this.y = this.flag5.y + this.flag4.y;
	this.Warp(this.x, this.y + 512);
	this.func = [
		function ()
		{
			::battle.DeleteTask(this.flag3);

			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}
		},
		function ( val_ )
		{
			if (val_ == 9)
			{
			}
			else if (val_ == 10)
			{
			}
			else
			{
			}

			this.flag1.anime.width = 24 * val_;
			this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.Dish_Guage_Flash, {});
		},
		function ( visible_ )
		{
			if (this.flag1)
			{
				this.flag1.isVisible = visible_;
			}

			this.isVisible = visible_;
		}
	];
	this.flag3 = {};
	this.flag3.actor <- this.weakref();
	this.flag3.Update <- function ()
	{
		if (this.actor)
		{
			::battle.gauge.mat_left_bottom.GetTranslation(this.actor.flag4);
			this.actor.Warp(this.actor.x, this.actor.flag5.y + this.actor.flag4.y);
		}
	};
	::battle.AddTask(this.flag3);
}

function Dish_Guage_Line( t )
{
	this.SetMotion(9041, 1);
	this.EnableTimeStop(false);
	this.ConnectRenderSlot(::graphics.slot.status, 100);
	this.flag4 = this.Vector3();
	this.flag5 = this.Vector3();
	this.flag5.x = this.x;
	this.flag5.y = this.y;
	this.Warp(this.x, this.y + 512);
	this.anime.width = 0;
	this.anime.top = 0;
	this.anime.height = 8;
	this.anime.left = 0;
	this.anime.center_x = 12;
	this.anime.center_y = 4;
	this.func = [
		function ()
		{
			::battle.DeleteTask(this.flag3);
			this.ReleaseActor();
		}
	];
	this.flag3 = {};
	this.flag3.actor <- this.weakref();
	this.flag3.Update <- function ()
	{
		if (this.actor)
		{
			::battle.gauge.mat_left_bottom.GetTranslation(this.actor.flag4);
			this.actor.Warp(this.actor.x, this.actor.flag5.y + this.actor.flag4.y);
		}
	};
	::battle.AddTask(this.flag3);
}

function Dish_Guage_Flash( t )
{
	this.SetMotion(9041, 4);
	this.EnableTimeStop(false);
	this.ConnectRenderSlot(::graphics.slot.status, 100);
	this.anime.width = this.owner.brokenDish * 24;
	this.anime.top = 0;
	this.anime.height = 8;
	this.anime.left = 0;
	this.anime.center_x = 12;
	this.anime.center_y = 4;
	this.stateLabel = function ()
	{
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Dish_LevelUP( t )
{
	this.PlaySE(1989);
	this.SetMotion(5999, 0);
	this.keyAction = this.ReleaseActor;
}

function DishAura( t )
{
	this.SetMotion(2005, 0);
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = (-70 - this.rand() % 6) * 0.01745329;
	this.ry = (10 - this.rand() % 21) * 0.01745329;
	this.sx = this.sy = 0.60000002 + this.rand() % 21 * 0.01000000;
	this.flag1 = (2.00000000 + this.rand() % 3) * 0.01745329;
	this.flag2 = 0.02500000 + this.rand() % 25 * 0.00100000;
	this.SetSpeed_XY(0.00000000, -0.10000000);
	this.alpha = 0.00000000;

	if (t.type == 1.00000000)
	{
		this.blue = 0.00000000;
		this.green = 0.25000000;
	}
	else
	{
		this.red = 0.00000000;
		this.green = 0.25000000;
	}

	this.subState = function ()
	{
		this.alpha += 0.07500000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = 1.00000000;
			this.subState = function ()
			{
				this.alpha -= this.flag2;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.00750000;
		this.rz += this.flag1;
		this.subState();
	};
}

function SetDish( t, dubble_ = false )
{
	if (dubble_)
	{
		this.SetMotion(2007, t);
	}
	else
	{
		this.SetMotion(2006, t);
	}

	this.func = function ()
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.BreakDish, {});
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 7 == 1)
		{
			local t_ = {};
			t_.type <- this.team.index;
			this.SetFreeObject(this.x, this.y, this.direction, this.DishAura, t_);
		}

		local moveC_ = false;

		if (this.x > 1200 || this.x < 80)
		{
			local x_ = 1180;

			if (this.x < 80)
			{
				x_ = 100;
			}

			this.SetSpeed_XY((x_ - this.x) * 0.10000000, this.va.y);
			moveC_ = true;
		}

		if (this.y > ::battle.corner_bottom - 80 || this.y < ::battle.scroll_top + 80)
		{
			local y_ = ::battle.corner_bottom - 100;

			if (this.y < ::battle.scroll_top + 100)
			{
				y_ = ::battle.scroll_top + 100;
			}

			this.SetSpeed_XY(this.va.x, (y_ - this.y) * 0.10000000);
			moveC_ = true;
		}

		this.Vec_Brake(1.00000000);
		this.sx = this.sy += (1.00000000 - this.sx) * 0.10000000;
	};

	if (this in this.owner.dish)
	{
		return false;
	}

	this.owner.dish.append(this.weakref());

	while (this.owner.dish.len() >= 6)
	{
		this.owner.dish[0].func.call(this.owner.dish[0]);
		this.owner.dish.remove(0);
	}
}

function DelDish( t = null )
{
	for( local i = 0; i < this.owner.dish.len(); i++ )
	{
		if (this.owner.dish[i])
		{
			if (this.owner.dish[i] == this)
			{
				this.owner.dish.remove(i);

				if (this.motion == 2007)
				{
					return 2;
				}
				else
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

function BreakDish( t )
{
	this.SetMotion(2008, 0);
	this.stateLabel = function ()
	{
		if (this.count <= 3)
		{
			for( local c_ = 0; c_ < 2;  )
			{
				c_++;
				this.SetFreeObject(this.x, this.y, this.direction, this.BreakDishParticle, {});
			}
		}

		this.count++;
		this.sx = this.sy *= 0.99000001;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function BreakDishParticle( t )
{
	this.SetMotion(2008, 1);
	this.SetSpeed_Vec(5 + this.rand() % 4, this.rand() % 360 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.94999999;
		this.alpha -= 0.02500000;
		this.AddSpeed_XY(0.00000000, 0.30000001);
		this.VX_Brake(0.01000000);

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function BreakDishCount( t_ = 1 )
{
	this.owner.brokenDish += t_;

	if (this.owner.brokenDish > 10)
	{
		this.owner.brokenDish = 10;
	}

	this.owner.dish_guage.func[1].call(this.owner.dish_guage, this.owner.brokenDish);
}

function SetDish_Point( t )
{
	this.SetMotion(2019, 3);
	this.owner.SetDish.call(this, this.keyTake, false);
}

function DashLow_Dish( t )
{
	this.SetMotion(2006, this.owner.dishLevel);
	this.flag1 = 0;
	this.func = [
		function ()
		{
			this.PlaySE(1899);
			this.SetFreeObject(this.x, this.y, this.direction, this.BreakDish, {});
			this.ReleaseActor();
			return;
		},
		function ( t_ )
		{
			local wx_ = this.x;
			local wy_ = this.y;

			if (wx_ > ::battle.corner_right - 40)
			{
				wx_ = ::battle.corner_right - 40;
			}

			if (wx_ < ::battle.corner_left + 40)
			{
				wx_ = ::battle.corner_left + 40;
			}

			if (wy_ > ::battle.corner_bottom - 40)
			{
				wy_ = ::battle.corner_bottom - 40;
			}

			if (wy_ < ::battle.corner_top + 40)
			{
				wy_ = ::battle.corner_top + 40;
			}

			this.Warp(wx_, wy_);
			this.owner.SetDish.call(this, this.keyTake, false);
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 1300)
		{
			if (this.owner.keyTake >= 2)
			{
				if (this.owner.hitResult)
				{
					if (this.owner.hitResult & 1)
					{
						this.flag1 = true;
					}

					this.func[1].call(this, null);
				}
				else
				{
					this.func[0].call(this);
				}

				return;
			}
			else
			{
				this.Warp(this.owner.point0_x, this.owner.point0_y);
				this.count++;

				if (this.count % 2 == 1)
				{
					local t_ = {};
					t_.scale <- 1.00000000;
					this.SetFreeObject(this.x, this.y, this.direction, this.NormalShot_Spin, t_, this.weakref());
				}
			}
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function Grab_Cyclone( t )
{
	this.SetMotion(1809, 1);
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.SetKeyFrame(1);
	};
	this.keyAction = this.ReleaseActor;
}

function NormalShot( t )
{
	this.SetMotion(2009, 4);
	this.atk_id = 16384;
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.sx = this.sy = 0.00000000;
	this.SetParent(this.owner, this.x - this.owner.x, this.y - this.owner.y);
	this.flag1 = 0.10000000;
	this.func = [
		function ()
		{
			this.PlaySE(1899);
			this.SetFreeObject(this.x, this.y, this.direction, this.BreakDish, {});
			this.ReleaseActor();
			return;
		},
		function ()
		{
			this.SetParent(null, 0, 0);
			this.sx = this.sy = 1.00000000;
			this.cancelCount = 3;
			this.SetMotion(this.motion, this.keyTake + 5);
			this.SetSpeed_Vec(this.initTable.v, this.initTable.rot, this.direction);
			this.stateLabel = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 5))
				{
					this.ReleaseActor();
					return true;
				}

				if (this.hitCount > 0)
				{
					this.owner.SetDish.call(this, this.keyTake - 5, false);
					return;
				}

				if (this.grazeCount >= 5 || this.cancelCount <= 0)
				{
					this.func[0].call(this);
					return;
				}

				this.HitCycleUpdate(5);
				this.count++;

				if (this.count % 2 == 1)
				{
					local t_ = {};
					t_.scale <- 1.00000000;
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.NormalShot_Spin, t_, this.weakref());
					a_.SetParent(this, 0, 0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.20000000;

		if (this.count % 5 == 1)
		{
			local t_ = {};
			t_.scale <- 1.00000000;
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.NormalShot_Spin, t_);
			a_.SetParent(this, 0, 0);
		}
	};
}

function NormalShotSub( t )
{
	this.SetMotion(2009, t.type + 5);
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.SetSpeed_Vec(this.initTable.v * 0.20000000, this.initTable.rot, this.direction);
	this.flag1 = 0.20000000;
	this.func = [
		function ()
		{
			this.PlaySE(1899);
			this.SetFreeObject(this.x, this.y, this.direction, this.BreakDish, {});
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 || this.grazeCount > 0 || this.cancelCount <= 0)
		{
			if (this.hitResult & 1)
			{
				this.owner.BreakDishCount.call(this);
			}

			this.func[0].call(this);
			return;
		}

		if (this.flag1 < 1.00000000)
		{
			this.flag1 += 0.20000000;
			this.SetSpeed_Vec(this.initTable.v * this.flag1, this.initTable.rot, this.direction);
		}
	};
}

function NormalShot_Spin( t )
{
	this.SetMotion(2009, 10);
	this.sx = this.sy = (0.75000000 + this.rand() % 5 * 0.10000000) * t.scale;
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = -70 * 0.01745329;
	this.ry = (-20 + this.rand() % 41) * 0.01745329;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.05000000;
		this.rz -= 14.00000000 * 0.01745329;
		this.alpha -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function FrontShot_Spin( t )
{
	this.SetMotion(2019, 11);
	this.sx = this.sy = 0.25000000 * t.scale;
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = -70 * 0.01745329;
	this.ry = (-30 + this.rand() % 61) * 0.01745329;
	this.alpha = 2.00000000;
	this.SetSpeed_XY(0.00000000, 2.00000000);
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.50000000);
		this.sx = this.sy += (3.00000000 * this.initTable.scale - this.sx) * 0.07500000;
		this.rz -= 10.00000000 * 0.01745329;
		this.alpha -= 0.07500000;

		if (this.alpha <= 1.00000000)
		{
			this.green = this.blue = this.alpha;
		}

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 3);
	this.keyAction = function ()
	{
		this.ReleaseActor();
	};
	this.cancelCount = 3;
	this.atk_id = 65536;
	this.flag1 = {};
	this.flag1.rot <- 0.00000000;
	this.flag2 = 3;
	this.flag3 = 0;
	this.flag4 = 20.00000000;
	this.flag5 = 0.00000000;
	this.func = [
		function ()
		{
			this.cancelCount = 3;
			this.SetMotion(this.motion, this.keyTake + 5);
			this.flag5 = this.GetTargetAngle(this.target, this.direction);
			this.flag5 = this.Math_MinMax(this.flag5, -15.00000000 * 0.01745329, 15.00000000 * 0.01745329);
			this.SetSpeed_Vec(20.00000000, this.flag5, this.direction);
			this.stateLabel = function ()
			{
				if (this.life <= 0 || this.IsScreen(100.00000000) || this.Damage_ConvertOP(this.x, this.y, 8))
				{
					this.func[1].call(this);
					return;
				}

				if (this.cancelCount <= 0)
				{
					this.owner.SetDish.call(this, this.keyTake - 5, false);
					return;
				}

				if (this.hitCount <= this.flag2)
				{
					this.HitCycleUpdate(1);
				}

				this.Vec_Brake(0.50000000);

				if (this.va.LengthXY() <= 0.50000000)
				{
					this.owner.SetDish.call(this, this.keyTake - 5, false);
					return;
				}

				if (this.IsWall(0.00000000) == this.direction && this.va.x * this.direction > 0)
				{
					if (this.flag3 == 0)
					{
						this.flag3 = 1;
					}

					this.SetSpeed_XY(-this.va.x, this.va.y);
				}

				if (this.flag3 == 0 && (this.grazeCount > 0 || this.hitCount > this.flag2))
				{
					this.flag3 = 1;
				}

				if (this.flag3 > 0)
				{
					this.flag3++;
				}

				if (this.flag3 >= 3 && this.hitResult == 0)
				{
					this.callbackGroup = 0;
				}

				this.count++;

				if (this.count % 2 == 1 && this.flag3 <= 0)
				{
					local t_ = {};
					t_.scale <- 1.00000000;
					local a_ = this.SetFreeObject(this.x, this.y, this.direction, this.FrontShot_Spin, t_, this.weakref());
					a_.SetParent(this, 0, 0);
				}

				if (this.count % 3 == 0 && this.flag3 <= 0)
				{
					this.SetFreeObject(this.x - 25 * this.rand() % 50, this.y + 12 - this.rand() % 25, this.direction, this.SPShot_E_Trail, {});
				}
			};
		},
		function ()
		{
			this.PlaySE(1899);
			this.SetFreeObject(this.x, this.y, this.direction, this.BreakDish, {});
			this.ReleaseActor();
			return;
		}
	];
	this.life = 1;
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2010 && this.owner.keyTake <= 2)
		{
			this.Warp(this.owner.point0_x + 75 * this.cos(this.flag1.rot) * this.direction, this.owner.point0_y + 75.00000000 * this.sin(this.flag1.rot));
		}
		else
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2027, 0);
	this.SetSpeed_Vec(1.00000000, t.rot, this.direction);
	this.cancelCount = 1;
	this.atk_id = 262144;
	this.flag1 = this.Vector3();
	this.func = [
		function ()
		{
			this.SetMotion(2027, 2);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.alpha = 2.00000000;
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;
				this.sx = this.sy *= 0.94000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.keyAction = [
		function ()
		{
			local r_ = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
			this.SetSpeed_Vec(1.00000000, r_, this.direction);
			this.flag1.x = this.va.x * 0.50000000;
			this.flag1.y = this.va.y * 0.50000000;
			this.subState = function ()
			{
				this.count++;
				this.AddSpeed_XY(this.flag1.x, this.flag1.y);

				if (this.count >= 30)
				{
					this.subState = function ()
					{
					};
				}
			};
		},
		this.func[0]
	];
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage() || this.hitCount + this.grazeCount > 0 || this.cancelCount <= 0 || this.IsScreen(75))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Shot_Barrage_Option( t )
{
	this.SetMotion(2027, 2);
	this.alpha = 0.00000000;
	this.subState = function ()
	{
		this.alpha += 0.20000000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = 1.00000000;
			this.subState = function ()
			{
			};
		}
	};
	this.flag1 = this.Vector3();
	this.flag1.x = 90.00000000;
	this.flag1.RotateByDegree(t.rot);
	this.func = [
		function ()
		{
			this.SetMotion(2027, 2);
			this.alpha = 2.00000000;
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;
				this.sx = this.sy *= 0.94000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			local t_ = {};
			t_.rot <- this.initTable.rot;
			this.SetShot(this.x, this.y, this.direction, this.Shot_Barrage, t_);
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion != 2025)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
		this.flag1.RotateByRadian(0.05235988);
		this.initTable.rot += 0.05235988;
		this.SetSpeed_XY(this.flag1.x + this.owner.x - this.x, this.flag1.y + this.owner.y - this.y);
	};
}

function Shot_ChargeVortex( t )
{
	this.flag5 = {};
	this.flag5.graze <- 1;
	this.flag5.hit <- 4;

	if (t.charge)
	{
		this.SetMotion(2028, 1);
		this.flag2 = 1.50000000;
		this.cancelCount = 12;
		this.flag5.graze = 30;
		this.flag5.hit = 10;
		this.stateLabel = function ()
		{
			this.count++;
			this.rz = 7.00000000 * this.sin(this.count * 6 * 0.01745329) * 0.01745329;
			this.sx = this.sy += (this.flag2 - this.sx) * 0.15000001;
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
			this.HitCycleUpdate(5);

			if (this.hitCount >= this.flag5.hit || this.grazeCount >= this.flag5.graze || this.cancelCount <= 0)
			{
				this.func[0].call(this);
			}
		};
	}
	else
	{
		this.SetMotion(2029, 3);
		this.flag2 = 0.75000000;
		this.cancelCount = 3;
		this.stateLabel = function ()
		{
			this.count++;
			this.rz = 7.00000000 * this.sin(this.count * 6 * 0.01745329) * 0.01745329;
			this.sx = this.sy += (this.flag2 - this.sx) * 0.15000001;
			this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

			if (this.hitResult & 8)
			{
				this.HitCycleUpdate(2);
			}
			else
			{
				this.HitCycleUpdate(5);
			}

			if (this.hitCount >= this.flag5.hit || this.grazeCount >= this.flag5.graze || this.cancelCount <= 0)
			{
				this.func[0].call(this);
			}
		};
	}

	this.atk_id = 131072;
	this.sx = this.sy = 0.25000000;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.flag3 = true;
	this.func = [
		function ()
		{
			this.cancelCount = 0;
			this.flag3 = false;
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha = this.red = this.green = this.blue -= 0.07500000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	return true;
}

function Shot_ChargeRoot( t )
{
	this.SetMotion(2029, 0);
	this.sx = this.sy = 0.10000000;
	this.cancelCount = 3;
	this.atk_id = 131072;
	this.flag1 = null;
	this.flag3 = false;
	this.flag4 = this.Vector3();
	this.flag4.x = 15.00000000;
	this.flag4.RotateByRadian(t.rot);
	this.flag5 = {};
	this.flag5.v <- this.Vector3();
	this.flag5.v.y = 4.00000000;
	this.flag5.v2 <- this.Vector3();
	this.flag5.v2.x = 5.00000000;
	this.flag5.v2.RotateByRadian(t.rot);
	this.flag5.dishV <- 1.00000000;
	this.flag5.wait <- 180;
	this.flag5.dish <- false;

	if (t.charge)
	{
		this.flag5.dishV = 1.50000000;
		this.flag5.wait = 210;
	}

	this.SetSpeed_XY(this.flag4.x * this.direction, this.flag4.y);
	this.func = [
		function ()
		{
			if (this.flag1)
			{
				this.flag1.func[0].call(this.flag1);
			}

			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0.89999998, this.va.y * 0.89999998);
				this.sx = this.sy += 0.25000000;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			if (!this.flag3)
			{
				this.flag3 = true;
				local t_ = {};
				t_.charge <- this.initTable.charge;
				this.flag1 = this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeVortex, t_).weakref();
				this.SetParent.call(this.flag1, this, 0, 0);
			}

			this.subState = function ()
			{
				if (!this.flag1 || !this.flag1.flag3)
				{
					this.func[0].call(this);
					return;
				}

				foreach( a in this.owner.dish )
				{
					if (this.abs(this.x - a.x) <= 100.00000000 && this.abs(this.y - a.y) <= 50)
					{
						this.flag5.dish = true;
						this.owner.BreakDishCount.call(a, this.owner.DelDish.call(a));
						a.ReleaseActor();
						this.func[2].call(this);

						if (this.flag1 && this.flag1.cancelCount > 0)
						{
							this.flag1.cancelCount += 3;
						}

						local t_ = {};
						t_.rot <- this.rz;
						this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
						{
							this.SetMotion(6060, 0);
							this.rz = t_.rot;
							this.stateLabel = function ()
							{
								this.sx += 0.10000000;
								this.sy += 0.20000000;
								this.alpha -= 0.02500000;

								if (this.alpha <= 0.00000000)
								{
									this.ReleaseActor();
								}
							};
						}, t_);
					}
					else
					{
						local v_ = this.Vector3();
						v_.x = this.x - a.x;
						v_.y = this.y - a.y;
						v_.Normalize();

						if (v_.x && v_.y)
						{
							a.AddSpeed_XY(v_.x * this.flag5.dishV, v_.y * this.flag5.dishV);
						}
					}
				}
			};
		},
		function ()
		{
			this.PlaySE(1966);

			if (this.flag1)
			{
				this.flag1.flag2 += 0.25000000;
			}
		}
	];
	this.subState = function ()
	{
	};
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		if (this.owner.motion == 2020 && this.owner.keyTake == 0 || !this.initTable.charge && this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.func[0].call(this);
			return;
		}

		if (this.initTable.charge)
		{
			this.flag5.v2.Mul(0.98000002);
		}
		else
		{
			this.flag5.v2.x += (5.00000000 - this.flag5.v2.x) * 0.05000000;
		}

		this.flag4.x += (this.flag5.v2.x - this.flag4.x) * 0.10000000;
		this.flag4.y += (this.flag5.v2.y - this.flag4.y) * 0.10000000;
		this.flag5.v.RotateByDegree(4);
		this.SetSpeed_XY((this.flag4.x + this.flag5.v.x) * this.direction, this.flag4.y + this.flag5.v.y * 0.75000000);

		if (this.initTable.charge)
		{
			this.sx = this.sy += (1.50000000 + 0.25000000 * this.sin(this.count * 6 * 0.01745329) - this.sx) * 0.05000000;
		}
		else
		{
			this.sx = this.sy += (1.00000000 + 0.25000000 * this.sin(this.count * 6 * 0.01745329) - this.sx) * 0.05000000;
		}

		this.count++;
		this.rz = 10 * this.sin(this.count * 12 * 0.01745329) * 0.01745329;

		if (this.count >= this.flag5.wait || this.IsScreen(300))
		{
			this.func[0].call(this);
			return;
		}

		if (this.flag5.dish && this.count % 3 == 1)
		{
			local a_ = this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
			{
				this.SetMotion(2029, 2);
				this.rz = this.rand() % 360 * 0.01745329;
				this.sx = this.sy = (5.00000000 + this.rand() % 75 * 0.01000000) * (1.00000000 + this.flag4);
				this.alpha = 0.00000000;
				this.rx = (65 + this.rand() % 10) * 0.01745329 * this.direction;
				this.ry = (-70 + this.rand() % 10) * 0.01745329;
				this.stateLabel = function ()
				{
					this.sx = this.sy *= 0.92500001;
					this.rz -= 15.00000000 * 0.01745329;

					if (this.sx < 2.00000000)
					{
						this.alpha -= 0.20000000;

						if (this.alpha <= 0.00000000)
						{
							this.ReleaseActor();
						}
					}
					else
					{
						this.alpha += 0.20000000;

						if (this.alpha > 1.00000000)
						{
							this.alpha = 1.00000000;
						}
					}
				};
			}, {});
			a_.SetParent(this, 0, 0);
		}

		this.subState();
	};
	return true;
}

function Shot_Okult( t )
{
	this.atk_id = 524288;
	this.atkRate_Pat = 1.00000000 + 0.05000000 * this.owner.brokenDish;

	if (this.owner.brokenDish == 9)
	{
		this.flag1 = true;

		if (this.owner.okltBall <= 1)
		{
			this.SetMotion(2508, 0);
		}
		else if (this.owner.okltBall >= 4 || this.owner.occultBoost)
		{
			this.SetMotion(2508, 2);
		}
		else
		{
			this.SetMotion(2508, 1);
		}
	}
	else if (this.owner.okltBall <= 1)
	{
		this.SetMotion(2509, 0);
	}
	else if (this.owner.okltBall >= 4 || this.owner.occultBoost)
	{
		this.SetMotion(2509, 2);
	}
	else
	{
		this.SetMotion(2509, 1);
	}

	this.SetSpeed_Vec(0.50000000, -60 * 0.01745329, this.direction);
	this.func = function ()
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultSmokeB, {});
		this.SetMotion(2507, 2);
		this.SetSpeed_XY(-3.00000000 * this.direction, -9.00000000);
		this.stateLabel = function ()
		{
			this.rz -= 12.00000000 * 0.01745329;
			this.AddSpeed_XY(0.00000000, 0.60000002);
			this.alpha -= 0.02500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.keyAction = this.func;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultSmoke, {});
	this.stateLabel = function ()
	{
		if (this.owner.IsDamage())
		{
			this.func();
			return;
		}

		if (this.flag1 && this.hitResult & 1)
		{
			if (this.flag1)
			{
				::camera.shake_radius = 10.00000000;
			}

			this.hitStopTime = 19;
			local t_ = {};
			t_.count <- 30;
			t_.priority <- 520;
			this.SetEffect(640, 360, 1.00000000, this.EF_SpeedLine, t_);
			this.flag1 = null;
		}

		this.Vec_Brake(3.00000000, 0.25000000);
	};
}

function Shot_OkultSmoke( t )
{
	this.SetMotion(2507, 0);

	if (this.owner.brokenDish == 9)
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.Shot_OkultSmokeB, {});
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy += (2.50000000 - this.sx) * 0.10000000;
		this.alpha -= 0.03300000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_OkultSmokeB( t )
{
	this.SetMotion(2507, 1);
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.25000000 - this.sx) * 0.05000000;
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Change( t )
{
	if (t.type == true)
	{
		this.SetMotion(3929, 4);
	}
	else
	{
		this.SetMotion(3929, 1);
	}

	this.atk_id = 536870912;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.cancelCount = 3;
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(3929, 2);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.keyAction = this.func[0];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount > 0 && this.keyTake == 4)
		{
			this.owner.SetDish.call(this, 4, false);
			return;
		}

		if (this.grazeCount >= 1 || this.cancelCount <= 0 || this.hitCount > 0)
		{
			this.func[0].call(this);
			return;
		}

		this.count++;
	};
}

function SPShot_A( t )
{
	this.flag1 = this.owner.DelDish.call(this);
	this.SetMotion(6000, 0);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.func = [
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.BreakDish, {});
			this.owner.BreakDishCount(this.flag1);
			this.PlaySE(1899);
			this.ReleaseActor();
			return;
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion == 3000)
		{
			if (this.owner.keyTake == 3)
			{
				this.Warp(this.owner.point0_x, this.owner.point0_y);
			}
			else
			{
				this.func[0].call(this);
			}
		}
		else
		{
			this.func[0].call(this);
			return;
		}
	};
}

function SPShot_A_Spin( t )
{
	this.SetMotion(6000, 2);
	this.sx = this.sy = 1.50000000 + this.rand() % 5 * 0.10000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.rx = -80 * 0.01745329;
	this.ry = (-20 + this.rand() % 41) * 0.01745329;
	this.flag1 = 50;
	this.flag2 = true;
	this.flag3 = 0.34999999;
	this.stateLabel = function ()
	{
		if (this.owner.motion >= 3000 && this.owner.motion <= 3002 && this.owner.keyTake >= 3)
		{
		}
		else
		{
			this.flag2 = false;
		}

		this.flag1 -= 8;

		if (this.flag2)
		{
			this.Warp(this.owner.x, this.owner.y + this.flag1);
		}

		this.sx = this.sy += this.flag3;
		this.flag3 *= 0.92000002;
		this.rz -= 18.00000000 * 0.01745329;
		this.alpha -= 0.07500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_A_Tornade( t )
{
	this.SetMotion(3009, t.type);
	this.sx = this.sy = 0.00000000;
	this.flag1 = true;
	this.cancelCount = 3;
	this.atk_id = 1048576;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx += 0.05000000;
			this.sy *= 0.92000002;
			this.alpha -= 0.07500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.20000000;
		this.count++;

		if (this.hitCount < 10)
		{
			this.HitCycleUpdate(5);
		}

		if (this.sx > 1.00000000)
		{
			this.sx = this.sy = 1.00000000;
		}

		if (this.owner.motion >= 3000 && this.owner.motion <= 3002 && this.owner.keyTake == 3)
		{
		}
		else if (this.flag1)
		{
			this.flag1 = false;
			this.SetSpeed_XY(0.00000000, -5.00000000);
		}

		if (this.cancelCount <= 0 || this.grazeCount >= 10 || this.count >= 60 || this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.func.call(this);
		}

		if (this.flag1)
		{
			this.Warp(this.owner.x, this.owner.y);
		}
		else
		{
			this.VY_Brake(0.15000001);
		}
	};
}

function SPShot_A_TornadeB( t )
{
	this.SetMotion(6000, 5);
	this.sx = this.sy = 0.00000000;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx += 0.05000000;
			this.sy *= 0.92000002;
			this.alpha -= 0.17500000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0.20000000;

		if (this.sx > 1.00000000)
		{
			this.sx = this.sy = 1.00000000;
		}

		if (this.owner.motion >= 3000 && this.owner.motion <= 3002)
		{
			if (this.owner.keyTake == 2)
			{
				this.Warp(this.owner.x, this.owner.y);
			}
			else
			{
				this.func();
			}
		}
		else
		{
			this.func();
		}
	};
}

function SPShot_B( t )
{
	this.SetMotion(6010, 0);
	this.flag1 = -1;
	this.flag2 = -1;
	this.flag3 = null;
	this.flag4 = this.Vector3();
	this.flag5 = this.SetTrail(this.motion, 2, 15, 20);
	this.flag5.red = 0.00000000;
	this.flag5.green = 0.25000000;
	this.cancelCount = 3;
	this.atk_id = 2097152;
	local i_ = 0;
	local target_;

	for( local i = 0; i < this.owner.dish.len(); i++ )
	{
		local a_ = this.owner.dish[i];
		local x_ = (a_.x - this.x) * this.direction;

		if (x_ <= 0)
		{
			  // [072]  OP_JMP            0     19    0    0
		}
		else if (this.flag1 < 0 || x_ < this.flag1)
		{
			this.flag1 = x_;
			this.flag2 = i;
			this.flag3 = a_.weakref();
		}
	}

	if (this.flag2 >= 0)
	{
		local angle_ = this.Math_ShotPath(30, 1.00000000, this, this.owner.dish[this.flag2]);

		if (angle_)
		{
			if (angle_.len() == 1)
			{
				target_ = angle_[0];
			}
			else if (angle_[0] > angle_[1])
			{
				target_ = angle_[0];
			}
			else
			{
				target_ = angle_[1];
			}

			this.flag4.x = this.owner.dish[this.flag2].x;
			this.flag4.y = this.owner.dish[this.flag2].y;
			this.rz = this.atan2(this.va.y, this.va.x * this.direction);
		}
		else
		{
			this.rz = t.rot;
		}

		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
		this.SetSpeed_Vec(30.00000000, this.rz, this.direction);
	}
	else
	{
		this.rz = t.rot;
		this.SetSpeed_Vec(30.00000000, this.rz, this.direction);
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	}

	if (target_)
	{
		this.rz = -this.atan(target_);
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
		this.SetSpeed_Vec(30.00000000, this.rz, this.direction);
	}

	this.subState = function ()
	{
		if (this.y >= ::battle.scroll_bottom + 300 || this.cancelCount <= 0 || this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.func[1].call(this);
			return true;
		}

		return false;
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.AddSpeed_XY(0.00000000, 1.00000000);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);

		if (this.va.y > 0)
		{
			if (this.abs(this.x - this.flag4.x) <= 50.00000000 && this.abs(this.y - this.flag4.y) <= 50.00000000)
			{
				foreach( a in this.owner.dish )
				{
					if (this.flag3 == a)
					{
						this.func[0].call(this);
						break;
					}
				}
			}
		}
	};
	this.func = [
		function ()
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_B_Spark, {});

			if ((this.target.x - this.x) * this.direction < 0.00000000)
			{
				this.direction = -this.direction;
			}

			local angle_ = this.Math_ShotPath(30, 1.00000000, this, this.target);

			if (this.flag5)
			{
				this.flag5.ReleaseActor();
			}

			if (angle_)
			{
				local target_;

				if (angle_.len() == 1)
				{
					target_ = angle_[0];
				}
				else if (angle_[0] > angle_[1])
				{
					target_ = angle_[0];
				}
				else
				{
					target_ = angle_[1];
				}

				this.SetSpeed_Vec(30.00000000, -this.atan(target_), this.direction);
				this.rz = this.atan2(this.va.y, this.va.x * this.direction);
				this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.AddSpeed_XY(0.00000000, 1.00000000);
					this.rz = this.atan2(this.va.y, this.va.x * this.direction);
					this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
				};

				for( local i = -2; i <= 2; i++ )
				{
					if (i != 0)
					{
						local t_ = {};
						t_.v <- this.Vector3();
						t_.v.x = this.va.x + 1.50000000 * i;
						t_.v.y = this.va.y;
						this.SetShot(this.x, this.y, this.direction, this.SPShot_B2, t_);
					}
				}
			}
			else
			{
				this.SetSpeed_XY(this.va.x, -this.va.y);
				this.rz = this.atan2(this.va.y, this.va.x * this.direction);
				this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
				this.stateLabel = function ()
				{
					if (this.subState())
					{
						return;
					}

					this.AddSpeed_XY(0.00000000, 1.00000000);
					this.rz = this.atan2(this.va.y, this.va.x * this.direction);
					this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
				};
			}

			this.HitReset();
			this.PlaySE(1905);
			this.PlaySE(1899);
			this.owner.BreakDishCount(this.owner.DelDish.call(this.flag3));
			this.flag3.ReleaseActor();
		},
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.flag5.alpha -= 0.10000000;
				this.flag5.anime.length *= 0.89999998;
				this.flag5.anime.radius0 *= 0.89999998;

				if (this.flag5.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}

				this.sy *= 0.92000002;
				this.sx *= 0.99000001;
				this.alpha = this.red = this.green -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function SPShot_B2( t )
{
	this.SetMotion(6011, 0);
	this.SetSpeed_XY(t.v.x, t.v.y);
	this.rz = this.atan2(this.va.y, this.va.x * this.direction);
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.cancelCount = 3;
	this.atk_id = 2097152;
	this.subState = function ()
	{
		if (this.y >= ::battle.scroll_bottom || this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0 || this.owner.IsDamage() || this.owner.IsGuard())
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.85000002;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			return true;
		}

		return false;
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.AddSpeed_XY(0.00000000, 1.00000000);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);
		this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	};
}

function SPShot_B_Spark( t )
{
	this.SetMotion(6011, 3);
	this.sx = this.sy = 5.00000000;
	this.alpha = 2.00000000;
	this.SetFreeObject(this.x, this.y, this.direction, function ( t )
	{
		this.SetMotion(6011, 2);
		this.sx = this.sy = 0.25000000;
		this.stateLabel = function ()
		{
			this.sx = this.sy += (3.50000000 - this.sx) * 0.17500000;
			this.alpha = this.blue = this.green -= 0.03300000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	}, {});
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.50000000;
		this.alpha -= 0.25000000;

		if (this.alpha < 1.00000000)
		{
			this.blue = this.green = this.alpha;
		}

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_C_Dish( t )
{
	this.flag4 = this.owner.DelDish.call(this);
	this.DrawActorPriority(190);
	this.SetMotion(6020, 3);
	this.SetSpeed_XY(0.00000000, 0.00000000);
	this.flag2 = 40;
	this.flag3 = 4;

	if (this.owner.dishLevel >= 1)
	{
		this.flag3 = 4;
	}

	if (this.owner.dishLevel >= 3)
	{
		this.flag3 = 5;
	}

	if (this.owner.dishLevel >= 4)
	{
		this.flag3 = 6;
	}

	switch(t.k)
	{
	case 4:
		this.SetSpeed_XY(-4.00000000 * this.owner.direction, 0.00000000);
		break;

	case 6:
		this.SetSpeed_XY(4.00000000 * this.owner.direction, 0.00000000);
		break;

	case 8:
		this.SetSpeed_XY(0.00000000, -7.00000000);
		break;
	}

	this.func = [
		function ()
		{
			this.PlaySE(1899);
			this.owner.BreakDishCount(this.flag4);
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.89999998;

				if (this.sx <= 0.05000000)
				{
					this.ReleaseActor();
				}
			};
			return;
		}
	];
	this.count = 0;
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.10000000;
		this.Vec_Brake(0.05000000);

		if (this.sx <= 0.00000000)
		{
			this.SetMotion(6020, 2);
			this.rx = -75 * 0.01745329;
			this.flag1 = this.SetShotDynamic(this.x, this.y, this.direction, this.SPShot_C_Water, {});
			this.stateLabel = function ()
			{
				this.rz -= 12.00000000 * 0.01745329;
				this.sx = this.sy += (1.00000000 - this.sx) * 0.25000000;
				this.count++;
				this.flag1.Warp(this.x, this.y);
				this.Vec_Brake(0.05000000);

				if (this.count % 20 == 1)
				{
					local st_ = function ( t )
					{
						this.SetMotion(6020, 4);
						this.rz = this.rand() % 360 * 0.01745329;
						this.rx = -75 * 0.01745329;
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0.00000000, 0.10000000);
							this.sx = this.sy += 0.02500000;
							this.alpha = this.red = this.green -= 0.05000000;

							if (this.alpha <= 0.00000000)
							{
								this.ReleaseActor();
							}
						};
					};
					this.SetFreeObject(this.x, this.y, this.direction, st_, {});
				}

				if (this.count >= this.flag2 || this.flag1.hitCount >= this.flag3 || this.Damage_ConvertOP(this.x, this.y, 5))
				{
					this.SetSpeed_XY(0.00000000, 0.00000000);
					this.flag1.func();
					this.flag1 = null;
					this.func[0].call(this);
				}
			};
		}
	};
}

function SPShot_C_Water( t )
{
	this.DrawActorPriority(180);
	this.SetMotion(6020, 1);
	this.atk_id = 4194304;
	this.sx = 0.00000000;
	this.anime.left = 128;
	this.anime.height = 1280;
	this.anime.width = 64;
	this.anime.center_x = 0;
	this.anime.center_y = 0;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.flag1 = true;
		this.stateLabel = function ()
		{
			this.sx *= 0.85000002;

			if (this.flag1 && this.sx < 0.10000000)
			{
				for( local i = 0; i < 6; i++ )
				{
					local st_ = function ( t )
					{
						this.SetMotion(6020, 5);
						this.sx = this.sy = 0.25000000 + this.rand() % 76 * 0.01000000;
						this.SetSpeed_XY(0.00000000, 5.00000000 + this.rand() % 10 * 0.10000000);
						this.flag1 = 0.03300000 + this.rand() % 20 * 0.00100000;
						this.stateLabel = function ()
						{
							this.AddSpeed_XY(0.00000000, 0.10000000);
							this.sx = this.sy *= 0.98000002;
							this.alpha = this.red = this.green -= this.flag1;

							if (this.alpha <= 0.00000000)
							{
								this.ReleaseActor();
							}
						};
					};
					this.SetFreeObject(this.x, this.y + this.rand() % 600, this.direction, st_, {});
					this.SetFreeObject(this.x, this.y + this.rand() % 128, this.direction, st_, {});
				}

				this.flag1 = false;
			}

			this.alpha = this.red = this.green -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.flag2 += 0.10000000;
		this.anime.top -= 20.00000000;
		this.sx += (1.50000000 - this.sx) * 0.20000000;
		this.count++;

		if (this.rand() % 4 == 0)
		{
			this.sx += 0.05000000 - this.rand() % 10 * 0.01000000;
		}

		if (this.hitResult == 32)
		{
			this.HitReset();
		}

		this.HitCycleUpdate(5);
	};
}

function SPShot_C( t )
{
	this.SetMotion(6020, 0);
	this.sx = this.sy = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.atk_id = 4194304;
	this.stateLabel = function ()
	{
		this.count++;
		this.rz += 5.00000000 * 0.01745329;
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0.15000001;
		local se_ = true;

		foreach( a in this.owner.dish )
		{
			local d_ = this.Vector3();
			d_.x = this.x - a.x;
			d_.y = this.y - a.y;

			if (d_.LengthXY() - 25 <= 55 * this.sx)
			{
				if (se_)
				{
					this.PlaySE(1908);
					se_ = false;
				}

				local t_ = {};
				t_.k <- this.initTable.k;
				this.owner.SPShot_C_Dish.call(a, t_);
			}
		}

		if (this.count >= 20)
		{
			this.stateLabel = function ()
			{
				this.rz += 5.00000000 * 0.01745329;

				if (this.alpha <= 0.05000000)
				{
					this.ReleaseActor();
				}
				else
				{
					this.alpha -= 0.05000000;
				}
			};
		}
	};
}

function SPShot_D( t )
{
	this.SetMotion(3039, t.type);
	this.SetSpeed_XY(t.v, t.vy);
	this.atk_id = 8388608;

	if (!t.atk)
	{
		this.callbackGroup = 0;
	}

	this.stateLabel = function ()
	{
		this.alpha -= 0.10000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
			return;
		}

		if (this.IsScreen(200.00000000))
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E( t )
{
	this.SetMotion(6040, 0);
	this.flag1 = this.Vector3();
	this.flag4 = true;
	this.flag5 = {};
	this.flag5.count <- 0;
	this.cancelCount = 3;
	this.atk_id = 16777216;
	this.func = [
		function ()
		{
			local i_ = 0;
			local target_;
			this.flag2 = -1;
			this.flag3 = null;

			for( local i = 0; i < this.owner.dish.len(); i++ )
			{
				local act_ = this.owner.dish[i];
				local d_ = (act_.x - this.x) * (act_.x - this.x) + (act_.y - this.y) * (act_.y - this.y);

				if (this.flag2 < 0 || d_ < this.flag2)
				{
					this.flag2 = d_;
					this.flag3 = act_.weakref();
				}
			}

			if (this.flag3)
			{
				this.SetSpeed_Vec(15.00000000, this.atan2(this.flag3.y - this.y, this.flag3.x - this.x), 1.00000000);
				this.flag1.x = this.flag3.x;
				this.flag1.y = this.flag3.y;
				this.flag4 = false;
				return true;
			}

			return false;
		},
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.func[0].call(this);

	if (!this.flag3)
	{
		this.SetSpeed_Vec(15.00000000, t.rot, this.direction);
	}

	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 8))
		{
			this.func[1].call(this);
			return;
		}

		this.count++;
		this.rz -= 3.00000000 * 0.01745329;

		if (this.count % 3 == 0)
		{
			this.SetFreeObject(this.x - 25 * this.rand() % 50, this.y + 25 - this.rand() % 50, this.direction, this.SPShot_E_Trail, {});
		}

		if (this.cancelCount <= 0 || this.IsScreen(200.00000000))
		{
			this.func[1].call(this);
			return;
		}

		if (this.hitResult == 32)
		{
			this.HitReset();
		}

		if (this.hitCount > 0 && this.flag4)
		{
			local t_ = {};
			t_.count <- this.flag5.count;
			this.SetShot(this.x, this.y, this.direction, this.SPShot_E_FinishExp, t_);
			this.func[1].call(this);
			return;
		}

		if (this.flag3)
		{
			if ((this.flag1.x - this.x) * (this.flag1.x - this.x) + (this.flag1.y - this.y) * (this.flag1.y - this.y) <= 400.00000000)
			{
				for( local i = 0; i < this.owner.dish.len(); i++ )
				{
					if (this.flag3 == this.owner.dish[i])
					{
						this.cancelCount += 3;
						this.HitReset();
						this.hitCount = 0;
						this.flag5.count++;
						this.owner.BreakDishCount(this.owner.DelDish.call(this.flag3));

						if (this.owner.dishLevel >= 2)
						{
							this.SetShot(this.flag1.x, this.flag1.y, this.direction, this.SPShot_E_Exp, {});
						}

						this.PlaySE(1914);
						this.flag3.ReleaseActor();

						if (!this.func[0].call(this))
						{
							this.SetSpeed_Vec(15.00000000, this.atan2(this.target.y - this.y, this.target.x - this.x), 1.00000000);
							this.flag4 = true;
						}

						break;
					}
				}
			}
		}
	};
}

function SPShot_E_Exp( t )
{
	this.SetMotion(6040, 1);
	this.cancelCount = 3;
	this.atk_id = 16777216;
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_ExpRing, {});

	for( local i = 0; i < 8; i++ )
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_ExpParticle, {});
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.99900001;
		this.count++;

		if (this.count >= 10)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_E_FinishExp( t )
{
	if (t.count > 5)
	{
		this.SetMotion(6041, 5);
	}
	else
	{
		this.SetMotion(6041, t.count);
	}

	this.cancelCount = 3;
	this.atk_id = 16777216;
	this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_ExpRing, {});

	for( local i = 0; i < 8; i++ )
	{
		this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E_ExpParticle, {});
	}

	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.99900001;
		this.count++;

		if (this.count >= 10)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_E_ExpRing( t )
{
	this.SetMotion(6040, 3);
	this.flag1 = 0.44999999;
	this.stateLabel = function ()
	{
		this.sx = this.sy += this.flag1;
		this.flag1 -= 0.05000000;

		if (this.flag1 < 0.02500000)
		{
			this.flag1 = 0.02500000;
		}

		this.count++;

		if (this.count >= 5)
		{
			this.stateLabel = function ()
			{
				this.alpha = this.green = this.blue -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SPShot_E_ExpParticle( t )
{
	this.SetMotion(6040, 4 + this.rand() % 4);
	this.sx = this.sy = 1.50000000 + this.rand() % 125 * 0.01000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag1 = (-8.00000000 + this.rand() % 17) * 0.01745329;
	this.SetSpeed_Vec(5 + this.rand() % 10, this.rand() % 360 * 0.01745329, this.direction);
	this.stateLabel = function ()
	{
		this.Vec_Brake(0.33000001, 1.00000000);
		this.sx = this.sy *= 0.92000002;
		this.rz += this.flag1;
		this.alpha = this.green = this.blue -= 0.02500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_E_Trail( t )
{
	this.SetMotion(6040, 4 + this.rand() % 4);
	this.sx = this.sy = 0.75000000 + this.rand() % 50 * 0.01000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag1 = (-8.00000000 + this.rand() % 17) * 0.01745329;
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0.00000000, -0.50000000);
		this.sx = this.sy *= 0.92000002;
		this.rz += this.flag1;
		this.alpha = this.green = this.blue -= 0.05000000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_F( t )
{
	this.DrawActorPriority(180);

	if (t.rot == -90 * 0.01745329)
	{
		this.SetMotion(6050, t.type);
	}
	else
	{
		this.SetMotion(6050, t.type + 3);
	}

	this.flag1 = 100 + 20 * t.type;
	this.atk_id = 33554432;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.20000000);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				if (this.owner.motion == 3050 && (this.owner.keyTake == 4 || this.owner.keyTake == 5))
				{
					this.Warp(this.owner.x, this.owner.y + this.owner.va.y);
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
		if (this.owner.motion == 3050 && (this.owner.keyTake == 4 || this.owner.keyTake == 5))
		{
			if (this.hitCount > 0)
			{
				this.owner.hitResult = this.hitResult;
			}

			this.Warp(this.owner.x, this.owner.y + this.owner.va.y);

			if (this.owner.va.LengthXY() >= 5.00000000)
			{
				for( local i = 0; i < this.owner.dish.len(); i++ )
				{
					local a = this.owner.dish[i];

					if (this.abs(this.x - a.x) <= this.flag1 && this.abs(this.y + 100 - a.y) <= 40)
					{
						this.owner.BreakDishCount.call(a, this.owner.DelDish.call(a));
						local t_ = {};
						t_.rot <- -1.04719746;
						t_.v <- 26.00000000;
						this.SetShot(a.x, a.y, this.direction, this.SPShot_F_Shard_Core, t_);
						a.ReleaseActor();
						this.PlaySE(1920);
						i--;
					}
				}
			}
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function SPShot_F_Shard_Core( t )
{
	this.SetMotion(6053, this.rand() % 4);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.rz = this.rand() % 360 * 0.01745329;
	this.cancelCount = 2;
	this.atk_id = 33554432;
	this.flag1 = (8 - this.rand() % 17) * 0.01745329;
	this.flag2 = ::manbow.Actor2DProcGroup();
	local a_;

	for( local i = 0; i < 6; i++ )
	{
		a_ = this.SetShot(this.x, this.y, this.direction, this.SPShot_F_Sub, {});
		a_.hitOwner = this.weakref();
		a_.SetParent(this, 0, 0);
		this.flag2.Add(a_);
	}

	this.func = function ()
	{
		this.callbackGroup = 0;
		this.flag2.Foreach(function ()
		{
			this.func[0].call(this);
		});
		this.stateLabel = function ()
		{
			this.rz -= this.flag1;
			this.AddSpeed_XY(0.00000000, 1.00000000);
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		this.rz += this.flag1;
		this.AddSpeed_XY(0.00000000, 1.00000000);

		if (this.y > ::battle.scroll_bottom + 100)
		{
			this.func();
			return;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 10)
		{
			this.func();
			return;
		}

		if (this.motion == 6051 && this.va.y > 0.00000000)
		{
			this.SetMotion(6052, this.keyTake);
			this.flag2.Foreach(function ()
			{
				this.SetMotion(6052, this.keyTake);
			});
		}
	};
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 7)
		{
			this.SetMotion(6051, this.keyTake);
			this.flag2.Foreach(function ()
			{
				this.func[1].call(this);
			});
			this.stateLabel = function ()
			{
				this.VX_Brake(0.10000000);
				this.subState();
			};
		}

		this.subState();
	};
}

function SPShot_F_Sub( t )
{
	this.SetMotion(6053, this.rand() % 4);
	this.SetSpeed_XY(14 - this.rand() % 29, 10 - this.rand() % 21);
	this.rz = this.rand() % 360 * 0.01745329;
	this.cancelCount = 2;
	this.atk_id = 33554432;
	this.flag1 = (8 - this.rand() % 17) * 0.01745329;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.rz -= this.flag1;
				this.SetSpeed_XY(this.va.x * 0.92000002, this.va.y * 0.92000002);
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(6051, this.keyTake);
		}
	];
	this.stateLabel = function ()
	{
		this.rz += this.flag1;
		this.SetSpeed_XY(this.va.x * 0.92000002, this.va.y * 0.92000002);
	};
}

function SPShot_F_Shard( t )
{
	this.SetMotion(6051, this.rand() % 4);
	this.SetSpeed_Vec(t.v + this.rand() % 3, t.rot + (10 - this.rand() % 21) * 0.01745329, this.direction);
	this.rz = this.rand() % 360 * 0.01745329;
	this.cancelCount = 2;
	this.atk_id = 33554432;
	this.flag1 = (8 - this.rand() % 17) * 0.01745329;
	this.func = function ()
	{
		this.callbackGroup = 0;
		this.SetSpeed_XY(this.va.x, -this.va.y * 0.50000000);
		this.stateLabel = function ()
		{
			this.rz -= this.flag1;
			this.AddSpeed_XY(0.00000000, 0.75000000);
			this.sx = this.sy *= 0.94999999;
			this.alpha -= 0.05000000;

			if (this.alpha <= 0.00000000)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		this.rz += this.flag1;
		this.AddSpeed_XY(0.00000000, 1.00000000);

		if (this.y > ::battle.scroll_bottom + 100)
		{
			this.ReleaseActor();
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 10)
		{
			this.func();
			return;
		}
	};
	this.stateLabel = function ()
	{
		if (this.va.y > 0.00000000)
		{
			this.SetMotion(6052, this.keyTake);
			this.stateLabel = function ()
			{
				this.VX_Brake(0.05000000);
				this.HitCycleUpdate(5);
				this.subState();
			};
		}

		this.subState();
	};
}

function SpellShot_A( t )
{
	this.SetMotion(7000, this.owner.dishLevel);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.flag1 = 0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.sx = this.sy = 1.00000000;
		this.owner.SetDish.call(this, this.keyTake - 5);
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion != 4000)
		{
			this.func[0].call(this);
			return;
		}
		else if (this.owner.keyTake <= 3)
		{
			this.initTable.rot -= 12.50000000 * 0.01745329;
			this.flag1 += (160 - this.flag1) * 0.10000000;
			this.Warp(this.owner.x + this.flag1 * this.cos(this.initTable.rot) * this.direction, this.owner.y + this.flag1 * this.sin(this.initTable.rot));
			this.HitCycleUpdate(8);
		}
		else
		{
			this.HitReset();
			this.SetMotion(7000, this.keyTake + 5);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function SpellShot_A_Sub( t )
{
	this.SetMotion(7000, this.owner.dishLevel);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.flag1 = 0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.keyAction = function ()
	{
		this.sx = this.sy = 1.00000000;
		this.owner.SetDish.call(this, this.keyTake - 5);
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion != 4000)
		{
			this.func[0].call(this);
			return;
		}
		else if (this.owner.keyTake <= 3)
		{
			this.initTable.rot -= 12.50000000 * 0.01745329;
			this.flag1 += (160 - this.flag1) * 0.10000000;
			this.Warp(this.owner.x + this.flag1 * this.cos(this.initTable.rot) * this.direction, this.owner.y + this.flag1 * this.sin(this.initTable.rot));
		}
		else
		{
			this.SetMotion(7000, this.keyTake + 5);
			this.stateLabel = function ()
			{
			};
		}
	};
}

function SpellShot_A2( t )
{
	this.SetMotion(7000, 10);
	this.SetParent(this.owner, 0, 0);
	this.func = function ()
	{
		this.SetParent(null, 0, 0);
		this.SetKeyFrame(1);
	};
	this.keyAction = this.ReleaseActor;
}

function SpellShot_B( t )
{
	this.SetMotion(7010, 0);
	this.SetSpeed_Vec(30, 60 * 0.01745329, this.direction);
	this.rx = -60 * 0.01745329;
	this.ry = 30 * 0.01745329 * this.direction;
	this.sx = this.sy = 0.25000000;
	this.SetCollisionScaling(0.25000000, 0.25000000, 1.00000000);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.stateLabel = function ()
	{
		this.rz -= 21 * 0.01745329;
		this.sx = this.sy += (2.00000000 - this.sx) * 0.10000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
		this.HitCycleUpdate(15);
		this.SetFreeObject(this.x - 50 * this.rand() % 100 * this.sx, this.y + 50 * this.rand() % 100 * this.sy, this.direction, this.SPShot_E_Trail, {});

		if (this.y >= ::battle.corner_bottom)
		{
			local t_ = {};
			t_.num <- 0;
			t_.rate <- this.atkRate_Pat;
			this.PlaySE(1935);
			this.SetShot(this.x, ::battle.corner_bottom, this.direction, this.SpellShot_B_Fire, t_);
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.isVisible = false;
			this.callbackGroup = 0;
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 180)
				{
					this.team.spell_enable_end = true;
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B_Fire( t )
{
	this.SetMotion(7010, 1);
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count == 15 && !this.IsScreen(400.00000000))
		{
			this.PlaySE(1935);
			local t_ = {};
			t_.num <- this.initTable.num + 1;
			t_.rate <- this.atkRate_Pat;
			this.SetShot(this.x + 120 * this.direction, ::battle.corner_bottom, this.direction, this.owner.SpellShot_B_Fire, t_);

			if (this.initTable.num == 0)
			{
				local t_ = {};
				t_.num <- this.initTable.num + 1;
				t_.rate <- this.atkRate_Pat;
				this.SetShot(this.x - 120 * this.direction, ::battle.corner_bottom, -this.direction, this.owner.SpellShot_B_Fire, t_);
			}
		}
	};
}

function SpellShot_C( t )
{
	this.SetMotion(7020, 0);
	this.sx = this.sy = 0.00000000;
	this.rz = this.rand() % 360 * 0.01745329;
	this.flag3 = false;
	this.atkRate_Pat = t.rate;
	this.flag5 = {};
	this.flag5.count <- 300 * t.rate;
	this.flag5.fieldCountA <- 0;
	this.flag5.fieldCountB <- 0;
	this.flag5.fieldCountC <- -210;
	this.flag5.ufoActive <- false;
	this.stateLabel = function ()
	{
		this.rz += 0.50000000 * 0.01745329;
		this.sx = this.sy += (3.00000000 - this.sx) * 0.15000001;

		if (this.sx > 2.97499990)
		{
			this.sx = this.sy = 3.00000000;
			local dish_ = [];
			local se_ = false;

			foreach( a in this.owner.dish )
			{
				local d_ = this.Vector3();
				d_.x = this.x - a.x;
				d_.y = this.y - a.y;

				if (d_.LengthXY() - 50 <= 100 * this.sx)
				{
					dish_.append(a.weakref());
				}
			}

			foreach( a in dish_ )
			{
				this.owner.BreakDishCount(this.owner.DelDish.call(a));
				a.func();
				this.flag1++;
				se_ = true;
			}

			if (se_)
			{
				this.PlaySE(1970);
			}

			local t_ = {};
			t_.keyTake <- 0;

			if (this.flag1 > 1)
			{
				t_.keyTake = 1;
			}

			if (this.flag1 > 3)
			{
				t_.keyTake = 2;
			}

			if (t_.keyTake == 2)
			{
				this.flag4 = -210;
				this.flag5.count = 360;
			}

			this.flag2 = this.SetFreeObject(this.target.x, this.target.y - 100, 1.00000000, this.owner.SpellShot_C_Font, t_, this.weakref()).weakref();
			this.stateLabel = function ()
			{
				this.count++;
				this.rz += 0.50000000 * 0.01745329;
				this.sx = this.sy += 0.00750000;
				local d_ = this.Vector3();
				d_.x = this.x - this.target.x;
				d_.y = this.y - this.target.y;

				if (this.count <= this.flag5.count && d_.LengthXY() - 50 <= 100 * this.sx)
				{
					if (!this.flag3)
					{
						this.flag2.func[2].call(this.flag2);
						this.flag3 = true;
					}

					this.flag5.fieldCountA++;
					this.flag5.fieldCountB++;
					this.flag5.fieldCountC++;

					if (this.flag5.fieldCountA > 90)
					{
						local t_ = {};
						t_.type <- 0;
						t_.rate <- this.atkRate_Pat;
						this.flag5.fieldCountA = 0;
						this.SetFreeObject(640, 200, 1.00000000, this.owner.SpellShot_C_Call, t_, this.weakref());
					}

					if (this.flag5.fieldCountB > 90 && this.flag1 > 1)
					{
						local t_ = {};
						t_.type <- 1;
						t_.rate <- this.atkRate_Pat;
						this.flag5.fieldCountB = -60;
						this.SetFreeObject(640, 200, 1.00000000, this.owner.SpellShot_C_Call, t_, this.weakref());
					}

					if (this.flag5.fieldCountC > 90 && this.flag1 > 3)
					{
						this.flag5.ufoActive = true;
						local t_ = {};
						t_.type <- 2;
						t_.rate <- this.atkRate_Pat;
						this.flag5.fieldCountC = -999;
						this.SetFreeObject(640, 200, 1.00000000, this.owner.SpellShot_C_Call, t_, this.weakref());
					}
				}
				else if (this.flag3)
				{
					this.flag2.func[1].call(this.flag2);
					this.flag3 = false;
				}

				if (this.count % 45 == 0 && this.count <= this.flag5.count + 45)
				{
					this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_C_Aura, {});
				}

				if (this.count >= this.flag5.count + 90)
				{
					if (this.flag5.ufoActive == false)
					{
						this.team.spell_enable_end = true;
					}

					this.flag2.func[0].call(this.flag2);
					this.flag2 = null;
					this.stateLabel = function ()
					{
						this.rz += 0.50000000 * 0.01745329;

						if (this.alpha <= 0.02500000)
						{
							this.ReleaseActor();
						}
						else
						{
							this.alpha -= 0.02500000;
						}
					};
				}
			};
		}
	};
}

function SpellShot_C_Aura( t )
{
	this.SetMotion(7020, 2);
	this.rz = this.rand() % 360 * 0.01745329;
	this.sx = this.sy = 3.00000000;
	this.alpha = 0;
	this.subState = function ()
	{
		this.alpha += 0.02000000;

		if (this.alpha >= 1.00000000)
		{
			this.subState = function ()
			{
				this.alpha -= 0.02000000;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.rz -= 0.01000000;
		this.subState();
		this.sx = this.sy += 0.00500000;

		if (this.alpha <= 0.00000000)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_C_Call( t )
{
	this.DrawScreenActorPriority(100);
	this.flag1 = t.type;
	this.target = this.owner.target.weakref();
	this.Warp((this.target.x - ::camera.camera2d.left) * ::camera.zoom, 150);

	switch(t.type)
	{
	case 0:
		this.SetMotion(7021, 3);
		break;

	case 1:
		this.SetMotion(7021, 4);
		break;

	case 2:
		this.SetMotion(7021, 5);
		break;
	}

	if (this.flag1 == 2)
	{
		this.PlaySE(1969);
		this.stateLabel = function ()
		{
			this.Warp((this.target.x - ::camera.camera2d.left) * ::camera.zoom, 150);
			this.count++;

			if (this.count >= 180)
			{
				local t_ = {};
				t_.type <- this.flag1;
				t_.rate <- this.initTable.rate;
				this.SetShot(this.target.x - 200 * this.owner.direction, ::battle.scroll_top - 600, this.owner.direction, this.owner.SpellShot_C_Fall, t_, this.weakref());
				this.stateLabel = function ()
				{
					this.Warp((this.target.x - ::camera.camera2d.left) * ::camera.zoom, 150);
					this.sy *= 0.85000002;
					this.sx += 0.10000000;

					if (this.sy <= 0.01000000)
					{
						this.ReleaseActor();
					}
				};
			}
		};
	}
	else
	{
		this.PlaySE(1968);
		this.stateLabel = function ()
		{
			this.Warp((this.target.x - ::camera.camera2d.left) * ::camera.zoom, 150);
			this.count++;

			if (this.count >= 60)
			{
				local t_ = {};
				t_.type <- this.flag1;
				t_.rate <- this.initTable.rate;

				if (this.flag1 == 0)
				{
					this.SetShot(this.target.x - this.rand() % 500 * this.owner.direction, ::battle.scroll_top - 100, this.owner.direction, this.owner.SpellShot_C_Fall, t_, this.weakref());
				}
				else
				{
					this.SetShot(this.target.x + 100 - this.rand() % 200, ::battle.scroll_top - 100, this.owner.direction, this.owner.SpellShot_C_Fall, t_, this.weakref());
				}

				this.stateLabel = function ()
				{
					this.Warp((this.target.x - ::camera.camera2d.left) * ::camera.zoom, 150);
					this.sy *= 0.75000000;
					this.sx += 0.10000000;

					if (this.sy <= 0.01000000)
					{
						this.ReleaseActor();
					}
				};
			}
		};
	}
}

function SpellShot_C_Fall( t )
{
	this.target = this.owner.target.weakref();
	this.atkRate_Pat = t.rate;
	this.atk_id = 67108864;

	switch(t.type)
	{
	case 1:
		this.SetMotion(7023, this.rand() % 3);
		this.sx = this.sy = 1.25000000;
		this.FitBoxfromSprite();
		this.rz = this.rand() % 20 * 0.01745329;
		this.PlaySE(1961);
		local angle_ = this.Math_ShotPath(15, 0.25000000, this, this.target);

		if (angle_)
		{
			local target_;

			if (angle_.len() == 1)
			{
				target_ = angle_[0];
			}
			else
			{
				target_ = angle_[1];
			}

			this.SetSpeed_Vec(15.00000000, -this.atan(target_), this.direction);
		}
		else
		{
			this.SetSpeed_XY(0.00000000, 15.00000000);
		}

		this.cancelCount = 3;
		this.flag1 = (-2 + this.rand() % 5) * 0.01745329;
		this.func = function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(4 - this.rand() % 9, -this.va.y * 0.25000000);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.75000000);
				this.alpha -= 0.03300000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		};
		this.stateLabel = function ()
		{
			this.AddSpeed_XY(0.00000000, 0.25000000);

			if (this.IsScreen(300.00000000))
			{
				this.ReleaseActor();
				return;
			}

			if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
			{
				this.func();
				return;
			}
		};
		break;

	case 2:
		this.SetMotion(7024, 0);
		this.PlaySE(1963);
		this.SetSpeed_Vec(12.00000000, (85 + this.rand() % 11) * 0.01745329, this.direction);
		this.cancelCount = 3;
		this.SetSpeed_XY(0.00000000, 8.00000000);
		this.TargetHoming(this.target, 45.00000000 * 0.01745329, this.direction);
		this.stateLabel = function ()
		{
			if (this.hitCount <= 10)
			{
				this.HitCycleUpdate(2);
			}

			if (this.y > ::battle.scroll_bottom + 600)
			{
				this.team.spell_enable_end = true;
				this.ReleaseActor();
				return;
			}
		};
		break;

	default:
		this.SetMotion(7022, this.rand() % 4);
		this.rz = this.rand() % 360 * 0.01745329;
		this.PlaySE(1959);
		local angle_ = this.Math_ShotPath(10, 0.25000000, this, this.target);

		if (angle_)
		{
			local target_;

			if (angle_.len() == 1)
			{
				target_ = angle_[0];
			}
			else
			{
				target_ = angle_[1];
			}

			this.SetSpeed_Vec(10.00000000, -this.atan(target_), this.direction);
		}
		else
		{
			this.SetSpeed_XY(0.00000000, 10.00000000);
		}

		this.cancelCount = 3;
		this.flag1 = (-3 + this.rand() % 7) * 0.01745329;
		this.func = function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_XY(null, -this.va.y * 0.33000001);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.40000001);
				this.rz += this.flag1;
				this.alpha -= 0.03300000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		};
		this.stateLabel = function ()
		{
			if (this.y > ::battle.scroll_bottom + 100)
			{
				this.ReleaseActor();
				return;
			}

			this.rz += this.flag1;

			if (this.hitCount > 0 || this.cancelCount <= 0 || this.grazeCount > 0)
			{
				this.func();
				return;
			}

			this.AddSpeed_XY(0.00000000, 0.25000000);
		};
		break;
	}
}

function SpellShot_C_Font( t )
{
	this.SetMotion(7021, t.keyTake);
	this.alpha = 0.00000000;
	this.flag1 = [];
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.subState = function ()
			{
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.alpha = 0.00000000;
				}
			};
		},
		function ()
		{
			this.subState = function ()
			{
				this.alpha += 0.05000000;

				if (this.alpha > 1.00000000)
				{
					this.alpha = 1.00000000;
					this.count++;

					if (this.count % 15 == 1)
					{
						local t_ = {};
						t_.scale <- 1.00000000;

						switch(this.keyTake)
						{
						case 1:
							t_.scale = 2.00000000;
							break;

						case 2:
							t_.scale = 3.00000000;
							break;
						}

						this.flag1.append(this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
						{
							this.DrawActorPriority(195);
							this.SetMotion(7021, 6);
							this.alpha = 0;
							this.flag1 = 0.00500000 * t_.scale;
							this.rz = this.rand() % 360 * 0.01745329;
							this.func = function ()
							{
								this.stateLabel = function ()
								{
									this.alpha -= 0.05000000;

									if (this.alpha <= 0.00000000)
									{
										this.ReleaseActor();
									}
								};
							};
							this.stateLabel = function ()
							{
								this.alpha += 0.05000000;
								this.sx = this.sy += this.flag1;

								if (this.isVisible && this.team.current.flagState & -2147483648)
								{
									this.isVisible = false;
								}
								else if (!this.isVisible)
								{
									this.isVisible = true;
								}

								if (this.alpha >= 1.00000000)
								{
									this.alpha = 1.00000000;
									this.stateLabel = function ()
									{
										this.alpha = this.red -= 0.02500000;
										this.sx = this.sy += this.flag1;

										if (this.alpha <= 0.00000000)
										{
											this.ReleaseActor();
										}
									};
								}
							};
						}, t_).weakref());
					}
				}
			};
		}
	];
	this.SetParent(this.owner.target, this.x - this.owner.target.x, this.y - (this.owner.target.y + 20));
	this.stateLabel = function ()
	{
		if (this.isVisible && this.team.current.flagState & -2147483648)
		{
			this.isVisible = false;
		}
		else if (!this.isVisible)
		{
			this.isVisible = true;
		}

		for( local i = 0; i < this.flag1.len(); i++ )
		{
			if (this.flag1[i])
			{
				this.flag1[i].Warp(this.x, this.y);
			}
			else
			{
				this.flag1.remove(i);
				i--;
				  // [047]  OP_JMP            0      0    0    0
			}
		}

		if (this.subState)
		{
			this.subState();
		}
	};
}

function Climax_Well( t )
{
	this.SetMotion(4909, 0);
	this.DrawActorPriority(180);
	this.EnableTimeStop(false);
	this.atkRate_Pat = t.rate;
	this.flag1 = ::manbow.Actor2DProcGroup();
	this.flag2 = this.Vector3();
	this.atkRate_Pat = t.rate;
	this.atk_id = 134217728;
	this.func = [
		function ()
		{
			this.SetMotion(4909, 8);
			this.flag1.Foreach(function ()
			{
				if (this.func[0])
				{
					this.func[0].call(this);
				}
			});
			this.SetSpeed_XY(6.00000000 * this.direction, -25.00000000);
			this.SetEffect(this.x, this.y, this.direction, this.EF_HitSmashC, {});
			this.stateLabel = function ()
			{
				this.rz += 18.00000000 * 0.01745329;
				this.AddSpeed_XY(0.00000000, 1.00000000);

				if (this.va.y > 0.00000000)
				{
					this.SetMotion(4909, 9);
					this.stateLabel = function ()
					{
						this.rz += 18.00000000 * 0.01745329;
						this.AddSpeed_XY(0.00000000, 1.00000000);

						if (this.y > ::battle.scroll_bottom + 100)
						{
							this.ReleaseActor();
						}
					};
				}
			};
		},
		function ()
		{
			this.SetMotion(4909, 2);
			this.stateLabel = function ()
			{
				this.count++;
				local pos_ = this.Vector3();
				this.GetPoint(0, pos_);
				this.flag1.Foreach(function ( x_, y_ )
				{
					this.x = x_;
					this.y = y_;
				}, pos_.x, pos_.y);
				local t_ = {};
				t_.rate <- this.atkRate_Pat;

				if (this.count % 10 == 1)
				{
					this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_Squee, t_));
				}

				if (this.count % 16 == 1)
				{
					this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_SqueeB, t_));
				}
			};
		},
		function ()
		{
			this.owner.target.freeMap = true;
			this.owner.target.DamageGrab_Common(311, 1, -this.direction);
			this.flag2.x = this.owner.target.x - this.x;
			this.flag2.y = this.owner.target.y - this.y;
			this.flag2.SetLength(225);
			this.SetMotion(4909, 2);
			this.owner.target.DrawActorPriority(210);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				local pos_ = this.Vector3();
				this.GetPoint(0, pos_);
				this.flag1.Foreach(function ( x_, y_ )
				{
					this.x = x_;
					this.y = y_;
				}, pos_.x, pos_.y);

				if (this.count % 10 == 1)
				{
					this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_Squee, {}));
				}

				if (this.count % 8 == 1)
				{
					this.flag1.Add(this.SetFreeObject(this.x, this.y, this.direction, this.owner.Climax_SqueeB, {}));
				}

				this.flag2.Mul(0.99000001);
				this.flag2.RotateByDegree(-5.00000000);
				this.owner.target.x += (pos_.x + this.flag2.x * this.direction - this.owner.target.x) * 0.15000001;
				this.owner.target.y += (pos_.y + this.flag2.y - this.owner.target.y) * 0.15000001;
				this.owner.target.sx = this.owner.target.sy += (0.15000001 - this.owner.target.sx) * 0.01000000;
				this.owner.target.rz = -this.atan2(this.flag2.y, this.flag2.x) + 45 * 0.01745329;
			};
		},
		function ()
		{
			this.flag1.Foreach(function ()
			{
				this.ReleaseActor();
			});
			this.ReleaseActor();
		}
	];
}

function Climax_Squee( t )
{
	this.SetMotion(4909, 3);
	this.rz = this.rand() % 360 * 0.01745329;
	this.alpha = 0.00000000;
	this.sx = this.sy = 1.50000000;
	this.rx = (35 - this.rand() % 71) * 0.01745329;
	this.ry = (35 - this.rand() % 71) * 0.01745329;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.94999999;
				this.rz -= 6.00000000 * 0.01745329;
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}

				this.func[0] = null;
			};
		}
	];
	this.subState = function ()
	{
		this.alpha += 0.05000000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = 1.00000000;
			this.subState = function ()
			{
				this.alpha -= 0.01000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.rz -= 12.00000000 * 0.01745329;
		this.sx = this.sy *= 0.93000001;
		this.subState();
	};
}

function Climax_SqueeB( t )
{
	this.SetMotion(4909, 4);
	this.rx = (15 - this.rand() % 31) * 0.01745329;
	this.ry = (15 - this.rand() % 31) * 0.01745329;
	this.rz = this.rand() % 360 * 0.01745329;
	this.alpha = 0.00000000;
	this.sx = this.sy = 3.00000000;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy *= 0.94999999;
				this.alpha -= 0.20000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}

				this.func[0] = null;
			};
		}
	];
	this.subState = function ()
	{
		this.alpha += 0.20000000;

		if (this.alpha >= 1.00000000)
		{
			this.alpha = 1.00000000;
			this.subState = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		this.sx = this.sy -= 0.15000001;
		this.subState();
	};
}

function Climax_HitSmash( t )
{
	this.SetMotion(4908, 0);
	this.DrawScreenActorPriority(1000);
	this.keyAction = this.ReleaseActor;
}

function Climax_CutA( t )
{
	this.SetMotion(4909, 5);
	this.DrawScreenActorPriority(200);
	this.SetSpeed_XY(0.10000000 * this.direction, -0.20000000);
	this.sx = this.sy = 2.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.33000001;
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_CutB( t )
{
	this.SetMotion(4909, 7);
	this.DrawScreenActorPriority(199);
	this.SetSpeed_XY(-0.20000000 * this.direction, 0.14000000);
	this.sx = this.sy = 2.00000000;
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1.00000000 - this.sx) * 0.33000001;
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_BackA( t )
{
	this.SetMotion(4909, 6);
	this.sx = this.sy = 1.00000000;
	this.red = this.green = this.blue = 0.00000000;
	this.DrawScreenActorPriority(190);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.red = this.green = this.blue = 1.00000000;
		}
	];
}

function Climax_EnemyMove( t )
{
	this.SetMotion(311, 1);
	this.sx = this.sy = 1.50000000;
	this.SetSpeed_XY(-0.50000000 * this.direction, -0.30000001);
	this.DrawScreenActorPriority(197);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.99500000;
	};
}

function Climax_HitEffect( t )
{
	this.SetMotion(4909, 10);
	this.DrawScreenActorPriority(198);
	this.sx = this.sy = 2.00000000;
	this.flag1 = [
		this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
		{
			this.SetMotion(4909, 11);
			this.DrawScreenActorPriority(200);
			this.func = [
				function ()
				{
					this.ReleaseActor();
				}
			];
			this.sx = this.sy = 2.00000000;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0.00750000;
			};
		}, {}).weakref(),
		this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
		{
			this.SetMotion(4909, 12);
			this.DrawScreenActorPriority(198);
			this.func = [
				function ()
				{
					this.ReleaseActor();
				}
			];
			this.stateLabel = function ()
			{
				this.rz -= 0.05000000 * 0.01745329;
				this.sx += 0.01500000;
				this.sy -= 0.00500000;
			};
		}, {}).weakref()
	];
	this.func = [
		function ()
		{
			foreach( a in this.flag1 )
			{
				a.func[0].call(a);
			}

			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0.99900001;
	};
}

