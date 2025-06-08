this.width <- 256;
this.height <- 256;
this.param <- {};
this.texture <- {};

foreach( v in ::character_name )
{
	this.param[v] <- [];
	::manbow.LoadCSVtoArray("data/spell/" + v + ".csv", this.param[v]);
	this.texture[v] <- [];
	local t;

	foreach( i, w in this.param[v] )
	{
		local t = ::manbow.Texture();

		if (t.Load("data/spell/" + v + "_" + i + ".png"))
		{
			this.texture[v].append(t);
		}
		else
		{
			this.texture[v].append(null);
		}
	}
}

foreach( v in this.texture )
{
	if (v.len())
	{
		this.width = v[0].width;
		this.height = v[0].height;
		break;
	}
}

function CreateCardSprite( name, id )
{
	local sprite = ::manbow.Sprite();
	local t = this.texture[name][id];
	sprite.Initialize(t, 0, 0, this.width, this.height);
	sprite.filter = 1;
	return sprite;
}

function SetCardSprite( sprite, name, id )
{
	local t = this.texture[name][id];
	sprite.Initialize(t, 0, 0, this.width, this.height);
}

