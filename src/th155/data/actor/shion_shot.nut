function Binbou_Shot( t )
{
	this.SetMotion(3919, this.rand() % 4);
	this.rz = this.rand() % 360 * 0,01745329.0;
	this.SetSpeed_Vec(8 + this.rand() % 3, t.rot, 1,00000000.0);
	this.cancelCount = 1;
	this.SetTaskAddRotation(0,00000000.0, 0,00000000.0, 0,03490658.0);
	this.func = [
		function ()
		{
			this.SetMotion(this.motion, this.keyTake + 4);
			this.func[0] = function ()
			{
			};
			this.stateLabel = function ()
			{
				this.Vec_Brake(0,50000000.0);
				this.sx = this.sy *= 0,92000002.0;
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
		if (this.IsScreen(100))
		{
			this.ReleaseActor();
			return;
		}

		this.sx = this.sy += 0,05000000.0;
		this.SetCollisionScaling(this.sx, this.sy, 1,00000000.0);

		if (this.grazeCount > 0 || this.hitCount > 0 || this.cancelCount == 0)
		{
			this.func[0].call(this);
			return;
		}
	};
}

