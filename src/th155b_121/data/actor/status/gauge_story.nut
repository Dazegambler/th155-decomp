function Initialize()
{
	local actor;
	local mat = ::manbow.Matrix();
	local lang = ::config.lang;
	this.parts = [];
	local face_slave = [];
	this.face = {};
	actor = this.CreateStaticParts(8010, this.mat_left_top, this.mat_identity, ::actor.actor_list.master0.mgr.GetAnimationSet2D());
	this.face.master0 <- actor;
	actor = this.CreateStaticParts(8010, this.mat_left_top, this.mat_identity, ::actor.actor_list.slave0.mgr.GetAnimationSet2D());
	actor.SetMotion(8010, 1);
	face_slave.append(actor);
	this.face.slave0 <- actor;
	mat.SetScaling(-1, 1, 1);
	mat.Translate(1280, 0, 0);
	actor = this.CreateStaticParts(8011, this.mat_right_top, mat, ::actor.actor_list.master1.mgr.GetAnimationSet2D());
	this.face.master1 <- actor;

	if ("slave1" in ::actor.actor_list)
	{
		actor = this.CreateStaticParts(8011, this.mat_right_top, mat, ::actor.actor_list.slave1.mgr.GetAnimationSet2D());
		actor.SetMotion(8011, 1);
		face_slave.append(actor);
		this.face.slave1 <- actor;
	}
	else
	{
		face_slave.append(null);
	}

	actor = this.CreateStaticParts(0, this.mat_left_top);
	this.spell_name_x <- [
		actor.GetFramePointX(0),
		actor.GetFramePointX(1)
	];
	this.spell_name_y <- [
		actor.GetFramePointY(0),
		actor.GetFramePointY(1)
	];
	this.spell_name_start_y <- actor.GetFramePointY(2);
	this.CreateStaticParts(20, this.mat_left_top);
	actor = this.CreateStaticParts(1, this.mat_right_top);

	if (!("slave1" in ::actor.actor_list))
	{
		actor.SetTake(1);
	}

	this.CreateStaticParts(2, this.mat_center);
	this.fps <- ::manbow.Number();
	this.fps.Initialize(this.texture, 0, 575, 16, 18, 2, -5, true);
	this.fps.SetValue(0);
	this.fps.x = 1279;
	this.fps.y = 1;
	this.fps.ConnectRenderSlot(::graphics.slot.status, 1000);
	this.fps.visible = ::config.graphics.fps;
	local bottom = [
		this.CreateStaticParts(10, this.mat_left_bottom)
	];
	this.gauge = [
		{},
		{}
	];

	foreach( i, v in this.gauge )
	{
		local t = ::battle.team[i];
		local offset = i * 10;
		local dir = i == 0 ? 1.00000000 : -1.00000000;
		local mat_top = i == 0 ? this.mat_left_top : this.mat_right_top;
		local mat_bottom = i == 0 ? this.mat_left_bottom : this.mat_right_bottom;
		local mat = ::manbow.Matrix();
		v.team <- t;
		v.face_slave <- face_slave[i];
		v.regain <- this.Gauge();
		v.regain.Initialize(100 + offset, mat_top);
		v.regain.actor.SetTake(3);
		v.damage <- this.Gauge();
		v.damage.Initialize(100 + offset, mat_top);
		v.damage.actor.SetTake(2);
		v.life <- this.Gauge();
		v.life.Initialize(100 + offset, mat_top);

		if (i >= 1)
		{
			continue;
		}

		v.op <- this.Gauge();
		v.op.Initialize(200 + offset, mat_top);
		v.op_state <- this.CreateStaticParts(lang * 10000 + 201 + offset, mat_top);
		v.op_state.visible = false;
		v.op_flash <- this.CreateStaticParts(203 + offset, mat_top);
		v.op_flash.visible = false;
		v.op_flash2 <- this.CreateStaticParts(lang * 10000 + 202 + offset, mat_top);
		v.op_flash2.visible = false;
		local a = [
			this.Gauge(),
			this.Gauge(),
			this.Gauge(),
			this.Gauge(),
			this.Gauge()
		];

		for( local j = 0; j < 5; j = ++j )
		{
			a[j].Initialize(300 + offset + j, mat_bottom);
		}

		v.mp <- a;
		a = [
			this.SPGauge(),
			this.SPGauge()
		];
		a[0].Initialize(t.sp_max, bottom[i].GetFramePointX(0), bottom[i].GetFramePointY(0), dir, mat_bottom);
		a[1].Initialize(t.sp_max2 - t.sp_max, bottom[i].GetFramePointX(0) + ((a[0].length * a[0].scale).tointeger() + 19) * dir, bottom[i].GetFramePointY(0), dir, mat_bottom);
		v.sp <- a;
		actor = ::spell.CreateCardSprite(t.master_name, t.master.spellcard.id);
		mat = ::manbow.Matrix();
		mat.SetTranslation(bottom[i].GetFramePointX(1) - ::spell.width / 2, bottom[i].GetFramePointY(1) - ::spell.height / 2, 0);
		this.AddParts(actor, mat_bottom, mat);
		actor.ConnectRenderSlot(::graphics.slot.status, 1200);
		v.spell <- actor;
	}

	this.stock_list = [];
	this.stock <- ::story.stock;

	for( local j = 0; j < ::story.stock_init; j = ++j )
	{
		mat = ::manbow.Matrix();
		mat.SetTranslation(j * -32, 0, 0);
		actor = this.CreateStaticParts(220, this.mat_left_top, mat);
		actor.SetTake(j < this.stock ? 1 : 0);
		this.stock_list.push(actor);
	}

	::graphics.slot.status.Show(false);
}

function Update()
{
	this.alpha -= 0.05000000;

	if (this.alpha < -1)
	{
		this.alpha = 1;
	}

	this.fps.visible = ::config.graphics.fps;

	if (::config.graphics.fps)
	{
		this.fps.SetValue(::GetFPS());
	}

	if (this.stock > 0 && this.stock > ::story.stock)
	{
		this.stock--;
		this.stock_list[this.stock].SetTake(0);
	}

	if (this.stock < ::story.stock)
	{
		this.stock_list[this.stock].SetTake(1);
		this.stock++;
	}

	this.UpdateGauge.call(this.gauge[0], this);
	this.UpdateGaugeBoss.call(this.gauge[1], this);
}

function UpdateGaugeBoss( env )
{
	this.life.SetValue(this.team.life, this.team.life_max, this.team.life == this.team.life_max ? 1 : 0);
	this.regain.SetValue(this.team.regain_life, this.team.life_max, 3);
	this.damage.SetValue(this.team.damage_life, this.team.life_max, 2);
}

