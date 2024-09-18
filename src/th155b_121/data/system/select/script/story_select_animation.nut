function Initialize()
{
	this.anime_set <- ::manbow.AnimationSet2D();
	local lang = ::config.lang == 1 ? "_en" : "";
	this.anime_set.Load("data/system/select/character_select" + lang + ".pat", null);
	this.anime_set.Load("data/system/select/character_select2.pat", null);
	this.mode <- 1;
	this.take <- ::actor.LoadAnimationData("data/system/select/story_pic/story_pic.pat", true);
	this.take_id <- {};
	local callback = function ()
	{
		if (!::menu.story_select.anime)
		{
			return;
		}

		local prop = ::manbow.Animation2DProperty();
		prop.texture_name = this.texture_name;
		prop.id = this.id;
		prop.width = this.texture.width;
		prop.height = this.texture.height;
		prop.offset_x = this.offset_x;
		prop.offset_y = this.offset_y;
		prop.index = 1;
		prop.frame = 9999;
		prop.filter = 1;
		prop.is_loop = true;
		::menu.story_select.anime.take_id[this.id] <- true;
		::menu.story_select.anime.anime_set.Create(prop);
	};

	for( local j = 0; j < 2; j = ++j )
	{
		foreach( i, name in ::menu.story_select.story_list )
		{
			local id = 1000 + ::character_id[name] + j * 1000;
			local v = this.take[id];
			local t = ::manbow.Texture();
			v.id <- id;
			v.texture <- t;

			if (::menu.story_select.cursor_story.val == i)
			{
				t.Load(v.texture_name);
				callback.call(v);
				continue;
			}

			t.LoadBackground(v.texture_name, v, callback);
		}
	}

	this.parts <- [];
	local mat = ::manbow.Matrix();
	local actor;
	actor = ::manbow.AnimationController2D();
	actor.Init(this.anime_set);
	actor.SetMotion(0, 0);
	actor.ConnectRenderSlot(::graphics.slot.ui, 0);
	this.parts.push(actor);

	for( local i = 1; i <= 5; i = ++i )
	{
		actor = ::manbow.AnimationController2D();
		actor.Init(this.anime_set);
		actor.SetMotion(i, 0);
		actor.ConnectRenderSlot(::graphics.slot.ui, 40000);
		this.parts.push(actor);
	}

	this.data <- [];
	local v = {};
	this.title <- ::manbow.AnimationController2D();
	this.title.Init(this.anime_set);
	this.title.SetMotion(42, 0);
	this.title.ConnectRenderSlot(::graphics.slot.ui, 40000);
	local s = 0;

	if (::menu.story_select.device_id >= 4)
	{
		s = 5;
	}
	else if (::menu.story_select.device_id >= -1)
	{
		s = ::menu.story_select.device_id + 1;
	}

	local d = ::manbow.AnimationController2D();
	d.Init(this.anime_set);
	d.SetMotion(800, s);
	d.ConnectRenderSlot(::graphics.slot.ui, 60000);
	mat = ::manbow.Matrix();
	mat.SetScaling(0.50000000, 0.50000000, 0.50000000);
	mat.Translate(8, 8, 0);
	d.SetWorldTransform(mat);
	this.device_icon <- d;
	::manbow.CompileFile("data/system/select/script/animation_story_character.nut", this);
	::manbow.CompileFile("data/system/select/script/animation_story_title.nut", this);
	::manbow.CompileFile("data/system/select/script/animation_stage_title.nut", this);
	::manbow.CompileFile("data/system/select/script/animation_spell.nut", this);
	::manbow.CompileFile("data/system/select/script/animation_item.nut", this);
}

function Update()
{
	foreach( v in this.data )
	{
		v.Update();
	}
}

