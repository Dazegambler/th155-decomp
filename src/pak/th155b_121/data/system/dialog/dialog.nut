local _texture = ::manbow.Texture();
_texture.Load("data/system/dialog/mini_window.png");
local help_0 = [
	"B1",
	"ok",
	null,
	"B2",
	"return"
];
local help_1 = [
	"B1",
	"ok",
	null,
	"B2",
	"return",
	null,
	"LR",
	"select"
];
local help_2 = [
	"KEY",
	"input_string"
];
class this.Dialog 
{
	static texture = _texture;
	static OK = 0;
	static YESNO = 1;
	static TEXT = 2;
	type = 0;
	obj = null;
	proc = null;
	task = null;
	cursor = null;
	item = null;
	callback = null;
	constructor( type, message, callback = null, arg = null )
	{
		this.Initialize(type, message, callback, arg);
	}

	Update = null;
	function Initialize( _type, message, _callback = null, arg = null )
	{
		::loop.Begin(this);
		this.callback = _callback;
		this.obj = [];
		local sprite = ::manbow.Sprite();
		sprite.Initialize(this.texture, 0, 0, this.texture.width, this.texture.height);
		sprite.x = -this.texture.width / 2;
		sprite.y = -this.texture.height / 2;
		local text = ::font.CreateSystemString(message);
		text.x = -text.width / 2;
		this.obj.append(sprite);
		this.obj.append(text);
		this.type = _type;

		switch(_type)
		{
		case 0:
			text.y = -text.height / 2 - 8;
			this.Update = this.UpdateOK;
			::menu.cursor.Activate();
			break;

		case 1:
			text.y = -40;
			this.item = [];
			this.item.append(this.AddTextObject(::menu.common.GetMessageText("yes"), -80, 0));
			this.item.append(this.AddTextObject(::menu.common.GetMessageText("no"), 80, 0));
			this.cursor = this.Cursor(1, this.item.len(), ::input_all);

			if (arg)
			{
				this.cursor.val = arg;
			}

			this.Update = this.UpdateSelect;
			::menu.cursor.Activate();
			break;

		case 2:
			text.y = -40;
			this.item = {};
			this.item.count <- 0;
			this.item.pos <- 0;
			local width = 400;
			local left = -width / 2;
			local right = width / 2;
			local top = 8;
			local bottom = top + ::font.system_size;
			local margin = 2;
			this.item.left <- left;
			local input_rect = ::manbow.Rectangle();
			input_rect.SetPosition(left, top - margin, right, bottom + margin);
			input_rect.SetColor(1, 0.20000000, 0.20000000, 0.20000000);
			this.item.input_rect <- input_rect;
			this.obj.append(input_rect);
			local text = arg ? arg : "";
			this.item.text <- this.AddTextObject(text, 0, top - 12);
			this.item.text.x = left;
			this.item.comp <- this.AddTextObject("", 0, top - 12);
			this.item.comp.red = this.item.comp.blue = 0;
			local cursor_rect = ::manbow.Rectangle();
			cursor_rect.SetPosition(0, top, 1, bottom);
			this.item.cursor <- cursor_rect;
			this.obj.append(cursor_rect);
			this.item.message_length_obj <- ::font.CreateSystemString("");
			this.item.cursor_x <- 0;
			this.Update = this.UpdateInputText;
			::manbow.SetIMEText(text);
			::manbow.SetIMECursor(0);
			::manbow.BeginIME();
			::menu.cursor.Activate();
			break;

		case -1:
			text.y = -text.height / 2 - 8;
			this.Update = this.UpdateOK;

			if (arg)
			{
				arg.call(this);
			}

			break;
		}

		this.task = ::loop.GeneratorTask();
		this.task.Set(function ( t )
		{
			// Function is a generator.
			foreach( v in this.obj )
			{
				v.ConnectRenderSlot(::graphics.slot.front, 10000);
			}

			local mat = ::manbow.Matrix();

			for( local i = 0; i <= 5; i = ++i )
			{
				mat.SetScaling(i / 5.00000000, i / 5.00000000, 1);
				mat.Translate(::graphics.width / 2, ::graphics.height / 2, 0);

				foreach( v in this.obj )
				{
					v.alpha = i / 5.00000000;
					v.SetWorldTransform(mat);
				}

				yield true;
			}
		}(this));
	}

	function Terminate()
	{
		::menu.help.Reset();

		switch(this.type)
		{
		case 0:
		case 1:
		case 2:
			::menu.cursor.Deactivate();
			break;
		}

		this.task.Set(function ( t )
		{
			// Function is a generator.
			local mat = ::manbow.Matrix();

			for( local i = 5; i > 0; i = --i )
			{
				mat.SetScaling(i / 5.00000000, i / 5.00000000, 1);
				mat.Translate(::graphics.width / 2, ::graphics.height / 2, 0);

				foreach( v in this.obj )
				{
					v.alpha = i / 5.00000000;
					v.SetWorldTransform(mat);
				}

				yield true;
			}
		}(this));
	}

	function Suspend()
	{
	}

	function Resume()
	{
	}

	function AddTextObject( text, offset_x, offset_y )
	{
		local t = ::font.CreateSystemString(text);
		t.x = -t.width / 2 + offset_x;
		t.y = offset_y;
		this.obj.append(t);
		return t;
	}

	function UpdateOK()
	{
		::menu.help.Set(help_0);

		if (::input_all.b0 == 1 || ::input_all.b1 == 1)
		{
			::loop.End();

			if (this.callback)
			{
				this.callback();
			}
		}

		::menu.cursor.SetTarget(this.obj[1].x - 20 + ::graphics.width / 2, this.obj[1].y + 24 + ::graphics.height / 2, 0.69999999);
	}

	function UpdateSelect()
	{
		::menu.help.Set(help_1);
		this.cursor.Update();

		foreach( i, v in this.item )
		{
			if (i == this.cursor.val)
			{
				v.red = v.green = v.blue = 1;
			}
			else
			{
				v.red = v.green = v.blue = 0.50000000;
			}
		}

		if (this.cursor.ok)
		{
			::loop.End();

			if (this.callback)
			{
				this.callback(this.cursor.val == 0);
			}
		}

		if (this.cursor.cancel)
		{
			::loop.End();

			if (this.callback)
			{
				this.callback(null);
			}
		}

		local cur = this.item[this.cursor.val];
		::menu.cursor.SetTarget(cur.x - 20 + ::graphics.width / 2, cur.y + 24 + ::graphics.height / 2, 0.69999999);
	}

	function UpdateInputText()
	{
		::menu.help.Set(help_2);
		local im_state = {};
		::manbow.GetIMEState(im_state);

		if (im_state.text.len() > 16)
		{
			local length = 0;

			for( local i = 0; i < 16; i = ++i )
			{
				local c = im_state.text[i];

				if (c < 0)
				{
					c = c + 256;
				}

				if (c >= 129 && c <= 159 || c >= 224 && c <= 255)
				{
					if (i >= 15)
					{
					}

					i = ++i;
				}

				length = i + 1;
			}

			im_state.text = im_state.text.slice(0, length);
			::manbow.SetIMEText(im_state.text);
			::manbow.GetIMEState(im_state);
			this.item.pos = -1;
		}

		this.item.text.Set(im_state.text);

		if (im_state.composition != "")
		{
			this.item.comp.Set(im_state.composition);
			this.item.comp.x = this.item.left + this.item.cursor_x - 3;
			this.item.comp.visible = true;
		}
		else
		{
			this.item.comp.visible = false;
		}

		if (this.item.pos != im_state.cursor)
		{
			this.item.pos = im_state.cursor;
			this.item.count = 0;

			if (this.item.pos == 0)
			{
				this.item.cursor_x = 0;
			}
			else
			{
				if (this.item.pos >= im_state.text.len())
				{
					this.item.message_length_obj.Set(im_state.text);
				}
				else
				{
					this.item.message_length_obj.Set(im_state.text.slice(0, this.item.pos));
				}

				this.item.cursor_x = this.item.message_length_obj.width + (this.item.pos ? -2 : 0);
			}
		}

		this.item.cursor.visible = this.item.count++ % 60 < 30;
		this.item.cursor.x0 = this.item.left + this.item.cursor_x;
		this.item.cursor.x1 = this.item.cursor.x0 + 1;

		if (::manbow.IsFinishedIME())
		{
			if (::manbow.IsKeyDown(28) || ::manbow.IsKeyDown(156))
			{
				::manbow.EndIME();
				::loop.End();
				::input_all.Lock();

				if (this.callback)
				{
					this.callback(im_state.text);
				}
			}
			else if (::manbow.IsKeyDown(1))
			{
				::manbow.EndIME();
				::loop.End();
				::input_all.Lock();

				if (this.callback)
				{
					this.callback(null);
				}
			}
		}

		::menu.cursor.SetTarget(this.obj[1].x - 20 + ::graphics.width / 2, this.obj[1].y + 24 + ::graphics.height / 2, 0.69999999);
	}

}

