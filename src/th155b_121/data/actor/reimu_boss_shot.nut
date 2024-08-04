function Boss_Shot_1( t )
{
	this.SetMotion(4917 + t.type, 1);
	this.sx = this.sy = 0,25000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 3;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = 0,05235988.0;
	this.SetSpeed_Vec(8,00000000.0 + this.rand() % 6, t.rot, this.direction);
	this.SetTrail(this.motion, 6, 20, 100);

	if (t.stop == true)
	{
		this.count = 30 + this.rand() % 15;
	}

	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				if (this.linkObject[0])
				{
					this.linkObject[0].alpha -= 0,10000000.0;
					this.linkObject[0].anime.length *= 0,80000001.0;
					this.linkObject[0].anime.radius0 *= 0,80000001.0;

					if (this.linkObject[0].alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				}

				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,04000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.owner.com_flag3.append(this.weakref());
			this.stateLabel = function ()
			{
				if (this.linkObject[0])
				{
					this.linkObject[0].alpha -= 0,10000000.0;
					this.linkObject[0].anime.length *= 0,80000001.0;
					this.linkObject[0].anime.radius0 *= 0,80000001.0;

					if (this.linkObject[0].alpha <= 0,00000000.0)
					{
						this.linkObject[0].ReleaseActor();
					}
				}

				this.C_Vec_Brake(this.va, 0,50000000.0);
			};
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += (this.initTable.scale - this.sx) * 0,10000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();

		if (this.count > 0)
		{
			this.count++;
		}

		if (this.count >= 60)
		{
			this.func[1].call(this);
			return;
		}
	};
}

function Boss_Shot_3( t )
{
	this.SetMotion(4914 + t.type, 1);
	this.sx = this.sy = 0,25000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 2;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = 0,50000000.0 * 0,01745329.0;

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag4 = 90;
		break;

	case 2:
		this.flag4 = 135;
		break;

	case 3:
		this.flag4 = -1;
		break;

	default:
		this.flag4 = 60;
		break;
	}

	this.flag5 = true;
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.SetTrail(this.motion, 6, 20, 60);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);
			this.stateLabel = function ()
			{
				if (this.linkObject[0])
				{
					this.linkObject[0].alpha -= 0,10000000.0;
					this.linkObject[0].anime.length *= 0,80000001.0;
					this.linkObject[0].anime.radius0 *= 0,80000001.0;

					if (this.linkObject[0].alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
					}
				}

				this.sx = this.sy *= 0,80000001.0;
				this.alpha -= 0,04000000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.subState = function ()
			{
				local tVec_ = this.Vector3();
				tVec_.x = this.target.x - this.x;
				tVec_.y = this.target.y - this.y;

				if (tVec_.Length() <= 360,00000000.0)
				{
					this.count = 0;
					tVec_.SetLength(1,00000000.0);
					this.SetSpeed_XY(tVec_.x, tVec_.y);
					this.subState = function ()
					{
						this.count++;

						if (this.flag4 > 0 && this.count >= this.flag4)
						{
							this.func[0].call(this);
							return;
						}

						this.C_AddSpeed_Vec(this.va, 0,15000001.0, null, 7,50000000.0, this.direction);
						local tVec_ = this.Vector3();
						tVec_.x = this.target.x - this.x;
						tVec_.y = this.target.y - this.y;

						if (this.flag5 && this.va.x * tVec_.x + this.va.y * tVec_.y >= this.cos(1,57079601.0))
						{
							this.TargetHoming(this.target, 0,50000000.0 * 0,01745329.0, this.direction);
						}
						else
						{
							this.flag5 = false;
						}
					};
				}
			};
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += (1,50000000.0 - this.sx) * 0,10000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
		this.SetSpeed_XY(this.va.x * 0,98000002.0, this.va.y * 0,98000002.0);
		this.count++;

		if (this.count >= 60)
		{
			this.func[1].call(this);
			return;
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_SL1( t )
{
	this.SetMotion(4917, 1);
	this.sx = this.sy = 0,25000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = 0,05235988.0;
	this.SetSpeed_Vec(15,00000000.0, t.rot, this.direction);
	this.SetTrail(this.motion, 6, 20, 100);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);
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
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,10000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.C_Vec_BrakeLimited(this.va, 0,60000002.0, 0,50000000.0))
		{
			this.subState = function ()
			{
				this.sx = this.sy += (1,50000000.0 - this.sx) * 0,15000001.0;
				this.C_AddSpeed_Vec(this.va, 0,50000000.0, null, 20,00000000.0, this.direction);
				this.C_TargetHoming(this.va, this.target, this.flag2, 1,00000000.0);
			};
		}
	};
	this.stateLabel = function ()
	{
		if (!(this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Boss_Shot_SL2( t )
{
	this.SetMotion(4929, 0);

	if (this.owner.target != this.owner.target.team.slave)
	{
		this.SetMotion(this.motion, 1);
	}

	this.SetSpeed_Vec(3,00000000.0, t.rot, this.direction);
	this.cancelCount = 1;
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.flag1 = this.va.x * 0,05000000.0;
	this.flag2 = this.va.y * 0,05000000.0;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.sx = this.sy -= 0,10000000.0;

				if (this.sx <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.C_AddFreeSpeed_XY(this.va, this.flag1, this.flag2);

		if (this.keyTake == 0)
		{
			if (this.owner.target != this.owner.target.team.slave)
			{
				this.SetMotion(this.motion, 1);
			}
		}
		else if (this.owner.target == this.owner.target.team.slave)
		{
			this.SetMotion(this.motion, 0);
		}
	};
}

function Boss_Shot_SL3( t )
{
	this.SetMotion(4917 + t.type, 1);
	this.sx = this.sy = 0,25000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 10;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.SetSpeed_Vec(17,00000000.0, t.rot, this.direction);
	this.flag1 = this.Vector3();
	this.flag1.x = this.va.x;
	this.flag1.y = this.va.y;
	this.flag1.Normalize();
	this.flag2 = this.Vector3();
	this.flag3 = 0,00000000.0;
	this.SetTrail(this.motion, 6, 20, 100);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);
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
		},
		function ()
		{
			this.C_SetSpeed_XY(this.va, this.flag1.x, this.flag1.y);
			this.stateLabel = function ()
			{
				if (!(!this.IsScreen(100) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[0].call(this);
					return;
				}

				this.sx = this.sy += (3,00000000.0 - this.sx) * 0,15000001.0;
				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
				this.AddSpeed_Vec(0,20000000.0, null, 10,00000000.0, this.direction);
				this.flag3 += 0,10000000.0 * 0,01745329.0;
				this.C_TargetHoming(this.va, this.owner.target, this.flag3, this.direction);
				this.vec.x = this.owner.target.x - this.x;
				this.vec.y = this.owner.target.y - this.y;

				if (this.vec.Length() <= 30)
				{
					this.func[0].call(this);
					return;
				}
			};
		},
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);
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
		}
	];
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(100) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.count++;

		if (this.count >= this.initTable.wait)
		{
			this.func[1].call(this);
			return;
		}

		this.C_Vec_Brake(this.va, 0,50000000.0);
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	};
}

function Boss_Shot_SL_Kasen( t )
{
	this.SetMotion(4918, 1);
	this.sx = this.sy = 0,25000000.0;
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
	this.flag2 = 0,01745329.0;
	this.SetSpeed_Vec(15,00000000.0, t.rot, this.direction);
	this.SetTrail(this.motion, 6, 20, 100);
	this.func = [
		function ()
		{
			this.SetSpeed_XY(0,00000000.0, 0,00000000.0);
			this.SetMotion(this.motion, 3);
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
		}
	];
	this.subState = function ()
	{
		this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.C_Vec_BrakeLimited(this.va, 0,60000002.0, 1,50000000.0))
		{
			this.subState = function ()
			{
				this.sx = this.sy += (2,00000000.0 - this.sx) * 0,10000000.0;
				this.count++;

				if (this.count >= 30)
				{
					this.C_TargetHoming(this.va, this.target, 3,14159203.0, 1,00000000.0);
					this.subState = function ()
					{
						this.sx = this.sy += (3,00000000.0 - this.sx) * 0,15000001.0;
						this.C_AddSpeed_Vec(this.va, 0,25000000.0, null, 30,00000000.0, this.direction);
						this.C_TargetHoming(this.va, this.target, this.flag2, 1,00000000.0);
					};
				}
			};
		}
	};
	this.stateLabel = function ()
	{
		if (!(!this.IsScreen(400) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
		{
			this.func[0].call(this);
			return;
		}

		this.subState();
	};
}

function Shot_Master2_SideSlashCore( t )
{
	this.SetMotion(4939, 5);
	this.owner.shot_actor.Add(this);
	this.isVisible = false;
	this.flag1 = this.Vector3();
	this.flag3 = 45;
	this.sx = this.sy = 0,50000000.0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.flag2 = 25 * 0,01745329.0 * t.rot2;
		this.flag4 = 3;
		break;

	case 1:
		this.flag2 = 15 * 0,01745329.0 * t.rot2;
		this.flag4 = 5;
		break;

	case 2:
		this.flag2 = 7,50000000.0 * 0,01745329.0 * t.rot2;
		this.flag4 = 10;
		break;

	case 3:
		this.flag2 = 5,00000000.0 * 0,01745329.0 * t.rot2;
		this.flag4 = 15;
		break;

	case 4:
		this.flag2 = 5,00000000.0 * 0,01745329.0 * t.rot2;
		this.flag4 = 20;
		break;
	}

	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		local t_ = {};
		t_.rot <- this.rz;
		t_.wait <- this.flag3;
		this.owner.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_Line, t_, null));
		this.rz += this.flag2;
		this.flag3 += 5;
		this.flag4--;

		if (this.flag4 <= 0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Master2_V_SlashCore( t )
{
	this.SetMotion(4939, 5);
	this.owner.shot_actor.Add(this);
	this.isVisible = false;
	this.flag1 = this.Vector3();
	this.flag2 = 4 * 0,01745329.0;
	this.flag3 = 45;
	this.sx = this.sy = 0,50000000.0;

	switch(this.owner.com_difficulty)
	{
	case 0:
		this.rz = -20 * 0,01745329.0;
		this.flag2 = 20 * 0,01745329.0;
		this.flag4 = 3;
		break;

	case 1:
		this.rz = -20 * 0,01745329.0;
		this.flag2 = 10 * 0,01745329.0;
		this.flag4 = 5;
		break;

	case 2:
		this.rz = -25 * 0,01745329.0;
		this.flag2 = 5,00000000.0 * 0,01745329.0;
		this.flag4 = 10;
		break;

	case 3:
		this.rz = -30 * 0,01745329.0;
		this.flag2 = 4,00000000.0 * 0,01745329.0;
		this.flag4 = 15;
		break;

	case 4:
		this.rz = -40 * 0,01745329.0;
		this.flag2 = 4,00000000.0 * 0,01745329.0;
		this.flag4 = 20;
		break;
	}

	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		local t_ = {};
		t_.rot <- this.rz;
		t_.wait <- this.flag3;
		this.owner.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_Line, t_));
		this.rz += this.flag2;
		this.flag3 += 5;
		this.flag4--;

		if (this.flag4 <= 0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Master2_SlashEffect( t )
{
	this.SetMotion(4939, 3);
	this.rz = t.rot;
	this.sx = this.sy = 3,00000000.0;
	this.keyAction = function ()
	{
		this.stateLabel = function ()
		{
			this.sy *= 0,94999999.0;

			if (this.sy <= 0,10000000.0)
			{
				this.ReleaseActor();
			}
		};
	};
}

function Shot_Master2_CoreA( t )
{
	this.SetMotion(4939, 5);
	this.owner.shot_actor.Add(this);
	this.isVisible = false;
	this.flag1 = this.Vector3();
	this.flag2 = -8 * 0,01745329.0;
	this.sx = this.sy = 0,50000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += 0,02500000.0;
		this.count++;

		if (this.count == 45)
		{
			this.PlaySE(1133);
		}

		local t_ = {};
		t_.rot <- this.rz;
		t_.wait <- 45;
		this.owner.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_Line2, t_));
		this.rz += this.flag2;

		if (this.rz <= -6,28318548.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Master2_CoreB( t )
{
	this.SetMotion(4939, 5);
	this.owner.shot_actor.Add(this);
	this.isVisible = false;
	this.flag1 = this.Vector3();
	this.flag2 = (10 + 5 / 36,00000000.0) * 0,01745329.0;
	this.rz = -90 * 0,01745329.0;
	this.sx = this.sy = 1,25000000.0;
	this.func = [
		function ()
		{
			this.ReleaseActor();
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		local t_ = {};
		t_.rot <- this.rz;
		t_.wait <- 45;
		this.owner.shot_actor.Add(this.SetLightShot(this.point0_x, this.point0_y, this.direction, this.Shot_Master2_Line2, t_));
		this.rz += this.flag2;

		if (this.count == 45)
		{
			this.PlaySE(1133);
		}

		if (this.sx == 1,25000000.0 && this.rz > 90 * 0,01745329.0 + 3,14159203.0)
		{
			this.sx = this.sy += 1,25000000.0;
		}

		if (this.rz > 90 * 0,01745329.0 + 6,28318548.0)
		{
			this.ReleaseActor();
		}
	};
}

function Shot_Master2_Line( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.sx = this.sy = 0,10000000.0;
	this.flag1 = 0,15000001.0;
	this.cancelCount = 3;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sy *= 0,80000001.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.sy += (1,00000000.0 - this.sy) * 0,10000000.0;
		this.sx += this.flag1;
		this.flag1 *= 0,94999999.0;

		if (this.flag1 <= 0,01000000.0)
		{
			this.flag1 = 0,01000000.0;
		}

		if (this.count > this.initTable.wait)
		{
			local t_ = {};
			t_.rot <- this.rz;
			t_.wait <- this.initTable.wait - 45;
			this.SetLightShot(this.x, this.y, this.direction, this.Shot_Master2_SparkLine, t_);
			this.PlaySE(1131);
			this.SetMotion(4939, 1);
			this.stateLabel = function ()
			{
				this.C_AddFreeSpeed_Vec(this.va, 0,50000000.0, this.rz, this.direction);
				this.sy += (4,00000000.0 - this.sy) * 0,02500000.0;
				this.flag1 *= 1,10000002.0;
				this.sx += this.flag1;

				if (this.sx > 15,00000000.0 || this.grazeCount > 0)
				{
					this.sy *= 0,98000002.0;
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
						return;
					}
				}

				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			};
		}
	};
}

function Shot_Master2_Line2( t )
{
	this.SetMotion(4939, 0);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.sx = this.sy = 0,10000000.0;
	this.flag1 = 0,15000001.0;
	this.cancelCount = 3;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sy *= 0,80000001.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.sy += (1,00000000.0 - this.sy) * 0,10000000.0;
		this.sx += this.flag1;
		this.flag1 *= 0,94999999.0;

		if (this.flag1 <= 0,01000000.0)
		{
			this.flag1 = 0,01000000.0;
		}

		if (this.count > this.initTable.wait)
		{
			this.PlaySE(1131);
			this.SetMotion(4939, 1);
			this.stateLabel = function ()
			{
				this.sy += (4,00000000.0 - this.sy) * 0,02500000.0;
				this.flag1 *= 1,10000002.0;
				this.sx += this.flag1;

				if (this.sx > 15,00000000.0 || this.grazeCount > 0)
				{
					this.sy *= 0,98000002.0;
					this.alpha -= 0,05000000.0;

					if (this.alpha <= 0,00000000.0)
					{
						this.ReleaseActor();
						return;
					}
				}

				this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
			};
		}
	};
}

function Shot_Master2_SparkLine( t )
{
	this.SetMotion(4939, 5);
	this.DrawActorPriority(180);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.sy = 0,00000000.0;
	this.flag1 = 0,30000001.0;
	this.cancelCount = 3;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.func = [
		function ()
		{
			this.stateLabel = function ()
			{
				this.sy *= 0,80000001.0;
				this.alpha -= 0,02500000.0;

				if (this.alpha <= 0,00000000.0)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4939, 5);
			this.count = 0;
			this.stateLabel = function ()
			{
				this.count++;
				this.sy += (0,10000000.0 - this.sy) * 0,10000000.0;
				this.sx += this.flag1;
				this.flag1 *= 0,94999999.0;

				if (this.count >= this.initTable.wait)
				{
					this.count = 0;
					this.SetMotion(4939, 1);
					this.stateLabel = function ()
					{
						this.sy += (4,00000000.0 - this.sy) * 0,07500000.0;
						this.flag1 *= 1,10000002.0;
						this.sx += this.flag1;
						this.count++;

						if (this.count >= 45 || this.grazeCount > 0 || this.cancelCount <= 0)
						{
							this.SetMotion(4939, 5);
							this.stateLabel = function ()
							{
								this.sy *= 0,94999999.0;
								this.alpha -= 0,05000000.0;

								if (this.alpha <= 0,00000000.0)
								{
									this.ReleaseActor();
									return;
								}
							};
							return;
						}

						this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);
					};
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		this.count++;
		this.sy += (0,10000000.0 - this.sy) * 0,10000000.0;
		this.sx += this.flag1;
		this.flag1 *= 0,94999999.0;
	};
}

function Shot_Master2_Spike( t )
{
	this.SetMotion(4938, 0);
	this.sx = this.sy = 0,10000000.0;
	this.rz = t.rot;
	this.SetCollisionRotation(0,00000000.0, 0,00000000.0, this.rz);
	this.flag1 = this.Vector3();
	this.flag1.x = 0,25000000.0;
	this.flag1.RotateByRadian(this.rz);
	this.keyAction = this.ReleaseActor;
	this.flag1.x *= this.direction;
	this.cancelCount = 1;
	this.func = [
		function ()
		{
			this.SetMotion(4938, 2);
			this.stateLabel = function ()
			{
				this.sy *= 0,75000000.0;
			};
		},
		function ()
		{
			this.SetMotion(4938, 1);
			this.stateLabel = function ()
			{
				if (!(!this.IsScreen(50) && this.cancelCount > 0 && this.hitCount <= 0 && this.grazeCount <= 0))
				{
					this.func[0].call(this);
					return;
				}

				this.C_AddFreeSpeed_XY(this.va, this.flag1.x, this.flag1.y);
			};
		}
	];
	this.stateLabel = function ()
	{
		this.sx = this.sy += (1,00000000.0 - this.sx) * 0,05000000.0;
		this.count++;

		if (this.count >= 60)
		{
			this.func[1].call(this);
		}
	};
}

