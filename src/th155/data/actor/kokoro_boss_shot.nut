function Boss_Shot_SL1( t )
{
	this.SetMotion(4919, this.rand() % 3);
	this.owner.shot_actor.Add(this);
	this.cancelCount = 1;
	this.SetCollisionScaling(this.sx, this.sy, 1.00000000);
	this.SetSpeed_Vec(t.v, t.rot, this.direction);
	this.flag1 = 0.00000000;
	this.func = [
		function ()
		{
			this.callbackGroup = 0;
			this.SetMotion(4939, 1);
			this.flag2 = (6 - this.rand() % 13) * 0.01745329;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.rz += this.flag2;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
			this.func[0] = function ()
			{
			};
		},
		function ()
		{
			this.subState = function ()
			{
				this.flag1 += 0.75000000;
				this.va.x = (this.owner.flag5.pos.x - this.x) * 0.20000000;
				this.va.y = (this.owner.flag5.pos.y - this.y) * 0.20000000;
				local r_ = this.va.Length();

				if (r_ > this.flag1)
				{
					this.va.SetLength(this.flag1);
				}

				this.ConvertTotalSpeed();
			};
		},
		function ()
		{
			this.callbackGroup = 0;
			this.SetSpeed_Vec(10.00000000 + this.rand() % 8, this.rand() % 360 * 0.01745329, this.direction);
			this.flag2 = (6 - this.rand() % 13) * 0.01745329;
			this.stateLabel = function ()
			{
				this.AddSpeed_XY(0.00000000, 0.50000000);
				this.rz += this.flag2;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.subState = function ()
	{
		this.SetSpeed_XY(this.va.x * 0.92000002, this.va.y * 0.92000002);
	};
	this.stateLabel = function ()
	{
		this.subState();
	};
}

