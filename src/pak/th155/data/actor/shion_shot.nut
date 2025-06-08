function Binbou_Shot( t )
{
	this.SetMotion(3919, this.rand() % 4);
	this.rz = this.rand() % 360 * 0.01745329;
	this.SetSpeed_Vec(8 + this.rand() % 3, t.rot, 1.00000000);
	this.cancelCount = 1;
	this.SetTaskAddRotation(0.00000000, 0.00000000, 0.03490658);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0.50000000);
				this.sx = this.sy *= 0.92000002;
				this.alpha -= 0.05000000;

				if (this.alpha <= 0.00000000)
				{
					this.ReleaseActor();
				}
			};
		}
	];
	this.stateLabel = function ()
	{
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0.05000000;
		this.SetCollisionScaling(this.sx, this.sy, 1.00000000);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

