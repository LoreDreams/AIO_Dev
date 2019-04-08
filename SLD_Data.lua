local AIO = AIO or require("AIO")
local SLD_LIB = SLD_LIB or require("SLD_LIB")
assert(not SLD_Data, "SLD_Data is already loaded. Possibly different versions!")
-- SLD_Data main table
SLD_Data =
{
    -- SLD_Data flavour functions
    unpack = unpack,
}

local SLD_Data = SLD_Data
if AIO.AddAddon() then
   function SLD_LoadData(MyPlayer)
      local MySQLCommand= "SELECT LD_PJ, LD_INDEX, LD_VALUE, LD_TYPE FROM LD_SessionVars;"
	  	  local MyRes = CharDBQuery(MySQLCommand)
      if ( MyRes ~= nil ) then
         local NumRows = MyRes:GetRowCount()
         for i = 1,NumRows do
            MyPj     = MyRes:GetString( 0 )
            MyIndex  = MyRes:GetString( 1 )
            MyValue  = MyRes:GetString( 2 )
            MyType   = MyRes:GetString( 3 )
			   AIO.Msg():Add("LDMsg","LDGEN#"..MyPj.."#"..MyIndex.."#"..MyType.."#".. MyValue):Send(MyPlayer)
            MyRes:NextRow()
         end
      end
   end
   PrintInfo("SLD Data Loaded ...")
end