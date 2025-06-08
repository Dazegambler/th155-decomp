this.system <- ::manbow.FontTexture();
this.system.Load("data/font/font_texture_outline24.bmp");
this.system_size <- this.system.size;
this.system_small <- ::manbow.FontTexture();
this.system_small.Load("data/font/font_texture_outline16_600.bmp");
this.system_small_size <- this.system_small.size;
function CreateSystemString( str )
{
	local text = ::manbow.String();
	text.Initialize(this.system);
	text.SetSpace(-5, 0);
	text.SetOutline(true);
	text.Set(str);
	text.outline_threshold = 0.16000000;
	text.outline_scale = 6.00000000;
	return text;
}

function CreateSystemStringSmall( str )
{
	local text = ::manbow.String();
	text.Initialize(this.system_small);
	text.SetSpace(-3, 0);
	text.SetOutline(true);
	text.Set(str);
	text.outline_threshold = 0.16000000;
	text.outline_scale = 6.00000000;
	return text;
}

this.spell <- ::manbow.FontTexture();
this.spell.Load("data/font/spell_font.bmp");
function CreateSpellString( str, r, g, b )
{
	local text = ::manbow.String();
	text.Initialize(this.spell);
	text.SetSpace(-4, 0);
	text.SetOutline(true);
	text.SetGradation(true);
	text.red = 1.79999995;
	text.green = 1.79999995;
	text.blue = 1.79999995;
	text.red2 = r + 0.10000000;
	text.green2 = g + 0.10000000;
	text.blue2 = b + 0.10000000;
	text.outline_scale = 4.00000000;
	text.Set(str);
	return text;
}

