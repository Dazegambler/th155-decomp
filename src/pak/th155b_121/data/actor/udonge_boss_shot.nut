function Boss_Shot_M1( t )
{
	this.SetMotion(4919, 0);
	this.owner.shot_actor.Add(this);
	this.SetParent(this.owner, this.owner.x - this.x, this.owner.y - this.y);
	this.rz = t.rot;
	this.SetSpeed_Vec(30.00000000, this.rz, this.direction);
	this.func = [
		function ()
		{
			this.ReleaseActor();
		},
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.AddSpeed_Vec(-10.00000000, this.rz, 30.00000000, this.direction);
			};
			this.keyAction = null;
		}
	];
	this.stateLabel = function ()
	{
		local t_ = {};
		t_.rot <- this.rz;
		this.SetFreeObject(this.x, this.y, this.direction, this.SPShot_E2, t_);
	};
	this.keyAction = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.50000000, this.va.y * 0.50000000);
		this.stateLabel = function ()
		{
			this.Vec_Brake(1.50000000, 0.50000000);
		};
	};
}

function Boss_Shot_M2( t )
{
	this.SetMotion(4918, 0);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
	this.SetSpeed_Vec(t.v, this.rz, this.direction);
	this.cancelCount = 3;
	this.flag2 = 0.00750000 + this.owner.com_difficulty * 0.00250000;
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.alpha -= 0.10000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		},
		function ()
		{
			this.SetMotion(4917, 0);
			this.SetSpeed_XY(this.va.x * 0.66000003, this.va.y * 0.66000003);
			this.SetCollisionRotation(0.00000000, 0.00000000, this.rz);
			this.stateLabel = function ()
			{
				if (this.hitCount > 0 || this.cancelCount <= 0 || this.IsScreen(200 * this.sx))
				{
					this.func[0].call(this);
					return;
				}

				this.sx = this.sy += this.flag2;
				this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

				if (this.hitCount == 0)
				{
					this.HitCycleUpdate(5);
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.hitCount > 0 || this.grazeCount > 5 || this.cancelCount <= 0 || this.IsScreen(200))
		{
			this.func[0].call(this);
			return;
		}

		if (this.hitCount == 0)
		{
			this.HitCycleUpdate(5);
		}
	};
}

function Boss_Shot_S1_Vision( t )
{
	this.SetMotion(4928, 0);
	this.owner.shot_actor.Add(this);
	this.flag1 = 2;
	this.flag2 = 0;
	this.flag3 = 3;
	this.rz = this.atan2(this.owner.target.y - this.y, (this.owner.target.x - this.x) * this.direction);
	this.SetSpeed_Vec(-10.00000000, this.rz, this.direction);

	switch(this.owner.com_difficulty)
	{
	case 1:
		this.flag3 = 6;
		break;

	case 2:
		this.flag3 = 9;
		break;

	case 3:
	case 4:
		this.flag3 = 12;
		break;
	}

	this.func = [
		function ()
		{
			if (this.owner.skillB_SE)
			{
				this.PlaySE(3846);
				this.owner.skillB_SE = false;
			}

			this.keyAction = this.ReleaseActor;
			this.SetMotion(this.motion, 2);
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(-2.50000000 * this.direction, 0.00000000);
			};
		}
	];
	this.keyAction = [
		function ()
		{
			this.count = 0;
			this.subState = function ()
			{
				this.Vec_Brake(1.00000000, 1.00000000);
				this.count++;

				if (this.count >= 5 && this.count % 4 == 1)
				{
					if (this.flag2 < this.flag3)
					{
						this.PlaySE(3844);
						local t_ = {};
						t_.rot <- this.rz;
						this.SetShot(this.point0_x, this.point0_y, this.direction, this.Boss_Shot_S1_Bullet, t_);
					}

					this.flag2++;

					if (this.flag2 >= 16)
					{
						this.func[0].call(this);
					}
				}
			};
		}
	];
	this.subState = function ()
	{
		this.Vec_Brake(1.00000000, 0.00000000);
	};
	this.stateLabel = function ()
	{
		this.subState();
	};
}

function Boss_Shot_S1_Bullet( t )
{
	this.SetMotion(4929, 0);
	this.owner.shot_actor.Add(this);
	this.rz = t.rot;
	this.SetSpeed_Vec(7.50000000, this.rz, this.direction);
	this.cancelCount = 1;
	local t_ = {};
	t_.rot <- this.rz;
	this.SetFreeObject(this.x, this.y, this.direction, this.Shot_NormalFire, t_);
	this.func = [
		function ()
		{
			this.func[0] = function ()
			{
			};
			this.stateLabel = null;
			this.SetSpeed_XY(0.00000000, 0.00000000);
			this.SetMotion(this.motion, 3);
			this.keyAction = this.ReleaseActor;
		}
	];
	this.subState = function ()
	{
		if (this.hitCount >= 1 || this.cancelCount <= 0 || this.grazeCount >= 1)
		{
			this.func[0].call(this);
			return;
		}
	};
	this.stateLabel = function ()
	{
		if (this.IsScreen(200))
		{
			this.ReleaseActor();
			return;
		}

		this.count++;
		this.subState();
	};
}

