function BeginBattle_Bou( t )
{
	this.SetMotion(9000, 7);
	this.SetSpeed_XY(0,25000000.0 * this.direction, -15,00000000.0);
	this.func = function ()
	{
		this.ReleaseActor();
	};
	this.stateLabel = function ()
	{
		this.AddSpeed_XY(null, 0,50000000.0);
	};
}

function BattleBeginObject_A( t )
{
	this.SetMotion(9002, 0);

	if (this.owner.demoObject == null)
	{
		this.owner.demoObject = [];
	}

	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 0,75000000.0 + this.rand() % 15 * 0,10000000.0;
	this.rz = (360 - this.rand() % 720) * 0,01745329.0;
	this.red = this.rand() % 10 * 0,10000000.0;
	this.green = this.rand() % 10 * 0,10000000.0;
	this.blue = this.rand() % 10 * 0,10000000.0;
	this.stateLabel = function ()
	{
		this.rz *= 0,98000002.0;
		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function BattleBeginObject_B( t )
{
	this.SetMotion(9002, 0);

	if (this.owner.demoObject == null)
	{
		this.owner.demoObject = [];
	}

	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 0,75000000.0 + this.rand() % 15 * 0,10000000.0;
	this.rz = (360 - this.rand() % 720) * 0,01745329.0;
	this.red = this.rand() % 10 * 0,10000000.0;
	this.green = this.rand() % 10 * 0,10000000.0;
	this.blue = this.rand() % 10 * 0,10000000.0;
	this.stateLabel = function ()
	{
		this.rz *= 0,98000002.0;
		this.AddSpeed_XY(0,00000000.0, 0,10000000.0);
		this.count++;

		if (this.count >= 30)
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function BattleWinObject_B( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(9011, 3);
	this.owner.demoObject = [];
	this.owner.demoObject.append(this.weakref());
	this.sx = this.sy = 0,00000000.0;
	this.rx = 75 * 0,01745329.0;
	this.rz = (360 - this.rand() % 720) * 0,01745329.0;
	this.flag1 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.flag2 = this.Vector3();
	this.stateLabel = function ()
	{
		this.flag2.x = (::camera.camera2d.left + ::camera.camera2d.right) * 0,50000000.0;
		this.flag2.y = (::camera.camera2d.top + ::camera.camera2d.bottom) * 0,50000000.0;
		this.rz += 28 * 0,01745329.0;
		this.flag3 += 0,04000000.0;
		this.sx = this.sy = this.flag3 * 6,00000000.0;
		local tx_ = this.flag1.x + (this.flag2.x - this.flag1.x) * (1 - this.cos(this.flag3 * 3,14159203.0 * 0,50000000.0));
		local ty_ = this.flag1.y + (this.flag2.y - this.flag1.y) * (1 - this.cos(this.flag3 * 3,14159203.0 * 0,50000000.0));
		this.Warp(tx_, ty_);

		if (this.flag3 >= 1,00000000.0)
		{
			this.PlaySE(1094);
			::camera.Shake(10);
			this.sx = this.sy = 1,00000000.0;
			this.y += 50;
			this.SetMotion(9011, 4);
			this.rx = 0,00000000.0;
			this.rz = 15 * 0,01745329.0;
			this.stateLabel = null;
		}
	};
}

function Grab_Spark( t )
{
	this.SetMotion(1809, 1);
	this.keyAction = this.ReleaseActor;
}

function Grab_Ofuda( t )
{
	this.SetMotion(1809, 2);
	this.keyAction = this.ReleaseActor;
	this.SetParent(t.pare, this.x - t.pare.x, this.y - t.pare.y);
	this.func = function ()
	{
		this.ReleaseActor();
	};
}

class this.shot_normal 
{
	brake = true;
	vecV = 15,00000000.0;
	vecR = 0,00000000.0;
	moveVec = null;
}

function Shot_Normal( t )
{
	this.SetMotion(2007, 0);
	this.flag5 = this.owner.shot_normal();
	this.flag1 = t.flag1;
	this.flag5.vecR = t.rot;
	this.sx = this.sy = 0,50000000.0;
	this.cancelCount = 3;
	this.flag5.moveVec = this.Vector3();
	this.atk_id = 16384;
	this.flag5.moveVec.x = 1,00000000.0;
	this.flag5.moveVec.RotateByRadian(t.rot);
	this.SetSpeed_Vec(this.flag5.vecV, this.flag5.vecR, this.direction);
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.SetMotion(this.motion, 2);
		this.sx = this.sy *= 1,50000000.0;
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.rz += 0,50000000.0 * this.flag1;
			this.sx = this.sy *= 0,89999998.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount >= 3 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.hitResult & 8)
		{
			this.func();
			return true;
		}

		if (this.hitResult)
		{
			if (this.HitCycleUpdate(3))
			{
				this.flag2 = true;
			}
			else if (this.flag2 && this.hitTarget.len() > 0)
			{
				this.flag2 = false;
				this.flag5.vecV = 4,00000000.0;
			}
		}

		this.rz += 0,22499999.0 * this.flag1;
		this.SetSpeed_XY(this.flag5.moveVec.x * this.flag5.vecV * this.direction, this.flag5.moveVec.y * this.flag5.vecV);
		return false;
	};
	this.stateLabel = function ()
	{
		if (this.sx < 2,00000000.0)
		{
			this.sx = this.sy += 0,10000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		}

		this.count++;
		this.flag5.vecV -= 0,60000002.0;

		if (this.flag5.vecV < 0,00000000.0)
		{
			this.flag5.vecV = 0,00000000.0;
		}

		if (this.count >= 25)
		{
			this.flag5.moveVec = this.TargetHoming_Vec(this.owner.target, this.flag5.moveVec, 1,00000000.0 * 0,01745329.0, this.direction);
			this.flag5.vecV = 0,00000000.0;
			this.count++;

			if (this.count >= 2)
			{
				this.PlaySE(1072);
				this.count = 0;
				this.flag5.vecR = this.GetTargetAngle(this.owner.target, this.direction);
				this.flag5.vecR = this.Math_MinMax(this.flag5.vecR, -30,00000000.0 * 0,01745329.0, 30,00000000.0 * 0,01745329.0);
				this.flag5.moveVec.x = this.cos(this.flag5.vecR);
				this.flag5.moveVec.y = this.sin(this.flag5.vecR);
				this.stateLabel = function ()
				{
					this.count++;

					if (this.count % 4 == 0)
					{
						local t_ = {};
						t_.scale <- this.sx;
						t_.rot <- this.rz;
						this.SetFreeObject(this.x, this.y, this.direction, this.Shot_Normal_Trail, t_);
					}

					this.flag5.vecV += 0,44999999.0;

					if (this.flag5.vecV >= 17,50000000.0)
					{
						this.flag5.vecV = 17,50000000.0;

						if (this.count >= 120)
						{
							this.func();
							return;
						}
					}

					this.flag5.moveVec = this.TargetHoming_Vec(this.owner.target, this.flag5.moveVec, 0,50000000.0 * 0,01745329.0, this.direction);
					this.subState();
				};
				return;
			}
		}

		this.subState();
	};
}

function Shot_NormalMini( t )
{
	this.SetMotion(t.motion, 3);
	this.flag1 = t.flag1;
	this.flag3 = 0;
	this.flag5 = null;
	this.flag5 = this.owner.shot_normal();
	this.flag5.vecR = t.rot;
	this.sx = this.sy = 0,50000000.0;
	this.flag5.moveVec = this.Vector3();
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.flag5.moveVec.x = 1,00000000.0;
	this.flag5.moveVec.RotateByRadian(t.rot);
	this.SetSpeed_Vec(this.flag5.vecV, this.flag5.vecR, this.direction);
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.SetMotion(2007, 5);
		this.sx = this.sy *= 1,50000000.0;
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.rz += 0,50000000.0 * this.flag1;
			this.sx = this.sy *= 0,89999998.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.hitResult & 8)
		{
			this.func();
			return true;
		}

		this.rz += 0,22499999.0 * this.flag1;
		this.SetSpeed_XY(this.flag5.moveVec.x * this.flag5.vecV * this.direction, this.flag5.moveVec.y * this.flag5.vecV);
		return false;
	};
	this.stateLabel = function ()
	{
		if (this.sx < 1,00000000.0)
		{
			this.sx = this.sy += 0,10000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		}

		this.count++;
		this.flag5.vecV -= 0,60000002.0;

		if (this.flag5.vecV < 0,00000000.0)
		{
			this.flag5.vecV = 0,00000000.0;
		}

		if (this.count >= 25)
		{
			this.flag5.vecV = 0,00000000.0;
			this.count++;

			if (this.count >= 2)
			{
				this.PlaySE(1072);
				this.count = 0;
				this.flag5.moveVec.x = this.cos(this.flag5.vecR);
				this.flag5.moveVec.y = this.sin(this.flag5.vecR);
				this.stateLabel = function ()
				{
					this.count++;

					if (this.count % 4 == 0)
					{
						local t_ = {};
						t_.scale <- this.sx * 0,75000000.0;
						t_.rot <- this.rz;
						this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalMini_Trail, t_);
					}

					this.flag5.vecV += 0,44999999.0;

					if (this.flag5.vecV >= 17,00000000.0)
					{
						this.flag5.vecV = 17,00000000.0;

						if (this.count >= 120)
						{
							this.func();
							return;
						}
					}

					this.flag5.moveVec = this.TargetHoming_Vec(this.owner.target, this.flag5.moveVec, 0,75000000.0 * 0,01745329.0, this.direction);
					this.subState();
				};
				return;
			}
		}

		this.subState();
	};
}

function Shot_NormalMiniB( t )
{
	this.SetMotion(t.motion, 4);
	this.flag1 = t.flag1;
	this.flag3 = 0;
	this.flag5 = null;
	this.flag5 = this.owner.shot_normal();
	this.flag5.vecR = t.rot;
	this.sx = this.sy = 0,50000000.0;
	this.flag5.moveVec = this.Vector3();
	this.cancelCount = 1;
	this.atk_id = 16384;
	this.flag5.moveVec.x = 1,00000000.0;
	this.flag5.moveVec.RotateByRadian(t.rot);
	this.SetSpeed_Vec(this.flag5.vecV, this.flag5.vecR, this.direction);
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.SetMotion(2007, 5);
		this.sx = this.sy *= 1,50000000.0;
		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.rz += 0,50000000.0 * this.flag1;
			this.sx = this.sy *= 0,89999998.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.hitResult & 8)
		{
			this.func();
			return true;
		}

		this.rz += 0,22499999.0 * this.flag1;
		this.SetSpeed_XY(this.flag5.moveVec.x * this.flag5.vecV * this.direction, this.flag5.moveVec.y * this.flag5.vecV);
		return false;
	};
	this.stateLabel = function ()
	{
		if (this.sx < 1,00000000.0)
		{
			this.sx = this.sy += 0,10000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		}

		this.count++;
		this.flag5.vecV -= 0,60000002.0;

		if (this.flag5.vecV < 0,00000000.0)
		{
			this.flag5.vecV = 0,00000000.0;
		}

		if (this.count >= 25)
		{
			this.flag5.vecV = 0,00000000.0;
			this.count++;

			if (this.count >= 2)
			{
				this.PlaySE(1072);
				this.count = 0;
				this.flag5.moveVec.x = this.cos(this.flag5.vecR);
				this.flag5.moveVec.y = this.sin(this.flag5.vecR);
				this.stateLabel = function ()
				{
					this.count++;

					if (this.count % 4 == 0)
					{
						local t_ = {};
						t_.scale <- this.sx * 0,75000000.0;
						t_.rot <- this.rz;
						this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_NormalMini_Trail, t_);
					}

					this.flag5.vecV += 0,44999999.0;

					if (this.flag5.vecV >= 17,00000000.0)
					{
						this.flag5.vecV = 17,00000000.0;

						if (this.count >= 120)
						{
							this.func();
							return;
						}
					}

					this.flag5.moveVec = this.TargetHoming_Vec(this.owner.target, this.flag5.moveVec, 0,50000000.0 * 0,01745329.0, this.direction);
					this.subState();
				};
				return;
			}
		}

		this.subState();
	};
}

function Shot_Normal_Trail( t )
{
	this.DrawActorPriority(190);
	this.SetMotion(2009, 1);
	this.rz = t.rot;
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,05000000.0;
		this.alpha = this.green = this.blue -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_NormalMini_Trail( t )
{
	this.DrawActorPriority(190);
	this.SetMotion(2007, 4);
	this.rz = t.rot;
	this.sx = this.sy = t.scale;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,05000000.0;
		this.alpha = this.green = this.blue -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

class this.shot_normal_v 
{
	brake = true;
	vecV = 7,00000000.0;
	vecR = 0,00000000.0;
	moveVec = null;
}

function Shot_NormalV( t )
{
	this.flag1 = t.flag1;
	this.flag2 = true;
	this.flag3 = 0;
	this.flag5 = this.owner.shot_normal_v();
	this.flag5.moveVec = this.Vector3();
	this.flag5.vecR = t.rot;
	this.sx = this.sy = 0,50000000.0;

	if (this.sin(t.rot) < 0)
	{
		this.SetMotion(2008, 0);
	}
	else
	{
		this.SetMotion(2009, 0);
	}

	this.SetSpeed_Vec(this.flag5.vecV, this.flag5.vecR, this.direction);
	this.cancelCount = 3;
	this.atk_id = 16384;
	this.flag5.moveVec.x = 1,00000000.0;
	this.flag5.moveVec.RotateByRadian(t.rot);
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.SetMotion(this.motion, 2);
		this.sx = this.sy *= 1,50000000.0;
		this.stateLabel = function ()
		{
			this.rz += 0,50000000.0 * this.flag1;
			this.sx = this.sy *= 0,98000002.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 5))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.hitCount >= 3 || this.cancelCount <= 0 || this.grazeCount >= 1 || this.hitResult & 8)
		{
			this.func();
			return true;
		}

		if (this.hitResult)
		{
			if (this.HitCycleUpdate(4))
			{
				this.flag2 = true;
			}
			else if (this.flag5.brake)
			{
				this.flag5.brake = false;
				this.flag5.vecV = 4,00000000.0;
			}
		}

		this.rz += 0,22499999.0 * this.flag1;
		this.SetSpeed_XY(this.flag5.moveVec.x * this.flag5.vecV * this.direction, this.flag5.moveVec.y * this.flag5.vecV);
	};
	this.stateLabel = function ()
	{
		if (this.sx < 2,00000000.0)
		{
			this.sx = this.sy += 0,10000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		}

		this.count++;

		if (this.count % 4 == 0)
		{
			local t_ = {};
			t_.scale <- this.sx;
			t_.rot <- this.rz;
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_Normal_Trail, t_);
		}

		this.flag5.vecV += 0,50000000.0;

		if (this.flag5.vecV >= 10,00000000.0)
		{
			this.flag5.vecV = 10,00000000.0;

			if (this.count >= 120)
			{
				this.func();
				return;
			}
		}

		this.flag5.moveVec = this.TargetHoming_Vec(this.owner.target, this.flag5.moveVec, 0,25000000.0 * 0,01745329.0, this.direction);
		this.subState();
	};
}

function Shot_Front( t )
{
	this.SetMotion(2019, 0);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.atk_id = 65536;
	this.SetTrail(this.motion, 3, 10, 20);
	this.linkObject[0].green = 0,00000000.0;
	this.linkObject[0].red = 0,50000000.0;
	this.rz = t.rot;
	this.SetSpeed_Vec(27,50000000.0, this.rz, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = null;
		this.ReleaseActor.call(this.linkObject[0]);
		this.linkObject = null;
		this.SetMotion(2019, 1);
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.hitResult & 32)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Barrage_Fire( t )
{
	this.SetMotion(2026, 3);
	this.keyAction = this.ReleaseActor;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,98000002.0;
		this.alpha = this.green -= 0,10000000.0;
	};
}

function Shot_Barrage( t )
{
	this.SetMotion(2026, 0);
	this.atk_id = 262144;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetSpeed_Vec(15,00000000.0, this.rz, this.direction);
	this.keyAction = this.ReleaseActor;
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x * 0,01000000.0;
	this.flag1.y = this.va.y * 0,01000000.0;
	this.cancelCount = 1;
	this.func = function ()
	{
		this.SetMotion(this.motion, 1);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,92000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.subState = function ()
	{
		if (this.Vec_Brake(1,00000000.0, 1,00000000.0))
		{
			this.subState = function ()
			{
				this.count++;

				if (this.count == 15)
				{
					this.subState = function ()
					{
						this.AddSpeed_XY(this.flag1.x, this.flag1.y);
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.subState();

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Shot_Charge( t )
{
	this.SetMotion(2029, 1);
	this.sx = this.sy = 0,00000000.0;
	this.flag1 = {};
	this.flag1.bound <- 3;
	this.flag1.roll <- 5,00000000.0 * 0,01745329.0;
	this.flag1.trail <- null;
	this.cancelCount = 3;
	this.flag2 = 0;
	this.atk_id = 131072;
	this.subState = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.ReleaseActor();
			return true;
		}
	};
	this.func = [
		function ()
		{
			this.cancelCount = 3;
			this.HitReset();
			this.flag1.roll <- 10,00000000.0 * 0,01745329.0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.rz += this.flag1.roll;
				this.sx = this.sy += 0,00600000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

				if (this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0)
				{
					this.func[1].call(this);
					return;
				}

				this.HitCycleUpdate(0);

				if ((this.va.y > 0,00000000.0 && this.y + 27 * this.sy >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 * this.sy <= ::camera.camera2d.top) && this.flag1.bound > 0)
				{
					this.PlaySE(1108);
					this.flag1.bound--;
					this.SetSpeed_XY(null, -this.va.y);

					if (this.va.LengthXY() > 8,00000000.0)
					{
						this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
					}

					if (this.va.y > 0,00000000.0)
					{
						if (this.keyTake == 2)
						{
							this.SetMotion(this.motion, 3);
						}
						else
						{
							this.SetMotion(this.motion, 5);
						}
					}
					else if (this.keyTake == 3)
					{
						this.SetMotion(this.motion, 2);
					}
					else
					{
						this.SetMotion(this.motion, 4);
					}
				}
			};

			if (this.initTable.rot == 0)
			{
				this.initTable.rot = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
				this.initTable.rot = this.Math_MinMax(this.initTable.rot, -0,52359873.0, 0,52359873.0);
			}

			local v_ = 12,00000000.0;

			if (this.initTable.rot <= 0,00000000.0)
			{
				this.SetMotion(this.motion, 2);
			}
			else
			{
				this.SetMotion(this.motion, 3);
			}

			this.SetSpeed_Vec(v_, this.initTable.rot, this.direction);
		},
		function ()
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.flag1.trail = null;
			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.initTable.rot *= 0,33000001.0;
			this.cancelCount = 3;
			this.HitReset();
			this.flag1.roll = 10,00000000.0 * 0,01745329.0;
			local t_ = {};
			t_.rot <- this.initTable.rot;
			this.flag1.trail = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_ChargeTrail, t_).weakref();
			this.SetParent.call(this.flag1.trail, this, 0, 0);
			this.DrawActorPriority();
			this.subState = function ()
			{
				if (this.IsScreen(100))
				{
					if (this.flag1.trail)
					{
						this.flag1.trail.func[0].call(this.flag1.trail);
					}

					this.ReleaseActor();
					return true;
				}
			};
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.rz += this.flag1.roll;

				if (this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0)
				{
					this.func[1].call(this);
					return;
				}

				this.HitCycleUpdate(0);

				if ((this.va.y > 0,00000000.0 && this.y + 27 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 <= ::camera.camera2d.top) && this.flag1.bound > 0)
				{
					this.PlaySE(1108);
					this.flag1.bound--;
					this.SetSpeed_XY(null, -this.va.y);

					if (this.flag1.trail)
					{
						this.flag1.trail.rz *= -1,00000000.0;
						this.flag1.trail.func[1].call(this.flag1.trail);
					}

					if (this.va.LengthXY() > 8,00000000.0)
					{
						this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
					}

					if (this.va.y > 0,00000000.0)
					{
						this.SetMotion(this.motion, 3);
					}
					else
					{
						this.SetMotion(this.motion, 2);
					}
				}
			};
			local t_ = {};
			t_.rot <- this.initTable.rot + 60 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			local t_ = {};
			t_.rot <- this.initTable.rot - 60 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			local t_ = {};
			t_.rot <- this.initTable.rot + 30 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			local t_ = {};
			t_.rot <- this.initTable.rot - 30 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.Shot_ChargeSub, t_);
			this.SetMotion(2028, 1);
			this.SetSpeed_Vec(7,00000000.0, this.initTable.rot, this.direction);
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.motion != 2020)
		{
			this.func[1].call(this);
			return;
		}

		local r_ = (3,14159203.0 * 2 - this.rz) * 0,20000000.0;

		if (r_ < 0,01745329.0)
		{
			this.rz += 0,01745329.0;
		}
		else
		{
			this.rz += r_;
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,20000000.0;

		if (this.sx > 1,00000000.0)
		{
			this.sx = this.sy = 1,00000000.0;
		}

		this.x = this.owner.point0_x;
		this.y = this.owner.point0_y;
	};
}

function Shot_ChargeSub( t )
{
	this.flag1 = {};
	this.flag1.rot <- t.rot;
	this.flag1.bound <- 2;
	this.flag1.roll <- 5,00000000.0 * 0,01745329.0;
	this.flag1.trail <- null;
	this.cancelCount = 3;
	this.atk_id = 131072;
	local v_ = 7,00000000.0;

	if (t.rot == 0,00000000.0)
	{
		this.SetMotion(2028, 1);
	}
	else if (this.sin(t.rot) <= 0)
	{
		this.SetMotion(2028, 2);
	}
	else
	{
		this.SetMotion(2028, 3);
	}

	this.func = [
		function ()
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.flag1.trail = null;
			this.SetMotion(2029, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		if (this.IsScreen(100))
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.ReleaseActor();
			return true;
		}
	};
	this.flag1.roll = 10,00000000.0 * 0,01745329.0;
	local t_ = {};
	t_.rot <- this.flag1.rot;
	this.flag1.trail = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_ChargeTrail, t_).weakref();
	this.SetParent.call(this.flag1.trail, this, 0, 0);
	this.DrawActorPriority();
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.rz += this.flag1.roll;

		if (this.hitCount >= 1 && this.keyTake <= 3 || this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0)
		{
			this.func[0].call(this);
			return;
		}

		this.HitCycleUpdate(0);

		if ((this.va.y > 0,00000000.0 && this.y + 27 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 <= ::camera.camera2d.top) && this.flag1.bound > 0)
		{
			this.PlaySE(1108);
			this.flag1.bound--;
			this.SetSpeed_XY(null, -this.va.y);

			if (this.flag1.trail)
			{
				this.flag1.trail.rz *= -1,00000000.0;
				this.flag1.trail.func[1].call(this.flag1.trail);
			}

			if (this.va.LengthXY() > 8,00000000.0)
			{
				this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
			}

			if (this.va.y > 0,00000000.0)
			{
				this.SetMotion(this.motion, 3);
			}
			else
			{
				this.SetMotion(this.motion, 2);
			}
		}
	};
	this.SetSpeed_Vec(v_, this.flag1.rot, this.direction);
}

function Shot_ChargeTrail( t )
{
	this.rz = t.rot;
	this.SetMotion(2028, 4);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.sx = 0,50000000.0;
			this.sy = 1,00000000.0;
			this.alpha = 0,00000000.0;
			this.red = this.blue = this.green = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha += 0,20000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.subState = function ()
					{
						this.alpha = this.green = this.blue -= 0,02500000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.sx += (1,50000000.0 - this.sx) * 0,10000000.0;
		this.sy *= 0,99000001.0;
		this.subState();
	};
}

function Shot_ChargeCore( t )
{
	this.SetMotion(2029, 1);
	this.isVisible = false;
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		if (this.Damage_ConvertOP(this.x, this.y, 0) || this.owner.motion == 2025)
		{
			this.ReleaseActor();
			return true;
		}

		this.count++;

		if (this.count % 5 == 1)
		{
			this.flag1++;
			local t_ = {};
			t_.rot <- this.rz - this.flag1 * 15 * 0,01745329.0 + 45 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.FullChargeShot_Sub, t_);
			local t_ = {};
			t_.rot <- this.rz + this.flag1 * 15 * 0,01745329.0 - 45 * 0,01745329.0;
			this.SetShot(this.x, this.y, this.direction, this.owner.FullChargeShot_Sub, t_);

			if (this.flag1 >= 9)
			{
				this.ReleaseActor();
			}
		}
	};
}

function FullChargeShot_Sub( t )
{
	this.SetMotion(2028, 0);
	this.flag1 = {};
	this.flag1.rot <- t.rot;
	this.flag1.bound <- 2;
	this.flag1.roll <- 5,00000000.0 * 0,01745329.0;
	this.cancelCount = 3;
	this.flag2 = 0;
	this.subState = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}
	};
	this.func = [
		function ()
		{
		},
		function ()
		{
			this.SetMotion(2029, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.cancelCount = 3;
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.rz += this.flag1.roll;

		if (this.grazeCount > 0 || this.hitCount >= 1 && this.keyTake <= 3 || this.hitCount >= 1 || this.cancelCount <= 0 || this.owner.motion == 2020 && this.owner.keyTake == 0 || this.owner.motion == 2025)
		{
			this.func[1].call(this);
			return;
		}

		this.HitCycleUpdate(0);

		if ((this.va.y > 0,00000000.0 && this.y + 27 >= ::camera.camera2d.bottom || this.va.y < 0,00000000.0 && this.y - 27 <= ::camera.camera2d.top) && this.flag1.bound > 0)
		{
			this.PlaySE(1108);
			this.flag1.bound--;
			this.SetSpeed_XY(null, -this.va.y);

			if (this.va.LengthXY() > 8,00000000.0)
			{
				this.SetSpeed_XY(this.va.x * 0,80000001.0, this.va.y * 0,80000001.0);
			}
		}
	};
	local v_ = 12,00000000.0;

	if (this.sin(this.flag1.rot) <= 0)
	{
		this.SetMotion(this.motion, 0);
	}
	else
	{
		this.SetMotion(this.motion, 0);
	}

	this.SetSpeed_Vec(6,00000000.0, this.flag1.rot, this.direction);
}

function Shot_Okult( t )
{
	this.SetMotion(2508, 5);
	this.flag5 = {};
	local pos_ = this.Vector3();
	pos_.x = this.owner.target.x - this.x;
	pos_.y = this.owner.target.y - this.y;

	if (pos_.Length() <= 75)
	{
		this.flag5.rot <- 0,00000000.0;
	}
	else
	{
		this.flag5.rot <- this.atan2(pos_.y, pos_.x * this.direction);
	}

	this.rz = this.flag5.rot;
	this.anime.is_write = true;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_Okult_Slash, t_);
	this.DrawActorPriority(180);
	local t_ = {};
	t_.rot <- this.rz;
	this.flag2 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.owner.Occult_Back, t_).weakref();
	this.flag2.anime.stencil = this;
	local t_ = {};
	t_.rot <- this.rz;
	this.flag3 = this.SetShotStencil(this.x, this.y, this.direction, this.owner.Shot_OkultMask, t_);
	this.flag5.center <- [];
	this.flag5.num <- 5;
	this.flag5.list <- [
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3(),
		this.Vector3()
	];
	this.flag5.list[0].x = 0;
	this.flag5.list[0].y = 0;
	this.flag5.list[1].x = 10;
	this.flag5.list[1].y = -15;
	this.flag5.list[2].x = -15;
	this.flag5.list[2].y = 35;
	this.flag5.list[3].x = 5;
	this.flag5.list[3].y = -40;
	this.flag5.list[4].x = -20;
	this.flag5.list[4].y = 15;
	this.flag5.list[5].x = -10;
	this.flag5.list[5].y = -55;
	this.flag5.list[6].x = 25;
	this.flag5.list[6].y = 42;

	foreach( a in this.flag5.list )
	{
		a.RotateByRadian(this.rz);
	}

	this.flag5.lostCount <- 0;
	this.func = [
		function ()
		{
			if (this.owner.skima == this)
			{
				this.owner.skima = null;
			}

			foreach( a in this.flag5.center )
			{
				if (a)
				{
					a.func[0].call(a);
				}
			}

			this.stateLabel = function ()
			{
				this.sx *= 0,80000001.0;
				this.sy *= 0,80000001.0;

				if (this.sx <= 0,02000000.0)
				{
					this.ReleaseActor.call(this.flag3);
					this.ReleaseActor.call(this.flag2);
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
	};
	this.stateLabel = function ()
	{
		if (this.team.current.IsDamage() || (this.owner.motion == 2500 || this.owner.motion == 2501) && this.owner.keyTake == 0)
		{
			this.func[0].call(this);
			return;
		}

		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,25000000.0;
		this.count++;

		if (this.count <= 30 && this.flag5.num > this.flag4)
		{
			local t_ = {};
			t_.rot <- 6,00000000.0 * 0,01745329.0 * (this.flag5.list[this.flag4].y / 55,00000000.0) + this.flag5.rot;
			t_.mask <- this.flag3;
			this.flag5.center.append(this.SetShotStencil(this.x + (-180 * this.cos(this.flag5.rot) + this.flag5.list[this.flag4].x) * this.direction, this.y - 180 * this.sin(this.flag5.rot) + this.flag5.list[this.flag4].y, this.direction, this.owner.Shot_OkultSotoba, t_).weakref());
			this.flag4++;
		}

		if (this.count >= 45)
		{
			this.subState = function ()
			{
				if (this.count % 6 == 1)
				{
					local a_ = this.flag5.center.len();

					if (a_ > 0)
					{
						this.PlaySE(1075);

						if (this.flag5.center[0])
						{
							this.flag5.center[0].func[1].call(this.flag5.center[0]);
						}

						this.flag5.center.remove(0);
					}
					else
					{
						this.subState = function ()
						{
						};
					}
				}
			};
		}

		if (this.count == 120)
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Shot_SideOccult( t )
{
	this.SetMotion(2508, 9);
	this.anime.is_write = true;
	this.flag1 = this.SetFreeObjectStencil(this.x, this.y, this.direction, this.Shot_SideOccultBack, {}, this.weakref()).weakref();
	this.rx = 80 * 0,01745329.0;
	this.rz = 0,52359873.0;
	this.flag2 = this.SetFreeObject(this.x, this.y, this.direction, this.Shot_SideOccultShadow, {}).weakref();
	this.cancelCount = 3;
	this.atk_id = 524288;
	this.sx = this.sy = 0,85000002.0;
	this.SetCollisionScaling(this.sx, 1,00000000.0, 1,00000000.0);
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_SideOccultFire, {});
	this.func = [
		function ()
		{
			if (this.owner.skima == this)
			{
				this.owner.skima = null;
			}

			this.callbackGroup = 0;
			this.flag1.func[0].call(this.flag1);
			this.flag2.func[0].call(this.flag2);
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,00500000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,00500000.0;
		this.SetCollisionScaling(this.sx, 1,00000000.0, 1,00000000.0);
		this.flag2.sx = this.flag2.sy = this.sx;
		this.HitCycleUpdate(0);
		this.count++;

		if (this.count >= 210 || this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount >= 6 || this.Damage_ConvertOP(this.x, this.y, 0))
		{
			this.func[0].call(this);
			return;
		}
	};
}

function Shot_SideOccultFire( t )
{
	this.SetMotion(2508, 12);
	this.rx = 80 * 0,01745329.0;
	this.rz = -3,14159203.0;
	this.sx = this.sy = 0,85000002.0;
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.alpha = this.blue -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_SideOccultBack( t )
{
	this.SetMotion(2508, 10);
	this.anime.stencil = t.pare;
	this.anime.is_equal = true;
	this.sx = this.sy = 0,85000002.0;
	this.func = [
		function ()
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
	];
}

function Shot_SideOccultShadow( t )
{
	this.SetMotion(2508, 11);
	this.rx = 80 * 0,01745329.0;
	this.rz = 0,52359873.0;
	this.sx = this.sy = 0,85000002.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,00500000.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
}

function Shot_OkultMask( t )
{
	this.SetMotion(2508, 4);
	this.rz = -23 * 0,01745329.0 + t.rot;
	this.DrawActorPriority(180);
	this.anime.is_write = true;
}

function Occult_Back( t )
{
	this.SetMotion(2508, 6);
	this.SetSpeed_XY(0,00000000.0, -3,00000000.0);
	this.anime.is_equal = true;
	this.anime.stencil = t.pare;
	this.DrawActorPriority(180);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count * 3 >= 128)
		{
			this.count = 0;
			this.y += 256;
		}
	};
}

function Shot_OkultSotoba( t )
{
	this.SetMotion(2509, 0);
	this.atk_id = 524288;
	this.DrawActorPriority(180);
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.SetSpeed_Vec(20,00000000.0, t.rot, this.direction);
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.keyAction = this.ReleaseActor;
	this.cancelCount = 1;
	this.anime.stencil = t.mask;
	this.subState = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return true;
		}

		this.count++;
	};
	this.func = [
		function ()
		{
			this.SetMotion(2509, 2);
			this.stateLabel = function ()
			{
				this.sy -= 0,10000000.0;

				if (this.sy <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.subState = function ()
			{
				if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 2))
				{
					this.ReleaseActor();
					return true;
				}

				if (this.cancelCount <= 0 || this.grazeCount > 0)
				{
					this.func[0].call(this);
					return true;
				}

				this.count++;
			};
			this.grazeCount = 0;
			this.cancelCount = 1;
			this.HitReset();
			this.SetMotion(2509, 1);
			this.DrawActorPriority(200);
			this.SetSpeed_Vec(30,00000000.0, this.rz, this.direction);
			this.count = 0;
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				if (this.count == 10)
				{
					this.anime.stencil = null;
					this.anime.is_equal = true;
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		if (this.count == 7)
		{
			this.SetSpeed_Vec(0,50000000.0, this.rz, this.direction);
		}
	};
}

function Shot_Okult_Slash( t )
{
	this.SetMotion(2508, 0);
	this.sx = this.sy = 0,00000000.0;
	this.rz = -23 * 0,01745329.0;
	this.stateLabel = function ()
	{
		this.sx += (1,00000000.0 - this.sx) * 0,15000001.0;
		this.sy += (2,00000000.0 - this.sy) * 0,30000001.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Change( t )
{
	this.SetMotion(3929, 0);
	this.atk_id = 536870912;
	local func_ = function ()
	{
		this.ReleaseActor();
	};
	this.rz = t.rot;
	this.SetSpeed_Vec(12,50000000.0, this.rz, this.direction);
	this.cancelCount = 1;
	this.func = function ()
	{
		this.keyAction = this.ReleaseActor;
		this.SetMotion(this.motion, 2);
		this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,92000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100) || this.Damage_ConvertOP(this.x, this.y, 1))
		{
			this.ReleaseActor();
			return true;
		}

		this.TargetHoming(this.owner.target, 0,75000000.0 * 0,01745329.0, this.direction);
		this.rz = this.atan2(this.va.y, this.va.x * this.direction);

		if (this.cancelCount <= 0 || this.hitCount > 0 || this.grazeCount > 0)
		{
			this.func();
			return true;
		}
	};
}

function Shot_ChangeFin( t )
{
	this.SetMotion(3939, 1);
	this.atk_id = 536870912;
	this.flag1 = {};
	this.flag1.trail <- null;
	local t_ = {};
	t_.rot <- t.rot;
	this.flag1.trail = this.SetFreeObject(this.x, this.y, this.direction, this.owner.Shot_ChangeFinTrail, t_).weakref();
	this.cancelCount = 3;
	this.SetSpeed_Vec(15,00000000.0, this.initTable.rot, this.direction);
	this.subState = function ()
	{
		if (this.IsScreen(100 * this.sx) || this.Damage_ConvertOP(this.x, this.y, 10))
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.ReleaseActor();
			return true;
		}
	};
	this.func = [
		function ()
		{
			if (this.flag1.trail)
			{
				this.flag1.trail.func[0].call(this.flag1.trail);
			}

			this.flag1.trail = null;
			this.SetMotion(this.motion, 1);
			this.SetSpeed_XY(-5,00000000.0 * this.direction, -5,00000000.0);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(null, 0,25000000.0);
				this.rz -= 10 * 0,01745329.0;
				this.alpha -= 0,05000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		if (this.hitCount >= 1 || this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		this.rz += 0,17453292.0;
		this.HitCycleUpdate(0);
		this.sx = this.sy += 0,02500000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Shot_ChangeFinTrail( t )
{
	this.rz = t.rot;
	this.SetMotion(3939, 2);
	this.alpha = 0,00000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.sx = 0,50000000.0;
			this.sy = 1,00000000.0;
			this.alpha = 0,00000000.0;
			this.red = this.blue = this.green = 1,00000000.0;
			this.subState = function ()
			{
				this.alpha += 0,20000000.0;

				if (this.alpha >= 1,00000000.0)
				{
					this.subState = function ()
					{
						this.alpha = this.green = this.blue -= 0,02500000.0;

						if (this.alpha <= 0,00000000.0)
						{
							this.func[1].call(this);
						}
					};
				}
			};
		}
	];
	this.func[1].call(this);
	this.stateLabel = function ()
	{
		this.sx += (1,50000000.0 - this.sx) * 0,10000000.0;
		this.sy *= 0,99000001.0;
		this.subState();
	};
}

function SPShot_A( t )
{
	this.rz = t.rot;
	this.SetMotion(3009, 0);
	this.atk_id = 1048576;
	this.flag1 = 0;
	this.SetSpeed_Vec(30,00000000.0, t.rot, this.direction);
	this.cancelCount = 3;
	this.FitBoxfromSprite();
	this.func = [
		function ()
		{
			this.SetMotion(3009, 1);
			this.keyAction = this.ReleaseActor;
			this.stateLabel = function ()
			{
				this.SetSpeed_XY(this.va.x * 0,94999999.0, this.va.y * 0,94999999.0);
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(200) || this.Damage_ConvertOP(this.x, this.y, 4))
		{
			this.ReleaseActor();
			return true;
		}

		if (this.cancelCount <= 0)
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitResult)
		{
			if (this.hitResult & 31)
			{
				this.SetSpeed_Vec(1,00000000.0, this.rz, this.direction);
				this.stateLabel = function ()
				{
					if (this.count >= 15 || this.hitCount >= 4 || this.hitResult & 8)
					{
						this.owner.SPShot_A_Exp.call(this, null);
						return;
					}

					this.HitCycleUpdate(4);
					this.count++;
				};
			}

			this.HitCycleUpdate(4);
		}

		this.count++;
	};
}

function SPShot_A_Exp( t )
{
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.SetMotion(3009, 2);
	this.atk_id = 1048576;
	this.HitReset();
	this.stateLabel = null;
	this.keyAction = this.ReleaseActor;
}

function SPShot_A_Release( t )
{
	this.rz = t.rz;
	this.SetMotion(3009, 3);
	this.keyAction = this.ReleaseActor;
}

function SPShot_B( t )
{
	this.SetMotion(3019, 3);
	this.atk_id = 2097152;
	this.cancelCount = 9;
	this.flag1 = [];
	this.flag2 = {};
	this.flag2.range <- 0,00000000.0;
	this.flag3 = 8,00000000.0;
	this.SetSpeed_XY(15,00000000.0 * this.direction, 0,00000000.0);

	for( local i = 0; i < 4; i++ )
	{
		local t_ = {};
		t_.rot <- (45 + 90 * i) * 0,01745329.0;

		if (i <= 1)
		{
			t_.rotRate <- 1,00000000.0;
		}
		else
		{
			t_.rotRate <- -1,00000000.0;
		}

		this.flag1.append(this.SetObject(this.x, this.y, this.direction, this.owner.SPShot_B_Point, t_).weakref());
	}

	this.func = function ()
	{
		foreach( a in this.flag1 )
		{
			if (a)
			{
				a.func();
			}
		}

		this.callbackGroup = 0;
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,92000002.0;
			this.alpha -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.owner.motion == 3010 && this.owner.keyTake == 0)
		{
			this.func();
			return;
		}

		if (this.va.x * this.direction >= 2,50000000.0 && this.IsScreen(0))
		{
			this.SetSpeed_XY(2,00000000.0 * this.direction, 0,00000000.0);
		}

		this.count++;

		foreach( a in this.flag1 )
		{
			if (a)
			{
				a.Warp(this.x + this.flag2.range * a.flag1.x * this.direction, this.y + this.flag2.range * a.flag1.y);
			}
			else
			{
				this.func();
				return;
			}
		}

		this.flag2.range += this.flag3;

		if (this.flag2.range >= 160,00000000.0)
		{
			this.PlaySE(1102);
			this.SetMotion(3019, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.count = 0;
			this.flag2.range = 160,00000000.0;
			this.sx = this.sy = 1,00000000.0;
			this.FitBoxfromSprite();

			foreach( a in this.flag1 )
			{
				if (a)
				{
					a.SetMotion(3019, 1);
					this.SetFreeObject(a.x, a.y, this.direction, this.owner.SPShot_B_SetEffect, {});
				}
			}

			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 300 || this.hitCount >= 3 || this.cancelCount <= 0 || this.flag2.range <= 25 || this.owner.motion == 3010 && this.owner.keyTake == 0 || this.Damage_ConvertOP(this.x, this.y, 10, 2))
				{
					this.func();
					return;
				}

				this.flag2.range -= 0,50000000.0;

				if (this.hitResult & 32)
				{
					this.flag2.range -= 3,00000000.0;
				}

				this.sx = this.flag2.range / 160,00000000.0;
				this.sy = this.flag2.range / 160,00000000.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

				foreach( val, a in this.flag1 )
				{
					if (a)
					{
						a.Warp(this.x + this.flag2.range * a.flag1.x * this.direction, this.y + this.flag2.range * a.flag1.y);

						if (a.life <= 0)
						{
							a.func();
							this.func();
							return;
						}
					}
					else
					{
						this.func();
						return;
					}
				}

				this.HitCycleUpdate(3);
			};
		}
	};
}

function SPShot_B_SetEffect( t )
{
	this.SetMotion(3019, 0);
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.rz += 13,00000000.0 * 0,01745329.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_B_Point( t )
{
	this.SetMotion(3019, 0);
	this.atk_id = 2097152;
	this.life = 1;
	this.flag1 = this.Vector3();
	this.flag1.x = this.cos(t.rot);
	this.flag1.y = this.sin(t.rot);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.keyTake == 0)
		{
			if (this.Damage_ConvertOP(this.x, this.y, 2, 1))
			{
				this.ReleaseActor();
				return;
			}

			this.rz += 18 * 0,01745329.0 * this.initTable.rotRate;

			if (this.count % 2 == 1)
			{
				local t_ = {};
				t_.rot <- this.rz;
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_B_Trail, t_);
			}
		}
		else
		{
			this.rz += 0,01745329.0 * this.initTable.rotRate;
		}
	};
	this.func = function ()
	{
		this.owner.SPShot_B_PointFade.call(this, null);
	};
}

function SPShot_B_Trail( t )
{
	this.SetMotion(3019, 0);
	this.rz = t.rot;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.alpha = this.green = this.blue -= 0,07500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_B_PointFade( t )
{
	this.SetMotion(3019, 4);
	this.sx = this.sy = 2,00000000.0;
	local i = 0;

	while (i < 6)
	{
		i++;
		this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_B_Ball, {});
	}

	this.stateLabel = function ()
	{
		this.AddSpeed_XY(0,00000000.0, -0,20000000.0);

		if (this.rand() % 100 <= 25)
		{
			this.SetFreeObject(this.x, this.y, this.direction, this.owner.SPShot_B_Ball, {});
		}

		this.sx = this.sy *= 0,92000002.0;
		this.alpha -= 0,05000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_B_Ball( t )
{
	this.SetMotion(3019, 5 + this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.sx = this.sy = 0,75000000.0 + this.rand() % 6 * 0,10000000.0;
	this.SetSpeed_Vec(4 + this.rand() % 4, this.rand() % 360 * 0,01745329.0, this.direction);
	this.stateLabel = function ()
	{
		this.VX_Brake(0,25000000.0);
		this.AddSpeed_XY(0,00000000.0, -0,25000000.0);
		this.sx = this.sy *= 0,98000002.0;
		this.alpha = this.blue -= 0,03500000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_G( t )
{
	this.SetMotion(3069, 0);
	this.DrawActorPriority(180);
	this.rz = t.rot;
	this.keyAction = this.ReleaseActor;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, function ( t_ )
	{
		this.SetMotion(3069, 3);
		this.DrawActorPriority(180);
		this.rz = t.rot;
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,05000000.0;
			this.alpha = this.green = this.blue -= 0,20000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	}, t_);
}

function SPShot_G_Head( t )
{
	this.SetMotion(3069, 1);
	this.func = function ()
	{
		this.SetSpeed_XY(this.initTable.pare.va.x, this.initTable.pare.va.y);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,98000002.0;
			this.alpha = this.green = this.blue -= 0,10000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		if (this.initTable.pare.hitStopTime == 0)
		{
			this.rz -= 10,00000000.0 * 0,01745329.0;
		}

		if (this.initTable.pare.motion >= 3060 && this.initTable.pare.motion <= 3064)
		{
			this.Warp(this.initTable.pare.point1_x, this.initTable.pare.point1_y);
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SPShot_G_Trail( t )
{
	this.rz = t.rot;
	this.alpha = 0,00000000.0;
	this.SetMotion(3069, 2);
	this.DrawActorPriority(180);
	this.sx = 0,25000000.0;
	this.func = function ()
	{
		this.SetSpeed_XY(this.initTable.pare.va.x, this.initTable.pare.va.y);
		this.stateLabel = function ()
		{
			this.sy *= 0,94999999.0;
			this.alpha = this.green = this.blue -= 0,07500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
	this.stateLabel = function ()
	{
		this.alpha += 0,20000000.0;

		if (this.alpha > 1,00000000.0)
		{
			this.alpha = 1,00000000.0;
		}

		if (this.initTable.pare.hitStopTime == 0)
		{
			this.sx += (1,50000000.0 - this.sx) * 0,25000000.0;
		}

		if (this.initTable.pare.motion >= 3060 && this.initTable.pare.motion <= 3064)
		{
			this.Warp(this.initTable.pare.point1_x, this.initTable.pare.point1_y);
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A( t )
{
	this.SetMotion(t.motion, 0);
	this.atk_id = 67108864;
	this.flag1 = {};
	this.flag2 = 20,00000000.0;
	this.flag1.range <- 20,00000000.0;
	this.flag1.rot <- t.rot;
	this.sx = this.sy = 0,00000000.0;
	this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
	this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);

	if (this.team == 1)
	{
		this.group = 256;
	}
	else
	{
		this.group = 512;
	}

	this.subState = function ()
	{
		if (this.owner.motion == 4000)
		{
			if (this.owner.keyTake == 2)
			{
				this.stateLabel = function ()
				{
					this.sx = this.sy += 0,10000000.0;
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
				return true;
			}

			this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
			this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
		}
		else
		{
			this.ReleaseActor();
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.sx += 0,02500000.0;

		if (this.sx > 2,00000000.0)
		{
			this.sx = 2,00000000.0;
		}

		this.sy = this.sx;
		this.flag1.range += this.flag2;
		this.flag2 -= 2,00000000.0;

		if (this.flag2 < 2,00000000.0)
		{
			this.flag2 = 2,00000000.0;
			this.count++;
		}

		if (this.count >= 35)
		{
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.sy = this.sx *= 0,94999999.0;
				this.flag1.range *= 0,80000001.0;
				this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
				this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
			};
		}

		this.flag1.rot -= 0,07500000.0;
	};
}

function SpellShot_A_Bullet( t )
{
	this.SetMotion(t.motion, 1);
	this.atk_id = 67108864;
	this.sx = this.sy = 2,00000000.0;
	this.SetSpeed_Vec(20,00000000.0, t.rot, this.direction);
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0);
		this.count++;

		if (this.count >= 30)
		{
			this.TargetHoming(this.owner.target, 180,00000000.0 * 0,01745329.0, this.direction);
			this.stateLabel = function ()
			{
				this.count++;
				this.TargetHoming(this.owner.target, 0,50000000.0 * 0,01745329.0, this.direction);
				local t_ = {};
				t_.motion <- this.motion;
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_A_Trail, t_);
				this.AddSpeed_Vec(2,00000000.0, null, 30,00000000.0, this.direction);

				if (this.count >= 120)
				{
					this.ReleaseActor();
				}

				return;
			};
		}

		this.TargetHoming(this.owner.target, 3,00000000.0 * 0,01745329.0, this.direction);
		local t_ = {};
		t_.motion <- this.motion;
		this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_A_Trail, t_);
	};
}

function SpellShot_A_Flash( t )
{
	this.SetMotion(t.motion, 2);
	this.flag1 = 1,50000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 1,10000002.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A_Trail( t )
{
	this.SetMotion(t.motion, 4);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,92000002.0;
		this.alpha -= 0,08000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A( t )
{
	this.SetMotion(t.motion, 0);
	this.flag1 = {};
	this.flag2 = 20,00000000.0;
	this.flag1.range <- 20,00000000.0;
	this.flag1.rot <- t.rot;
	this.sx = this.sy = 0,00000000.0;
	this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
	this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
	this.EnableTimeStop(false);
	this.subState = function ()
	{
		if (this.owner.motion == 4000)
		{
			if (this.owner.keyTake == 2)
			{
				this.stateLabel = function ()
				{
					this.sx = this.sy += 0,10000000.0;
					this.alpha -= 0,10000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				};
				return true;
			}

			this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
			this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
		}
		else
		{
			this.ReleaseActor();
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}

		this.sx += 0,02500000.0;

		if (this.sx > 2,00000000.0)
		{
			this.sx = 2,00000000.0;
		}

		this.sy = this.sx;
		this.flag1.range += this.flag2;
		this.flag2 -= 2,00000000.0;

		if (this.flag2 < 2,00000000.0)
		{
			this.flag2 = 2,00000000.0;
			this.count++;
		}

		if (this.count >= 35)
		{
			this.stateLabel = function ()
			{
				if (this.subState())
				{
					return;
				}

				this.sy = this.sx *= 0,94999999.0;
				this.flag1.range *= 0,80000001.0;
				this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
				this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot);
			};
		}

		this.flag1.rot -= 0,07500000.0;
	};
}

function SpellShot_A_Bullet( t )
{
	this.SetMotion(t.motion, 1);
	this.atk_id = 67108864;
	this.target = this.owner.target.weakref();
	this.sx = this.sy = 0,50000000.0;
	this.SetSpeed_Vec(20,00000000.0, t.rot, this.direction);
	this.PlaySE(1156);
	this.cancelCount = 3;
	this.SetTrail(this.motion, 6, 20, 100);
	this.atkRate_Pat = t.rate;
	this.flag1 = 0,10471975.0;
	this.func = function ()
	{
		this.rz += 8,00000000.0 * 0,01745329.0;

		if (this.hitResult)
		{
			if (this.cancelCount <= 0 || this.hitCount >= 1)
			{
				local t_ = {};
				t_.motion <- this.motion;
				this.SpellShot_A_Hit(t_);
			}
			else
			{
				this.HitReset();
			}
		}
		else if (this.count >= 180 || this.IsScreen(300,00000000.0))
		{
			local t_ = {};
			t_.motion <- this.motion;
			this.SpellShot_A_Hit(t_);
		}
	};
	this.stateLabel = function ()
	{
		this.Vec_Brake(0,50000000.0, 1,00000000.0);
		this.count++;
		this.sx = this.sy += 0,05000000.0;

		if (this.sx > 1,75000000.0)
		{
			this.sx = this.sy = 1,75000000.0;
		}

		if (this.count >= 40)
		{
			this.TargetHoming(this.owner.target, 360,00000000.0 * 0,01745329.0, this.direction);
			this.stateLabel = function ()
			{
				this.count++;
				this.TargetHoming(this.owner.target, this.flag1, this.direction);
				this.flag1 -= 0,10000000.0 * 0,01745329.0;

				if (this.flag1 < 0,05235988.0)
				{
					this.flag1 = 0,05235988.0;
				}

				this.AddSpeed_Vec(3,00000000.0, null, 45,00000000.0, this.direction);
				this.func();
				return;
			};
			return;
		}

		this.TargetHoming(this.owner.target, 3,00000000.0 * 0,01745329.0, this.direction);
		this.func();
	};
}

function SpellShot_A_Flash( t )
{
	this.SetMotion(t.motion, 2);
	this.sx = this.sy = 0,25000000.0 + this.rand() % 50 * 0,01000000.0;
	this.rz = 0,01745329.0 * this.rand() % 360;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.alpha -= 0,04000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A_Trail( t )
{
	this.SetMotion(t.motion, 4);
	this.sx = this.sy = 1,00000000.0;
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,92000002.0;
		this.alpha -= 0,10000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A_Hit( t )
{
	this.SetMotion(t.motion, 2);
	this.atk_id = 67108864;
	this.sx = this.sy = 1,50000000.0;
	this.rz = 0,01745329.0 * this.rand() % 360;
	this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
	this.stateLabel = function ()
	{
		this.linkObject[0].alpha -= 0,10000000.0;
		this.linkObject[0].anime.length *= 0,80000001.0;
		this.linkObject[0].anime.radius0 *= 0,80000001.0;

		if (this.linkObject[0].alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}

		this.sx = this.sy *= 0,80000001.0;
		this.alpha -= 0,04000000.0;

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
		}
	};
	local t_ = {};
	t_.motion <- this.motion;
	local init_ = function ( t__ )
	{
		this.SetMotion(t__.motion, 5);
		this.stateLabel = function ()
		{
			this.sx = this.sy *= 0,89999998.0;
		};
		this.keyAction = function ()
		{
			this.ReleaseActor();
		};
	};
	this.SetFreeObject(this.x, this.y, this.direction, init_, t_);
}

function SpellShot_A_Aura( t )
{
	this.SetMotion(7013, 0);

	if (this.team == 1)
	{
		this.group = 256;
	}
	else
	{
		this.group = 512;
	}

	this.stateLabel = function ()
	{
		local a_ = this.owner;

		if (a_.motion == 4000)
		{
			this.Warp(a_.x, a_.y);
			this.red += 0,05000000.0;
			this.green += 0,05000000.0;
			this.blue += 0,05000000.0;

			if (this.red > 1,00000000.0)
			{
				this.red = 1,00000000.0;
			}

			if (this.green > 1,00000000.0)
			{
				this.green = 1,00000000.0;
			}

			if (this.blue > 1,00000000.0)
			{
				this.blue = 1,00000000.0;
			}

			if (a_.keyTake >= 4)
			{
				this.ReleaseActor();
			}
		}
		else
		{
			this.ReleaseActor();
		}
	};
}

function SpellShot_A_Bou( t )
{
	this.SetMotion(4006, 0);
	this.flag1 = this.Vector3();
	this.flag2 = this.Vector3();
	this.flag1.x = this.x;
	this.flag1.y = this.y;
	this.EnableTimeStop(false);
	this.flag2.y = -25,00000000.0;
	this.func = function ()
	{
		local pos_ = this.Vector3();
		this.GetPoint.call(this.owner, 2, pos_);
		this.Warp(pos_.x, pos_.y - 600,00000000.0);
		this.flag1.x = this.x;
		this.flag1.y = this.y;
		this.flag2.y = 40,00000000.0;
	};
	this.stateLabel = function ()
	{
		local pos_ = this.Vector3();
		this.GetPoint.call(this.owner, 2, pos_);
		this.flag1.y += this.flag2.y;
		this.flag1.x = pos_.x;
		this.Warp(this.flag1.x, this.flag1.y);

		if (this.owner.motion != 4000)
		{
			this.ReleaseActor();
			return;
		}
	};
}

function SpellShot_C( t )
{
	this.SetMotion(4029, 0);
	this.atk_id = 67108864;
	this.sx = this.sy = 0,10000000.0;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.cancelCount = 15;
	this.flag5 = {};
	this.flag5.aura <- null;
	this.atkRate_Pat = t.rate;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 3);

			if (this.flag5.aura)
			{
				this.flag5.aura.func();
			}

			this.stateLabel = function ()
			{
				this.rz += 0,10000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.PlaySE(1161);
			this.EnableTimeStop(true);
			this.SetMotion(this.motion, 1);
			this.HitReset();
			this.sx = this.sy = 1,25000000.0;
			this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			this.count = 0;
			local r_ = 60;

			if (this.owner.input.x * this.direction > 0)
			{
				r_ = 40;
			}

			if (this.owner.input.x * this.direction < 0)
			{
				r_ = 75;
			}

			this.SetSpeed_Vec(25,00000000.0, r_ * 0,01745329.0, this.direction);
			this.cancelCount = 30;
			this.stateLabel = function ()
			{
				if (this.cancelCount <= 0)
				{
					this.team.spell_enable_end = true;
					this.func[0].call(this);
					return;
				}

				if (this.va.x > 0,00000000.0 && this.x > ::battle.scroll_right - 50 || this.va.x < 0,00000000.0 && this.x < ::battle.scroll_left + 50)
				{
					this.SetSpeed_XY(0,00000000.0, null);
				}

				this.count++;

				if (this.count % 10 == 1)
				{
					this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_C_AuraC, {}, this.weakref()), this, 0, 0);
				}

				this.rz += 0,25000000.0;
				this.HitCycleUpdate(12);

				if (this.y > ::battle.scroll_bottom)
				{
					this.PlaySE(1164);
					this.SetMotion(this.motion, 2);
					this.SetSpeed_Vec(7,50000000.0, -65 * 0,01745329.0, this.direction);
					this.count = 0;
					this.stateLabel = function ()
					{
						if (this.va.x > 0,00000000.0 && this.x > ::battle.scroll_right - 50 || this.va.x < 0,00000000.0 && this.x < ::battle.scroll_left + 50)
						{
							this.SetSpeed_XY(0,00000000.0, null);
						}

						if (this.cancelCount <= 0)
						{
							this.team.spell_enable_end = true;
							this.func[0].call(this);
							return;
						}

						this.count++;

						if (this.count % 15 == 1)
						{
							this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_C_Aura, {}, this.weakref()), this, 0, 0);
						}

						if (this.count % 9 == 1)
						{
							this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_C_AuraB, {}, this.weakref()), this, 0, 0);
						}

						if (this.IsScreen(300,00000000.0))
						{
							this.team.spell_enable_end = true;
							this.ReleaseActor();
							return;
						}

						this.rz += 0,05000000.0;
						this.HitCycleUpdate(12);
					};
				}
			};
		},
		function ()
		{
			this.EnableTimeStop(false);
			this.stateLabel = function ()
			{
				if (this.owner.motion != 4020 && this.owner.motion != 4021)
				{
					this.func[0].call(this);
					return;
				}
				else
				{
					this.sx = this.sy += (1,25000000.0 - this.sx) * 0,15000001.0;
					this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,25000000.0 - this.sx) * 0,15000001.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.rz += 0,05000000.0;

		if (this.owner.motion != 4020 && this.owner.motion != 4021)
		{
			this.func[0].call(this);
			return;
		}
		else
		{
			this.count++;

			if (this.count % 15 == 1)
			{
				this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_C_Aura, {}, this.weakref()), this, 0, 0);
			}

			if (this.count >= 25 && this.count % 9 == 1)
			{
				this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_C_AuraB, {}, this.weakref()), this, 0, 0);
			}

			this.HitCycleUpdate(6);
		}
	};
}

function SpellShot_C_Aura( t )
{
	this.SetMotion(4028, 0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,05000000.0;
			this.alpha = this.green = this.red -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha = this.green = this.red -= 0,05000000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0,05000000.0;

		if (!this.initTable.pare)
		{
			this.func();
		}
	};
}

function SpellShot_C_AuraB( t )
{
	this.SetMotion(4028, 1);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.rz -= 2,50000000.0 * 0,01745329.0;
			this.sx = this.sy += 0,01000000.0;
			this.alpha = this.green = this.red -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.subState = function ()
	{
		this.alpha += 0,25000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha = this.green = this.red -= 0,02500000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
			return;
		}

		this.rz -= 2,50000000.0 * 0,01745329.0;
		this.sx = this.sy += 0,01000000.0;

		if (!this.initTable.pare)
		{
			this.func();
		}
	};
}

function SpellShot_C_AuraC( t )
{
	this.SetMotion(4028, 0);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.alpha = 0,00000000.0;
	this.func = function ()
	{
		this.stateLabel = function ()
		{
			this.sx = this.sy += 0,05000000.0;
			this.alpha = this.green = this.red -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
				return;
			}
		};
	};
	this.subState = function ()
	{
		this.alpha += 0,10000000.0;

		if (this.alpha >= 1,00000000.0)
		{
			this.subState = function ()
			{
				this.alpha = this.green = this.red -= 0,05000000.0;
			};
		}
	};
	this.stateLabel = function ()
	{
		this.subState();

		if (this.alpha <= 0,00000000.0)
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0,10000000.0;

		if (!this.initTable.pare)
		{
			this.func();
		}
	};
}

function SpellShot_B( t )
{
	this.SetMotion(4019, 1);
	this.atk_id = 67108864;
	this.flag1 = {};
	this.flag2 = 20,00000000.0;
	this.flag1.range <- 20,00000000.0;
	this.flag1.rot <- t.rot;
	this.flag1.tagRot <- t.tagRot + 22,50000000.0 * 0,01745329.0;
	this.flag1.rotRate <- 0,00000000.0;
	this.ry = this.flag1.rot;
	this.x = this.owner.point0_x + this.flag1.range * this.cos(this.flag1.rot) * this.direction;
	this.y = this.owner.point0_y + this.flag1.range * this.sin(this.flag1.rot) * 0,17399999.0;
	this.EnableTimeStop(false);
	this.subState = function ()
	{
		if (this.owner.motion == 4010)
		{
			if (this.owner.keyTake <= 3)
			{
				this.rz += 15,00000000.0 * 0,01745329.0;
				this.flag1.range += this.flag2;
				this.flag2 *= 0,89999998.0;
				this.flag1.rotRate += (1,00000000.0 - this.flag1.rotRate) * 0,15000001.0;
				this.ry = this.flag1.rot + this.flag1.tagRot * this.flag1.rotRate;

				if (this.sin(this.ry) < 0,00000000.0)
				{
					this.DrawActorPriority(180);
				}
				else
				{
					this.DrawActorPriority(200);
				}

				this.x = this.owner.point0_x + this.flag1.range * this.cos(this.ry + 90 * 0,01745329.0) * this.direction;
				this.y = this.owner.point0_y + this.flag1.range * this.sin(this.ry + 90 * 0,01745329.0) * 0,17399999.0;
				return false;
			}
			else
			{
				local t_ = {};
				t_.rot <- this.ry;
				this.SetFreeObject(this.x, this.y, this.direction, this.owner.SpellShot_B_Start, t_);
				this.ReleaseActor();
				return true;
			}
		}
		else
		{
			this.ReleaseActor();
			return true;
		}
	};
	this.stateLabel = function ()
	{
		if (this.subState())
		{
			return;
		}
	};
}

function SpellShot_B_Start( t )
{
	this.SetMotion(4019, 2);
	this.ry = t.rot;
	this.sx = this.sy = 0,00000000.0;
	this.stateLabel = function ()
	{
		this.sx += (1,00000000.0 - this.sx) * 0,34999999.0;
		this.sy += (1,00000000.0 - this.sy) * 0,34999999.0;
		this.count++;
		this.AddSpeed_XY(0,00000000.0, -0,20000000.0);

		if (this.count >= 5)
		{
			this.alpha -= 0,02500000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function SpellShot_B_Tower( t )
{
	this.SetMotion(4019, 7);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 512;
	this.anime.height = 512;
	this.anime.radius0 = 250;
	this.anime.radius1 = 250;
	this.anime.length = 1028;
	this.anime.vertex_blue1 = 0,00000000.0;
	this.rx = -85 * 0,01745329.0 * this.direction;
	this.alpha = 0,00000000.0;
	this.flag1 = 0,00000000.0;
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,02500000.0;
				this.green -= 0,02500000.0;
				this.blue -= 0,02500000.0;
				this.flag1 += 1,50000000.0;
				this.anime.radius0 = this.anime.radius1 *= 1,10000002.0;
				this.rz -= 6,00000000.0 * 0,01745329.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.owner.keyTake <= 5 && this.owner.motion == 4010)
		{
			this.alpha += 0,10000000.0;

			if (this.alpha > 1,00000000.0)
			{
				this.alpha = 1,00000000.0;
			}

			this.anime.top += this.flag1;
			this.flag1 += 0,10000000.0;
			this.rz -= 3,00000000.0 * 0,01745329.0;
			this.x = this.owner.x;
		}
		else
		{
			this.func[0].call(this);
		}
	};
}

function SpellShot_B_OutTower( t )
{
	this.SetMotion(4019, 6);
	this.stateLabel = function ()
	{
		if (this.owner.keyTake <= 5 && this.owner.motion == 4010)
		{
			this.Warp(this.owner.x, this.y);
		}
		else
		{
			this.stateLabel = function ()
			{
				this.alpha -= 0,05000000.0;
				this.sx = this.sy += 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function SpellShot_B_Hit( t )
{
	this.SetMotion(4019, 4);
	this.atk_id = 67108864;
	this.atkRate_Pat = t.rate;
	this.stateLabel = function ()
	{
		if (this.owner.keyTake <= 5 && this.owner.motion == 4010)
		{
			if (this.hitResult)
			{
				if (!(this.hitResult & 32))
				{
					this.count++;

					if (this.count >= 6)
					{
						this.HitReset();
						this.count = 0;
					}
				}
				else
				{
					this.HitReset();
				}
			}

			this.Warp(this.owner.x + this.cos(this.ry - 90 * 0,01745329.0) * this.flag2 * this.direction, this.y);
		}
		else
		{
			this.SetMotion(this.motion, 5);
			this.HitReset();
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;

				if (this.count >= 5)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Climax_Shot( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(4909, 6);
	this.atk_id = 134217728;
	this.rz = -20 * 0,01745329.0;
	this.SetSpeed_Vec(60, -110 * 0,01745329.0, this.direction);
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.atkRate_Pat = t.rate;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.flag1 = 1,00000000.0;
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.flag1 += 0,00500000.0;
				this.sx *= this.flag1;
				this.count++;

				if (this.count >= 4)
				{
					this.Vec_Brake(8,00000000.0, 0,50000000.0);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitResult & 1)
		{
		}

		this.count++;

		if (this.count >= 4)
		{
			this.callbackGroup = 0;
			this.Vec_Brake(8,00000000.0, 0,50000000.0);
		}

		if (this.count >= 15)
		{
			this.SetMotion(4909, 7);
			this.sx *= 0,89999998.0;

			if (this.sx <= 0,01000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_ShotB( t )
{
	this.DrawActorPriority(210);
	this.SetMotion(4908, 2);
	this.atk_id = 134217728;
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.count++;

		if (this.hitResult & 1)
		{
			this.owner.flag1 = true;
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,02500000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
		else
		{
			this.HitCycleUpdate(2);
		}

		if (this.count >= 10)
		{
			this.callbackGroup = 0;
			this.stateLabel = function ()
			{
				this.sx = this.sy += 0,02500000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
}

function Climax_ShotC( t )
{
	this.SetMotion(4908, 0);
	this.atk_id = 134217728;

	if (this.rand() % 100 <= 50)
	{
		this.DrawActorPriority(110);
	}
	else
	{
		this.DrawActorPriority(210);
	}

	this.rz = t.rot + 90 * 0,01745329.0;
	this.sx = this.sy = 0,00000000.0;
	this.flag2 = 0,50000000.0 + this.rand() % 10 * 0,10000000.0;
	this.SetSpeed_Vec(1,00000000.0 * this.flag2, t.rot, this.direction);
	this.flag1 = 0,02500000.0 + this.rand() % 25 * 0,00100000.0;
	this.stateLabel = function ()
	{
		this.sx += 0,50000000.0;
		this.sy += (this.flag2 - this.sy) * 0,25000000.0;
		this.count++;

		if (this.count == 6)
		{
			this.stateLabel = function ()
			{
				this.sx += 0,00500000.0;
				this.sy *= 0,99980003.0;
				this.alpha -= 0,00100000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_Back( t )
{
	this.DrawActorPriority(490);
	this.SetMotion(4909, 1);
	this.alpha = 0,00000000.0;
	this.rz = (45 - this.rand() % 90) * 0,01745329.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		if (this.initTable.pare.motion != 4903)
		{
			this.ReleaseActor();
			return;
		}

		this.rz += 0,50000000.0 * 0,01745329.0;
		this.count++;
		this.alpha += 0,02500000.0;
		this.sx = this.sy += 0,00500000.0;

		if (this.count == 40)
		{
			this.SetFreeObject(640, 360, this.direction, this.initTable.pare.Climax_Back, {}, this.initTable.pare);
		}

		if (this.count == 80)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_BackB( t )
{
	this.SetMotion(4909, 5);
	this.flag4 = this.Vector3();
	this.flag4.x = -320;
	this.flag4.RotateByRadian(-30 * 0,01745329.0);
	this.flag5 = this.Vector3();
	this.flag5.x = 45;
	this.flag5.RotateByRadian(-30 * 0,01745329.0);
	this.anime.stencil = t.mask;
	this.anime.is_equal = true;
	this.DrawActorPriority(510);
	this.func = [
		function ()
		{
			this.ReleaseActor.call(this.flag3);
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
	};
}

function Climax_FaceA( t )
{
	this.SetMotion(4909, 3);
	this.flag1 = -30 * 0,01745329.0;
	this.anime.is_equal = true;
	this.flag4 = this.Vector3();
	this.flag4.x = -320;
	this.flag4.RotateByRadian(-30 * 0,01745329.0);
	this.flag5 = this.Vector3();
	this.flag5.x = 45;
	this.flag5.RotateByRadian(-30 * 0,01745329.0);
	this.flag3 = this.SetFreeObjectStencil(this.x + this.flag4.x * this.direction, this.y + this.flag4.y, this.direction, this.initTable.pare.Climax_FaceMaskA, {}, t.pare).weakref();
	local t_ = {};
	t_.mask <- this.flag3.weakref();
	this.flag2 = this.SetFreeObjectStencil(0, 0, 1,00000000.0, this.initTable.pare.Climax_BackB, t_, t.pare).weakref();
	this.DrawActorPriority(510);
	this.anime.stencil = this.flag3;
	this.sx = this.sy = 0,80000001.0;
	this.stateLabel = function ()
	{
		local s_ = (2,50000000.0 - this.sx) * 0,05000000.0;

		if (s_ < 0,00500000.0)
		{
			s_ = 0,00500000.0;
		}

		this.sx = this.sy += s_;
		this.count++;

		if (this.flag3)
		{
			if (this.count <= 40)
			{
				this.flag3.x += this.flag5.x * this.direction;
				this.flag3.y += this.flag5.y;
			}
		}
	};
	this.func = [
		function ()
		{
			if (this.flag3)
			{
				this.ReleaseActor.call(this.flag3);
			}

			if (this.flag2)
			{
				this.ReleaseActor.call(this.flag2);
			}

			this.ReleaseActor();
		}
	];
}

function Climax_FaceMaskA( t )
{
	this.SetMotion(4909, 4);
	this.rz = -30 * 0,01745329.0;
	this.DrawActorPriority(510);
	this.anime.is_write = true;
	this.SetParent.call(this.SetFreeObject(this.x, this.y, this.direction, this.initTable.pare.Climax_MaskSlash, {}), this, 0, 0);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_MaskSlash( t )
{
	this.SetMotion(4909, 2);
	this.rz = -30 * 0,01745329.0;
	this.DrawActorPriority(520);
	this.stateLabel = function ()
	{
		this.sx = this.sy *= 0,99000001.0;
		this.count++;

		if (this.count >= 15)
		{
			this.alpha = this.blue -= 0,05000000.0;

			if (this.alpha <= 0,00000000.0)
			{
				this.ReleaseActor();
			}
		}
	};
}

function Climax_Slash( t )
{
	this.SetMotion(4909, 9);
	this.rz = 70 * 0,01745329.0;
	this.sx = 12,00000000.0;
	this.SetSpeed_Vec(20,00000000.0, -20 * 0,01745329.0, this.direction);
	this.DrawActorPriority(520);
	this.stateLabel = function ()
	{
		this.sx *= 0,85000002.0;
		this.sy += 0,01500000.0;

		if (this.sx <= 0,01000000.0)
		{
			this.ReleaseActor();
		}
	};
}

function Climax_LineA( t )
{
	this.SetMotion(4909, 8);
	this.DrawActorPriority(t.priority);
	this.rz = t.rot;
	this.sx = this.sy = t.scale;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(4909, 9);
			this.sx = 0,10000000.0;
			this.stateLabel = function ()
			{
				this.sx += (this.initTable.scale * 0,50000000.0 - this.sx) * 0,15000001.0;
			};
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.sx *= 0,94999999.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
			this.initTable.pare.flag1.Add(this.SetFreeObjectDynamic(this.x, this.y, this.direction, this.initTable.pare.Climax_LineA2, this.initTable));
		}
	];
}

function Climax_LineA2( t )
{
	this.SetMotion(4909, 10);
	this.DrawActorPriority(t.priority);
	this.anime.left = 160;
	this.anime.top = 0;
	this.anime.width = 32;
	this.anime.height = 512;
	this.rz = t.rot;
	this.sx = 0,10000000.0;
	this.sy = t.scale;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.anime.top -= 15,00000000.0;
		this.sx += (this.initTable.scale * 0,50000000.0 - this.sx) * 0,15000001.0;
	};
}

function Climax_LineB( t )
{
	this.SetMotion(4909, 8);
	this.DrawActorPriority(520);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_LineFlash( t )
{
	this.SetMotion(4909, 11);
	this.sx = this.sy = 0,00000000.0;
	this.DrawActorPriority(499);
	this.stateLabel = function ()
	{
		this.count++;

		if (this.count % 4 == 0)
		{
			this.rz = this.rand() % 360 * 0,01745329.0;
		}

		this.sx = this.sy += (3,00000000.0 - this.sx) * 0,10000000.0;
	};
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
}

function Climax_LineSpark( t )
{
	this.SetMotion(4909, 12);
	this.DrawActorPriority(510);
	this.anime.left = 0;
	this.anime.top = 0;
	this.anime.width = 256;
	this.anime.height = 256;
	this.anime.radius0 = 0;
	this.anime.radius1 = 24;
	this.anime.vertex_alpha1 = 0,00000000.0;
	this.anime.vertex_green1 = 0,10000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.stateLabel = function ()
			{
				this.anime.top += 6,00000000.0;
				this.alpha -= 0,10000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.anime.radius1 += (512 - this.anime.radius1) * 0,05000000.0;
		this.anime.top -= 25,00000000.0;
	};
}

