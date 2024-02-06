-- $Id: gmaps.lua,v 1.3 2009/02/14 15:41:35 root Exp $

-- gmaps.lua
-- 13feb2009, gflima@telemidia.puc-rio.br, bslima@telemidia.puc-rio.br
--
-- Retrieves Google Maps directions info.


require 'tcp'


-- Returns Google Maps directions page from location FROM to location TO.
-- If unsuccessful returns nil.  Note that this function must be called
-- within a coroutine.

function gmaps_get_directions (from, to)
   tcp.connect ('maps.google.com', 80)

   local q = 'GET /maps?q=' .. to .. '+near:' .. from
      .. '&radius=1000&view=text&ll=-15.792254,-47.724609'
      .. '&spn=50.817939,79.101583&z=4\n\n'
   tcp.send (q)
   return tcp.receive('*a')
end



-- Returns the nearest location address as string.

function gmaps_parse (html)
   if html == nil then
      return 'Erro de conexão.'
   end

   -- Get first address.
   local i, j = html:find ('<div class="al adr">.-</div>')
   if i == nil or j == nil then
      return 'CEP não localizado.'   -- Fail to parse.
   end

   html = html:sub (i, j)
   html = html:gsub ('<.->', '')     -- Remove tags.
   html = html:gsub ('%&.-%;', '')   -- Remove entities.
   html = html:gsub ('  *', ' ')     -- Trim whitespaces.
   return html
end

-- End: gmaps.lua
