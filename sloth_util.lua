local doors = {
  ["prop_door_rotating"] = true,
  ["func_door"] = true,
  ["func_door_rotating"] = true
}
function sloth.IsDoor(ent)
  return doors[ent:GetClass()] or false
end

function sloth.AreEntsInsideEnt(ent)
  local trace = { start = ent:GetPos(), endpos = ent:GetPos(), filter = ent }

  local tr = util.TraceEntity( trace, ent )
  if ( tr.Hit ) then
    return true
  end

  return false
end

--STRING

function sloth.StringToArgs(string)
  local bIsCurArg = false
  local curArg = ""

  args = string.Explode(" ", string, false)

  local t = {}
  for k, v in pairs(args) do

    if v[1] == '"' then



      v = string.Explode("", v)
      v[1] = ""
      v = string.Implode("", v)

      bIsCurArg = true
    end

    if v[#v] == '"' then

      v = string.Explode("", v)
      v[#v] = ""
      v = string.Implode("", v)

      bIsCurArg = false
      t[#t + 1] = curArg..v
      curArg = ""
      continue
    end


    if bIsCurArg then
      curArg = curArg..v.." "
      continue
    end

    t[#t + 1] = v
  end

  return t
end

function sloth.getNamensEndeDingens(v)
  if IsValid(v) and v:IsPlayer() then
    local n = v:Nick()

    local e
    if n[#n] == "s" then
      e = "'"
    else
      e = "'s"
    end
  end

  return e
end

function sloth.levensteihn(s1, s2, notCaseSensetive)

  if notCaseSensetive then
    s1 = string.lower(s1)
    s2 = string.lower(s2)
  end

  local rV = 0
  local string1Lenght = #s1
  local string2Lenght = #s2

  if not (string1Lenght == string2Lenght) then
    if (string1Lenght > string2Lenght) then
      rV = rV + (string1Lenght - string2Lenght)
    else
      rV = rV + (string2Lenght - string1Lenght)
    end
  end

  for i=0, string2Lenght do
    local s1Char = s1:sub(i, i)
    local s2Char = s2:sub(i, i)

    if not (s1Char == "") then
      if not (s1Char == "") then
        if s1Char == s2Char then
        else
          rV = rV + 1
        end
      end
    end
  end

  return rV
end

function sloth.stringContains(haystack, ...)
  local checklist = {...}
  local b = false

  local t = {}
  for k, v in pairs(t) do
    if ( string.find( haystack, string.lower( v ) ) ) then
      t[k] = true

      if !b then
        b = true
      end
    end
  end


  return b, t
end

function sloth.stringMatch(string1, string2)
  if string.lower(string1) == string.lower(string2) then
    return true
  end

  return false
end

function sloth.shortenString( str, max )
  if !string then return end

	if !max then max = 200 end


  local t = string.Explode("", str, false)

  if #t < 35 then return str end

  local j = math.floor( #t / 35 )

  for i=1, j do
    table.insert( t, 35 * i, "-\n" )
  end

  if #t > max then
    local u = 0
    for k, v in pairs(t) do
      if k > max then
        if u < 4 then
          u = u + 1
          t[k] = "."
        else
          t[k] = ""
        end
      end
    end
  end

  return string.Implode("", t)
end

function sloth.stringToUID(str)
  return string.lower(string.gsub( str, "%s", "_" ))
end

function sloth.boolToString(b)
  if b then
    return "True", 1
  else
    return "False", 0
  end

  return "Nil", 0
end


--Player Related Stuff
function sloth.getPlayer(n, levensteihn)

  if levensteihn == nil then levensteihn = true end

  if levensteihn then
    local t = {}

    local b = false

    for key, player in pairs(player.GetAll()) do
      local lvDist = sloth.levensteihn(n, player:Name())

      if lvDist < 3 then

        if !b then b = true end

        t[#t + 1] = {
          pl = player,
          distance = lvDist
        }
      end
    end

    if !b then return end
    --table.sort(t, function(a, b) return a.distance > b.distance end)
    table.SortByMember( t, "distance", true)
    --[[
    local tempArray = {}
    for k, v in pairs(t) do

      if tempArray[v.distance] then

        table.insert(tempArray[v.distance], v.pl)
      else

          tempArray[v.distance] = { v.pl }
      end
    end

    table.sort(tempArray)

    for k, v in pairs(te)
    --]]

    if !t then return end

    return t[1].pl, t
    --end

    --for k, v in pairs(t) do

    --end
  end

  for key, player in pairs(player.GetAll()) do
    if player:Nick() == n then
      return player
    end
  end
end

function sloth.gatherAdmins()
  local players = player.GetAll()
  local t = {}

  for k, v in pairs(players) do
    if v:IsAdmin() then
      t[#t + 1] = v
    end
  end

  return t
end

function sloth.gatherSuperAdmins()
  local players = player.GetAll()
  local t = {}

  for k, v in pairs(players) do
    if v:IsSuperAdmin() then
      t[#t + 1] = v
    end
  end

  return t
end


-- Misc.

function sloth.timeStamp( time )
  if !time then time = os.time() end

  return os.date( "%H:%M:%S" , time )
end

function sloth.dateStamp( time )
  if !time then time = os.time() end

  return os.date( "%d.%m.%Y" , time )
end

function sloth.colorToVector(color)
	local vec = Vector(color.r / 255, color.g / 255, color.b / 255 )

	return vec
end

function sloth.bodygroupsToTable(ent)
  if (IsValid(ent)) then
    if (IsEntity(ent)) then
      local t = {}

      local bc = sloth.GetBodygroupCount(ent)
      for i=0,bc do
        t[i] = ent:GetBodygroup(i)
      end

      return t
    end
  end
end

function sloth.bodygroupsToString(ent)
  return table.concat( sloth.bodygroupsToTable(ent), "" )
end

function sloth.isTypeOf(obj, t)
  if (string.lower(type(obj)) == t ) then
    return true
  end
end

function sloth.GetBodygroupCount(ent)
  return #ent:GetBodyGroups()
end

function sloth.ApplyBodygroupTable(ent, tBodygroups)
  if !tBodygroups then return end
  if !istable(tBodygroups) then return end
  if IsValid(ent) then
    for k, v in pairs(tBodygroups) do
      ent:SetBodygroup(k, v)
    end
  end
end

function sloth.SimpleTimeString(s)
  if !s then return end

  local h = s / 3600
  h = math.floor(h) or 0

  s = s - (h * 3600)

  local m = s / 60
  m = math.floor(m) or 0

  s = s - (m * 60)


  return FLANG("SimpleTimeString", h, m, s)
end

function sloth.FormatMoney(amount)

  --print("formatmoney", amount)

  amount = tostring(amount)
  local t = string.Explode("", amount, false)

  local h = math.floor(#amount / 3)
  print("len", #amount, h)

    for i=1, h do
      local num = i * 3 + i

      --if num > #amount then
      --  continue
      --end

      print(num)
      if amount[num + 1] then
        print(i)

      --  if i > 1 then
          num = num - 1
      --  end

        table.insert(t, num, ".")
      end
    end

  PrintTable(t)
  --print(table.concat(t, ""))
  amount = string.Implode("", t)

  return sloth.GetCVar("Cash_Symbole")..amount
end
