-- $Id: cep.lua,v 1.3 2009/02/14 22:31:59 root Exp $

-- cep.lua
-- 10feb2009, gflima@telemidia.puc-rio.br, bslima@telemidia.puc-rio.br
--
-- Shows nearest OUTBACK address based on user's location code (CEP).
-- This address is obtained using Google Maps directions service.



-- Module globals.
local DX, DY = canvas:attrSize()  -- Screen dimensions.
local DRAWS = {}      -- Picture list.

local LOCATION = nil  -- User's location code (CEP).
local INPUT = nil     -- Input text.



-- Compose a text object into canvas.  Text X and Y can be absolute coordinates
-- or have the following string values: X = {left, center, right}
-- and Y = {top, center, bottom}.

local function draw_text (self)
   canvas:attrColor(self.color)
   canvas:attrFont(self.font.face, self.font.height)

   local x, y = self.x, self.y
   local dx, dy = canvas:measureText (self.text)

   if not tonumber (x) then
      -- x is not a number, calculate its abs value.
      if x == 'left' then
         x = 0
      elseif x == 'center' then
         x = (DX - dx) / 2
      elseif x == 'right' then
         x = DX - dx
      end
   end

   if not tonumber (y) then
      -- y is not a number, calculate its abs value.
      if y == 'top' then
         y = 0
      elseif y == 'center' then
         y = (DY - dy) / 2
      elseif y == 'bottom' then
         y = DY - dy
      end
   end

   canvas:drawText (x, y, self.text)
end



-- Redraw all pictures.

local function redraw ()
   -- Fill canvas with an transparent color.
   canvas:attrColor (0, 0, 0, 0)
   canvas:clear ()

   for i=1, #DRAWS do
      DRAWS[i]:draw()
   end
   canvas:flush ()
end



-- Handle keypress events.

local function handler_keypress (evt)
   -- Resume.
   if evt.class == 'key' and evt.type =='press' then
      if evt.key == 'ENTER' then
         assert (coroutine.resume (APP))
      end

   -- Put number.
   elseif tonumber (evt.key) and INPUT then
      if #INPUT.text < 8 then
         INPUT.text = INPUT.text .. evt.key
         redraw ()
      end

   -- Delete last char.
   elseif evt.key == 'CURSOR_LEFT' and INPUT then
      INPUT.text = string.sub (INPUT.text, 1, -2)
      redraw ()
   end
end



-- Main.

require 'gmaps'

do
   APP = coroutine.create (
      function  ()
         event.register (handler_keypress)

         -- `user.location' settings is empty, request location input.
         if LOCATION == nil then
            INPUT = { text='', font={face='vera', height=25},
                      color='yellow', x=390, y=25, draw=draw_text }

            DRAWS[#DRAWS + 1] = INPUT
            DRAWS[#DRAWS + 1] = { text='Entre com o seu CEP:',
                                  font={face='vera', height=25},
                                  color='white', x=135, y=25, draw=draw_text }

            DRAWS[#DRAWS + 1] = { text='(Não foi possível determinar o seu '
                                  .. 'CEP utilizando o perfil corrente)',
                                  font={face='vera', height=14},
                                  color='red', x='center', y=55,
                                  draw=draw_text }
            redraw ()

            -- Waits for enter key.
            coroutine.yield ()

            -- Remove current text from DRAWS.
            DRAWS[#DRAWS] = nil
            DRAWS[#DRAWS] = nil
            DRAWS[#DRAWS] = nil
            LOCATION = INPUT.text
         end

         -- Insert CEP separator char.
         if #LOCATION == 8 then
            LOCATION = LOCATION:sub(1,5) .. '-' .. LOCATION:sub(6,8)
         end

         -- Get nearest Outback address.
         local res = gmaps_parse (gmaps_get_directions (LOCATION, 'outback'))

         DRAWS[#DRAWS + 1] = { text='Existe um OUTBACK perto de você em:',
                               font={face='vera', height=20}, color='white',
                               x='center', y=25, draw=draw_text }
         DRAWS[#DRAWS + 1] = { text=res, font={face='vera', height=14},
                               color='red', x='center', y=55, draw=draw_text }
         redraw ()

         -- Waits for another enter key.
         coroutine.yield ()

         -- Quit application.
         event.unregister (handler_keypress)
         event.post('out',
                    { class='ncl', type='presentation', action='stop' })
      end
   )

   event.register (
      function (evt)
         -- Waits for user.location info.
         if evt.class == 'ncl' and evt.type == 'attribution' then
            location = evt.value

            -- Validate profile location code.
            if location ~= nil and location:len() == 8 and location ~= '00000000' then
               LOCATION = location
            end
            coroutine.resume (APP)
         end
      end
   )
end

-- End: cep.lua
